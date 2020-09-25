Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80D6A279264
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 22:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbgIYUmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 16:42:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:50488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbgIYUmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 16:42:36 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D82720838;
        Fri, 25 Sep 2020 20:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601066556;
        bh=LJ5Wq7Ghlg4aaCr8Y6wHkODK/JS9MUf2NYdYnegp7ew=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=GIUZnJrR7cU/+X537LFf4l4Pgd3gAxHmvwfaAD2WCed1p5GrKginNxqvvX1jofR3U
         8P3TErmQ7onDMGJoxLG6erq4/UBU/Dm8KPKm8CAUol8Yrc0p84rDTwQ/GnKP3KwcgN
         1y0p3pN+UWpOL6y/kGgw44rVIXXqJb4Xy0PN/qqg=
Date:   Fri, 25 Sep 2020 21:41:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20200925163552.20717-1-srinivas.kandagatla@linaro.org>
References: <20200925163552.20717-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 0/2] ASoC: qdsp6: fix some warnings when build without CONFIG_OF
Message-Id: <160106647647.2866.17095858742124521206.b4-ty@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Sep 2020 17:35:50 +0100, Srinivas Kandagatla wrote:
> Here are fixes for two warnings types discovered while building qdsp6 drivers
> without CONFIG_OF and with W=1
> 
> One of them was reported by Intel kernel test robot on q6afe-clocks patch, which
> equally applies to rest of the qdsp6 drivers.
> 
> changes since v1:
> 	- added ifdef CONFIG_OF instead of removing of_match_ptr
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: qdsp6: add ifdef CONFIG_OF around of_device_id
      commit: 156d0273f62fd437b25dced944788d8784f0212c
[2/2] ASoC: q6asm: fix kernel doc warnings
      commit: 5d0576bba9eb37bf07dc58a91568a2332a22fbcd

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
