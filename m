Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4322CF786
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 00:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730795AbgLDXap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 18:30:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:41598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbgLDXap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 18:30:45 -0500
From:   Mark Brown <broonie@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Paul Cercueil <paul@crapouillou.net>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <20201203144227.418194-1-hslester96@gmail.com>
References: <20201203144227.418194-1-hslester96@gmail.com>
Subject: Re: [PATCH] ASoC: jz4740-i2s: add missed checks for clk_get()
Message-Id: <160712460212.7629.1938775307281622942.b4-ty@kernel.org>
Date:   Fri, 04 Dec 2020 23:30:02 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Dec 2020 22:42:27 +0800, Chuhong Yuan wrote:
> jz4740_i2s_set_sysclk() does not check the return values of clk_get(),
> while the file dereferences the pointers in clk_put().
> Add the missed checks to fix it.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: jz4740-i2s: add missed checks for clk_get()
      commit: 1c1fb2653a0c2e3f310c07eacd8fc3a10e08c97a

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
