Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1ADA2CF78B
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 00:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730933AbgLDXbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 18:31:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:41964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726634AbgLDXbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 18:31:12 -0500
From:   Mark Brown <broonie@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Arnd Bergmann <arnd@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Timur Tabi <timur@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>
Cc:     linux-kernel@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <20201203222900.1042578-1-arnd@kernel.org>
References: <20201203222900.1042578-1-arnd@kernel.org>
Subject: Re: [PATCH] ASoC: fsl_aud2htx: mark PM functions as __maybe_unused
Message-Id: <160712460213.7629.13692802144415827947.b4-ty@kernel.org>
Date:   Fri, 04 Dec 2020 23:30:02 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Dec 2020 23:28:47 +0100, Arnd Bergmann wrote:
> When CONFIG_PM is disabled, we get a warning for unused functions:
> 
> sound/soc/fsl/fsl_aud2htx.c:261:12: error: unused function 'fsl_aud2htx_runtime_suspend' [-Werror,-Wunused-function]
> static int fsl_aud2htx_runtime_suspend(struct device *dev)
> sound/soc/fsl/fsl_aud2htx.c:271:12: error: unused function 'fsl_aud2htx_runtime_resume' [-Werror,-Wunused-function]
> static int fsl_aud2htx_runtime_resume(struct device *dev)
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_aud2htx: mark PM functions as __maybe_unused
      commit: 7b153760513cee875515398f4a9ba329a8d426e2

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
