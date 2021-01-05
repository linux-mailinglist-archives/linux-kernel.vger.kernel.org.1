Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 313042EB17A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 18:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729852AbhAERgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 12:36:18 -0500
Received: from foss.arm.com ([217.140.110.172]:58086 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbhAERgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 12:36:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D5A71063;
        Tue,  5 Jan 2021 09:35:31 -0800 (PST)
Received: from bogus (unknown [10.57.35.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC94A3F66E;
        Tue,  5 Jan 2021 09:35:29 -0800 (PST)
Date:   Tue, 5 Jan 2021 17:35:26 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        "open list:SYSTEM CONTROL & POWER/MANAGEMENT INTERFACE Mes..." 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] firmware: arm_scmi: Augment SMC/HVC to allow
 optional interrupt
Message-ID: <20210105173526.yvjh2bxnofjzmc6n@bogus>
References: <20201222145603.40192-1-jim2101024@gmail.com>
 <20201222145603.40192-3-jim2101024@gmail.com>
 <e37cb2fc-14a3-b658-9df7-6f67a2c4d755@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e37cb2fc-14a3-b658-9df7-6f67a2c4d755@gmail.com>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 22, 2020 at 07:37:22PM -0800, Florian Fainelli wrote:
> 
> 
> On 12/22/2020 6:56 AM, Jim Quinlan wrote:
> > The SMC/HVC SCMI transport is modified to allow the completion of an SCMI
> > message to be indicated by an interrupt rather than the return of the smc
> > call.  This accommodates the existing behavior of the BrcmSTB SCMI
> > "platform" whose SW is already out in the field and cannot be changed.
> > 
> > Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> 
> This looks good to me, just one question below:
> 
> [snip]
> 
> > @@ -111,6 +145,8 @@ static int smc_send_message(struct scmi_chan_info *cinfo,
> >  	shmem_tx_prepare(scmi_info->shmem, xfer);
> >  
> >  	arm_smccc_1_1_invoke(scmi_info->func_id, 0, 0, 0, 0, 0, 0, 0, &res);
> > +	if (scmi_info->irq)
> > +		wait_for_completion(&scmi_info->tx_complete);
> 
> Do we need this to have a preceding call to reinit_completion()? It does
> not look like this is going to make any practical difference but there
> are drivers doing that for correctness.

Why do you think that might not cause any issue ? After first message
is completed and ISR is executed, the completion flag remains done for
ever. So practically 2nd message onwards won't block in wait_for_completion
which means return from smc/hvc is actually completion too which is clearly
wrong or am I missing something ?

Jim, please confirm either way. If you agree I can add the below snippet,
no need to repost.

Regards,
Sudeep

--
diff --git i/drivers/firmware/arm_scmi/smc.c w/drivers/firmware/arm_scmi/smc.c
index fd41d436e34b..86eac0831d3c 100644
--- i/drivers/firmware/arm_scmi/smc.c
+++ w/drivers/firmware/arm_scmi/smc.c
@@ -144,6 +145,8 @@ static int smc_send_message(struct scmi_chan_info *cinfo,

        shmem_tx_prepare(scmi_info->shmem, xfer);

+       if (scmi_info->irq)
+               reinit_completion(&scmi_info->tx_complete);
        arm_smccc_1_1_invoke(scmi_info->func_id, 0, 0, 0, 0, 0, 0, 0, &res);
        if (scmi_info->irq)
                wait_for_completion(&scmi_info->tx_complete);

