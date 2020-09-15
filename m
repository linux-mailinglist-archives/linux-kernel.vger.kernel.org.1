Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 853AC26A704
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 16:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgIOO1f convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 15 Sep 2020 10:27:35 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:56139 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbgIOOPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 10:15:04 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id B302D20008;
        Tue, 15 Sep 2020 14:14:02 +0000 (UTC)
Date:   Tue, 15 Sep 2020 16:14:01 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 3/3] ASoC: tlv320aic32x4: Enable fast charge
Message-ID: <20200915161401.54f6d4f3@xps13>
In-Reply-To: <20200915141025.GB4913@sirena.org.uk>
References: <20200911173140.29984-1-miquel.raynal@bootlin.com>
        <20200911173140.29984-4-miquel.raynal@bootlin.com>
        <20200915082602.GH4230@piout.net>
        <20200915115034.GA5576@sirena.org.uk>
        <20200915130207.GA9675@piout.net>
        <20200915141025.GB4913@sirena.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

Mark Brown <broonie@kernel.org> wrote on Tue, 15 Sep 2020 15:10:25
+0100:

> On Tue, Sep 15, 2020 at 03:02:07PM +0200, Alexandre Belloni wrote:
> > On 15/09/2020 12:50:34+0100, Mark Brown wrote:  
> > > On Tue, Sep 15, 2020 at 10:26:02AM +0200, Alexandre Belloni wrote:  
> > > > On 11/09/2020 19:31:40+0200, Miquel Raynal wrote:  
> 
> > > > > +	/*
> > > > > +	 * Enable the fast charging feature and ensure the needed 40ms ellapsed
> > > > > +	 * before using the analog circuits.
> > > > > +	 */
> > > > > +	snd_soc_component_write(component, AIC32X4_REFPOWERUP,
> > > > > +				AIC32X4_REFPOWERUP_40MS);
> > > > > +	msleep(40);
> > > > > +  
> 
> > > > Maybe the actual REFPOWERUP value could be exposed as a control so
> > > > userspace has a way to set the policy?   
> 
> > > We very rarely do this, there's not usially anything   
> 
> > Could you suggest something then? This mainly changes the power
> > codec power consumption. I guess people will want to trade latency
> > for less consumption.  
> 
> Is it increasing steady state power consumption or is it just drawing
> more power during the ramp (ie, peak current consumption is bigger)?
> Usually this is trading off clean ramps for fast ramps rather than
> affecting steady state.  If it's affecting steady state a control seems
> sensible.

Indeed, it is just affecting the ramp (peak current is bigger).

Thanks,
Miquèl
