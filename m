Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA9C285CE7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 12:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbgJGKbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 06:31:08 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:42971 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbgJGKbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 06:31:07 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 097AUXEr006622;
        Wed, 7 Oct 2020 12:30:33 +0200
Date:   Wed, 7 Oct 2020 12:30:33 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Florian Weimer <fweimer@redhat.com>,
        linux-toolchains@vger.kernel.org, Will Deacon <will@kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
        torvalds@linux-foundation.org
Subject: Re: Control Dependencies vs C Compilers
Message-ID: <20201007103033.GB6550@1wt.eu>
References: <20201006114710.GQ2628@hirez.programming.kicks-ass.net>
 <875z7nm4qm.fsf@oldenburg2.str.redhat.com>
 <20201007093243.GB2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007093243.GB2628@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.6.1 (2016-04-27)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 11:32:43AM +0200, Peter Zijlstra wrote:
> A branch that cannot be optimized away and prohibits lifting stores
> over. One possible suggestion would be allowing the volatile keyword as
> a qualifier to if.
> 
> 	x = *foo;
> 	volatile if (x > 42)
> 		*bar = 1;
> 
> This would tell the compiler that the condition is special in that it
> must emit a conditional branch instruction and that it must not lift
> stores (or sequence points) over it.

This test is interesting, because if foo and bar are of the same type,
nothing prevents them from aliasing and the compiler cannot make wild
guesses on them (i.e. they may be plain memory as well as memory-mapped
registers).

Extending it like this shows a difference between the use of volatile
and __atomic_{load,store}_n. While both are correct in that each access
is properly performed, for an unknown reason the compiler decided to
implement two distinct branches in the atomic case and to inflate the
code:

$ gcc -v
gcc version 9.3.0 (GCC)

$ cat foo-volatile.c
long foobar(long *foo, long *bar)
{
        *(volatile long *)bar = 10;
        if (*(volatile long *)foo <= 42)
                *(volatile long *)bar = 64;
        if (*(volatile long *)foo > 42)
                *(volatile long *)bar = 0;
        return *(volatile long *)bar;
}
$ gcc -c -O2 foo-volatile.c
$ objdump -dr foo-volatile.o 
0000000000000000 <foobar>:
   0:   48 c7 06 0a 00 00 00    movq   $0xa,(%rsi)
   7:   48 8b 07                mov    (%rdi),%rax
   a:   48 83 f8 2a             cmp    $0x2a,%rax
   e:   7f 07                   jg     17 <foobar+0x17>
  10:   48 c7 06 40 00 00 00    movq   $0x40,(%rsi)
  17:   48 8b 07                mov    (%rdi),%rax
  1a:   48 83 f8 2a             cmp    $0x2a,%rax
  1e:   7e 07                   jle    27 <foobar+0x27>
  20:   48 c7 06 00 00 00 00    movq   $0x0,(%rsi)
  27:   48 8b 06                mov    (%rsi),%rax
  2a:   c3                      retq   


$ cat foo-atomic.c  
long foobar(long *foo, long *bar)
{
        __atomic_store_n(bar, 10, __ATOMIC_RELAXED);
        if (__atomic_load_n(foo, __ATOMIC_RELAXED) <= 42)
                __atomic_store_n(bar, 64, __ATOMIC_RELAXED);
        if (__atomic_load_n(foo, __ATOMIC_RELAXED) > 42)
                __atomic_store_n(bar, 0, __ATOMIC_RELAXED);
        return __atomic_load_n(bar, __ATOMIC_RELAXED);
}
$ objdump -dr foo-atomic.o 
0000000000000000 <foobar>:
   0:   48 c7 06 0a 00 00 00    movq   $0xa,(%rsi)
   7:   48 8b 07                mov    (%rdi),%rax
   a:   48 83 f8 2a             cmp    $0x2a,%rax
   e:   7e 10                   jle    20 <foobar+0x20>
  10:   48 8b 07                mov    (%rdi),%rax
  13:   48 83 f8 2a             cmp    $0x2a,%rax
  17:   7f 17                   jg     30 <foobar+0x30>
  19:   48 8b 06                mov    (%rsi),%rax
  1c:   c3                      retq   
  1d:   0f 1f 00                nopl   (%rax)
  20:   48 c7 06 40 00 00 00    movq   $0x40,(%rsi)
  27:   48 8b 07                mov    (%rdi),%rax
  2a:   48 83 f8 2a             cmp    $0x2a,%rax
  2e:   7e e9                   jle    19 <foobar+0x19>
  30:   48 c7 06 00 00 00 00    movq   $0x0,(%rsi)
  37:   48 8b 06                mov    (%rsi),%rax
  3a:   c3                      retq   

When building at -Os both produce the same code as the volatile version
above. It *seems* to me that the volatile version always produces more
optimal code, but is it always correct ? This is just an illustration of
how tricky this can currently be and how confusing it can sometimes be
for the developer to make sure the desired code is emitted in a few
special cases. And just for this, having the compiler support more easily
predictable constructs would be a nice improvement.

Willy
