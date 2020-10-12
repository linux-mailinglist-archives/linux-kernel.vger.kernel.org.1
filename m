Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9312E28B1F1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 12:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbgJLKDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 06:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729400AbgJLKDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 06:03:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF80C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 03:03:21 -0700 (PDT)
Date:   Mon, 12 Oct 2020 12:03:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602496999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=urpCCm7OfhmrHoV8fTLVu0OnW199cthG54BdXPavDDs=;
        b=WgFJExp6VUKALTQ5MfJIoCbRmzPP7PQThqmEAD9yiaZPcWdDZP4pWv2c13el5rAUI4nYaa
        et2QhzzJFdSnff4R72gxEoXC4h4LDbTdmewtJ48rRqse/mOU2k5jvmUBQG/sX1tBBrjidj
        2w5BqAvhH03VsLgPULqxJ/BGyV00UWzct7oKJWem3f47RF3ywPfaEnGeMhOb2nP4LbLExd
        9G9+rC9ZADrrhcrtqwFMJ+p+IXpbapY2MOjH6ZuFmMcFOZ1Xbfdli4gU8CvMeK8UyBFflf
        QXoBD+CA8Wx86VyH4l9CVtfcfT+KVosdWDC4UAl8IPlT/c50kQF6mrGOZa/rGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602496999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=urpCCm7OfhmrHoV8fTLVu0OnW199cthG54BdXPavDDs=;
        b=STzgUXdOFKHedf3MOLniJPVkjuLiVFByUvFhVM9wNfHCynvYu5KijZvq88kfUwu1nNbeaj
        6M6Y68bQsjx2etAg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Xiaoming Ni <nixiaoming@huawei.com>, dima@arista.com,
        will@kernel.org, jpoimboe@redhat.com, akpm@linux-foundation.org,
        christian.brauner@ubuntu.com, viro@zeniv.linux.org.uk,
        ldufour@linux.ibm.com, amanieu@gmail.com, walken@google.com,
        ben.dooks@codethink.co.uk, tglx@linutronix.de, mingo@kernel.org,
        vincent.whitchurch@axis.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, wangle6@huawei.com,
        luohaizheng@huawei.com
Subject: Re: [PATCH] arm:traps: Don't print stack or raw PC/LR values in
 backtraces
Message-ID: <20201012100318.4ikyffo3mcnq6bnl@linutronix.de>
References: <20201009075957.110017-1-nixiaoming@huawei.com>
 <20201009080849.GM1551@shell.armlinux.org.uk>
 <20201009081820.jargnmck6zfkzegx@linutronix.de>
 <20201011213238.GN1551@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201011213238.GN1551@shell.armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-11 22:32:38 [+0100], Russell King - ARM Linux admin wrote:
> I don't have a problem getting rid of the hex numbers in [< >]
> although then I will need to convert the symbol back to an address
> using the vmlinux to then calculate its address to then find the
> appropriate place in the objdump output - because objdump does
> _not_ use the symbol+offset annotation.  Yes, I really do look up
> the numeric addresses in the objdump output to then read the
> disassembly.
> 
> $ objdump -d vmlinux | less
> 
> and then search for the address is the fastest and most convenient
> way for me rather than having to deal with some random script.
> 
> Maybe I'm just antequated about how I do my debugging, but this
> seems to me to be the most efficient and fastest way.

besides what Josh mentioned, there is also 
         scripts/decode_stacktrace.sh path-vmlinux
 
where you can copy/paste your complete stack trace / dmesg and it will
decode it line by line. So if you invoke
        scripts/decode_stacktrace.sh vmlinux.o

and paste this:

|[    7.568155] 001: PC is at do_work_pending+0x190/0x5c4
|[    7.568641] 001: LR is at slow_work_pending+0xc/0x20
|[    7.569232] 001: Backtrace:
|[    7.569367] 001: [<c020c2d0>] (do_work_pending) from [<c02000cc>] (slow_work_pending+0xc/0x20)

you get this in return:
|[    7.568155] 001: PC is at do_work_pending (arch/arm/kernel/signal.c:616 arch/arm/kernel/signal.c:670)
|[    7.568641] 001: LR is at slow_work_pending (arch/arm/kernel/entry-common.S:112)
|[    7.569232] 001: Backtrace:
|[    7.569367] 001: (do_work_pending) from slow_work_pending (arch/arm/kernel/entry-common.S:112)

Sebastian
