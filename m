Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42E332CF783
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 00:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730342AbgLDXag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 18:30:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:41386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726583AbgLDXag (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 18:30:36 -0500
From:   Mark Brown <broonie@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Arnd Bergmann <arnd@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Jaroslav Kysela <perex@perex.cz>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <20201203223815.1353451-1-arnd@kernel.org>
References: <20201203223815.1353451-1-arnd@kernel.org>
Subject: Re: [PATCH] ASoC: atmel: mchp-spdifrx needs COMMON_CLK
Message-Id: <160712460213.7629.11656615448561894421.b4-ty@kernel.org>
Date:   Fri, 04 Dec 2020 23:30:02 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Dec 2020 23:38:05 +0100, Arnd Bergmann wrote:
> Compile-testing this driver on an older platform without CONFIG_COMMON_CLK fails with
> 
> ERROR: modpost: "clk_set_min_rate" [sound/soc/atmel/snd-soc-mchp-spdifrx.ko] undefined!
> 
> Make this is a strict dependency.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: atmel: mchp-spdifrx needs COMMON_CLK
      commit: 29275309b0e32bb838d67158c6b6e687275f43e9

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
