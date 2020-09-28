Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 826A227B4F1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 21:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgI1TDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 15:03:52 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:42150 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgI1TDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 15:03:51 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 62EBC20058;
        Mon, 28 Sep 2020 21:03:42 +0200 (CEST)
Date:   Mon, 28 Sep 2020 21:03:41 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     "Alex G." <mr.nuke.me@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        Mark Brown <broonie@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>, linux-kernel@vger.kernel.org,
        Andrzej Hajda <a.hajda@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 1/2] drm/bridge: sii902x: Enable I/O and core VCC
 supplies if present
Message-ID: <20200928190341.GA673726@ravnborg.org>
References: <20200924200507.1175888-1-mr.nuke.me@gmail.com>
 <20200926184919.GB98875@ravnborg.org>
 <9c3ce766-743c-705f-7926-21e753c2d02d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c3ce766-743c-705f-7926-21e753c2d02d@gmail.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=CaYmGojl c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=pGLkceISAAAA:8 a=n0pIf5krzdTGiaSpMTQA:9
        a=CjuIK1q_8ugA:10
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex.

On Mon, Sep 28, 2020 at 12:35:01PM -0500, Alex G. wrote:
> On 9/26/20 1:49 PM, Sam Ravnborg wrote:
> > Hi Alexandru
> > 
> > On Thu, Sep 24, 2020 at 03:05:05PM -0500, Alexandru Gagniuc wrote:
> > > On the SII9022, the IOVCC and CVCC12 supplies must reach the correct
> > > voltage before the reset sequence is initiated. On most boards, this
> > > assumption is true at boot-up, so initialization succeeds.
> > > 
> > > However, when we try to initialize the chip with incorrect supply
> > > voltages, it will not respond to I2C requests. sii902x_probe() fails
> > > with -ENXIO.
> > > 
> > > To resolve this, look for the "iovcc" and "cvcc12" regulators, and
> > > make sure they are enabled before starting the reset sequence. If
> > > these supplies are not available in devicetree, then they will default
> > > to dummy-regulator. In that case everything will work like before.
> > > 
> > > This was observed on a STM32MP157C-DK2 booting in u-boot falcon mode.
> > > On this board, the supplies would be set by the second stage
> > > bootloader, which does not run in falcon mode.
> > > 
> > > Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> > 
> > One nitpick here. The binding should be present in the tree before
> > you start using it. So this patch should be applied after the binding.
> 
> It is :)
>   * arch/arm/boot/dts/stm32mp15xx-dkx.dtsi

This is the device tree. So essentially there is part of the device
tree that is not yet documented - so in a perfect world all parts of the
device tree is documented in bindings
(Documentation/devicetree/bindings/* ) before the device tree is
committed.

	Sam
