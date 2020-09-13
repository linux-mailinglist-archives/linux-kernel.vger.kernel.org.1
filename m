Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0276267D5A
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 04:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbgIMCuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 22:50:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:38496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbgIMCuc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 22:50:32 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 457E9207EA;
        Sun, 13 Sep 2020 02:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599965431;
        bh=c6d5FuxAU1itofgwPghtwPak/5DXK2sYSJJ0ptY6ChA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GNusl8jxqVxdW1Khy44B4HccOBYQPdIlNjnkXQQ382iY+BuTV97ye5b0i4xgI3G5z
         +OoHGkTEtR2hyj5rHrKSuZXvMoYvYqVWaO2aq7yrX2P6WHQTdoyBRqYoOunv7lRCMd
         No+rdhH8RgjlurAt4VU2PqW6snx5X2Y+hh+SfhoU=
Date:   Sun, 13 Sep 2020 10:50:26 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     Aisheng Dong <aisheng.dong@nxp.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/4] dt-bindings: fsl: add i.MX7ULP PMC binding doc
Message-ID: <20200913025025.GJ25109@dragon>
References: <1599795053-5091-1-git-send-email-peng.fan@nxp.com>
 <1599795053-5091-2-git-send-email-peng.fan@nxp.com>
 <AM6PR04MB49661958310D649508AB698B80240@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <DB6PR0402MB276056780BC661041A5D604C88240@DB6PR0402MB2760.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB6PR0402MB276056780BC661041A5D604C88240@DB6PR0402MB2760.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 11, 2020 at 07:45:20AM +0000, Peng Fan wrote:
> > b/Documentation/devicetree/bindings/arm/freescale/imx7ulp-pmc.yaml
> > > @@ -0,0 +1,33 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/arm/freescale/imx7ulp-pmc.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: i.MX7ULP Power Management Controller(PMC) Device Tree Bindings
> > > +
> > > +maintainers:
> > > +  - Peng Fan <peng.fan@nxp.com>
> > > +
> > > +properties:
> > > +  compatible:
> > > +    items:
> > > +      - enum:
> > > +          - fsl,imx7ulp-pmc-m4
> > > +          - fsl,imx7ulp-pmc-a7
> > 
> > Can we change to the exist naming pattern which also align with HW
> > reference manual?
> > e.g.
> > fsl,imx7ulp-pmc0
> > fsl,imx7ulp-pmc1
> 
> This was rejected by Shawn before.
> https://patchwork.kernel.org/patch/11390591/

Oh, I'm fine with the naming if pmc0 and pmc1 are different HW block
rather than two instances of the same block.

Shawn
