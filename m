Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E861124CD1D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 07:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgHUFID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 01:08:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:40502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbgHUFID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 01:08:03 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71AA821734;
        Fri, 21 Aug 2020 05:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597986482;
        bh=x660jxZ8Q6Aeqmpmtz11Rp0YUyTn70giXVYHYASZhWM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yn0S7FATqpr2d7IIzpuGTeXzWCXoVbxSu3+kSA40RnYCT8/gci802hDKQj8e8Prkp
         RLyrpNYw3v1QwHQkQB+N3Ud2806wTQtt+2tb+n/s63Bu/zEPofPywruBj28hiUQGUb
         9FIyiUOHRCTDnJV8QjyRhkKLRaq/Gvab3gHq6NI4=
Date:   Fri, 21 Aug 2020 10:37:58 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, mengdong.lin@intel.com, sanyog.r.kale@intel.com,
        rander.wang@linux.intel.com, bard.liao@intel.com
Subject: Re: [PATCH] soundwire: cadence: fix race condition between suspend
 and Slave device alerts
Message-ID: <20200821050758.GI2639@vkoul-mobl>
References: <20200817222340.18042-1-yung-chuan.liao@linux.intel.com>
 <20200819090637.GE2639@vkoul-mobl>
 <8d60fa6f-bb7f-daa8-5ae2-51386b87ccad@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d60fa6f-bb7f-daa8-5ae2-51386b87ccad@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-08-20, 07:51, Pierre-Louis Bossart wrote:
> 
> 
> On 8/19/20 4:06 AM, Vinod Koul wrote:
> > On 18-08-20, 06:23, Bard Liao wrote:
> > > From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > > 
> > > In system suspend stress cases, the SOF CI reports timeouts. The root
> > > cause is that an alert is generated while the system suspends. The
> > > interrupt handling generates transactions on the bus that will never
> > > be handled because the interrupts are disabled in parallel.
> > > 
> > > As a result, the transaction never completes and times out on resume.
> > > This error doesn't seem too problematic since it happens in a work
> > > queue, and the system recovers without issues.
> > > 
> > > Nevertheless, this race condition should not happen. When doing a
> > > system suspend, or when disabling interrupts, we should make sure the
> > > current transaction can complete, and prevent new work from being
> > > queued.
> > > 
> > > BugLink: https://github.com/thesofproject/linux/issues/2344
> > > Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > > Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> > > Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
> > > Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> > > ---
> > >   drivers/soundwire/cadence_master.c | 24 +++++++++++++++++++++++-
> > >   drivers/soundwire/cadence_master.h |  1 +
> > >   2 files changed, 24 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
> > > index 24eafe0aa1c3..1330ffc47596 100644
> > > --- a/drivers/soundwire/cadence_master.c
> > > +++ b/drivers/soundwire/cadence_master.c
> > > @@ -791,7 +791,16 @@ irqreturn_t sdw_cdns_irq(int irq, void *dev_id)
> > >   			     CDNS_MCP_INT_SLAVE_MASK, 0);
> > >   		int_status &= ~CDNS_MCP_INT_SLAVE_MASK;
> > > -		schedule_work(&cdns->work);
> > > +
> > > +		/*
> > > +		 * Deal with possible race condition between interrupt
> > > +		 * handling and disabling interrupts on suspend.
> > > +		 *
> > > +		 * If the master is in the process of disabling
> > > +		 * interrupts, don't schedule a workqueue
> > > +		 */
> > > +		if (cdns->interrupt_enabled)
> > > +			schedule_work(&cdns->work);
> > 
> > would it not make sense to mask the interrupts first and then cancel the
> > work? that way you are guaranteed that after this call you dont have
> > interrupts and work scheduled?
> 
> cancel_work_sync() will either
> a) wait until the current work completes, or
> b) prevent a new one from starting.
> 
> there's no way to really 'abort' a workqueue, 'cancel' means either complete
> or don't start.

Quite right, as that is how everyone deals with it. Stop the irq from
firing first and then wait until work is cancelled or completed, hence
cancel_work_sync()

> if you disable the interrupts then cancel the work, you have a risk of not
> letting the work complete if it already started (case a).
> 
> The race is
> a) the interrupt thread (this function) starts
> b) the work is scheduled and starts
> c) the suspend handler starts and disables interrupts in [1] below.
> d) the work initiates transactions which will never complete since Cadence
> interrupts have been disabled.

Would it not be better to let work handle the case of interrupts
disabled and not initiates transactions which wont complete here? That
sounds more reasonable to do rather than complete the work which anyone
doesn't matter as you are suspending

> So the idea was that before disabling interrupts, the suspend handler
> changes the status, and then calls cancel_work_sync(). the status is also
> used to prevent a new work from being scheduled if you already know the
> suspend is on-going. The test on the status above is not strictly necessary,
> I believe the sequence is safe without it but it avoid starting a useless
> work.
> 
> If you want to follow the flow it's better to start with what the suspend
> handler does below first, then look at how the interrupt thread might
> interfere. The diff format does not help, might be also easier to apply the
> patch and look at the rest of the code, e.g the 3 mask updates mentioned
> below are not included in the diff.
> 
> > 
> > >   	}
> > >   	cdns_writel(cdns, CDNS_MCP_INTSTAT, int_status);
> > > @@ -924,6 +933,19 @@ int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns, bool state)
> > >   		slave_state = cdns_readl(cdns, CDNS_MCP_SLAVE_INTSTAT1);
> > >   		cdns_writel(cdns, CDNS_MCP_SLAVE_INTSTAT1, slave_state);
> > >   	}
> 
> [1]
> 
> > > +	cdns->interrupt_enabled = state;
> > > +
> > > +	/*
> > > +	 * Complete any on-going status updates before updating masks,
> > > +	 * and cancel queued status updates.
> > > +	 *
> > > +	 * There could be a race with a new interrupt thrown before
> > > +	 * the 3 mask updates below are complete, so in the interrupt
> > > +	 * we use the 'interrupt_enabled' status to prevent new work
> > > +	 * from being queued.
> > > +	 */
> > > +	if (!state)
> > > +		cancel_work_sync(&cdns->work);
> > >   	cdns_writel(cdns, CDNS_MCP_SLAVE_INTMASK0, slave_intmask0);
> > >   	cdns_writel(cdns, CDNS_MCP_SLAVE_INTMASK1, slave_intmask1);
> > > diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
> > > index fdec62b912d3..4d1aab5b5ec2 100644
> > > --- a/drivers/soundwire/cadence_master.h
> > > +++ b/drivers/soundwire/cadence_master.h
> > > @@ -133,6 +133,7 @@ struct sdw_cdns {
> > >   	bool link_up;
> > >   	unsigned int msg_count;
> > > +	bool interrupt_enabled;
> > >   	struct work_struct work;
> > > -- 
> > > 2.17.1
> > 

-- 
~Vinod
