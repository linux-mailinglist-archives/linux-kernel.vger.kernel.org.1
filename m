Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC582E92C8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 10:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbhADJqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 04:46:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:43508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbhADJqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 04:46:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 013DA21D93;
        Mon,  4 Jan 2021 09:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609753563;
        bh=G3K3d2gDGBKT7zbOWsS5dtsQnCnbuk7smJPC7wAv2qA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bf+wF74f87p4nC2HmCmYtIGKi7FJ3vF+2hKZc6exXMzL3+97kv8Htl/eYXYLX1qVg
         CaLTjd/x4bHpHpUBoDwV2Fr/nrVXgR4MmMV6wNpJMGaWOB8efAYETHRtTii2cFXNJ4
         tTsVsB7AKnmUC2Sg2ebtUBqGkL41OTJHE86wxPNFa7o5dxuYNENxiRF6kU7W4vi5xU
         RrAslxPwDZhG59MYHpMsjH4AxjmUBtgvO1t8H0ZxgMr5vi19RUL6681ka6g/f0gg1s
         Q3k316j1+nIv0zimLLSUDG7QljtMeDuHWoUf90q61wvq4eXTliDPNFlx+ePFe9pE+L
         4NSxtfA0EIOVQ==
Date:   Mon, 4 Jan 2021 17:45:28 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     arm-soc <linux-arm-kernel@lists.infradead.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V4 1/3] dt-bindings: arm: fsl: Add
 beacon,imx8mn-beacon-kit
Message-ID: <20210104094526.GA4142@dragon>
References: <20201107144811.1977108-1-aford173@gmail.com>
 <20201110033243.GA31601@dragon>
 <CAHCN7xLdB4q=DpRYOiPVewbpqGmx3aC4Ktm27vpUsNYtfppFcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHCN7xLdB4q=DpRYOiPVewbpqGmx3aC4Ktm27vpUsNYtfppFcg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 07:50:48PM -0600, Adam Ford wrote:
> On Mon, Nov 9, 2020 at 9:32 PM Shawn Guo <shawnguo@kernel.org> wrote:
> >
> > On Sat, Nov 07, 2020 at 08:48:08AM -0600, Adam Ford wrote:
> > > Add beacon,imx8mn-beacon-kit to list of compatible options.
> > >
> > > Signed-off-by: Adam Ford <aford173@gmail.com>
> > > Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> >
> > You need to stop posting patches that have dependency not accepted yet,
> > or explicitly mention the dependency.
> 
> Sorry about that.  I wrongly assumed the series dependency would have
> been accepted by the time this was reviewed.  I'll try not to do that
> again.
> 
> Based on your e-mail from [1], it appears as if you've accepted the
> other series upon which this depends.  Is there any way this can be
> reapplied again, or do you need me to re-submit it?

Applied all, thanks.
