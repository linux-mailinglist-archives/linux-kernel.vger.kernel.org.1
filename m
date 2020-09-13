Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61ECE267D0E
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 03:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbgIMBTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 21:19:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:39586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbgIMBTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 21:19:15 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EFA8214F1;
        Sun, 13 Sep 2020 01:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599959955;
        bh=o2bVdjxpULrUup9iSKagiQwwz7bvCxt8RBPtA41IJI0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mLDX/kSAHPstTpQFU0Ub0Jkklpf+ndKjNMoOainVadn5veQZ2o52M6ugwm9ew+9pk
         3f0SNghnkh0XmyvQLE0LtSRQ8HFsQrQzKURr10CRDTP9XN9yTpzrnSjvhhfVk5MKVr
         c9wqlv3O/upR0P0VfS6jQUqV5DxvhFbDFKR+kgD0=
Date:   Sun, 13 Sep 2020 09:19:07 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>, Li Yang <leoyang.li@nxp.com>,
        Robert Chiras <robert.chiras@nxp.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, etnaviv@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 08/13] arm64: dts: imx8mm-var-som-symphony: Use newer
 interrupts property
Message-ID: <20200913011906.GC25109@dragon>
References: <20200904145312.10960-1-krzk@kernel.org>
 <20200904145312.10960-9-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904145312.10960-9-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 04, 2020 at 04:53:07PM +0200, Krzysztof Kozlowski wrote:
> The int-gpios was deprecated in favor of generic interrupts property.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied patch #8 ~ #13, thanks.
