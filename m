Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAE6F301116
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 00:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbhAVXnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 18:43:04 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57448 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbhAVXnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 18:43:03 -0500
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611358940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2usHywykDaW7T9UZh7mlPP/pHrQ9ICLZqK1hc6ZZjqk=;
        b=oJUdhNvSa6rK9luJyIOD7gEArax/kG+iUJPwBvwUNBLImKGrv6jC6MmNGLB2ae1VLIY9KE
        5iXfDbxyM/pgoK04yjcHR/04jy/H+AztR3BTgT8GqgKxLY3UGHzDRsgU5gyxRS2IQiWgox
        hC6hUYMZHnlMbirNFvqlPu6XaalOrvzCyGXPoInlf98OBBm44VhkSoUkAG2Btt4QRnHzkE
        fSE0MORiRfDT4FAh7+y0aBBdm4dF9F16Xu9qoXU9gPO05c3gmGpOfe1bCJ5UqdAbPL2aOI
        3WkwVO1CToA18z1+j50q3DiDUQi8LHbfDv9XRwBzLo0so4iPvK1JDom4LNVq+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611358940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2usHywykDaW7T9UZh7mlPP/pHrQ9ICLZqK1hc6ZZjqk=;
        b=//wib/O15OJpWJttK/l4WkFKOCqVrpsg+jvgU4MAWTilKdMPFO3QfVXGNHbKvzlVBiM6kO
        6yPnBvz/mmbnmnDw==
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: fix buffer overflow potential for print_text()
In-Reply-To: <yt9dk0s48y70.fsf@linux.ibm.com>
References: <20210114170412.4819-1-john.ogness@linutronix.de> <yt9dk0s48y70.fsf@linux.ibm.com>
Date:   Sat, 23 Jan 2021 00:48:19 +0106
Message-ID: <87v9bomtd0.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-22, Sven Schnelle <svens@linux.ibm.com> wrote:
> I'm seeing crashes on s390x with this patch while running the glibc
> testsuite. The glibc test suite triggers a few FPU exceptions which
> are printed to the kernel log by default. Looking at the crash dump,
> i see that the console_drivers pointer seems to be overwritten while
> printing that (user space) warning:
>
> crash> print *console_drivers
> $1 = {
>   name = "\247\071\377\373\354!\004\214\000\331\300\345\000\033\353_", 
>   write = 0xa7190001eb119078, 
>   read = 0xe6e320b0050090, 
>   device = 0xa51e0010a7210001, 
>   unblank = 0xa7291000b9e28012, 
>   setup = 0xe320f0a00004e320, 
>   exit = 0x208e0094eb112000, 
>   match = 0xcec1c006e017f, 
>   flags = -4984, 
>   index = 133, 
>   cflag = 8143136, 
>   data = 0x800458108004ec12, 
>   next = 0x5007eaf000000
> }
>
> crash> x/16i console_drivers
>    0x79009700:  lghi    %r3,-5
>    0x79009704:  aghik   %r2,%r1,1164
>    0x7900970a:  brasl   %r14,0x79386dc8
>    0x79009710:  lghi    %r1,1
>    0x79009714:  laog    %r1,%r1,120(%r9)
>    0x7900971a:  llgc    %r2,5(%r11)
>    0x79009720:  llilh   %r1,16
>    0x79009724:  tmll    %r2,1
>    0x79009728:  lghi    %r2,4096
>    0x7900972c:  locgre  %r1,%r2
>    0x79009730:  lg      %r2,160(%r15)
>    0x79009736:  llc     %r2,142(%r2)
>    0x7900973c:  srlg    %r1,%r1,0(%r2)
>    0x79009742:  clij    %r1,1,12,0x7900981e
>    0x79009748:  cgij    %r8,0,8,0x79009852
>    0x7900974e:  la      %r2,4(%r8)
>
> crash> sym 0x79009700
> 79009700 (t) iomap_finish_ioend+192
> /usr/src/debug/kernel-5.10.fc33/linux-5.11.0-20210122.rc4.git0.9f29bd8b2e71.300.fc33.s390x/./include/linux/pagemap.h:
> 59
>
> So somehow the pointer for console_drivers changes.
>
> I can't provide the normal kernel crash output as printk is no longer
> working,

I don't understand what you mean here. The crash tool can dump the
printk buffer.

I would be curious to see what the messages look like. It would also be
helpful to know the last message you saw on the console.

> but in crash the backtrace looks like this:
> crash> bt
> PID: 859915  TASK: dad24000          CPU: 9   COMMAND: "ld.so.1"
>  LOWCORE INFO:
>   -psw      : 0x0002000180000000 0x0000000078c8400e
>   -function : stop_run at 78c8400e
>   -prefix   : 0x0041e000
>   -cpu timer: 0x7ffff953a957e166
>   -clock cmp: 0xd92876863ac66b00
>   -general registers:
>      0xf0f0f0f000000000 0x0000000078c8400e
>      0x0000000079984830 0x0000000079984830
>      0x0000000079ac62c0 0x0000000000000002
>      0x0000000000000038 000000000000000000
>      0x000000007a19157e 000000000000000000
>      0x00000000fffffffa 000000000000000000
>      0x00000000dad24000 000000000000000000
>      0x0000000078c8416e 0x00000380033136f0
>   -access registers:
>      0x7d5b4da0 0xa2a795c0 0000000000 0000000000
>      0000000000 0000000000 0000000000 0000000000
>      0000000000 0000000000 0000000000 0000000000
>      0000000000 0000000000 0000000000 0000000000
>   -control registers:
>      0x00a0000014966a10 0x000000007a15c007
>      0x000000000001d0a0 000000000000000000
>      0x000000000000ffff 0x000000000001d080
>      0x000000003b000000 0x00000001f29b81c7
>      0x0000000000008000 000000000000000000
>      000000000000000000 000000000000000000
>      000000000000000000 0x000000007a15c007
>      0x00000000db000000 0x000000000001d0c0
>   -floating point registers:
>      0x5faaaaabeb67f92f 0x0007fffffffffff8
>      0x40400000eb67f000 000000000000000000
>      0x0000000000000007 0x0000006400000000
>      0x000002aa2a63f028 0x000000000963cf85
>      0x000000002a642c60 000000000000000000
>      0x7f85516ceb67f222 0x000003ffeb67f528
>      0x000003ffeb67f230 0x0000000100000000
>      0x000003ffeb67f21d 0x000002aa28d2d970
>
>  #0 [38003313710] stop_run at 78c8400e
>  #1 [38003313728] atomic_notifier_call_chain at 78ced536
>  #2 [38003313778] panic at 7974aeca
>  #3 [38003313818] die at 78c897ea
>  #4 [38003313880] do_no_context at 78c9b230
>  #5 [380033138b8] pgm_check_handler at 7976438c
>  PSW:  0404c00180000000 0000000078d304ba (kmsg_dump_rewind+290)
>  GPRS: 0000000000000020 0000000000000000 0000000000000000 00000000ffffec88 
>        000000000000000e 00000000793f4800 0000000000000224 0000000000000000 
>        0000000000000000 0000000000000000 0000000000000224 0005007eaf000000 
>        00000000dad24000 0000000000000000 0000038003313a68 0000038003313a18 
>  #0 [38003313a68] console_unlock at 78d3158e
>  #1 [38003313b48] vprintk_emit at 78d32f50
>  #2 [38003313ba8] vprintk_default at 78d32f9e
>  #3 [38003313c00] printk at 7974bfae
>  #4 [38003313c90] show_code at 78c8588e
>  #5 [38003313de0] show_registers at 7974a26e
>  #6 [38003313e70] show_regs at 78c8961e
>  #7 [38003313ea0] pgm_check_handler at 7976438c
>  PSW:  0705300080000000 000000007d7983b2 (user space)
>  GPRS: 0000000000000000 000000007d798360 0000000000000010 000003ff00000004 
>        000000007f854dd0 000000007d7e9788 000003ff00401b30 000000007f854ff8 
>        000003ff00000000 000003ff7d5b4da0 000003ff00000000 000003ff00000010 
>        000003ff004022c6 000003ff004024b0 0000000080401796 000000007f854de8
>
> kmsg_dump_rewind+290 is:
>
>               if (!(con->flags & CON_ENABLED))
>                         continue;
>
> in kernel/printk/printk.c:1845
>
> I haven't dived into whether our show_code() is doing something wrong
> which was covered in the past or whether that's because of the patch
> above but wanted to make you aware of that in case you have an idea.
> Otherwise i have to dig into the code.

Unless we are dealing with very long printk messages that normally get
truncated (800+ characters) this patch simply adds a string
terminator. I do not see how that could possibly cause this kind of
damage.

When this triggers, there is nothing happening with consoles registering
or deregistering, right?

The string terminator (kernel/printk/printk.c:1402) is only added for
paranoia. If you comment that out, this patch will have no effect (for
"normal" length lines). I would be curious if that somehow makes a
difference for you.

John Ogness
