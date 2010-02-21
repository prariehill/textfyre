//
//  TFEngine_Opcodes.m
//  fyrevm-foundation
//
//  Copyright 2010 Textfyre, Inc. All rights reserved.
//  Please read the accompanying COPYRIGHT file for licensing restrictions.
//

#import "TFEngine_Opcodes.h"


@implementation TFEngine (Opcodes)
/*
//[Opcode(0x00, "nop", 0)]
- (void)op_nop:(uint32_t *)args
{
    // do nothing!
}

#pragma mark Arithmetic

//[Opcode(0x10, "add", 2, 1)]
- (void)op_add:(uint32_t *)args
{
    args[2] = args[0] + args[1];
}

//[Opcode(0x11, "sub", 2, 1)]
- (void)op_sub:(uint32_t *)args
{
    args[2] = args[0] - args[1];
}

//[Opcode(0x12, "mul", 2, 1)]
- (void)op_mul:(uint32_t *)args
{
    args[2] = args[0] * args[1];
}

//[Opcode(0x13, "div", 2, 1)]
- (void)op_div:(uint32_t *)args
{
    args[2] = (uint32_t)((int)args[0] / (int)args[1]);
}

//[Opcode(0x14, "mod", 2, 1)]
- (void)op_mod:(uint32_t *)args
{
    args[2] = (uint32_t)((int)args[0] % (int)args[1]);
}

//[Opcode(0x15, "neg", 1, 1)]
- (void)op_neg:(uint32_t *)args
{
    args[1] = (uint32_t)(-(int)args[0]);
}

//[Opcode(0x18, "bitand", 2, 1)]
- (void)op_bitand:(uint32_t *)args
{
    args[2] = args[0] & args[1];
}

//[Opcode(0x19, "bitor", 2, 1)]
- (void)op_bitor:(uint32_t *)args
{
    args[2] = args[0] | args[1];
}

//[Opcode(0x1A, "bitxor", 2, 1)]
- (void)op_bitxor:(uint32_t *)args
{
    args[2] = args[0] ^ args[1];
}

//[Opcode(0x1B, "bitnot", 1, 1)]
- (void)op_bitnot:(uint32_t *)args
{
    args[1] = ~args[0];
}

//[Opcode(0x1C, "shiftl", 2, 1)]
- (void)op_shiftl:(uint32_t *)args
{
    if (args[1] >= 32)
        args[2] = 0;
    else
        args[2] = args[0] << (int)args[1];
}

//[Opcode(0x1D, "sshiftr", 2, 1)]
- (void)op_sshiftr:(uint32_t *)args
{
    if (args[1] >= 32)
        args[2] = ((args[0] & 0x80000000) == 0) ? 0 : 0xFFFFFFFF;
    else
        args[2] = (uint32_t)((int)args[0] >> (int)args[1]);
}

//[Opcode(0x1E, "ushiftr", 2, 1)]
- (void)op_ushiftr:(uint32_t *)args
{
    if (args[1] >= 32)
        args[2] = 0;
    else
        args[2] = args[0] >> (int)args[1];
}

#pragma mark Branching

- (void)takeBranch:(uint32_t)target
{
    if (target == 0)
        [self leaveFunction:0];
    else if (target == 1)
        [self leaveFunction:1];
    else
        pc += target - 2;
}

//[Opcode(0x20, "jump", 1)]
- (void)op_jump:(uint32_t *)args
{
    [self takeBranch:args[0]];
}

//[Opcode(0x22, "jz", 2)]
- (void)op_jz:(uint32_t *)args
{
    if (args[0] == 0)
        [self takeBranch:args[1]];
}

//[Opcode(0x23, "jnz", 2)]
- (void)op_jnz:(uint32_t *)args
{
    if (args[0] != 0)
        [self takeBranch:args[1]];
}

//[Opcode(0x24, "jeq", 3)]
- (void)op_jeq:(uint32_t *)args
{
    if (args[0] == args[1])
        [self takeBranch:args[2]];
}

//[Opcode(0x25, "jne", 3)]
- (void)op_jne:(uint32_t *)args
{
    if (args[0] != args[1])
        [self takeBranch:args[2]];
}

//[Opcode(0x26, "jlt", 3)]
- (void)op_jlt:(uint32_t *)args
{
    if ((int)args[0] < (int)args[1])
        [self takeBranch:args[2]];
}

//[Opcode(0x27, "jge", 3)]
- (void)op_jge:(uint32_t *)args
{
    if ((int)args[0] >= (int)args[1])
        [self takeBranch:args[2]];
}

//[Opcode(0x28, "jgt", 3)]
- (void)op_jgt:(uint32_t *)args
{
    if ((int)args[0] > (int)args[1])
        [self takeBranch:args[2]];
}

//[Opcode(0x29, "jle", 3)]
- (void)op_jle:(uint32_t *)args
{
    if ((int)args[0] <= (int)args[1])
        [self takeBranch:args[2]];
}

//[Opcode(0x2A, "jltu", 3)]
- (void)op_jltu:(uint32_t *)args
{
    if (args[0] < args[1])
        [self takeBranch:args[2]];
}

//[Opcode(0x2B, "jgeu", 3)]
- (void)op_jgeu:(uint32_t *)args
{
    if (args[0] >= args[1])
        [self takeBranch:args[2]];
}

//[Opcode(0x2C, "jgtu", 3)]
- (void)op_jgtu:(uint32_t *)args
{
    if (args[0] > args[1])
        [self takeBranch:args[2]];
}

//[Opcode(0x2D, "jleu", 3)]
- (void)op_jleu:(uint32_t *)args
{
    if (args[0] <= args[1])
        [self takeBranch:args[2]];
}

//[Opcode(0x104, "jumpabs", 1)]
- (void)op_jumpabs:(uint32_t *)args
{
    pc = args[0];
}

#pragma mark Functions

static uint32_t funcargs1[1] = { 0 };
static uint32_t funcargs2[2] = { 0, 0 };
static uint32_t funcargs3[3] = { 0, 0, 0 };

//[Opcode(0x30, "call", 2, Rule = OpcodeRule.DelayedStore)]
- (void)op_call:(uint32_t *)args
{
    int count = (int)args[1];
    uint32_t funcargs[count];

    for (int i = 0; i < count; i++)
        funcargs[i] = [self pop];

    [self performCallWithAddress:args[0], funcargs, args[2], args[3]];
}

//[Opcode(0x160, "callf", 1, Rule = OpcodeRule.DelayedStore)]
- (void)op_callf:(uint32_t *)args
{
    [self performCallWithAddress:args[0], null, args[1], args[2]];
}

//[Opcode(0x161, "callfi", 2, Rule = OpcodeRule.DelayedStore)]
- (void)op_callfi:(uint32_t *)args
{
    funcargs1[0] = args[1];
    [self performCallWithAddress:args[0], funcargs1, args[2], args[3]];
}

//[Opcode(0x162, "callfii", 3, Rule = OpcodeRule.DelayedStore)]
- (void)op_callfii:(uint32_t *)args
{
    funcargs2[0] = args[1];
    funcargs2[1] = args[2];
    [self performCallWithAddress:args[0], funcargs2, args[3], args[4]];
}

//[Opcode(0x163, "callfiii", 4, Rule = OpcodeRule.DelayedStore)]
- (void)op_callfiii:(uint32_t *)args
{
    funcargs3[0] = args[1];
    funcargs3[1] = args[2];
    funcargs3[2] = args[3];
    [self performCallWithAddress:args[0], funcargs3, args[4], args[5]];
}

- (void)performCallWithAddress:(uint32_t)address args:(uint32_t *)args, destType:(uint32_t)destType destAddr:(uint32_t)destAddr)
{
    [self performCallWithAddress:address args:args destType:destType destAddress:destAddr stubPC:pc];
}

- (void)performCallWithAddress(uint32_t)address args:(uint32_t *)args, destType:(uint32_t)destType destAddr:(uint32_t)destAddr) stubPC:(uint32_t)stubPC
{
    [self performCallWithAddress:address args:args destType:destType destAddress:destAddr stubPC:stubPC tailCall:NO];
}

/// <summary>
/// Enters a function, pushing a call stub first if necessary.
/// </summary>
/// <param name="address">The address of the function to call.</param>
/// <param name="args">The function's arguments, or <b>null</b> to call without arguments.</param>
/// <param name="destType">The DestType for the call stub. Ignored for tail calls.</param>
/// <param name="destAddr">The DestAddr for the call stub. Ignored for tail calls.</param>
/// <param name="stubPC">The PC value for the call stub. Ignored for tail calls.</param>
/// <param name="tailCall"><b>true</b> to perform a tail call, reusing the current call stub
/// and frame instead of pushing a new stub and creating a new frame.</param>
- (void)performCallWithAddress(uint32_t)address args:(uint32_t *)args, destType:(uint32_t)destType destAddr:(uint32_t)destAddr) stubPC:(uint32_t)stubPC tailCall:(BOOL)tailCall
{
    uint32_t result;
    if (veneer.InterceptCall(this, address, args, out result))
    {
        PerformDelayedStore(destType, destAddr, result);
        return;
    }

    if (tailCall)
    {
        // pop the current frame and use the call stub below it
        sp = fp;
    }
    else
    {
        // use a new call stub
        PushCallStub(new CallStub(destType, destAddr, stubPC, fp));
    }

    byte type = image.ReadByte(address);
    if (type == 0xC0)
    {
        // arguments are passed in on the stack
        EnterFunction(address);
        if (args == null)
        {
            Push(0);
        }
        else
        {
            for (int i = args.Length - 1; i >= 0; i--)
                Push(args[i]];
            Push((uint32_t)args.Length);
        }
    }
    else if (type == 0xC1)
    {
        // arguments are passed in local storage
        EnterFunction(address, args);
    }
    else
        throw new VMException(string.Format("Invalid function type {0:X}h", type));
}

//[Opcode(0x31, "return", 1)]
- (void)op_return:(uint32_t *)args
{
    LeaveFunction(args[0]];
}

//[Opcode(0x32, "catch", 0, Rule = OpcodeRule.Catch)]
- (void)op_catch:(uint32_t *)args
{
    PushCallStub(new CallStub(args[0], args[1], pc, fp));
    // the catch token is the value of sp after pushing that stub
    PerformDelayedStore(args[0], args[1], sp);
    [self takeBranch:args[2]];
}

//[Opcode(0x33, "throw", 2)]
- (void)op_throw:(uint32_t *)args
{
    if (args[1] > sp)
        throw new VMException("Invalid catch token");

    // pop the stack back down to the stub pushed by catch
    sp = args[1];

    // restore from the stub
    CallStub stub = PopCallStub();
    pc = stub.PC;
    fp = stub.FramePtr;
    frameLen = ReadFromStack(fp);
    localsPos = ReadFromStack(fp + 4);

    // store the thrown value and resume after the catch opcode
    PerformDelayedStore(stub.DestType, stub.DestAddr, args[0]];
}

//[Opcode(0x34, "tailcall", 2)]
- (void)op_tailcall:(uint32_t *)args
{
    int count = (int)args[1];
    uint32_t *funcargs = new uint32_t[count];

    for (int i = 0; i < count; i++)
        funcargs[i] = [self pop];

    [self performCallWithAddress:args[0] args:funcargs destType:0 destAddr:0 stubPC:0 tailCall:YES];
}

#pragma mark Variables and Arrays

//[Opcode(0x40, "copy", 1, 1)]
- (void)op_copy:(uint32_t *)args
{
    args[1] = args[0];
}

//[Opcode(0x41, "copys", 1, 1, Rule = OpcodeRule.Indirect16Bit)]
- (void)op_copys:(uint32_t *)args
{
    args[1] = args[0];
}

//[Opcode(0x42, "copyb", 1, 1, Rule = OpcodeRule.Indirect8Bit)]
- (void)op_copyb:(uint32_t *)args
{
    args[1] = args[0];
}

//[Opcode(0x44, "sexs", 1, 1)]
- (void)op_sexs:(uint32_t *)args
{
    args[1] = (uint32_t)(int)(short)args[0];
}

//[Opcode(0x45, "sexb", 1, 1)]
- (void)op_sexb:(uint32_t *)args
{
    args[1] = (uint32_t)(int)(sbyte)args[0];
}

//[Opcode(0x48, "aload", 2, 1)]
- (void)op_aload:(uint32_t *)args
{
    args[2] = image.ReadInt32(args[0] + 4 * args[1]];
}

//[Opcode(0x49, "aloads", 2, 1)]
- (void)op_aloads:(uint32_t *)args
{
    args[2] = image.ReadInt16(args[0] + 2 * args[1]];
}

//[Opcode(0x4A, "aloadb", 2, 1)]
- (void)op_aloadb:(uint32_t *)args
{
    args[2] = image.ReadByte(args[0] + args[1]];
}

//[Opcode(0x4B, "aloadbit", 2, 1)]
- (void)op_aloadbit:(uint32_t *)args
{
    uint32_t address = (uint32_t)(args[0] + ((int)args[1]) / 8);
    byte bit = (byte)(((int)args[1]) % 8);

    byte value = image.ReadByte(address);
    args[2] = (value & (1 << bit)) == 0 ? (uint32_t)0 : (uint32_t)1;
}

//[Opcode(0x4C, "astore", 3)]
- (void)op_astore:(uint32_t *)args
{
    image.WriteInt32(args[0] + 4 * args[1], args[2]];
}

//[Opcode(0x4D, "astores", 3)]
- (void)op_astores:(uint32_t *)args
{
    image.WriteInt16(args[0] + 2 * args[1], (ushort)args[2]];
}

//[Opcode(0x4E, "astoreb", 3)]
- (void)op_astoreb:(uint32_t *)args
{
    image.WriteByte(args[0] + args[1], (byte)args[2]];
}

//[Opcode(0x4F, "astorebit", 3)]
- (void)op_astorebit:(uint32_t *)args
{
    uint32_t address = (uint32_t)(args[0] + ((int)args[1]) / 8);
    byte bit = (byte)(((int)args[1]) % 8);

    byte value = image.ReadByte(address);
    if (args[2] == 0)
        value &= (byte)(~(1 << bit));
    else
        value |= (byte)(1 << bit);
    image.WriteByte(address, value);
}

#pragma mark Output

//[Opcode(0x70, "streamchar", 1)]
- (void)op_streamchar:(uint32_t *)args
{
    StreamCharCore((byte)args[0]];
}

//[Opcode(0x73, "streamunichar", 1)]
- (void)op_streamunichar:(uint32_t *)args
{
    StreamCharCore(args[0]];
}

- (void)StreamCharCore(uint32_t value)
{
    if (outputSystem == IOSystem.Filter)
    {
        [self performCallWithAddress:filterAddress, new uint32_t *{ value }, GLULX_STUB_STORE_NULL, 0);
    }
    else
    {
        SendCharToOutput(value);
    }
}

//[Opcode(0x71, "streamnum", 1)]
- (void)op_streamnum:(uint32_t *)args
{
    if (outputSystem == IOSystem.Filter)
    {
        PushCallStub(new CallStub(GLULX_STUB_RESUME_FUNC, 0, pc, fp));
        string num = ((int)args[0]).ToString();
        [self performCallWithAddress:filterAddress, new uint32_t *{ (uint32_t)num[0] },
            GLULX_STUB_RESUME_NUMBER, 1, args[0]];
    }
    else
    {
        string num = ((int)args[0]).ToString();
        SendStringToOutput(num);
    }
}

//[Opcode(0x72, "streamstr", 1)]
- (void)op_streamstr:(uint32_t *)args
{
    if (outputSystem == IOSystem.Null)
        return;

    uint32_t address = args[0];
    byte type = image.ReadByte(address);

    // for retrying a compressed string after we discover it needs a call stub
    byte savedDigit = 0;
    StrNode savedNode = null;

    // if we're not using the userland output filter, and the string is uncompressed (or contains no indirect references), we can just print it right here.
    if (outputSystem != IOSystem.Filter)
    {
        switch (type)
        {
            case 0xE0:
                // C string
                SendStringToOutput(ReadCString(address + 1));
                return;
            case 0xE2:
                // Unicode string
                SendStringToOutput(ReadUniString(address + 4));
                return;
            case 0xE1:
                // compressed string
                if (nativeDecodingTable != null)
                {
                    uint32_t oldPC = pc;

                    pc = address + 1;
                    printingDigit = 0;

                    StrNode node = nativeDecodingTable.GetHandlingNode(this);
                    while (!node.NeedsCallStub)
                    {
                        if (node.IsTerminator)
                        {
                            pc = oldPC;
                            return;
                        }

                        node.HandleNextChar(this);

                        node = nativeDecodingTable.GetHandlingNode(this);
                    }

                    savedDigit = printingDigit;
                    savedNode = node;
                    address = pc - 1;
                    pc = oldPC;
                }
                break;
        }
    }

    // can't decompress anything without a decoding table
    if (type == 0xE1 && decodingTable == 0)
        throw new VMException("No string decoding table is set");

    // otherwise, we have to push a call stub and let the main interpreter loop take care of printing the string.
    PushCallStub(new CallStub(GLULX_STUB_RESUME_FUNC, 0, pc, fp));

    switch (type)
    {
        case 0xE0:
            execMode = ExecutionMode.CString;
            pc = address + 1;
            break;
        case 0xE1:
            execMode = ExecutionMode.CompressedString;
            pc = address + 1;
            printingDigit = savedDigit;
            // this won't read a bit, since savedNode can't be a branch...
            if (savedNode != null)
                savedNode.HandleNextChar(this);
            break;
        case 0xE2:
            execMode = ExecutionMode.UnicodeString;
            pc = address + 4;
            break;
        default:
            throw new VMException(string.Format("Invalid string type {0:X}h", type));
    }
}

//[Opcode(0x130, "glk", 2, 1)]
- (void)op_glk:(uint32_t *)args
{
    // not really supported, just clear the stack
    for (uint32_t i = 0; i < args[1]; i++)
        Pop();
    args[2] = 0;
}

//[Opcode(0x140, "getstringtbl", 0, 1)]
- (void)op_getstringtbl:(uint32_t *)args
{
    args[0] = decodingTable;
}

//[Opcode(0x141, "setstringtbl", 1)]
- (void)op_setstringtbl:(uint32_t *)args
{
    decodingTable = args[0];
    CacheDecodingTable();
}

//[Opcode(0x148, "getiosys", 0, 2)]
- (void)op_getiosys:(uint32_t *)args
{
    switch (outputSystem)
    {
        case IOSystem.Null:
            args[0] = 0;
            args[1] = 0;
            break;

        case IOSystem.Filter:
            args[0] = 1;
            args[1] = filterAddress;
            break;

        case IOSystem.Channels:
            args[0] = 20;
            args[1] = 0;
            break;
    }
}

//[Opcode(0x149, "setiosys", 2, 0)]
- (void)op_setiosys:(uint32_t *)args
{
    SelectOutputSystem(args[0], args[1]];
}

#pragma mark Memory Management

//[Opcode(0x102, "getmemsize", 0, 1)]
- (void)op_getmemsize:(uint32_t *)args
{
    args[0] = image.EndMem;
}

//[Opcode(0x103, "setmemsize", 1, 1)]
- (void)op_setmemsize:(uint32_t *)args
{
    if (heap != null)
        throw new VMException("setmemsize is not allowed while the heap is active");

    try
    {
        image.EndMem = args[0];
        args[1] = 0;
    }
    catch
    {
        args[1] = 1;
    }
}

//[Opcode(0x170, "mzero", 2)]
- (void)op_mzero:(uint32_t *)args
{
    for (uint32_t i = 0; i < args[0]; i++)
        image.WriteByte(args[1] + i, 0);
}

//[Opcode(0x171, "mcopy", 3)]
- (void)op_mcopy:(uint32_t *)args
{
    if (args[2] < args[1])
    {
        for (uint32_t i = 0; i < args[0]; i++)
            image.WriteByte(args[2] + i, image.ReadByte(args[1] + i));
    }
    else
    {
        for (uint32_t i = args[0] - 1; i >= 0; i--)
            image.WriteByte(args[2] + i, image.ReadByte(args[1] + i));
    }
}

private bool HandleHeapMemoryRequest(uint32_t newEndMem)
{
    try
    {
        image.EndMem = newEndMem;
        return true;
    }
    catch
    {
        return false;
    }
}

//[Opcode(0x178, "malloc", 1, 1)]
- (void)op_malloc:(uint32_t *)args
{
    uint32_t size = args[0];
    if ((int)size <= 0)
    {
        args[1] = 0;
        return;
    }

    if (heap == null)
    {
        uint32_t oldEndMem = image.EndMem;
        heap = new HeapAllocator(oldEndMem, HandleHeapMemoryRequest);
        heap.MaxSize = maxHeapSize;
        args[1] = heap.Alloc(size);
        if (args[1] == 0)
        {
            heap = null;
            image.EndMem = oldEndMem;
        }
    }
    else
    {
        args[1] = heap.Alloc(size);
    }
}

//[Opcode(0x179, "mfree", 1)]
- (void)op_mfree:(uint32_t *)args
{
    if (heap != null)
    {
        heap.Free(args[0]];
        if (heap.BlockCount == 0)
        {
            image.EndMem = heap.Address;
            heap = null;
        }
    }
}

#pragma mark Searching

[Flags]
private enum SearchOptions
{
    None = 0,

    KeyIndirect = 1,
    ZeroKeyTerminates = 2,
    ReturnIndex = 4,
}

private bool KeyIsZero(uint32_t address, uint32_t size)
{
    for (uint32_t i = 0; i < size; i++)
        if (image.ReadByte(address + i) != 0)
            return false;

    return true;
}

private int CompareKeys(uint32_t query, uint32_t candidate, uint32_t keySize, SearchOptions options)
{
    if ((options & SearchOptions.KeyIndirect) == 0)
    {
        uint32_t ckey;
        switch (keySize)
        {
            case 1:
                ckey = image.ReadByte(candidate);
                query &= 0xFF;
                break;
            case 2:
                ckey = image.ReadInt16(candidate);
                query &= 0xFFFF;
                break;
            case 3:
                ckey = (uint32_t)(image.ReadByte(candidate) << 24 + image.ReadInt16(candidate + 1));
                query &= 0xFFFFFF;
                break;
            default:
                ckey = image.ReadInt32(candidate);
                break;
        }

        return query.CompareTo(ckey);
    }

    for (uint32_t i = 0; i < keySize; i++)
    {
        byte b1 = image.ReadByte(query++);
        byte b2 = image.ReadByte(candidate++);
        if (b1 < b2)
            return -1;
        else if (b1 > b2)
            return 1;
    }

    return 0;
}

//[Opcode(0x150, "linearsearch", 7, 1)]
- (void)op_linearsearch:(uint32_t *)args
{
    uint32_t key = args[0];
    uint32_t keySize = args[1];
    uint32_t start = args[2];
    uint32_t structSize = args[3];
    uint32_t numStructs = args[4];
    uint32_t keyOffset = args[5];
    SearchOptions options = (SearchOptions)args[6];

    if (keySize > 4 && (options & SearchOptions.KeyIndirect) == 0)
        throw new VMException("KeyIndirect option must be used when searching for a >4 byte key");

    uint32_t result = (options & SearchOptions.KeyIndirect) == 0 ? 0 : 0xFFFFFFFF;

    for (uint32_t index = 0; index < numStructs; index++)
    {
        if ((options & SearchOptions.ZeroKeyTerminates) != 0 &&
            KeyIsZero(start + index * structSize + keyOffset, keySize))
        {
            // stop searching, even if this key would match
            break;
        }

        int cmp = CompareKeys(key, start + index * structSize + keyOffset, keySize, options);
        if (cmp == 0)
        {
            // found it
            if ((options & SearchOptions.ReturnIndex) == 0)
                result = start + index * structSize;
            else
                result = index;
            break;
        }
    }

    args[7] = result;
}

//[Opcode(0x151, "binarysearch", 7, 1)]
- (void)op_binarysearch:(uint32_t *)args
{
    uint32_t key = args[0];
    uint32_t keySize = args[1];
    uint32_t start = args[2];
    uint32_t structSize = args[3];
    uint32_t numStructs = args[4];
    uint32_t keyOffset = args[5];
    SearchOptions options = (SearchOptions)args[6];

    args[7] = PerformBinarySearch(key, keySize, start, structSize, numStructs, keyOffset, options);
}

// this is a separate method because it's also used by Veneer.CP__Tab
private uint32_t PerformBinarySearch(uint32_t key, uint32_t keySize, uint32_t start, uint32_t structSize, uint32_t numStructs, uint32_t keyOffset, SearchOptions options)
{
    if ((options & SearchOptions.ReturnIndex) != 0)
        throw new VMException("ReturnIndex option may not be used with binarysearch");
    if (keySize > 4 && (options & SearchOptions.KeyIndirect) == 0)
        throw new VMException("KeyIndirect option must be used when searching for a >4 byte key");

    uint32_t result = (options & SearchOptions.ReturnIndex) == 0 ? 0 : 0xFFFFFFFF;
    uint32_t low = 0, high = numStructs;

    while (low < high)
    {
        uint32_t index = (low + high) / 2;
        int cmp = CompareKeys(key, start + index * structSize + keyOffset, keySize, options);
        if (cmp == 0)
        {
            // found it
            if ((options & SearchOptions.ReturnIndex) == 0)
                result = start + index * structSize;
            else
                result = index;
            break;
        }
        else if (cmp < 0)
        {
            high = index;
        }
        else
        {
            low = index + 1;
        }
    }
    return result;
}

//[Opcode(0x152, "linkedsearch", 6, 1)]
- (void)op_linkedsearch:(uint32_t *)args
{
    uint32_t key = args[0];
    uint32_t keySize = args[1];
    uint32_t start = args[2];
    uint32_t keyOffset = args[3];
    uint32_t nextOffset = args[4];
    SearchOptions options = (SearchOptions)args[5];

    uint32_t result = 0;
    uint32_t node = start;

    while (node != 0)
    {
        if ((options & SearchOptions.ZeroKeyTerminates) != 0 &&
            KeyIsZero(node + keyOffset, keySize))
        {
            // stop searching, even if this key would match
            break;
        }

        int cmp = CompareKeys(key, node + keyOffset, keySize, options);
        if (cmp == 0)
        {
            // found it
            result = node;
            break;
        }

        // advance to next item
        node = image.ReadInt32(node + nextOffset);
    }

    args[6] = result;
}

#pragma mark Stack Manipulation

//[Opcode(0x50, "stkcount", 0, 1)]
- (void)op_stkcount:(uint32_t *)args
{
    args[0] = (sp - (fp + frameLen)) / 4;
}

//[Opcode(0x51, "stkpeek", 1, 1)]
- (void)op_stkpeek:(uint32_t *)args
{
    uint32_t position = sp - 4 * (1 + args[0]];
    if (position < (fp + frameLen))
        throw new VMException("Stack underflow");

    args[1] = ReadFromStack(position);
}

//[Opcode(0x52, "stkswap", 0)]
- (void)op_stkswap:(uint32_t *)args
{
    if (sp - (fp + frameLen) < 8)
        throw new VMException("Stack underflow");

    uint32_t a = Pop();
    uint32_t b = Pop();
    Push(a);
    Push(b);
}

//[Opcode(0x53, "stkroll", 2)]
- (void)op_stkroll:(uint32_t *)args
{
    int items = (int)args[0];
    int distance = (int)args[1];

    if (items != 0)
    {
        distance %= items;

        if (distance != 0)
        {
            // rolling X items down Y slots == rolling X items up X-Y slots
            if (distance < 0)
                distance += items;

            if (sp - (fp + frameLen) < 4 * items)
                throw new VMException("Stack underflow");

            Stack<uint32_t> temp1 = new Stack<uint32_t>(distance);
            Stack<uint32_t> temp2 = new Stack<uint32_t>(items - distance);

            for (int i = 0; i < distance; i++)
                temp1.Push(Pop());
            for (int i = distance; i < items; i++)
                temp2.Push(Pop());
            while (temp1.Count > 0)
                Push(temp1.Pop());
            while (temp2.Count > 0)
                Push(temp2.Pop());
        }
    }
}

//[Opcode(0x54, "stkcopy", 1)]
- (void)op_stkcopy:(uint32_t *)args
{
    uint32_t bytes = args[0] * 4;
    if (bytes > sp - (fp + frameLen))
        throw new VMException("Stack underflow");

    uint32_t start = sp - bytes;
    while (bytes-- > 0)
        stack[sp++] = stack[start++];
}

private enum Gestalt
{
    GlulxVersion = 0,
    TerpVersion = 1,
    ResizeMem = 2,
    Undo = 3,
    IOSystem = 4,
    Unicode = 5,
    MemCopy = 6,
    MAlloc = 7,
    MAllocHeap = 8,
}

//[Opcode(0x100, "gestalt", 2, 1)]
- (void)op_gestalt:(uint32_t *)args
{
    Gestalt selector = (Gestalt)args[0];
    switch (selector)
    {
        case Gestalt.GlulxVersion:
            args[2] = 0x00030100;
            break;

        case Gestalt.TerpVersion:
            args[2] = 0x00000900;
            break;

        case Gestalt.ResizeMem:
        case Gestalt.Undo:
        case Gestalt.Unicode:
        case Gestalt.MemCopy:
        case Gestalt.MAlloc:
            args[2] = 1;
            break;

        case Gestalt.IOSystem:
            if (args[1] == 0 || args[1] == 1 || args[1] == 20)
                args[2] = 1;
            else
                args[2] = 0;
            break;

        case Gestalt.MAllocHeap:
            if (heap == null)
                args[2] = 0;
            else
                args[2] = heap.Address;
            break;

        default:
            // unrecognized gestalt selector
            args[2] = 0;
            break;
    }
}

//[Opcode(0x101, "debugtrap", 1)]
- (void)op_debugtrap:(uint32_t *)args
{
    uint32_t status = args[0];
    System.Diagnostics.Debugger.Break();
}

#pragma mark Game State

//[Opcode(0x120, "quit", 0)]
- (void)op_quit:(uint32_t *)args
{
    // end execution
    running = false;
}

//[Opcode(0x121, "verify", 0, 1)]
- (void)op_verify:(uint32_t *)args
{
    // we already verified the game when it was loaded
    args[0] = 0;
}

//[Opcode(0x122, "restart", 0)]
- (void)op_restart:(uint32_t *)args
{
    Restart();
}

//[Opcode(0x123, "save", 1, Rule = OpcodeRule.DelayedStore)]
- (void)op_save:(uint32_t *)args
{
    if (nestingLevel == 0 && SaveRequested != null)
    {
        SaveRestoreEventArgs e = new SaveRestoreEventArgs();
        SaveRequested(this, e);
        if (e.Stream != null)
        {
            try
            {
                do
                {
                    try
                    {
                        SaveToStream(e.Stream, args[1], args[2]];
                    }
                    catch (Exception ex)
                    {
                        if (SaveRestoreError != null)
                        {
                            SaveRestoreErrorEventArgs ee = new SaveRestoreErrorEventArgs();
                            ee.WasSaving = true;
                            ee.Exception = ex;
                            ee.Stream = e.Stream;
                            ee.Retry = false;
                            SaveRestoreError(this, ee);

                            if (ee.Retry)
                            {
                                if (e.Stream != ee.Stream)
                                {
                                    e.Stream.Close();
                                    e.Stream = ee.Stream;
                                }
                                continue;
                            }
                        }

                        // unrecoverable
                        PerformDelayedStore(args[1], args[2], 1);
                        return;
                    }
                } while (false);
            }
            finally
            {
                e.Stream.Close();
            }
            PerformDelayedStore(args[1], args[2], 0);
            return;
        }
    }

    // failed
    PerformDelayedStore(args[1], args[2], 1);
}

//[Opcode(0x124, "restore", 1, Rule = OpcodeRule.DelayedStore)]
- (void)op_restore:(uint32_t *)args
{
    if (LoadRequested != null)
    {
        SaveRestoreEventArgs e = new SaveRestoreEventArgs();
        LoadRequested(this, e);
        if (e.Stream != null)
        {
            try
            {
                do
                {
                    try
                    {
                        LoadFromStream(e.Stream);
                    }
                    catch (Exception ex)
                    {
                        if (SaveRestoreError != null)
                        {
                            SaveRestoreErrorEventArgs ee = new SaveRestoreErrorEventArgs();
                            ee.WasSaving = false;
                            ee.Exception = ex;
                            ee.Stream = e.Stream;
                            ee.Retry = false;
                            SaveRestoreError(this, ee);

                            if (ee.Retry)
                            {
                                if (e.Stream != ee.Stream)
                                {
                                    e.Stream.Close();
                                    e.Stream = ee.Stream;
                                }
                                continue;
                            }
                        }

                        // unrecoverable
                        PerformDelayedStore(args[1], args[2], 1);
                        return;
                    }
                } while (false);
            }
            finally
            {
                e.Stream.Close();
            }
            return;
        }
    }

    // failed
    PerformDelayedStore(args[1], args[2], 1);
}

//[Opcode(0x125, "saveundo", 0, 0, Rule = OpcodeRule.DelayedStore)]
- (void)op_saveundo:(uint32_t *)args
{
    if (nestingLevel != 0)
    {
        // can't save if there's native code on the call stack
        PerformDelayedStore(args[0], args[1], 1);
        return;
    }

    MemoryStream buffer = new MemoryStream();
    SaveToStream(buffer, args[0], args[1]];

    if (undoBuffers.Count >= MAX_UNDO_LEVEL)
        undoBuffers.RemoveAt(0);

    undoBuffers.Add(buffer);

    PerformDelayedStore(args[0], args[1], 0);
}

//[Opcode(0x126, "restoreundo", 0, 0, Rule = OpcodeRule.DelayedStore)]
- (void)op_restoreundo:(uint32_t *)args
{
    if (undoBuffers.Count == 0)
    {
        PerformDelayedStore(args[0], args[1], 1);
    }
    else
    {
        MemoryStream buffer = undoBuffers[undoBuffers.Count - 1];
        undoBuffers.RemoveAt(undoBuffers.Count - 1);

        buffer.Seek(0, System.IO.SeekOrigin.Begin);
        LoadFromStream(buffer);
    }
}

//[Opcode(0x127, "protect", 2)]
- (void)op_protect:(uint32_t *)args
{
    if (args[0] < image.EndMem)
    {
        protectionStart = args[0];
        protectionLength = args[1];

        if (protectionStart >= image.RamStart)
        {
            protectionStart -= image.RamStart;
        }
        else
        {
            protectionStart = 0;
            protectionLength -= image.RamStart - protectionStart;
        }

        if (protectionStart + protectionLength > image.EndMem)
            protectionLength = image.EndMem - protectionStart;
    }
}

#pragma mark Random Number Generator

//[Opcode(0x110, "random", 1, 1)]
- (void)op_random:(uint32_t *)args
{
    if (args[0] == 0)
    {
        // 32 random bits
        byte[] buffer = new byte[4];
        randomGenerator.NextBytes(buffer);
        args[1] = (uint32_t)(buffer[0] << 24 + buffer[1] << 16 + buffer[2] << 8 + buffer[3]];
    }
    else if ((int)args[0] > 0)
    {
        // range: 0 to args[0] - 1
        args[1] = (uint32_t)randomGenerator.Next((int)args[0]];
    }
    else
    {
        // range: args[0] + 1 to 0
        args[1] = (uint32_t)(-randomGenerator.Next(-(int)args[0]));
    }
}

//[Opcode(0x111, "setrandom", 1)]
- (void)op_setrandom:(uint32_t *)args
{
    if (args[0] == 0)
        randomGenerator = new Random();
    else
        randomGenerator = new Random((int)args[0]];
}

#pragma mark FyreVM Specific

/// <summary>
/// Selects a function for the FyreVM system call opcode.
/// </summary>
private enum FyreCall
{
    /// <summary>
    /// Reads a line from the user: args[1] = buffer, args[2] = buffer size.
    /// </summary>
    ReadLine = 1,
    /// <summary>
    /// Selects a text style: args[1] = an OutputStyle value (see OutputBuffer.cs).
    /// </summary>
    SetStyle = 2,
    /// <summary>
    /// Converts a character to lowercase: args[1] = the character,
    /// result = the lowercased character.
    /// </summary>
    ToLower = 3,
    /// <summary>
    /// Converts a character to uppercase: args[1] = the character,
    /// result = the uppercased character.
    /// </summary>
    ToUpper = 4,
    /// <summary>
    /// Selects an output channel: args[1] = an OutputChannel value (see Output.cs).
    /// </summary>
    Channel = 5,
    /// <summary>
    /// Turns the main channel's output filtering on or off: args[1] = nonzero to
    /// turn it on.
    /// </summary>
    EnableFilter = 6,
    /// <summary>
    /// Reads a character from the user: result = the 16-bit Unicode value.
    /// </summary>
    ReadKey = 7,
    /// <summary>
    /// Registers a veneer function address or constant value: args[1] = a
    /// VeneerSlot value (see Veneer.cs), args[2] = the function address or
    /// constant value, result = nonzero if the value was accepted.
    /// </summary>
    SetVeneer = 8,
}

//[Opcode(0x1000, "fyrecall", 3, 1)]
- (void)op_fyrecall:(uint32_t *)args
{
    args[3] = 0;

    FyreCall call = (FyreCall)args[0];
    switch (call)
    {
        case FyreCall.ReadLine:
            DeliverOutput();
            InputLine(args[1], args[2]];
            break;

        case FyreCall.ReadKey:
            DeliverOutput();
            args[3] = (uint32_t)InputChar();
            break;

        case FyreCall.SetStyle:
            outputBuffer.SetStyle((OutputStyle)args[1]];
            break;

        case FyreCall.ToLower:
        case FyreCall.ToUpper:
            byte[] bytes = new byte[] { (byte)args[1] };
            char[] chars = System.Text.Encoding.GetEncoding(LATIN1_CODEPAGE).GetChars(bytes);
            if (call == FyreCall.ToLower)
                chars[0] = char.ToLower(chars[0]];
            else
                chars[0] = char.ToUpper(chars[0]];
            bytes = System.Text.Encoding.GetEncoding(LATIN1_CODEPAGE).GetBytes(chars);
            args[3] = bytes[0];
            break;

        case FyreCall.Channel:
            outputBuffer.Channel = (OutputChannel)args[1];
            break;

        case FyreCall.EnableFilter:
            gameWantsFiltering = (args[1] != 0);
            outputBuffer.FilterEnabled = allowFiltering & gameWantsFiltering;
            break;

        case FyreCall.SetVeneer:
            args[3] = (uint32_t)(veneer.SetSlot(args[1], args[2]) ? 1 : 0);
            break;

        default:
            throw new VMException("Unrecognized FyreVM system call #" + args[0].ToString());
    }
}
*/
@end