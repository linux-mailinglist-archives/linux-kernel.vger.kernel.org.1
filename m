Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7417D2AA6BC
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 17:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgKGQyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 11:54:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:43900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726021AbgKGQyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 11:54:35 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73B27208FE;
        Sat,  7 Nov 2020 16:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604768074;
        bh=9bUJAFtKjhDN45p4T+UQtUzX1qvHFX2a8IQPUCLjMXg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iDKqtwlBRFyo3WWC/7pbXL36pzUaE5NQFLRgC/Rpg0ARPeta4Q6yOCXs3j5N03Aa3
         NDPey1IOfMWImyrH3T2nqQUg3PSOeiBAeDJO5FHwvRET+bg+nzFKehMJ5DqCxRjEl3
         vKbU10Ay2pBjB6uC3UnXrAyZm8Auiqzmn9v5F/AY=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kbRU0-008VU3-Et; Sat, 07 Nov 2020 16:54:32 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 07 Nov 2020 16:54:32 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Xu Qiang <xuqiang36@huawei.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        rui.xiang@huawei.com
Subject: Re: [PATCH -next] irq-chip/gic-v3-its: Fixed an issue where the ITS
 executes the residual commands in the queue again when the ITS wakes up from
 sleep mode.
In-Reply-To: <20201107104226.14282-1-xuqiang36@huawei.com>
References: <20201107104226.14282-1-xuqiang36@huawei.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <b278ce4baea0cf79403f793721d16a8b@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: xuqiang36@huawei.com, tglx@linutronix.de, linux-kernel@vger.kernel.org, rui.xiang@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[dropping Jason, whose email address has been bouncing for weeks now]

On 2020-11-07 10:42, Xu Qiang wrote:
> On my platform, ITS_FLAGS_SAVE_SUSPEND_STATE is not set,thus do nothing

Which platform?

> in its suspend and resuse function.On the other hand,firmware stores
> GITS_CTRL,GITS_CBASER,GITS_CWRITER and GITS_BASER<n> in the suspend,
> and restores these registers in the resume. As a result, the ITS 
> executes
> the residual commands in the queue.

Which firmware are you using? I just had a look at the trusted firmware 
source
code, and while it definitely does something that *looks* like what you 
are
describing, it doesn't re-enable the ITS on resume.

So what are you running?

> 
> Memory corruption may occur in the following scenarios:
> 
> The kernel sends three commands in the following sequence:
> 1.mapd(deviceA, ITT_addr1, valid:1)
> 2.mapti(deviceA):ITS write ITT_addr1 memory;
> 3.mapd(deviceA, ITT_addr1, valid:0) and kfree(ITT_addr1);

The ITS doesn't 'kfree' stuff.

> 4.mapd(deviceA, ITT_addr2, valid:1);
> 5.mapti(deviceA):ITS write ITT_addr2 memory;

I don't think this example is relevant. The core of the problem is that
the ITS gets re-enabled by your firmware. What are the affected systems?

> 
> To solve this problem,dropping the checks for 
> ITS_FLAGS_SAVE_SUSPEND_STATE.
> 
> Signed-off-by: Xu Qiang <xuqiang36@huawei.com>
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 13 -------------
>  1 file changed, 13 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c 
> b/drivers/irqchip/irq-gic-v3-its.c
> index 0fec31931e11..06f2c1c252b9 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -42,7 +42,6 @@
>  #define ITS_FLAGS_CMDQ_NEEDS_FLUSHING		(1ULL << 0)
>  #define ITS_FLAGS_WORKAROUND_CAVIUM_22375	(1ULL << 1)
>  #define ITS_FLAGS_WORKAROUND_CAVIUM_23144	(1ULL << 2)
> -#define ITS_FLAGS_SAVE_SUSPEND_STATE		(1ULL << 3)
> 
>  #define RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING	(1 << 0)
>  #define RDIST_FLAGS_RD_TABLES_PREALLOCATED	(1 << 1)
> @@ -4741,9 +4740,6 @@ static int its_save_disable(void)
>  	list_for_each_entry(its, &its_nodes, entry) {
>  		void __iomem *base;
> 
> -		if (!(its->flags & ITS_FLAGS_SAVE_SUSPEND_STATE))
> -			continue;
> -
>  		base = its->base;
>  		its->ctlr_save = readl_relaxed(base + GITS_CTLR);
>  		err = its_force_quiescent(base);
> @@ -4762,9 +4758,6 @@ static int its_save_disable(void)
>  		list_for_each_entry_continue_reverse(its, &its_nodes, entry) {
>  			void __iomem *base;
> 
> -			if (!(its->flags & ITS_FLAGS_SAVE_SUSPEND_STATE))
> -				continue;
> -
>  			base = its->base;
>  			writel_relaxed(its->ctlr_save, base + GITS_CTLR);
>  		}
> @@ -4784,9 +4777,6 @@ static void its_restore_enable(void)
>  		void __iomem *base;
>  		int i;
> 
> -		if (!(its->flags & ITS_FLAGS_SAVE_SUSPEND_STATE))
> -			continue;
> -
>  		base = its->base;
> 
>  		/*
> @@ -5074,9 +5064,6 @@ static int __init its_probe_one(struct resource 
> *res,
>  		ctlr |= GITS_CTLR_ImDe;
>  	writel_relaxed(ctlr, its->base + GITS_CTLR);
> 
> -	if (GITS_TYPER_HCC(typer))
> -		its->flags |= ITS_FLAGS_SAVE_SUSPEND_STATE;
> -
>  	err = its_init_domain(handle, its);
>  	if (err)
>  		goto out_free_tables;

I'm OK with the patch itself, but I don't want to paper over broken 
firmware.
I'll get TF-A fixed one way or another, but I want to be sure yours is 
too.
If firmware does its job correctly, we shouldn't have to do all of this.

         M.
-- 
Jazz is not dead. It just smells funny...
