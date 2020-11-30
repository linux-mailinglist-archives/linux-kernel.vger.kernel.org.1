Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79A2C2C8299
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 11:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbgK3Kt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 05:49:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:33400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbgK3Kt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 05:49:27 -0500
Received: from localhost (unknown [122.171.214.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B32C7206B7;
        Mon, 30 Nov 2020 10:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606733326;
        bh=t4+Yw1to2e7xKgHNLaIR4ydZHUYF8sCvmH3H7OvgUYw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q6ABZ3ILaOWWixyG25jTCRyYw/uqAHD9dELum8N03AlcBEwYd8gq9fdQHnsBzaylV
         bGU9UyYOpsWAfD3puDwururN+Tzl0434GJ4LlgBMz9u0FXWwKbuHTeHmzJtlAytemB
         mMZyT19WvoNPT3aaiswPrSSMzSzw3/uN+AvIf2gY=
Date:   Mon, 30 Nov 2020 16:18:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     robh+dt@kernel.org, kishon@ti.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        devel@driverdev.osuosl.org, neil@brown.name
Subject: Re: [PATCH v6 0/4] MT7621 PCIe PHY
Message-ID: <20201130104837.GO8403@vkoul-mobl>
References: <20201121155037.21354-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201121155037.21354-1-sergio.paracuellos@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-11-20, 16:50, Sergio Paracuellos wrote:
> This series adds support for the PCIe PHY found in the Mediatek
> MT7621 SoC.
> 
> There is also a 'mt7621-pci' driver which is the controller part
> which is still in staging and is a client of this phy.
> 
> Both drivers have been tested together in a gnubee1 board.
> 
> This series are rebased on the top of linux-phy:
> commit 768a711e2d4b ("phy: samsung: phy-exynos-pcie: fix typo 'tunning'")

Applied, thanks

-- 
~Vinod
