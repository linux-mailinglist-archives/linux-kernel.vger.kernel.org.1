Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9C62A4C64
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 18:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbgKCRMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 12:12:02 -0500
Received: from foss.arm.com ([217.140.110.172]:52406 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727530AbgKCRMB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 12:12:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3579B106F;
        Tue,  3 Nov 2020 09:12:00 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.57.89])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D2D123F718;
        Tue,  3 Nov 2020 09:11:58 -0800 (PST)
Date:   Tue, 3 Nov 2020 17:11:53 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: Does LOCKDEP work on ARM64?
Message-ID: <20201103171153.GA46833@C02TD0UTHF1T.local>
References: <CACT4Y+aAzoJ48Mh1wNYD17pJqyEcDnrxGfApir=-j171TnQXhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+aAzoJ48Mh1wNYD17pJqyEcDnrxGfApir=-j171TnQXhw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Sat, Oct 24, 2020 at 11:51:49AM +0200, Dmitry Vyukov wrote:
> Hello ARM64/LOCKDEP maintainers,
> 
> I've started experimenting with running syzkaller on ARM64 using
> QEMU/TCG. Total execution speed is very low and it ran just a handful
> of tests, but I am seeing massive amounts of locking bugs. Most of
> these were not observed on x86_64, while x86_64 ran gazillions of
> tests by now and most of these are trivial to trigger (depend only on
> call stack) and they do not look ARM64-specific. So I wonder:
> 1. Are there any known issues with LOCKDEP on ARM64?
> 2. Or are all these real and it's x86_64 LOCKDEP that's misbehaving?
> 3. Or are both x86_64 and ARM64 fine and these are just somehow ARM64-specific?

I haven't seen quite the same issues you're seeing, but I haven't had
the chance to fuzz a kernel since ~v5.8. Today I've stumbled over an irq
flag tracing issue (since v5.9) which can cause lockdep's idea of irq
and preemption state to go wrong, which could explain some of the
warnings -- I'm currently investigating that, with more details below.

Otherwise, I have seen warnings regarding suspicious RCU usage in the
past, but didn't have the time to investigate those, so the ones I saw
may have been legitimate. The other warnings you cite below don't look
familiar.

The issue I'm seeing bisected to commit:

  044d0d6de9f50192 ("ockdep: Only trace IRQ edges")

... which (with my fuzzing config) causes
lockdep_assert_preemption_disabled() to blow up during boot:

| ------------[ cut here ]------------
| WARNING: CPU: 3 PID: 1 at include/linux/seqlock.h:271 vtime_user_enter+0x2a8/0x598
| CPU: 3 PID: 1 Comm: init Not tainted 5.10.0-rc2-00001-gfd9f9bd1d7eb #1
| Hardware name: linux,dummy-virt (DT)
| pstate: 104003c5 (nzcV DAIF +PAN -UAO -TCO BTYPE=--)
| pc : vtime_user_enter+0x2a8/0x598
| lr : __context_tracking_enter+0x190/0x198
| sp : ffff3aeb8096fdd0
| x29: ffff3aeb8096fdd0 x28: ffff3aeb80960000
| x27: 0000000000000000 x26: 0000000000000000
| x25: 0000000000000001 x24: ffff3aeb80960000
| x23: ffffa000589d30e8 x22: ffff3aeb80960010
| x21: 0000000100000000 x20: ffff3aeb809605d8
| x19: ffff3aeb80960000 x18: 0000000000001080
| x17: 0000000000001168 x16: 1fffe75d7012dee4
| x15: 0000000000000003 x14: ffffa00053a72c00
| x13: ffff875d7012dfc1 x12: 1fffe75d7012dfc0
| x11: 1fffe75d7012dfc0 x10: ffff875d7012dfc0
| x9 : ffffa000589d30e8 x8 : ffff3aeb8096fe07
| x7 : 0000000000000001 x6 : ffff875d7012dfc1
| x5 : ffff3aeb80960000 x4 : 1ffff4000ba7106f
| x3 : 1fffe75d753fd32c x2 : 1fffe75d7012c002
| x1 : 1fffe75d7012c002 x0 : 0000000100000000
| Call trace:
|  vtime_user_enter+0x2a8/0x598
|  __context_tracking_enter+0x190/0x198
|  context_tracking_enter.part.1+0x64/0xd0
|  context_tracking_user_enter+0x98/0xb8
|  finish_ret_to_user+0x2c/0x13c
| Kernel panic - not syncing: panic_on_warn set ..

... and so it looks like our IRQ flag tracing is going wrong, I suspect
due to the way our local_daif_*() functions trace irqstate changes.

Thanks,
Mark.
  
> 
> Here are details. Kernel is on
> f9893351acaecf0a414baf9942b48d5bb5c688c6 (recent upstream HEAD).
> Kernel config:
> https://gist.githubusercontent.com/dvyukov/c92a1e08f3f7e22b1f0387096d98b18b/raw/9f79f83c3b018ac27a040649f7d0fef36b63b960/gistfile1.txt
> 
> Here is one "Invalid wait context". It looks like just a put_user
> inside of syscall function:
> https://gist.githubusercontent.com/dvyukov/15639a949278a981c8eb125b3088a6b8/raw/286117bc292578c07c8afbf0fa563cd5528821e7/gistfile1.txt
> 
> Here is one "bad unlock balance detected". The looks well balanced and
> the code path is well exercised:
> https://gist.githubusercontent.com/dvyukov/805f867823b9f77a26c2ebedec5b9b9e/raw/2e6605fb5c90f56ebd1ccda78d613b5c219dfb82/gistfile1.txt
> 
> Here is one "workqueue leaked lock". Again, lock/unlock are very local
> and there is no control flow in between:
> https://gist.githubusercontent.com/dvyukov/4d18d35a79d7e74bf66d6e7ec3794ec0/raw/1ff3e2a5d3a825eb0d196af1f81c67a47fa3a2f6/gistfile1.txt
> 
> Here is one confusing "bad unlock balance detected":
> https://gist.githubusercontent.com/dvyukov/e222fa34e04104678c52a5b5b1ad15a3/raw/943c6ebbc022418b89fa63b6282fa1f1f40a276a/gistfile1.txt
> 
> Here is one confusing "suspicious RCU usage":
> https://gist.githubusercontent.com/dvyukov/77b0ec246e1db86e549a80e4a11ec218/raw/0bce97be186c0a6617d8835a694443ed1aa2a98a/gistfile1.txt
> 
> Overall I have more than 50 of these now.
