Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B95AF279269
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 22:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbgIYUmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 16:42:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:50756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbgIYUmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 16:42:51 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE72021D42;
        Fri, 25 Sep 2020 20:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601066571;
        bh=EfSzTCliWhiljJ3+L77GOzDVfo7KHWTv3mmxcKGz2jQ=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=XwCW8Jdk4w7MvkQoLKzQ7B9IEUn0u+mioiXi243K9sDBT7ApPTyXZkJszGC6B6g+p
         u2H53IuYqY/4RsV1bQgUzgXVhAUkdlli4e/O0QJX7oaM6nTywJ0WCL06SxiXmD81C0
         YWy9+6ZQNSZgcRr8JoAlqg19KPkBzpLpLn2qqNhQ=
Date:   Fri, 25 Sep 2020 21:41:56 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20200925084925.26926-1-srinivas.kandagatla@linaro.org>
References: <20200925084925.26926-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 0/2] ASoC: qdsp6: fix some warnings when build without CONFIG_OF
Message-Id: <160106647647.2866.17205507189233379981.b4-ty@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Sep 2020 09:49:23 +0100, Srinivas Kandagatla wrote:
> Here are fixes for two warnings types discovered while building qdsp6 drivers
> without CONFIG_OF and with W=1
> 
> One of them was reported by Intel kernel test robot on q6afe-clocks patch, which
> equally applies to rest of the qdsp6 drivers.
> 
> Srinivas Kandagatla (2):
>   ASoC: qdsp6: Drop of_match_ptr to fix -Wunused-const-variable
>   ASoC: q6asm: fix kernel doc warnings
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: q6asm: fix kernel doc warnings
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
