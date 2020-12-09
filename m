Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41C1B2D454D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 16:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729725AbgLIPYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 10:24:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:38608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727090AbgLIPYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 10:24:32 -0500
From:   Mark Brown <broonie@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Paul Cercueil <paul@crapouillou.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        od@zcrc.me
In-Reply-To: <20201207125338.119397-1-paul@crapouillou.net>
References: <20201207125338.119397-1-paul@crapouillou.net>
Subject: Re: [PATCH 1/5] ASoC: codecs/jz47xx: Use regmap_{set,clear}_bits
Message-Id: <160752715602.48520.8596440910035760463.b4-ty@kernel.org>
Date:   Wed, 09 Dec 2020 15:19:16 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Dec 2020 12:53:33 +0000, Paul Cercueil wrote:
> Use regmap_{set,clear}_bits instead of regmap_update_bits, when
> applicable.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] ASoC: codecs/jz47xx: Use regmap_{set,clear}_bits
      commit: ad13c835442cdb2a964588fd03327f51dbcd4dfa
[2/5] ASoC: codecs/jz4770: Reset interrupt flags in bias PREPARE
      commit: a346c77836183f6e3e054c5da022e0fde2773683
[3/5] ASoC: codecs/jz4770: Adjust timeouts for cap-coupled outputs
      commit: 6b4da5374b10a48be18df26288125746f1858507
[4/5] ASoC: codecs/jz4770: Don't change cap-couple setting in HP PMU/PMD
      commit: 4f293dfea9f6d23a972be0e38556f5b0c02c2d4e
[5/5] ASoC: codecs/jz4770: Add DAPM widget to set HP out to cap-less mode
      commit: e648e3f1165354f04a4deed1f41152a287b68d59

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
