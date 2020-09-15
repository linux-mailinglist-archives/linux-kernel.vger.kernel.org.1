Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77B7126B867
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 02:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgIPAnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 20:43:21 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:9977 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbgIONCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 09:02:12 -0400
X-Originating-IP: 90.65.88.165
Received: from localhost (lfbn-lyo-1-1908-165.w90-65.abo.wanadoo.fr [90.65.88.165])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 7B97324000D;
        Tue, 15 Sep 2020 13:02:07 +0000 (UTC)
Date:   Tue, 15 Sep 2020 15:02:07 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 3/3] ASoC: tlv320aic32x4: Enable fast charge
Message-ID: <20200915130207.GA9675@piout.net>
References: <20200911173140.29984-1-miquel.raynal@bootlin.com>
 <20200911173140.29984-4-miquel.raynal@bootlin.com>
 <20200915082602.GH4230@piout.net>
 <20200915115034.GA5576@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915115034.GA5576@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/2020 12:50:34+0100, Mark Brown wrote:
> On Tue, Sep 15, 2020 at 10:26:02AM +0200, Alexandre Belloni wrote:
> > On 11/09/2020 19:31:40+0200, Miquel Raynal wrote:
> 
> > > +	/*
> > > +	 * Enable the fast charging feature and ensure the needed 40ms ellapsed
> > > +	 * before using the analog circuits.
> > > +	 */
> > > +	snd_soc_component_write(component, AIC32X4_REFPOWERUP,
> > > +				AIC32X4_REFPOWERUP_40MS);
> > > +	msleep(40);
> > > +
> 
> > Maybe the actual REFPOWERUP value could be exposed as a control so
> > userspace has a way to set the policy? 
> 
> We very rarely do this, there's not usially anything 
> 

Could you suggest something then? This mainly changes the power
codec power consumption. I guess people will want to trade latency
for less consumption.

> > I'm not sure it make sense to have the delay in probe because it is not
> > enable the analog part of the codec. The delay should probable be after
> > the clocks have been set up because the datasheet says that it is mdac
> > and madc that is starting the analog circuitry.
> 
> Deferring the delay to a workqueue is the usual thing where there's
> concerns about slowing down boot.

Well, that was not my concern. I didn't realize Miquel actually used the
Force power-up values and though the actual power up happened after
configuring the clocks (as is the case for the dafule values). In this
case, the delay is at the proper location.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
