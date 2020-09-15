Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB4D26A00A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 09:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgIOHof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 03:44:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:51910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgIOHlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 03:41:04 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02F2E21974;
        Tue, 15 Sep 2020 07:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600155663;
        bh=jCRPMMYy3Nuj4ALIYJmXAhKpYFP2QZ/lCeLiskn7tQs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FxNQ8EkiWtq5ZCSPehIU4ElJKdJoI+fRb+odp8GWiWHKI1M5P7wLbL4hlldccO31i
         a2Cr1DFEXwm9JLvc9lzPlV3hahGPh9ok9Z8ub3v3dxZiRvBMrDR0O3+mukB9OwB2yR
         4Rv47dqMfDLLm140DXEmGuLP1JEPCSht2VPX9s1A=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kI5aH-00Bvsa-2d; Tue, 15 Sep 2020 08:41:01 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 15 Sep 2020 08:41:00 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Shenming Lu <lushenming@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org, wanghaibin.wang@huawei.com
Subject: Re: [PATCH] irqchip/gic-v4.1: Optimize the delay time of the poll on
 the GICR_VENPENDBASER.Dirty bit
In-Reply-To: <20200915072213.62-1-lushenming@huawei.com>
References: <20200915072213.62-1-lushenming@huawei.com>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <977d4c86cae651d1b22b1a519ee6b037@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: lushenming@huawei.com, tglx@linutronix.de, jason@lakedaemon.net, linux-kernel@vger.kernel.org, wanghaibin.wang@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-15 08:22, Shenming Lu wrote:
> Every time the vPE is scheduled, the code starts polling the
> GICR_VPENDBASER.Dirty bit until it becomes 0. It's OK. But
> the delay_us of the poll function is directly set to 10, which
> is a long time for most interrupts. In our measurement, it takes
> only 1~2 microseconds, or even hundreds of nanoseconds, to finish
> parsing the VPT in most cases. However, in the current implementation,
> if the GICR_VPENDBASER.Dirty bit is not 0 immediately after the
> vPE is scheduled, it will directly wait for 10 microseconds,
> resulting in meaningless waiting.
> 
> In order to avoid meaningless waiting, we can set the delay_us
> to 0, which can exit the poll function immediately when the Dirty
> bit becomes 0.

We clearly have a difference in interpretation of the word 
"meaningless".

With this, you are busy-waiting on the register, adding even more 
overhead
at the RD level. How is that better? The whole point is to back off and 
let
the RD do its stuff in the background. This is also based on a massive
sample of *one* implementation. How is that representative?

It would be a lot more convincing if you measured the difference it
makes on the total scheduling latency of a vcpu. Assuming it makes
*any* observable difference.

Thanks,

         M.

> 
> Signed-off-by: Shenming Lu <lushenming@huawei.com>
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c 
> b/drivers/irqchip/irq-gic-v3-its.c
> index 548de7538632..5cfcf0c2ce1a 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -3803,7 +3803,7 @@ static void its_wait_vpt_parse_complete(void)
>  	WARN_ON_ONCE(readq_relaxed_poll_timeout_atomic(vlpi_base + 
> GICR_VPENDBASER,
>  						       val,
>  						       !(val & GICR_VPENDBASER_Dirty),
> -						       10, 500));
> +						       0, 500));
>  }
> 
>  static void its_vpe_schedule(struct its_vpe *vpe)
-- 
Jazz is not dead. It just smells funny...
