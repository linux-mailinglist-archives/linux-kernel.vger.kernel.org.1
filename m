Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C02F428B363
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 13:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387835AbgJLLHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 07:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387594AbgJLLHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 07:07:01 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C40C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 04:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=v7moxPw5GuhjvVezk/Fb3tR0JousuzieHNxwThJQAJ0=; b=g0KdTHBzcgP8PZzGn5eunUkof
        2/w4xxU5g7+dnNpLF0gdWvjzFkMfq9toP8huNVb9Gw6HMWe4AJiF45/rRXwh8PvzNHIn0Xw5U0tei
        OkzAAnKj6YkLdYexDyMHJt9MV30CNM8JeVd0+EjztnuIyhoJTfps1AG5oZAR0v52e5Dl3RiRHbZxY
        IZrnra8TJNIDiQy086TIdvoXfQzvPJzGzHI6syy7Zn+r6raDVb4C76K+Dp4x96LnntUZRN+5gz3P5
        M44qfYiy7ppmucLu8XdSJ/7/m7L/1Ij8dbzu11F9aqq+ilOMiSWaxTwdQrxtR89yszVZdsWTKDqDK
        9tyvY3fqA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45044)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1kRvfG-0003sM-JE; Mon, 12 Oct 2020 12:06:50 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1kRvfA-0005YE-9H; Mon, 12 Oct 2020 12:06:44 +0100
Date:   Mon, 12 Oct 2020 12:06:44 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
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
Message-ID: <20201012110643.GO1551@shell.armlinux.org.uk>
References: <20201009075957.110017-1-nixiaoming@huawei.com>
 <20201009080849.GM1551@shell.armlinux.org.uk>
 <20201009081820.jargnmck6zfkzegx@linutronix.de>
 <20201011213238.GN1551@shell.armlinux.org.uk>
 <20201012100318.4ikyffo3mcnq6bnl@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012100318.4ikyffo3mcnq6bnl@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 12:03:18PM +0200, Sebastian Andrzej Siewior wrote:
> On 2020-10-11 22:32:38 [+0100], Russell King - ARM Linux admin wrote:
> > I don't have a problem getting rid of the hex numbers in [< >]
> > although then I will need to convert the symbol back to an address
> > using the vmlinux to then calculate its address to then find the
> > appropriate place in the objdump output - because objdump does
> > _not_ use the symbol+offset annotation.  Yes, I really do look up
> > the numeric addresses in the objdump output to then read the
> > disassembly.
> > 
> > $ objdump -d vmlinux | less
> > 
> > and then search for the address is the fastest and most convenient
> > way for me rather than having to deal with some random script.
> > 
> > Maybe I'm just antequated about how I do my debugging, but this
> > seems to me to be the most efficient and fastest way.
> 
> besides what Josh mentioned, there is also 
>          scripts/decode_stacktrace.sh path-vmlinux
>  
> where you can copy/paste your complete stack trace / dmesg and it will
> decode it line by line. So if you invoke
>         scripts/decode_stacktrace.sh vmlinux.o
> 
> and paste this:
> 
> |[    7.568155] 001: PC is at do_work_pending+0x190/0x5c4
> |[    7.568641] 001: LR is at slow_work_pending+0xc/0x20
> |[    7.569232] 001: Backtrace:
> |[    7.569367] 001: [<c020c2d0>] (do_work_pending) from [<c02000cc>] (slow_work_pending+0xc/0x20)
> 
> you get this in return:
> |[    7.568155] 001: PC is at do_work_pending (arch/arm/kernel/signal.c:616 arch/arm/kernel/signal.c:670)
> |[    7.568641] 001: LR is at slow_work_pending (arch/arm/kernel/entry-common.S:112)
> |[    7.569232] 001: Backtrace:
> |[    7.569367] 001: (do_work_pending) from slow_work_pending (arch/arm/kernel/entry-common.S:112)

That's assuming:

1) you have built the kernel with debug information enabled
   (I never do, it uses way too much disk space)
2) you want to look at the C code rather than the assembly.

I think you've assumed that I debug oopses by looking primerily at C
code. I don't. I understand the assembly and then look at the C code.

I've stated in the past in detail how I debug the kernel when someone
has posted a hard-to-debug oops, going through the validation of the
dumped state, sometimes to find the bug in a function several parents
up from the one where the oops actually occurred.

However, as I've said, I have little problem removing the hex values
inside [< >] as I can work around that. Removing the other information
is what I'm objecting to.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
