Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 659952CF78A
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 00:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730904AbgLDXbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 18:31:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:41966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbgLDXbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 18:31:12 -0500
From:   Mark Brown <broonie@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com
In-Reply-To: <20201204164228.1826-1-srinivas.kandagatla@linaro.org>
References: <20201204164228.1826-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] ASoC: q6afe-clocks: Add missing parent clock rate
Message-Id: <160712460214.7629.10875040201126733865.b4-ty@kernel.org>
Date:   Fri, 04 Dec 2020 23:30:02 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Dec 2020 16:42:28 +0000, Srinivas Kandagatla wrote:
> setting clock rate on child clocks without a parent clock rate will
> result in zero clk rate for child. This also means that when audio
> is started dsp will attempt to access registers without enabling
> clock resulting in board boot up.
> 
> Fix this by adding the missing parent clock rate.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: q6afe-clocks: Add missing parent clock rate
      commit: 7e20ae1208daaf6dad85c2dcb968fc590b6f3b99

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
