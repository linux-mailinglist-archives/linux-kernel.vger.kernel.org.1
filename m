Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC2A22C94A4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 02:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731063AbgLAB1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 20:27:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:37104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726684AbgLAB1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 20:27:12 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 055A6206F9;
        Tue,  1 Dec 2020 01:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606785991;
        bh=qdRdABZgbfTme48h85OWWd/OyKqv2IBF0RreiM9gmu4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PhZpGrirFAt2jQrsyl55IO3EHoE6+NQXedce/LVzRCCgNNWMUpGvttv5+TE63mSsP
         H4eNSidQOy7/gTFg+bjVKzN7PEQY2DkSS5bZhtnWeKtezNPHuvY5zeG9mPiSzrJrIi
         7IJf6AwntSAy6q4UcmF8tCCkMStcBLUyHKZ3WK2c=
Date:   Tue, 1 Dec 2020 09:26:24 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     arm-soc <linux-arm-kernel@lists.infradead.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V4 2/5] arm64: dts: imx8mn: Enable Asynchronous Sample
 Rate Converter
Message-ID: <20201201012623.GR4072@dragon>
References: <20201107115809.1866131-1-aford173@gmail.com>
 <20201107115809.1866131-2-aford173@gmail.com>
 <CAHCN7xLxUHoc=VFHhbo36ytCLMc11a8DbD1Gh5eK2vogO=75Ww@mail.gmail.com>
 <CAHCN7xJ8y--v-xbY+Z-SjxScDsAqkxBiqgCMyZMTLzJxdy8nig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHCN7xJ8y--v-xbY+Z-SjxScDsAqkxBiqgCMyZMTLzJxdy8nig@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 06:08:25PM -0600, Adam Ford wrote:
> On Wed, Nov 18, 2020 at 5:13 PM Adam Ford <aford173@gmail.com> wrote:
> >
> > On Sat, Nov 7, 2020 at 5:58 AM Adam Ford <aford173@gmail.com> wrote:
> > >
> > > The driver exists for the Enhanced Asynchronous Sample Rate Converter
> > > (EASRC) Controller, but there isn't a device tree entry for it.
> > >
> > > On the vendor kernel, they put this on a spba-bus for SDMA support.
> > >
> > > Add the node for the spba-bus with the easrc node inside.
> > >
> > > Signed-off-by: Adam Ford <aford173@gmail.com>
> >
> > Shawn,
> >
> > I split the dt-binding into a separate patch since I was struggling
> > with checking the yaml syntax.  Rob helped me find the proper branch
> > to use. I hope it goes through this time.
> >
> > Do you have any comments on the rest of the series? I would like to
> > fix them if you have any concerns so I can resend if/when the
> > dt-binding is accepted.
> 
> Shawn,
> 
> The dt-binding was accepted per [1].  How do you want me to proceed
> for the rest of the series?  I can resend the other parts without the
> dt-binding if you like.

Applied 4 DTS patches, thanks.
