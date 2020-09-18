Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E29B26F556
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 07:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgIRFR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 01:17:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:40450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbgIRFR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 01:17:56 -0400
Received: from localhost (unknown [136.185.124.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE33F21D43;
        Fri, 18 Sep 2020 05:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600406275;
        bh=YX/IjhRwKaeUYwIYimZuhaCzEubqiwx+Y8BcqNSb48g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V484eNC7n0mQlhgy5pLQAIrZkmL6ilomd8f00UlQJH7UueT9RGg6w1NV6glZui7hN
         bAA4jOdfiNAMVPEI4Q2/jl0rsed7vwVwmPZco/MR+kn2BlNEey36aFNMwfvXH+4DUj
         +vJ0nRtk+19Up/T+wDrym1WtyX7TYmChfql7QNHs=
Date:   Fri, 18 Sep 2020 10:47:51 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Swapnil Jakhade <sjakhade@cadence.com>
Cc:     kishon@ti.com, robh+dt@kernel.org, p.zabel@pengutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mparab@cadence.com, yamonkar@cadence.com, tomi.valkeinen@ti.com,
        jsarha@ti.com, nsekhar@ti.com
Subject: Re: [PATCH v3 00/13] PHY: Add support for multilink configurations
 in Cadence Torrent PHY driver
Message-ID: <20200918051751.GC2968@vkoul-mobl>
References: <1600327846-9733-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600327846-9733-1-git-send-email-sjakhade@cadence.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-09-20, 09:30, Swapnil Jakhade wrote:
> Cadence Torrent PHY is a multiprotocol PHY supporting different multilink
> PHY configurations including DisplayPort, PCIe, USB, SGMII, QSGMII etc.
> This patch series extends functionality of Torrent PHY driver to support
> following configurations:
> - Single link PCIe configuration
> - PCIe + SGMII/QSGMII Unique SSC multilink configuration
> - Single link SGMII/QSGMII configuration
> - Single link USB configuration
> - PCIe + USB Unique SSC multilink configuration
> - USB + SGMII/QSGMII multilink configuration
> 
> The changes have been validated on TI J7200 platform.

Applied, thanks

-- 
~Vinod
