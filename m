Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63CFD2F2A44
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 09:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387648AbhALIqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 03:46:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:46892 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727057AbhALIqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 03:46:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B73C6AB92;
        Tue, 12 Jan 2021 08:45:53 +0000 (UTC)
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>, tdevries@suse.com,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
References: <20210111200027.GH25645@zn.tnic>
 <E74AC970-CFCF-4CFD-A71F-F719F5BCE2DC@amacapital.net>
 <CALCETrV=BpFwR-RU5ORioBCZj3RwK7nmD2Yz3VNd4gfFjukRAw@mail.gmail.com>
 <0ad68c87-ac2e-478e-ed97-95256464a3ba@suse.de>
 <CALCETrXkePULoyH85bmUGfCbvn4M9xxQOK9v_UL_+BkwUDrt1Q@mail.gmail.com>
From:   Tom de Vries <tdevries@suse.de>
Subject: Re: gdbserver + fsgsbase kaputt
Message-ID: <39be5148-ec03-8b7a-98d9-2d9295f54407@suse.de>
Date:   Tue, 12 Jan 2021 09:45:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <CALCETrXkePULoyH85bmUGfCbvn4M9xxQOK9v_UL_+BkwUDrt1Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/21 4:31 AM, Andy Lutomirski wrote:
> On Mon, Jan 11, 2021 at 3:52 PM Tom de Vries <tdevries@suse.de> wrote:
>>
>> On 1/12/21 12:40 AM, Andy Lutomirski wrote:
>>> On Mon, Jan 11, 2021 at 1:06 PM Andy Lutomirski <luto@amacapital.net> wrote:
>>>>
>>>>
>>>>> On Jan 11, 2021, at 12:00 PM, Borislav Petkov <bp@alien8.de> wrote:
>>>>>
>>>>
>>>>
>>>>> Or do you mean I should add "unsafe_fsgsbase" to grub cmdline and bisect
>>>>> with fsgsbase enabled in all test kernels?
>>>>
>>>> Yes. But I can also look myself in a bit.
>>>>
>>>
>>> Tom, if I reproduce it in an interactive gdb and play a bit, I get:
>>>
>>> Program received signal SIGSEGV, Segmentation fault.
>>> 0xf7df2cb6 in init_cacheinfo () from target:/lib/libc.so.6
>>> (gdb) p $gs = $gs
>>> $1 = 99
>>> (gdb) si
>>>
>>> Program terminated with signal SIGSEGV, Segmentation fault.
>>> The program no longer exists.
>>>
>>> That's gdb itself crashing.  Any idea what's wrong?
>>>
>>
>> The first "Program received signal SIGSEGV, Segmentation fault" means
>> that gdb intercepts the sigsegv, and allows you to inspect it f.i. by
>> printing $_siginfo.  The inferior is still live at this point.
>>
>> Then when trying to continue using si,  the signal is passed on to the
>> inferior, which means it'll be terminated.
>>
>> AFAIU, gdb has not crashed, and behaves as expected.  See below for a
>> similar scenario.
>>
>> Thanks,
>> - Tom
>>
>> ...
>> $ cat test2.c
>> int
>> main (void)
>> {
>>   *((int *)0) = 0;
>>   return 0;
>> }
>> $ gcc test2.c
>> $ ./a.out
>> Segmentation fault (core dumped)
>> $ gdb -q ./a.out
>> Reading symbols from ./a.out...
>> (gdb) r
>> Starting program: /home/vries/a.out
>>
>> Program received signal SIGSEGV, Segmentation fault.
>> 0x00000000004004a0 in main ()
>> (gdb) si
>>
>> Program terminated with signal SIGSEGV, Segmentation fault.
>> The program no longer exists.
>> (gdb)
>> ...
>>
> 
> Hah, you're right.  Is there an easy way to tell gdb to suppress the
> first signal and try again?
> 

Say the signal comes from outside the inferior, f.i. one did "kill -s
SIGSEGV <pid>" or some such.

The command "enqueue-signal 0" ignores the signal, after which you can
continue executing, using f.i. continue or si.

The command "signal 0" is a shorthand for "enqueue-signal 0; continue".

One can also change the handling of the signal in the debug session as a
whole using the command handle, f.i. "handle SIGSEGV nopass" to not pass
the SIGSEGV signal to the inferior.

In this case however, the signal comes from an insn, and we can ignore
it, but stepping further will just regenerate the same signal, unless we
fix the cause.

In the debug scenario below, we:
- fix the cause by overwriting the register containing the invalid
  dereferenced pointer value with the valid pointer value p2
- ignore the signal using "enqueue-signal 0"
- continue execution using "si"

Thanks,
- Tom

...
$ cat test2.c
int a;

int
main (void)
{
  int *p = 0;
  int *p2 = &a;
  *p = 0;
  return 0;
}
$ gcc test2.c -g
$ ./a.out
Segmentation fault (core dumped)
$ objdump -d a.out
  ...
0000000000400497 <main>:
  400497:       55                      push   %rbp
  400498:       48 89 e5                mov    %rsp,%rbp
  40049b:       48 c7 45 f8 00 00 00    movq   $0x0,-0x8(%rbp)
  4004a2:       00
  4004a3:       48 c7 45 f0 2c 10 60    movq   $0x60102c,-0x10(%rbp)
  4004aa:       00
  4004ab:       48 8b 45 f8             mov    -0x8(%rbp),%rax
  4004af:       c7 00 00 00 00 00       movl   $0x0,(%rax)
  4004b5:       b8 00 00 00 00          mov    $0x0,%eax
  4004ba:       5d                      pop    %rbp
  4004bb:       c3                      retq
  4004bc:       0f 1f 40 00             nopl   0x0(%rax)
  ...
$ gdb -q a.out
Reading symbols from a.out...
(gdb) r
Starting program: /home/vries/a.out

Program received signal SIGSEGV, Segmentation fault.
0x00000000004004af in main () at test2.c:8
8         *p = 0;
(gdb) set var $rax = p2
(gdb) queue-signal 0
(gdb) si
9         return 0;
(gdb) p $pc
$1 = (void (*)()) 0x4004b5 <main+30>
(gdb)
...
