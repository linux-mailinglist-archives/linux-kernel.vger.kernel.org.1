Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C393F1E6194
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 15:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390093AbgE1NCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 09:02:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:55458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390086AbgE1NCC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 09:02:02 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E1C4205CB;
        Thu, 28 May 2020 13:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590670922;
        bh=OhUaEkY53jp+eyO234rsoLAU6beLI62cCo0jIkv6StU=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=XnoMXWa04hz/rw5kA+KDLOKNwwu+2vpToTj1o3OHDpMSEBRZWEBJbcIO9w1KlgugU
         +Ks2txyM2Md0XcJlPmKSkXNtOFj38mIz2Dv/L3ZSgF/Gp+gki0sLwJbxY/AtFdLDFv
         yFIVlJe8E8WweINkcBTfD9Xry7d6tQ/SRafJfhok=
Date:   Thu, 28 May 2020 14:01:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        linux-kernel@vger.kernel.org, Shuming Fan <shumingf@realtek.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Derek Fang <derek.fang@realtek.com>,
        alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>
In-Reply-To: <20200528091851.2889754-1-arnd@arndb.de>
References: <20200528091851.2889754-1-arnd@arndb.de>
Subject: Re: [PATCH v2] ASoC: rt5682: split i2c driver into separate module
Message-Id: <159067091851.53762.13288841825484181405.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 May 2020 11:17:17 +0200, Arnd Bergmann wrote:
> With SND_SOC_AMD_RV_RT5682_MACH using the i2c version of the
> driver, we can easily get a build failure when I2C is built-in
> but soundwire is not:
> 
>  WARNING: unmet direct dependencies detected for SND_SOC_RT5682
>    Depends on [m]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && (I2C [=y] || SOUNDWIRE [=m]) && (SOUNDWIRE [=m] || !SOUNDWIRE [=m]) && (I2C [=y] || !I2C [=y])
>    Selected by [y]:
>    - SND_SOC_AMD_RV_RT5682_MACH [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_AMD_ACP3x [=y] && I2C [=y] && CROS_EC [=y]
>    Selected by [m]:
>    - SND_SOC_RT5682_SDW [=m] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SOUNDWIRE [=m] && (I2C [=y] || !I2C [=y])
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt5682: split i2c driver into separate module
      commit: a50067d4f3c1d60d3fa07584aa6a0f897c1ac5b6

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
