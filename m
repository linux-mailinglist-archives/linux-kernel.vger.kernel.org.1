Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 977CB2CC36C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 18:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389084AbgLBRVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 12:21:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:39080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728704AbgLBRU6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 12:20:58 -0500
From:   Mark Brown <broonie@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     tiwai@suse.de, bard.liao@intel.com,
        ranjani.sridharan@linux.intel.com, sanyog.r.kale@intel.com,
        hui.wang@canonical.com, pierre-louis.bossart@linux.intel.com,
        vinod.koul@linaro.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, rander.wang@linux.intel.com
In-Reply-To: <20201130144020.19757-1-yung-chuan.liao@linux.intel.com>
References: <20201130144020.19757-1-yung-chuan.liao@linux.intel.com>
Subject: Re: (subset) [PATCH v2 0/5] regmap/SoundWire/ASoC: Add SoundWire SDCA support
Message-Id: <160692956495.33960.17128508922677938348.b4-ty@kernel.org>
Date:   Wed, 02 Dec 2020 17:19:24 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Nov 2020 22:40:15 +0800, Bard Liao wrote:
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

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

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
