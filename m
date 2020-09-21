Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71317272481
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 15:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbgIUNDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 09:03:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:36412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726395AbgIUNDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 09:03:34 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DFC421BE5;
        Mon, 21 Sep 2020 13:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600693412;
        bh=/OXxvRuG9UKcQRKGwiYUXauAuIovgqSdUTuP2bCvGxc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BK91AnXD8umfR9eGG22AlARI0YYWuVA+LtPMvJ7jmlfx9fcC/mM7YICUl8Vrir2Ml
         DIZxeACidTCoL5lFzdwGm3c6r7G6e9uUZ99QlbzkJeAc7o/JvizkwnnvPVPuIcYXRk
         K3nWZjjjuk0ZGKIvXAU2wXzqWa3fayM6DRDwsqYE=
Date:   Mon, 21 Sep 2020 21:03:27 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Varun Sethi <V.Sethi@nxp.com>, Leo Li <leoyang.li@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Kuldeep Singh <kuldeep.singh@nxp.com>
Subject: Re: [PATCH 2/2] arm64: dts: lx2160a: add device tree for lx2162aqds
 board
Message-ID: <20200921130325.GA25428@dragon>
References: <1599059610-7570-1-git-send-email-meenakshi.aggarwal@nxp.com>
 <1599059610-7570-2-git-send-email-meenakshi.aggarwal@nxp.com>
 <20200905075419.GN9261@dragon>
 <AM7PR04MB688571606382A8992C71E8E38E260@AM7PR04MB6885.eurprd04.prod.outlook.com>
 <20200912094913.GB25109@dragon>
 <AM7PR04MB6885EF94F69D741496AD9C838E3A0@AM7PR04MB6885.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM7PR04MB6885EF94F69D741496AD9C838E3A0@AM7PR04MB6885.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 06:00:53AM +0000, Meenakshi Aggarwal wrote:
> 
> 
> > -----Original Message-----
> > From: Shawn Guo <shawnguo@kernel.org>
> > Sent: Saturday, September 12, 2020 3:19 PM
> > To: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
> > Cc: robh+dt@kernel.org; Varun Sethi <V.Sethi@nxp.com>; Leo Li
> > <leoyang.li@nxp.com>; linux-arm-kernel@lists.infradead.org;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Ioana Ciornei
> > <ioana.ciornei@nxp.com>; Kuldeep Singh <kuldeep.singh@nxp.com>
> > Subject: Re: [PATCH 2/2] arm64: dts: lx2160a: add device tree for lx2162aqds
> > board
> > 
> > On Wed, Sep 09, 2020 at 07:10:12AM +0000, Meenakshi Aggarwal wrote:
> > > > > +	sb_3v3: regulator-sb3v3 {
> > > > > +		compatible = "regulator-fixed";
> > > > > +		regulator-name = "MC34717-3.3VSB";
> > > > > +		regulator-min-microvolt = <3300000>;
> > > > > +		regulator-max-microvolt = <3300000>;
> > > > > +		regulator-boot-on;
> > > > > +		regulator-always-on;
> > > >
> > > > I do not see any point to have regulator-boot-on or
> > > > regulator-always-on for a regulator that doesn't have on/off control.
> > > [Meenakshi Aggarwal] Properties are added to specify that platform
> > > firmware's out of reset configuration enabled the regulator and regulator
> > should never be disabled or change its operative status.
> > 
> > What I was wondering if how this regulator is enabled by firmware, by some
> > GPIO control?  In that case, 'gpio' property should be there to describe the GPIO
> > control.
> > 
> [Meenakshi Aggarwal] Its not controlled by GPIO. Its gets power on with board.
> > >
> > > Can you help in understanding why these optional properties cannot be
> > > used together
> > 
> > It's totally fine to use these properties together.  But if the regulator doesn't
> > have on/off control, neither of them makes sense.
> [Meenakshi Aggarwal] As per documentation, we should keep " regulator-always-on " as per description, we
> Can remove " regulator-boot-on" property from dts.
> 
> regulator-always-on:
>     description: boolean, regulator should never be disabled                                  

Again, the property is only meaningful for a regulator that can possibly
be disabled.

Shawn
