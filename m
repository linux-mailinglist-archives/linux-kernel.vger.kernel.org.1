Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAA8B2DC06E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 13:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbgLPMmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 07:42:18 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:37096 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbgLPMmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 07:42:17 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 4FBE6FB03;
        Wed, 16 Dec 2020 13:41:35 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XPKuVr8ci4UN; Wed, 16 Dec 2020 13:41:33 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 68FEB43FDC; Wed, 16 Dec 2020 13:41:33 +0100 (CET)
Date:   Wed, 16 Dec 2020 13:41:33 +0100
From:   Guido =?iso-8859-1?Q?G=FCnther?= <guido.gunther@puri.sm>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        linux-power <linux-power@fi.rohmeurope.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "angus.ainslie@puri.sm" <angus.ainslie@puri.sm>
Subject: Re: [PATCH 1/1] regulators: bd718x7: Add enable times
Message-ID: <20201216124133.GA31109@bogon.m.sigxcpu.org>
References: <cover.1608116704.git.agx@sigxcpu.org>
 <d2b3d053d28ea0f35e7526b523287358c8fe20c2.1608116704.git.agx@sigxcpu.org>
 <7d4903f67ff81a9a749e75f24af0aea903213c43.camel@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7d4903f67ff81a9a749e75f24af0aea903213c43.camel@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matti,
On Wed, Dec 16, 2020 at 12:29:20PM +0000, Vaittinen, Matti wrote:
> Hello Guido,
> 
> Thanks for looking at this!
> 
> On Wed, 2020-12-16 at 12:05 +0100, Guido Günther wrote:
> > Use the typical startup times from the data sheet so boards get a
> > reasonable default. Not setting any enable time can lead to board
> > hangs
> > when e.g. clocks are enabled too soon afterwards.
> > 
> > This fixes gpu power domain resume on the Librem 5.
> > 
> > Signed-off-by: Guido Günther <agx@sigxcpu.org>
> > ---
> >  drivers/regulator/bd718x7-regulator.c | 27
> > +++++++++++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> > 
> > diff --git a/drivers/regulator/bd718x7-regulator.c
> > b/drivers/regulator/bd718x7-regulator.c
> > index e6d5d98c3cea..d6d34aa4ee2e 100644
> > --- a/drivers/regulator/bd718x7-regulator.c
> > +++ b/drivers/regulator/bd718x7-regulator.c
> > @@ -613,6 +613,7 @@ static struct bd718xx_regulator_data
> > bd71847_regulators[] = {
> >  			.vsel_mask = DVS_BUCK_RUN_MASK,
> >  			.enable_reg = BD718XX_REG_BUCK1_CTRL,
> >  			.enable_mask = BD718XX_BUCK_EN,
> > +			.enable_time = 144,
> 
> Where are these values obtained from? I have a feeling they might be
> board / load specific. If this is the case - can the "regulator-enable-
> ramp-delay" from device-tree be used instead to avoid hard-coding board
> specific values in the driver? Although, sane defaults would probably
> not be a bad idea - if I read code correctly then the constrains from
> DT can be used to override these values.

They're the 'typical values' from the data sheet and it's basically all
about setting a default for "regulator-enable-ramp-delay" to avoid
having every board do the same. If that's not the right thing todo let
me know and i add these to each of our boards (which is where i
basically started from but then figured that this would be busywork
and every board would hit that problem).

> I'd prefer well named defines over raw numeric values though.

So s.th. like

BD71837_BUCK1_STARTUP_TIME 144

(using the terminology from the datasheet)? If that works I'll send a
v2.

Cheers,
 --Guido

> 
> Best Regards
>     Matti Vaittinen
> 
> 
