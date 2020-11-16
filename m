Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 702632B41BB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 11:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbgKPKvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 05:51:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:47658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727107AbgKPKvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 05:51:08 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21234222B9;
        Mon, 16 Nov 2020 10:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605523867;
        bh=ai75Jt+48opuiQhCj0Z/RU0l3sgXV4X5LfLwk4hIntY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oV7bh+I73RgWxOpJi2SjopCruCq4nGy/GUj74D+N8VZoCmiScK0GxOTgmW5eN0TNE
         EWiMwjwxD2JjrA2815r3Wxhsbs/Z1fV5+IzvoJPIGo3uVTRPoMEZ/1zoFJU0R3BfwZ
         k1Me/U34wryIFXdhYISUdCoUU3mmUo+eZLhVRQLg=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kec6D-00AzEA-21; Mon, 16 Nov 2020 10:51:05 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 16 Nov 2020 10:51:00 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org, Russell King <linux@armlinux.org.uk>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [patch 06/19] arm64: irqstat: Get rid of duplicated declaration
In-Reply-To: <20201113141733.392015387@linutronix.de>
References: <20201113140207.499353218@linutronix.de>
 <20201113141733.392015387@linutronix.de>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <813afa3a895b0da8974fac72832a03b3@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: tglx@linutronix.de, linux-kernel@vger.kernel.org, peterz@infradead.org, frederic@kernel.org, paulmck@kernel.org, bigeasy@linutronix.de, arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org, linux-arm-kernel@lists.infradead.org, James.Bottomley@hansenpartnership.com, deller@gmx.de, linux-parisc@vger.kernel.org, ysato@users.sourceforge.jp, dalias@libc.org, linux-sh@vger.kernel.org, jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, linux-um@lists.infradead.org, linux@armlinux.org.uk, valentin.schneider@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-13 14:02, Thomas Gleixner wrote:
> irq_cpustat_t is exactly the same as the asm-generic one. Define
> ack_bad_irq so the generic header does not emit the generic version of 
> it.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> ---
>  arch/arm64/include/asm/hardirq.h |    7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> --- a/arch/arm64/include/asm/hardirq.h
> +++ b/arch/arm64/include/asm/hardirq.h
> @@ -13,11 +13,8 @@
>  #include <asm/kvm_arm.h>
>  #include <asm/sysreg.h>
> 
> -typedef struct {
> -	unsigned int __softirq_pending;
> -} ____cacheline_aligned irq_cpustat_t;
> -
> -#include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t 
> above */
> +#define ack_bad_irq ack_bad_irq
> +#include <asm-generic/hardirq.h>
> 
>  #define __ARCH_IRQ_EXIT_IRQS_DISABLED	1

Acked-by: Marc Zyngier <maz@kernel.org>

         M.
-- 
Jazz is not dead. It just smells funny...
