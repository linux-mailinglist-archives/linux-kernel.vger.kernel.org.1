Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 411372EAD1B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 15:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730717AbhAEOGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 09:06:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:43728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730701AbhAEOGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 09:06:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 67E0422AAA;
        Tue,  5 Jan 2021 14:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609855567;
        bh=ds/A3dn2QTSnI2EnAJ6qjxF6P6z+cjHawd5N+6nR5rE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TCW041t/X6L/j8EDNUySxuYw/MNF78ioMvKDL/70NDrCvND9CSNicPKAWWUAFv/pY
         tUuAepV7pAOnX4PldTn+gvDfk34QfyjmMZ0S8R0Iul9bTQ/xM9hRnKrVQ6kAcGQ0xx
         HpRugeKcv/bXUI/Pl3Phpxa8xOe1j25Wnj5WcY3LablC8jq/EyzBe0PKEf2bPLODib
         QbT78WibWDOyjRj/J3lIm5qqtdsg+hNXQpghYAjPQXw8T6tPGKQdrDwmCiOqulYOp+
         cv8mWqAGz9+13vatOt3m840VKn+crffi+8QLDYDcavobClNlFqO4+JdmtPrSSmM424
         gug8wihm4+Cmw==
Date:   Tue, 5 Jan 2021 22:06:00 +0800
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
Subject: Re: [PATCH] arm64: dts: imx8mm-beacon: Fix WiFi Pinmuxing
Message-ID: <20210105140555.GO4142@dragon>
References: <20201202135950.22164-1-aford173@gmail.com>
 <20210105030308.GK4142@dragon>
 <CAHCN7xJV11LqTwsJ=3Xz9gxHAjRg0B37RnMWgcx3CWDT+DiJHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHCN7xJV11LqTwsJ=3Xz9gxHAjRg0B37RnMWgcx3CWDT+DiJHg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 05, 2021 at 06:48:13AM -0600, Adam Ford wrote:
> On Mon, Jan 4, 2021 at 9:03 PM Shawn Guo <shawnguo@kernel.org> wrote:
> >
> > On Wed, Dec 02, 2020 at 07:59:50AM -0600, Adam Ford wrote:
> > > The WiFi chip is capable of communication at SDR104 speeds, and
> > > the pinmux was configured to support this, but the sdhc1 controller
> > > didn't properly reference the pinmux.  Enable 100Mhz and 200MHz pinmux
> > > as was originally intended.
> > >
> > > Fixes: 593816fa2f35 ("arm64: dts: imx: Add Beacon i.MX8m-Mini development kit")
> >
> > This looks more like an improvement than bug fix.
> 
> Do you want me to resubmit without the fixes tag?

Yes, please.  Also, update patch subject like below maybe.

  arm64: dts: imx8mm-beacon: add more pinctrl states for usdhc1

Shawn
