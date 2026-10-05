namespace StrictCommon;

/// <summary>Builds the greeting printed by the program.</summary>
internal static class Greeter
{
    /// <summary>Returns the greeting for <paramref name="name"/>.</summary>
    /// <param name="name">Who to greet.</param>
    /// <returns>The greeting text.</returns>
    public static string Greet(string name) => $"Hello World with {name}";
}
