namespace TestMini;

public static class Runner
{
    public static async Task<string> RunOnce()
    {
        await Task.Delay(10);
        return "1";
    }
}