Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5352D454B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 16:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729523AbgLIPYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 10:24:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:38450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729089AbgLIPYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 10:24:16 -0500
From:   Mark Brown <broonie@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     tiwai@suse.com, perex@perex.cz, lgirdwood@gmail.com,
        Chris Chiu <chiu@endlessos.org>
Cc:     linux-kernel@vger.kernel.org, linux@endlessos.org,
        alsa-devel@alsa-project.org
In-Reply-To: <20201208060414.27646-1-chiu@endlessos.org>
References: <20201208060414.27646-1-chiu@endlessos.org>
Subject: Re: [PATCH] ASoC: Intel: bytcr_rt5640: Add quirk for ARCHOS Cesium 140
Message-Id: <160752715602.48520.184118527808464071.b4-ty@kernel.org>
Date:   Wed, 09 Dec 2020 15:19:16 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Dec 2020 14:04:14 +0800, Chris Chiu wrote:
> Tha ARCHOS Cesium 140 tablet has problem with the jack-sensing,
> thus the heaset functions are not working.
> 
> Add quirk for this model to select the correct input map, jack-detect
> options and channel map to enable jack sensing and headset microphone.
> This device uses IN1 for its internal MIC and JD2 for jack-detect.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: bytcr_rt5640: Add quirk for ARCHOS Cesium 140
      commit: 1bea2256aa96a2d7b1b576eb74e29d79edc9bea8

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
