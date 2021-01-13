Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 448C12F4E36
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 16:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbhAMPLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 10:11:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:57500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbhAMPLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 10:11:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 55B202337F;
        Wed, 13 Jan 2021 15:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610550643;
        bh=49EcqNO3BNtm9SgsIEaZe12aoA3Tw/mLHvfiTqlGjXs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=etqN7VUMPx4jO+i41MW0+eU5VpDprOhFXusdoR3MrJsnkCxH44Ykn5OVU/hNixV1t
         6tSGJHAr1b9EM2+pHqwoTwfU0EYLBs3Nr5mKxxLHYb0wxJ28NbipKKpNBlpbO6gDTG
         c9BzrY1Yu1dkyPAYNcuYGfM32vU7+qsZGGMNEY4rqWjMSkuKhnO95L4D8EBv6SMiLp
         UNsHwmQLCx5khdJa2JKCwoGwl24SOuawSqLssT9UZcoarrxRkMq5QDPDZebC0BSVOj
         OzDqjVtcuencdVxTrQksJSrw+hcUcOhgKCKI9bWzCQ+BuXd2bv+rg6WP6x5J474dqC
         0Mx6ns/MHqLkg==
Date:   Wed, 13 Jan 2021 20:40:33 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2 0/6] STM32 USBPHYC PLL management rework
Message-ID: <20210113151033.GU2771@vkoul-mobl>
References: <20210105090525.23164-1-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210105090525.23164-1-amelie.delaunay@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-01-21, 10:05, Amelie Delaunay wrote:
> STM32 USBPHYC controls the USB PLL. PLL requires to be powered with 1v1 and 1v8
> supplies. To ensure a good behavior of the PLL, during boot, runtime and
> suspend/resume sequences, this series reworks its management to fix regulators
> issues and improve PLL status reliability.

Applied, thanks

-- 
~Vinod
