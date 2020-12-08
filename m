Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 353272D309B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 18:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730376AbgLHRKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 12:10:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:51034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726987AbgLHRKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 12:10:49 -0500
From:   Mark Brown <broonie@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Shengjiu Wang <shengjiu.wang@nxp.com>, timur@kernel.org,
        festevam@gmail.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, perex@perex.cz, robh+dt@kernel.org,
        nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, lgirdwood@gmail.com,
        tiwai@suse.com
In-Reply-To: <1607251319-5821-1-git-send-email-shengjiu.wang@nxp.com>
References: <1607251319-5821-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH v2 1/2] ASoC: dt-bindings: imx-hdmi: Add binding doc for hdmi machine driver
Message-Id: <160744738921.29839.15317690694275693705.b4-ty@kernel.org>
Date:   Tue, 08 Dec 2020 17:09:49 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Dec 2020 18:41:58 +0800, Shengjiu Wang wrote:
> Imx-hdmi is a new added machine driver for supporting hdmi devices
> on i.MX platforms. There is HDMI IP or external HDMI modules connect
> with SAI or AUD2HTX interface.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: imx-hdmi: Add binding doc for hdmi machine driver
      commit: e344cf5e4871f99495396f78d4401b8ac4c92465
[2/2] ASoC: fsl: Add imx-hdmi machine driver
      commit: 6a5f850aa83a1d844d27e3e53ca2f247e55d438b

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
