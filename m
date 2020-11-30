Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 722232C86F3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 15:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgK3OkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 09:40:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:49392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbgK3OkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 09:40:20 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3B7420725;
        Mon, 30 Nov 2020 14:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606747180;
        bh=UtCy0Q6iAI4eqrqdFVaVCDH6fxHOhNgoqJvsr9jGwsM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gg/Ygpse1DxxvOKzrzCjkMF/Pgu5rh3vH7qvVS8mBomxHfCZK3OZhKvLU4LgxQBud
         RisRlDu+LAZ9haxNjtRDI0ST9xxrOMVjj6vyl17VJCsxpPrh7GM8fSCXeP4YEIoN9Z
         H6aN7ObL2gz1snrIYOScVqA1+c8o/pBKkjfv1mfw=
Date:   Mon, 30 Nov 2020 22:39:32 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ashish Kumar <Ashish.Kumar@nxp.com>,
        Yangbo Lu <yangbo.lu@nxp.com>, Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v2] arm64: dts: ls1028a: make the eMMC and SD card
 controllers use fixed indices
Message-ID: <20201130143923.GK4072@dragon>
References: <20201119163821.980841-1-vladimir.oltean@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119163821.980841-1-vladimir.oltean@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 06:38:21PM +0200, Vladimir Oltean wrote:
> As the boot order in the kernel continues to change, sometimes it may
> happen that the eSDHC controller mmc@2150000 (the one for eMMC) gets
> probed before the one at mmc@2140000 (for external SD cards). The effect
> is that the eMMC controller gets the /dev/mmcblk0 name, and the SD card
> gets /dev/mmcblk1.
> 
> Since the introduction of this SoC, that has never happened in practice,
> even though it was never guaranteed in theory. Setting
> "root=/dev/mmcblk0p2" in /proc/cmdline has always caused the kernel to
> use the second partition from the SD card as the rootfs.
> 
> The NXP development boards are typically shipped with either
> - LSDK, which uses "root=UUID=", or
> - OpenIL, which uses "root=/dev/mmcblkNp2"
> 
> So for OpenIL, let's preserve that old behavior by adding some aliases
> which create naming consistency (for LSDK it doesn't matter):
> - the SD card controller uses /dev/mmcblk0
> - the eMMC controller uses /dev/mmcblk1
> 
> For the Kontron SL28 boards, Michael Walle says that they are shipped
> with "root=UUID=" already, so the probing order doesn't matter, but it
> is more natural to him for /dev/mmcblk0 to be the eMMC, so let's do it
> the other way around there.
> 
> The aliases are parsed by mmc_alloc_host() in drivers/mmc/core/host.c.
> 
> Cc: Ashish Kumar <Ashish.Kumar@nxp.com>
> Cc: Yangbo Lu <yangbo.lu@nxp.com>
> Cc: Michael Walle <michael@walle.cc>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Applied, thanks.
