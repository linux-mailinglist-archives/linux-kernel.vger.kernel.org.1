Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E45422C8C7F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 19:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbgK3SRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 13:17:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:59090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728003AbgK3SRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 13:17:44 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC863206F9;
        Mon, 30 Nov 2020 18:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606760223;
        bh=8cqYTAO7zXCkg3dI7zmJ6MhmYQP/JvOs34PggWV2qmI=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=ZI2ngs16wu09wXGbXH+s3TV32uqTQ8g5T4IFCl6mGVF8Au4h+nmvlWM5EP8u8RYIM
         eeL3EPceMXWpVoZE4pPV5SzN5h6YDVQWnJ894hXvjAP9VSlULnL05PqObiUGUWEF5O
         iimJWxtDnJyAEWhujx3W5u1v+1KEQ0KBkHPqu1m0=
Date:   Mon, 30 Nov 2020 18:16:35 +0000
From:   Mark Brown <broonie@kernel.org>
To:     vkoul@kernel.org, Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org
Cc:     gregkh@linuxfoundation.org, tiwai@suse.de, jank@cadence.com,
        vinod.koul@linaro.org, srinivas.kandagatla@linaro.org,
        bard.liao@intel.com, pierre-louis.bossart@linux.intel.com,
        linux-kernel@vger.kernel.org, ranjani.sridharan@linux.intel.com,
        rander.wang@linux.intel.com, hui.wang@canonical.com,
        mengdong.lin@intel.com, sanyog.r.kale@intel.com
In-Reply-To: <20201103172226.4278-1-yung-chuan.liao@linux.intel.com>
References: <20201103172226.4278-1-yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH 0/5] regmap/SoundWire/ASoC: Add SoundWire SDCA support
Message-Id: <160676019500.54241.11589384467836552465.b4-ty@kernel.org>
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

[1/3] ASoC/SoundWire: rt715-sdca: First version of rt715 sdw sdca codec driver
      commit: 6f4a038b99677f4db737841b81b9d45ed4b54966
[2/3] ASoC/SoundWire: rt1316: Add RT1316 SDCA vendor-specific driver
      (no commit info)
[3/3] ASoC/SoundWire: rt711-sdca: Add RT711 SDCA vendor-specific driver
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
