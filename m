Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 919852F1AE9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 17:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388258AbhAKQ3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 11:29:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:37124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728600AbhAKQ3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 11:29:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F1C9D22AAD;
        Mon, 11 Jan 2021 16:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610382513;
        bh=G5+Z2c5y/qafwv2OenU6ckGI8gYAwBTeTauA6NsOeXw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=jlyL/KarUMCerA5s1GvZDGI+MMvZwE5EMMAwM5K7exR2pspUYSqNioDDZDiXAYT1N
         1uK6KFuQvJsd7Ty8jLa02DcLNDpxijc5jxXGGp6wlba8n1iWlWjxPOv9ZMZhQuNsCs
         xZoqqc2bvEM+FfBJLUhRedfZ7KGVFjkOu0/tlqmKKbNsslFvhhsU9rlR+YhnMf7rPp
         PIW0kSJqm5DHoIY9d57+Y0/+lVaLbuZ7iFbPxz8Obf9JHdiESIYhnPBjMrbQcLvWAT
         Xo4AZUyCjEt/rtjQTu3Un6yqsO3PAbHieop5ftLjYpgmRvIo9QtfjwSag8iWEI6WMR
         NTsjoOaD1qP4A==
From:   Mark Brown <broonie@kernel.org>
To:     perex@perex.cz, oder_chiou@realtek.com, lgirdwood@gmail.com,
        tiwai@suse.com, Chris Chiu <chiu@endlessos.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux@endlessos.org
In-Reply-To: <20210111054141.4668-1-chiu@endlessos.org>
References: <20210111054141.4668-1-chiu@endlessos.org>
Subject: Re: [PATCH v3 0/4] ASoC: rt5645: Enable internal mic and headset on ECS EF20
Message-Id: <161038245912.32701.12070464225959721815.b4-ty@kernel.org>
Date:   Mon, 11 Jan 2021 16:27:39 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jan 2021 13:41:37 +0800, Chris Chiu wrote:
> These patches are trying to fix the jack detection and internal
> microphone problems on ECS EF20 series laptops which are empowered
> by Intel Atom x5-Z8350 CPU (CherryTrail) with Realtek rt5645 audio
> codec.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: rt5645: Introduce mapping for ACPI-defined GPIO
      commit: 21f603482a6bdc4e7481f5a8e0e4b654d8d6e3a3
[2/4] ASoC: rt5645: Add ACPI-defined GPIO for ECS EF20 series
      commit: a4dae468cfdd90cdb08d96161482c23739dd636a
[3/4] ASoC: rt5645: add inv_hp_det flag
      commit: 28c988492cf65626d06ae32d7f20f1596c080667
[4/4] ASoC: rt5645: Enable internal microphone and JD on ECS EF20
      commit: 3ac2bfd52b7de6206b1e694a4e79a39d6106c961

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
