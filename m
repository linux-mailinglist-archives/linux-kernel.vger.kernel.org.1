Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A936E267D61
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 04:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbgIMC5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 22:57:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:39310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbgIMC5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 22:57:08 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D82F206C3;
        Sun, 13 Sep 2020 02:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599965827;
        bh=Gx2FbAEiqAsojjESp9ixg0pcKegLnO66XJ550S7WpP4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IyEFWhRaFt74qtdLSaHgML7Q/kooNgdfjBkVpjHn/30cioFij3XC8tpzJX0x1F1po
         7+eaBypfTEQQygKLAN3YHmWYfNclGZ9V3k1/ginyEsT0GNpiD5uLzWo3s0bOZmSYi9
         /oeCQSRS2V+IIdSvnB2zqEJN7wQkLkqJrElGjCp4=
Date:   Sun, 13 Sep 2020 10:57:02 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Aisheng Dong <aisheng.dong@nxp.com>
Cc:     Peng Fan <peng.fan@nxp.com>,
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
Message-ID: <20200913025701.GK25109@dragon>
References: <1599795053-5091-1-git-send-email-peng.fan@nxp.com>
 <1599795053-5091-2-git-send-email-peng.fan@nxp.com>
 <AM6PR04MB49661958310D649508AB698B80240@AM6PR04MB4966.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR04MB49661958310D649508AB698B80240@AM6PR04MB4966.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 11, 2020 at 07:19:59AM +0000, Aisheng Dong wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> > Sent: Friday, September 11, 2020 11:31 AM
> > 
> > Add i.MX7ULP Power Management Controller binding doc
> > 
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  .../bindings/arm/freescale/imx7ulp-pmc.yaml   | 33 +++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/arm/freescale/imx7ulp-pmc.yaml
> 
> I wonder if we can merge it into the exist imx7ulp pm binding doc.
> Documentation/devicetree/bindings/arm/freescale/fsl,imx7ulp-pm.yaml

+1

Shawn
