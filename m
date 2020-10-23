Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E537296B32
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 10:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S460607AbgJWIZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 04:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S372605AbgJWIZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 04:25:54 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE01CC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 01:25:53 -0700 (PDT)
Received: from [2a0a:edc0:0:900:6245:cbff:fea0:1793] (helo=kresse.office.stw.pengutronix.de)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1kVsOC-00005o-25; Fri, 23 Oct 2020 10:25:32 +0200
Message-ID: <15c51fd40f3c79b9afd208e2890263bb936e8434.camel@pengutronix.de>
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Adam Ford <aford173@gmail.com>, Marek Vasut <marex@denx.de>
Cc:     arm-soc <linux-arm-kernel@lists.infradead.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 23 Oct 2020 10:25:30 +0200
In-Reply-To: <CAHCN7x+66Ziza0G2Q6iho9z3RKsiw9=PyqoCayXCXyAONcDLow@mail.gmail.com>
References: <20201022171639.773702-1-aford173@gmail.com>
         <5d17f3de-6864-c8fb-6413-24de943df1fd@denx.de>
         <CAHCN7x+66Ziza0G2Q6iho9z3RKsiw9=PyqoCayXCXyAONcDLow@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:6245:cbff:fea0:1793
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
        metis.ext.pengutronix.de
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=4.0 tests=AWL,BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.2
Subject: Re: [PATCH] arm64: dts: imx8mm: Add GPU node
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on metis.ext.pengutronix.de)
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Do, 2020-10-22 at 13:31 -0500, Adam Ford wrote:
> On Thu, Oct 22, 2020 at 1:17 PM Marek Vasut <marex@denx.de> wrote:
> > On 10/22/20 7:16 PM, Adam Ford wrote:
> > > According to the documentation from NXP, the i.MX8M Nano has a
> > > Vivante GC7000 Ultra Lite as its GPU core.
> > > 
> > > With this patch, the Etnaviv driver presents the GPU as:
> > >    etnaviv-gpu 38000000.gpu: model: GC7000, revision: 6203
> > > 
> > > It uses the GPCV2 controller to enable the power domain for the
> > > GPU.
> > 
> > Subject should say 8mn , not 8mm .
> 
> ugh.. My mistake.  I'll submit a V2 once other have had a chance to
> give some feedback.
> 
> Maybe NXP can comment on the dialog below.
> 
> > Are the assigned-clock-rates correct ?
> 
> I used the assigned clock rates from the vendor kernel, with the
> exception of running at 400MHz instead of 600MHz.  According to the
> datasheet, the GPU clock needs to be 400MHZ to run at 0.85V. The
> 600MHz operating point for the GPU requires a 0.95V operating point.
> Since the default operating point for the Nano shows 0.85V, I left
> the
> GPU clock lower to match the normal operating speed.  This varies a
> bit from the vendor kernel, but their kernel is also showing a 0.95V
> operating point, so I think that's why they are specifying a 600MHz
> operating point.
> 
> On the Beacon embedded board, we're driving the LPDDR to 800MHz which
> requires the ARM to run at .95V.   I was able to override the
> assigned-clock rates for my board to run at 600MHz, and change the
> ARM
> operating point to .95V to meet the spec.
> 
> My intent was to use the defaults and let the board files override
> them.   If you want, I can try to look through the board files to see
> what operating point their using and propose updates to those
> respective device trees to address the clocks on those boards.

I think this is fine as-is with this explanation. At least we have a
precedent in the i.MX8MQ DT where the assigned clocks are for the base
(non overdrive) operating point and boards can choose to override it if
they want to use the overdrive OPP. At least until we add proper
frequency scaling in etnaviv, which should obsolete those fixed clock
rates.

Regards,
Lucas

