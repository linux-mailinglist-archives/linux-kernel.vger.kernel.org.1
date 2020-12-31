Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D65772E8036
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 14:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgLaN3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Dec 2020 08:29:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:40538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726630AbgLaN3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Dec 2020 08:29:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 309CE223E0;
        Thu, 31 Dec 2020 13:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609421332;
        bh=K56VJyy27x0kGr4SNtwCRlFlFSdH8USKotViNClcc8s=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=P3AvGcGR0QvXm9N/JFSFfPexBrn4t4zGYbbibSrhJ1N3C9Jw7JmHB1JptbONJKUGb
         gFzzWqvc68i/mbItQTs/vqisNp1oaTflQQAl/jZ/Q0Fmlu25EAPuWMx6mdyDynTo7V
         idb9sFcQ+xZlgs/FjYdzaWzKKL/IetF1tLyzQRI9h/5Fei+/yxio/ggjRs2K/8jR5D
         aOFYwp5XX0fW/E7Ub3XL/ddbmIYn6kFQOBfvtfNW5iCKZyBagpjNaWdIbRD2OkrKye
         94i0Nn5Hs6h4FshBOIMkAZpAwFRyQY7wl6VE9uFwmjSOtUroHKpdh3zF/sWe4bNXrs
         eOnGzyNMqZsiA==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
        linux-mediatek@lists.infradead.org,
        Tzung-Bi Shih <tzungbi@google.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20201230154345.639122-1-arnd@kernel.org>
References: <20201230154345.639122-1-arnd@kernel.org>
Subject: Re: [PATCH] ASoC: mediatek: add MTK_PMIC_WRAP dependency
Message-Id: <160942130384.56416.5738350943602041009.b4-ty@kernel.org>
Date:   Thu, 31 Dec 2020 13:28:23 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Dec 2020 16:43:34 +0100, Arnd Bergmann wrote:
> Randconfig builds often show harmless warnings like
> 
> WARNING: unmet direct dependencies detected for SND_SOC_MT6359
>   Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && MTK_PMIC_WRAP [=n]
>   Selected by [y]:
>   - SND_SOC_MT8192_MT6359_RT1015_RT5682 [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && I2C [=y] && SND_SOC_MT8192 [=y]
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: add MTK_PMIC_WRAP dependency
      commit: c1cbbea9c4db41eb69a831d8b07da52e05b1d1e8

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
