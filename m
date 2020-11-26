Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCC42C5CD4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 21:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389751AbgKZUGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 15:06:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:36322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728118AbgKZUGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 15:06:21 -0500
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net [92.233.91.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48156221F8;
        Thu, 26 Nov 2020 20:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606421180;
        bh=oBmJdlXsf0MuvIMTSzK43kmDbaZhsMs7eidBXMsiiAs=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=bcOCKtP8ennVdATv+NCde6Ehk5X280RX7ayBJKtn37R1pmW0CsityQy3Kc+/ZfCVV
         KvaUH+wQ4q9/q7oZff2iq7exZ4TnimU1V+laoV7Y5wEzrRsXO+XNj8m1gt7PTAxokr
         a7Wh04TgOCJ9/vEQuO4VERPukE4ElSgxjFzL9p+g=
Date:   Thu, 26 Nov 2020 20:05:55 +0000
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org,
        Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, rander.wang@linux.intel.com,
        hui.wang@canonical.com, ranjani.sridharan@linux.intel.com,
        mengdong.lin@intel.com, pierre-louis.bossart@linux.intel.com,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        sanyog.r.kale@intel.com, bard.liao@intel.com, jank@cadence.com,
        tiwai@suse.de, vinod.koul@linaro.org
In-Reply-To: <20201103172226.4278-1-yung-chuan.liao@linux.intel.com>
References: <20201103172226.4278-1-yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH 0/5] regmap/SoundWire/ASoC: Add SoundWire SDCA support
Message-Id: <160642115073.9278.10273170290236043053.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Nov 2020 01:22:21 +0800, Bard Liao wrote:
> The MIPI SoundWire Device Class standard will define audio functionality
> beyond the scope of the existing SoundWire 1.2 standard, which is limited
> to the bus and interface.
> 
> The description is inspired by the USB Audio Class, with "functions",
> "entities", "control selectors", "audio clusters". The main difference
> with the USB Audio class is that the devices are typically on a motherboard
> and descriptors stored in platform firmware instead of being retrieved
> from the device.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/5] soundwire: SDCA: add helper macro to access controls
      commit: 07e21d4d96493fd0a8220ab134855253a34a9c84
[2/5] regmap/SoundWire: sdw: add support for SoundWire 1.2 MBQ
      commit: fb5103f9d6ce197b4d0b67b4e60e68470f5293d1
[3/5] ASoC/SoundWire: rt715-sdca: First version of rt715 sdw sdca codec driver
      commit: 6f4a038b99677f4db737841b81b9d45ed4b54966
[4/5] ASoC/SoundWire: rt1316: Add RT1316 SDCA vendor-specific driver
      (no commit info)
[5/5] ASoC/SoundWire: rt711-sdca: Add RT711 SDCA vendor-specific driver
      (no commit info)

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark
