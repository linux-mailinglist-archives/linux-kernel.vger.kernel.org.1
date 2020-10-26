Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11D022994DB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 19:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1789225AbgJZSI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 14:08:57 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:46416 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1789214AbgJZSIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 14:08:55 -0400
X-Greylist: delayed 558 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Oct 2020 14:08:53 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=k86Sk2vzUdIAWAPQ+NHqfUDiJ+SZmpD+LsPmG5feGcA=; b=NDe/P1VbFb3pzpjR++6NAqOf/
        fmUUQsRNOWIKCXzcPczLfURwp/QtACFvZyjzlhKp3Jk6iY/nhj6DjFlttHcU+FxYnWfe7Hf3glLn5
        n2lrFShAAGVRtTC/MbE6zL/oCMMDOjj4rJvywS/RX29ErMLbPy3rAOozPwM4h1YL9bBuGGBoDjxHp
        wIBNcGyvHnzpotXZxTMZE7Pg0tfOMdJN8reDhBH3lY6a2RnBYfnDcfXrjaiRlFWkkeIqhY97WGR+l
        Z3+3prrjFtf27Q6at5sx8begjdB8Exaf3PBXNHjkiMxDHvxa/ldOKoWOFWXkOI5MCj6iAp18/NMkK
        1KwEQC57Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51294)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1kX6oA-0007uS-S1; Mon, 26 Oct 2020 18:01:26 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1kX6oA-0003CP-Ep; Mon, 26 Oct 2020 18:01:26 +0000
Date:   Mon, 26 Oct 2020 18:01:26 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     akpm@linux-foundation.org, tglx@linutronix.de,
        vincent.whitchurch@axis.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        bigeasy@linutronix.de, will.deacon@arm.com, wangle6@huawei.com
Subject: Re: [PATCH] arm:traps:Don't dump the memory in non-system reset
 scenarios
Message-ID: <20201026180126.GI1551@shell.armlinux.org.uk>
References: <20201026063106.20744-1-nixiaoming@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026063106.20744-1-nixiaoming@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 02:31:06PM +0800, Xiaoming Ni wrote:
> Do not dump the memory in non-system reset scenarios to prevent virtual
>  address information leakage.
> 
> This patch follows x86 and arm64's lead and removes the "Exception stack:"
> dump from kernel backtraces:
> 	commit a25ffd3a6302a6 ("arm64: traps: Don't print stack or raw
> 	 PC/LR values in backtraces")
> 	commit 0ee1dd9f5e7eae ("x86/dumpstack: Remove raw stack dump")

Please make this conditional, so that if necessary this information can
be retrieved for debugging purposes. I object extremely strongly to
this "it's a security leak, let's rip out all the useful debugging that
enables people to get to the bottom of problems" attitude that we now
seem to have.

If that's what people want, then do not expect me to ever look at a
kernel crash again; other people can do the debugging and find out
how painful it can be without extra information.

> Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
> ---
>  arch/arm/kernel/traps.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
> index 911bbf164875..34e268378972 100644
> --- a/arch/arm/kernel/traps.c
> +++ b/arch/arm/kernel/traps.c
> @@ -60,13 +60,9 @@ static int __init user_debug_setup(char *str)
>  __setup("user_debug=", user_debug_setup);
>  #endif
>  
> -static void dump_mem(const char *, const char *, unsigned long, unsigned long);
> -
>  void dump_backtrace_entry(unsigned long where, unsigned long from,
>  			  unsigned long frame, const char *loglvl)
>  {
> -	unsigned long end = frame + 4 + sizeof(struct pt_regs);
> -
>  #ifdef CONFIG_KALLSYMS
>  	printk("%s (%ps) from (%pS)\n",
>  		loglvl, (void *)where, (void *)from);
> @@ -74,9 +70,6 @@ void dump_backtrace_entry(unsigned long where, unsigned long from,
>  	printk("%sFunction entered at [<%08lx>] from [<%08lx>]\n",
>  		loglvl, where, from);
>  #endif
> -
> -	if (in_entry_text(from) && end <= ALIGN(frame, THREAD_SIZE))
> -		dump_mem(loglvl, "Exception stack", frame + 4, end);
>  }
>  
>  void dump_backtrace_stm(u32 *stack, u32 instruction, const char *loglvl)
> @@ -125,6 +118,12 @@ static void dump_mem(const char *lvl, const char *str, unsigned long bottom,
>  	mm_segment_t fs;
>  	int i;
>  
> +	/*
> +	 * To prevent virtual address information leakage, memory
> +	 * information cannot be printed in non-reset scenarios.
> +	 */
> +	if (panic_on_oops == 0)
> +		return;
>  	/*
>  	 * We need to switch to kernel mode so that we can use __get_user
>  	 * to safely read from kernel space.  Note that we now dump the
> -- 
> 2.27.0
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
