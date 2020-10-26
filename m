Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2B052994DA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 19:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1789217AbgJZSIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 14:08:54 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:46416 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1782032AbgJZSIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 14:08:54 -0400
X-Greylist: delayed 558 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Oct 2020 14:08:53 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RV6kRgi8PeiaA054B8XN8/43kccUS3ZQbQeGDIsIcFY=; b=I2hlEoPsi2b8JLfqNzDwT5aJ9
        IVVxWtQ5XnDfC0w1TIJIM5RU9fpliDD/3GZ9BBn5oRvsVbx4jHWPFFFyJE5cdvY9KHIE7s0bA5OlG
        aPCeLE5jvTOZhrmJRJ5BoobSZ6EFPeE0CQuMTf38x58ZUWW1hS64G6aeYpT7MP8YS5BcnwH/8wcsZ
        t6E3tXzEFVmyGcm+6eDeVB49l0godO2WvBXegDHer8PcvmEgAI4o3Vfofc7ORdJAkpz8Uddj+SEiv
        LauksjD6Ykb40XR0DpM9GFCPMoRuy4h9qpsZL+J1Pjk1Flwh1Mk15w0wmoIHKiheYNxqm+LgBmKUY
        jniU7GwxQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51292)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1kX6lz-0007tZ-Om; Mon, 26 Oct 2020 17:59:11 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1kX6lt-0003CE-Co; Mon, 26 Oct 2020 17:59:05 +0000
Date:   Mon, 26 Oct 2020 17:59:05 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     dima@arista.com, will@kernel.org, jpoimboe@redhat.com,
        akpm@linux-foundation.org, christian.brauner@ubuntu.com,
        viro@zeniv.linux.org.uk, ldufour@linux.ibm.com, amanieu@gmail.com,
        walken@google.com, ben.dooks@codethink.co.uk, tglx@linutronix.de,
        bigeasy@linutronix.de, mingo@kernel.org,
        vincent.whitchurch@axis.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, wangle6@huawei.com,
        luohaizheng@huawei.com
Subject: Re: ping //Re: [PATCH v2] arm:traps: Don't print stack or raw PC/LR
 hex values in backtraces
Message-ID: <20201026175904.GH1551@shell.armlinux.org.uk>
References: <20201016023141.85300-1-nixiaoming@huawei.com>
 <23a3ce81-e1b6-337f-c217-5027134c0131@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23a3ce81-e1b6-337f-c217-5027134c0131@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 02:33:10PM +0800, Xiaoming Ni wrote:
> ping

The arm tree was closed due to the merge window, and thus patches do
not get applied at that point. Plus I tend not to review development
patches during the merge window.

> On 2020/10/16 10:31, Xiaoming Ni wrote:
> > Printing raw pointer values in backtraces has potential security
> > implications and are of questionable value anyway.
> > 
> > This patch follows x86 and arm64's lead and removes the "Exception stack:"
> > dump from kernel backtraces:
> > 	commit a25ffd3a6302a6 ("arm64: traps: Don't print stack or raw
> > 	 PC/LR values in backtraces")
> > 	commit bb5e5ce545f203 ("x86/dumpstack: Remove kernel text
> > 	 addresses from stack dump")
> > 
> > Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
> > 
> > -------
> > v2:
> >   Delete [<hex numbers>] from the stack according to the email discussion
> >   in patch V1, Other information processing will be discussed in subsequent
> >   patches.
> > 
> > v1: https://lore.kernel.org/lkml/20201009075957.110017-1-nixiaoming@huawei.com/
> >    1. Don't print stack or raw PC/LR hex values in backtraces
> >    2. Don't print stack mem in backtraces
> >    3. if (!panic_on_oops), Don't print stack mem in __die()
> > ---
> >   arch/arm/kernel/process.c | 3 +--
> >   arch/arm/kernel/traps.c   | 4 ++--
> >   2 files changed, 3 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
> > index 8e6ace03e960..71c9e5597d39 100644
> > --- a/arch/arm/kernel/process.c
> > +++ b/arch/arm/kernel/process.c
> > @@ -121,8 +121,7 @@ void __show_regs(struct pt_regs *regs)
> >   	printk("PC is at %pS\n", (void *)instruction_pointer(regs));
> >   	printk("LR is at %pS\n", (void *)regs->ARM_lr);
> > -	printk("pc : [<%08lx>]    lr : [<%08lx>]    psr: %08lx\n",
> > -	       regs->ARM_pc, regs->ARM_lr, regs->ARM_cpsr);
> > +	printk("psr: %08lx\n", regs->ARM_cpsr);
> >   	printk("sp : %08lx  ip : %08lx  fp : %08lx\n",
> >   	       regs->ARM_sp, regs->ARM_ip, regs->ARM_fp);
> >   	printk("r10: %08lx  r9 : %08lx  r8 : %08lx\n",
> > diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
> > index 17d5a785df28..911bbf164875 100644
> > --- a/arch/arm/kernel/traps.c
> > +++ b/arch/arm/kernel/traps.c
> > @@ -68,8 +68,8 @@ void dump_backtrace_entry(unsigned long where, unsigned long from,
> >   	unsigned long end = frame + 4 + sizeof(struct pt_regs);
> >   #ifdef CONFIG_KALLSYMS
> > -	printk("%s[<%08lx>] (%ps) from [<%08lx>] (%pS)\n",
> > -		loglvl, where, (void *)where, from, (void *)from);
> > +	printk("%s (%ps) from (%pS)\n",
> > +		loglvl, (void *)where, (void *)from);
> >   #else
> >   	printk("%sFunction entered at [<%08lx>] from [<%08lx>]\n",
> >   		loglvl, where, from);
> > 
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
