Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C59B02CD8DE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 15:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730909AbgLCOTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 09:19:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:39464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389233AbgLCOTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 09:19:31 -0500
From:   Mark Brown <broonie@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        perex@perex.cz, Shengjiu Wang <shengjiu.wang@nxp.com>,
        linuxppc-dev@lists.ozlabs.org, timur@kernel.org,
        Xiubo.Lee@gmail.com, nicoleotsuka@gmail.com,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        robh+dt@kernel.org, tiwai@suse.com, festevam@gmail.com
In-Reply-To: <1606708668-28786-1-git-send-email-shengjiu.wang@nxp.com>
References: <1606708668-28786-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH 1/2] ASoC: fsl-asoc-card: Add support for si476x codec
Message-Id: <160700512198.44361.18384133171951697931.b4-ty@kernel.org>
Date:   Thu, 03 Dec 2020 14:18:41 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Nov 2020 11:57:47 +0800, Shengjiu Wang wrote:
> The si476x codec is used for FM radio function on i.MX6
> auto board, it only supports recording function.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: fsl-asoc-card: Add support for si476x codec
      commit: 77f1ff751037fcd39c8fc37b3c3796fb139fb388
[2/2] ASoC: bindings: fsl-asoc-card: add compatible string for si476x codec
      commit: 0b3355b070434f9901f641aac9000df93e2c96ad

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
