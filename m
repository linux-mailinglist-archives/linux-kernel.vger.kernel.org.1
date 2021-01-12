Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E88A62F2BF5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 10:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392857AbhALJzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 04:55:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:42546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389287AbhALJze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 04:55:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 695F4225AC;
        Tue, 12 Jan 2021 09:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610445294;
        bh=dLHHGgqFtP2uYlc3nf/+6zFYdSZckeor1gxlC8d7+Wo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WP0xcDMahQfhRGfx/Bx1c+9YNeQMFKo/yoF2P8ReATf8uspiVer2xQ20rN6FQZwN3
         O5KweDgEz07AaPsRO6c7rVKrEOQvbf4bbeo0lE+FaFvXDWTkmK38bl4pBe7HYR1pfL
         IKy6lgt9YeEAzw1tFLZz7sFYd0X+u9H7K0FlHo9S2dhK76Z2n4QemdXdqNG3GKh6B7
         KYwKeMeM0UN16CPDKBkIz/u9KV1u0Szjb4ux8kbUxxnu0dhpQQ4CnFYv0qBidd+JXO
         f9SAELuFk9G66M1fmWxD/w5HrQ6dcz5/iQwdVPb2lV01aP0miP7BzH7S9+ZhMMIRLd
         qbOGP3/Q41Y0g==
Date:   Tue, 12 Jan 2021 10:54:47 +0100
From:   Matthias Brugger <matthias.bgg@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Gene Chen <gene_chen@richtek.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Axel Lin <axel.lin@ingics.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chen Zhong <chen.zhong@mediatek.com>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Subject: Re: [PATCH v2 1/3] regulator: mt6360: Add OF match table
Message-ID: <X/1x56kY+21B9fvR@ziggy.stardust>
References: <20210109112612.1221-1-matthias.bgg@kernel.org>
 <20210111164118.GE4728@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210111164118.GE4728@sirena.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 04:41:18PM +0000, Mark Brown wrote:
> On Sat, Jan 09, 2021 at 12:26:09PM +0100, matthias.bgg@kernel.org wrote:
> > From: Matthias Brugger <mbrugger@suse.com>
> > 
> > Binding documentation mentions that a compatible is required for the
> > MT6360 device node, but the driver doesn't provide a OF match table.
> 
> The binding should be fixed to remove the requirement for a compatible
> here, this is both redundant since we already know we have a mt6380 from
> the core MFD and encoding details of how Linux implements things into
> the DT bindings.

Ok, I'll leave that to the driver author to fix this.
Just be aware that there is series for the MFD part which adds
OF_MFD_CELL for the regulator.

Regards,
Matthias

> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek

