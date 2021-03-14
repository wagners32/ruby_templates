require 'readline'

puts "Project name:"

prompt = "> "

projeto_name = Readline.readline(prompt, true)
puts "Criando o projeto: '#{projeto_name}'"
# dotnet version
print "dotnet version: "
system "dotnet --version"

# diretórios
system "mkdir -p #{projeto_name}"
system "mkdir -p #{projeto_name}/#{projeto_name}.Domain"
system "mkdir -p #{projeto_name}/#{projeto_name}.Shared"
system "mkdir -p #{projeto_name}/#{projeto_name}.Tests"

# solution geral
system "cd #{projeto_name} && dotnet new sln --force"

# add classlib no Domain
system "cd #{projeto_name}/#{projeto_name}.Domain && dotnet new classlib --force"
system "cd #{projeto_name}/#{projeto_name}.Domain && rm Class1.cs"

# add classlib no Shared
system "cd #{projeto_name}/#{projeto_name}.Shared && dotnet new classlib --force"
system "cd #{projeto_name}/#{projeto_name}.Shared && rm Class1.cs"

# add xunit
system "cd #{projeto_name}/#{projeto_name}.Tests && dotnet new xunit --force"
system "cd #{projeto_name}/#{projeto_name}.Tests && rm UnitTest1.cs"

# add Domain in to solution
system "cd #{projeto_name} && dotnet sln add #{projeto_name}.Domain/#{projeto_name}.Domain.csproj"
system "cd #{projeto_name} && dotnet sln add #{projeto_name}.Shared/#{projeto_name}.Shared.csproj"
system "cd #{projeto_name} && dotnet sln add #{projeto_name}.Tests/#{projeto_name}.Tests.csproj"

# add references
# domain - shared
system "cd #{projeto_name}/#{projeto_name}.Domain && dotnet add reference ../#{projeto_name}.Shared/#{projeto_name}.Shared.csproj"
# tests - domain and shared
system "cd #{projeto_name}/#{projeto_name}.Tests && dotnet add reference ../#{projeto_name}.Domain/#{projeto_name}.Domain.csproj"
system "cd #{projeto_name}/#{projeto_name}.Tests && dotnet add reference ../#{projeto_name}.Shared/#{projeto_name}.Shared.csproj"

# restore
system "cd #{projeto_name} && dotnet restore"

# build solution
system "cd #{projeto_name} && dotnet build"