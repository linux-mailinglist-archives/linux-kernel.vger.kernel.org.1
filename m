Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4F0F21B9AA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 17:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbgGJPkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 11:40:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:56454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726872AbgGJPkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 11:40:00 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3047D2078B;
        Fri, 10 Jul 2020 15:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594395599;
        bh=V0MxTffCGmaOnddHTfSCUdkOwgjWSlGLURFExxwvWa4=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=DqsxumqgRIHMunsu1recsgEeyIYZ60a6TTOR2kIBx0AjtDK+mqMeeRWWug34Uwwll
         TaVCn0Lr4pknuDBBo1+XRnsMmERCLg9288IhTdISfrsyt/5DIk0M9e8+Begy4OB3Hu
         3YkbaQZphfB+fp1hSO8vi2YGo46gkISC8AkMYPuc=
Date:   Fri, 10 Jul 2020 16:39:53 +0100
From:   Mark Brown <broonie@kernel.org>
To:     timur@kernel.org, alsa-devel@alsa-project.org, perex@perex.cz,
        festevam@gmail.com, Shengjiu Wang <shengjiu.wang@nxp.com>,
        nicoleotsuka@gmail.com, tiwai@suse.com, Xiubo.Lee@gmail.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <1594112066-31297-1-git-send-email-shengjiu.wang@nxp.com>
References: <1594112066-31297-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH 0/2] ASoC: fsl_spdif: Clear the validity bit for TX
Message-Id: <159439557864.48910.15440396587948281544.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jul 2020 16:54:24 +0800, Shengjiu Wang wrote:
> Clear the validity bit for TX
> Add kctl for configuring TX validity bit
> 
> Shengjiu Wang (2):
>   ASoC: fsl_spdif: Clear the validity bit for TX
>   ASoC: fsl_spdif: Add kctl for configuring TX validity bit
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: fsl_spdif: Clear the validity bit for TX
      commit: 055b082156704b85a059770359d6cdedfb24831d
[2/2] ASoC: fsl_spdif: Add kctl for configuring TX validity bit
      commit: aa3fce5cd454db551a4ea1656bab9c2bacd2d1f4

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
