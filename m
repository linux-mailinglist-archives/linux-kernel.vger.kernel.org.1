Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9E722DC388
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 16:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgLPPyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 10:54:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:46304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726591AbgLPPya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 10:54:30 -0500
From:   Mark Brown <broonie@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Colin King <colin.king@canonical.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <20201216112859.11564-1-colin.king@canonical.com>
References: <20201216112859.11564-1-colin.king@canonical.com>
Subject: Re: [PATCH] ASoC: codecs: fix spelling mistake in Kconfig "comunicate" -> "communicate"
Message-Id: <160813397775.31838.15795647597993212991.b4-ty@kernel.org>
Date:   Wed, 16 Dec 2020 15:52:57 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Dec 2020 11:28:59 +0000, Colin King wrote:
> There is a spelling mistake in the Kconfig help text. Fix it.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: fix spelling mistake in Kconfig "comunicate" -> "communicate"
      commit: 4ad2d3cf2a299645bdc6d72e5b8ee11b2ed147ac

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
