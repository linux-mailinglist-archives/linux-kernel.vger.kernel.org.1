Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B02072D27B4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 10:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbgLHJbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 04:31:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:42282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728294AbgLHJbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 04:31:53 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CB8723A7E;
        Tue,  8 Dec 2020 09:31:12 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kmZKv-00H2jk-RO; Tue, 08 Dec 2020 09:31:10 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 08 Dec 2020 09:31:09 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/irq: report bug if NR_IPI greater than max SGI
 during compile time
In-Reply-To: <1607419304-26140-1-git-send-email-kernelfans@gmail.com>
References: <1607419304-26140-1-git-send-email-kernelfans@gmail.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <0f230af42ff4c6e4cf763b9145fb9487@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: kernelfans@gmail.com, linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de, jason@lakedaemon.net, mark.rutland@arm.com, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-12-08 09:21, Pingfan Liu wrote:
> Although there is a runtime WARN_ON() when NR_IPR > max SGI, it had 
> better
> do the check during built time, and associate these related code 
> together.
> 
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> To: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  arch/arm64/kernel/smp.c                | 2 ++
>  drivers/irqchip/irq-gic-v3.c           | 2 +-
>  drivers/irqchip/irq-gic.c              | 2 +-
>  include/linux/irqchip/arm-gic-common.h | 2 ++
>  4 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 18e9727..9fc383c 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -33,6 +33,7 @@
>  #include <linux/kernel_stat.h>
>  #include <linux/kexec.h>
>  #include <linux/kvm_host.h>
> +#include <linux/irqchip/arm-gic-common.h>
> 
>  #include <asm/alternative.h>
>  #include <asm/atomic.h>
> @@ -76,6 +77,7 @@ enum ipi_msg_type {
>  	IPI_WAKEUP,
>  	NR_IPI
>  };
> +static_assert(NR_IPI <= MAX_SGI_NUM);

I am trying *very hard* to remove dependencies between the architecture
code and random drivers, so this kind of check really is 
counter-productive.

Driver code should not have to know the number of IPIs, because there is
no requirement that all IPIs should map 1:1 to SGIs. Conflating the two
is already wrong, and I really don't want to add more of that.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
