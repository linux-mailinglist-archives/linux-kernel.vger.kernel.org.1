Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69C2026B697
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 02:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbgIPAHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 20:07:53 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:50871 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbgIOO2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 10:28:36 -0400
X-Originating-IP: 90.65.88.165
Received: from localhost (lfbn-lyo-1-1908-165.w90-65.abo.wanadoo.fr [90.65.88.165])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 86096C001D;
        Tue, 15 Sep 2020 14:27:43 +0000 (UTC)
Date:   Tue, 15 Sep 2020 16:27:43 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 3/3] ASoC: tlv320aic32x4: Enable fast charge
Message-ID: <20200915142743.GB9675@piout.net>
References: <20200911173140.29984-1-miquel.raynal@bootlin.com>
 <20200911173140.29984-4-miquel.raynal@bootlin.com>
 <20200915082602.GH4230@piout.net>
 <20200915115034.GA5576@sirena.org.uk>
 <20200915130207.GA9675@piout.net>
 <20200915141025.GB4913@sirena.org.uk>
 <20200915161401.54f6d4f3@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915161401.54f6d4f3@xps13>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/2020 16:14:01+0200, Miquel Raynal wrote:
> Mark Brown <broonie@kernel.org> wrote on Tue, 15 Sep 2020 15:10:25
> +0100:
> 
> > On Tue, Sep 15, 2020 at 03:02:07PM +0200, Alexandre Belloni wrote:
> > > On 15/09/2020 12:50:34+0100, Mark Brown wrote:  
> > > > On Tue, Sep 15, 2020 at 10:26:02AM +0200, Alexandre Belloni wrote:  
> > > > > On 11/09/2020 19:31:40+0200, Miquel Raynal wrote:  
> > 
> > > > > > +	/*
> > > > > > +	 * Enable the fast charging feature and ensure the needed 40ms ellapsed
> > > > > > +	 * before using the analog circuits.
> > > > > > +	 */
> > > > > > +	snd_soc_component_write(component, AIC32X4_REFPOWERUP,
> > > > > > +				AIC32X4_REFPOWERUP_40MS);
> > > > > > +	msleep(40);
> > > > > > +  
> > 
> > > > > Maybe the actual REFPOWERUP value could be exposed as a control so
> > > > > userspace has a way to set the policy?   
> > 
> > > > We very rarely do this, there's not usially anything   
> > 
> > > Could you suggest something then? This mainly changes the power
> > > codec power consumption. I guess people will want to trade latency
> > > for less consumption.  
> > 
> > Is it increasing steady state power consumption or is it just drawing
> > more power during the ramp (ie, peak current consumption is bigger)?
> > Usually this is trading off clean ramps for fast ramps rather than
> > affecting steady state.  If it's affecting steady state a control seems
> > sensible.
> 
> Indeed, it is just affecting the ramp (peak current is bigger).
> 

However, forcing powerup at probe time versus at play time means that
you consume power even when not playing audio.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
