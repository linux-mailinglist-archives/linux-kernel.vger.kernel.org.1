Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA9F2E6F55
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 10:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbgL2J2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 04:28:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:56726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbgL2J2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 04:28:23 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAD26207D1;
        Tue, 29 Dec 2020 09:27:42 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kuBI4-004OBp-Q4; Tue, 29 Dec 2020 09:27:40 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 29 Dec 2020 09:27:40 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Yejune Deng <yejune.deng@gmail.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irqchip/gic: add WARN_ON() to facilitate backtracking
In-Reply-To: <1609226114-32933-1-git-send-email-yejune.deng@gmail.com>
References: <1609226114-32933-1-git-send-email-yejune.deng@gmail.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <36538faa77fd0e34f559ec547b983c72@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: yejune.deng@gmail.com, tglx@linutronix.de, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yejune,

On 2020-12-29 07:15, Yejune Deng wrote:
> There is two function gic_of_init() and gic_of_init_child() called
> gic_of_setup(),so add WARN_ON() to facilitate backtracking.
> 
> Signed-off-by: Yejune Deng <yejune.deng@gmail.com>
> ---
>  drivers/irqchip/irq-gic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> index b1d9c22..7c11705 100644
> --- a/drivers/irqchip/irq-gic.c
> +++ b/drivers/irqchip/irq-gic.c
> @@ -1380,7 +1380,7 @@ static bool gic_check_eoimode(struct device_node
> *node, void __iomem **base)
> 
>  static int gic_of_setup(struct gic_chip_data *gic, struct device_node 
> *node)
>  {
> -	if (!gic || !node)
> +	if (WARN_ON(!gic || !node))
>  		return -EINVAL;
> 
>  	gic->raw_dist_base = of_iomap(node, 0);

I don't immediately see what you gain with this. If you end-up here
with NULL pointers, that either because:

- you have failed to allocate the GIC private data structure:
   but as it turns out, these allocations either cannot fail (gic_data[]
   is static), or the dynamic allocation in gic_of_init_child() is 
already
   checked.

- node is NULL: both paths already check for a NULL node, so that cannot
   fail either.

My conclusion is that these checks can never trigger, and we should be
able to *remove* them altogether.

Am I missing something?

         M.
-- 
Jazz is not dead. It just smells funny...
