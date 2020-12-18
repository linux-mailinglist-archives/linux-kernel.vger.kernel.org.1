Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 668AA2DE2A1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 13:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgLRMRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 07:17:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:57584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgLRMRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 07:17:19 -0500
From:   Mark Brown <broonie@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     alsa-devel@alsa-project.org, linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>
In-Reply-To: <20201217150812.3247405-1-jbrunet@baylibre.com>
References: <20201217150812.3247405-1-jbrunet@baylibre.com>
Subject: Re: [PATCH] ASoC: meson: axg-tdm-interface: fix loopback
Message-Id: <160829377018.10885.15767835159300610540.b4-ty@kernel.org>
Date:   Fri, 18 Dec 2020 12:16:10 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Dec 2020 16:08:12 +0100, Jerome Brunet wrote:
> When the axg-tdm-interface was introduced, the backend DAI was marked as an
> endpoint when DPCM was walking the DAPM graph to find a its BE.
> 
> It is no longer the case since this
> commit 8dd26dff00c0 ("ASoC: dapm: Fix handling of custom_stop_condition on DAPM graph walks")
> Because of this, when DPCM finds a BE it does everything it needs on the
> DAIs but it won't power up the widgets between the FE and the BE if there
> is no actual endpoint after the BE.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: meson: axg-tdm-interface: fix loopback
      commit: 671ee4db952449acde126965bf76817a3159040d

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
