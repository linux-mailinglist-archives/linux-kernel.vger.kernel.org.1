Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6CB2115D4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jul 2020 00:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbgGAWXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jul 2020 18:23:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:50644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726235AbgGAWXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 18:23:38 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB3B0207E8;
        Wed,  1 Jul 2020 22:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593642218;
        bh=YvDUNj+fg8trAMqTyRtGHgkegQAd30nkfRcCjZGkb3o=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=HXfv682n6ZespMyOigsYEjlTyhPezgFENJpvx8GP3dte0d2Uk8D8AJCLJhjmE7mPD
         nEMT4fLjbyqvDoeiEKGkrSLgup71imQOIpAGAcN3iShLJh9wIiBBDFLwi1U9ruaSZs
         I90nz+cLuMfFyL5fWb0NbUTeKiJEAJCw4nM4LGSQ=
Date:   Wed, 01 Jul 2020 23:23:36 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc:     Sia Jee Heng <jee.heng.sia@intel.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        alsa-devel@alsa-project.org
In-Reply-To: <20200617010232.23222-1-natechancellor@gmail.com>
References: <20200617010232.23222-1-natechancellor@gmail.com>
Subject: Re: [PATCH] ASoC: Intel: KeemBay: Fix header guard
Message-Id: <159364215574.10630.1671319730156602533.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jun 2020 18:02:32 -0700, Nathan Chancellor wrote:
> Clang warns:
> 
>  In file included from sound/soc/intel/keembay/kmb_platform.c:14:
>  sound/soc/intel/keembay/kmb_platform.h:9:9: warning: 'KMB_PLATFORM_H_'
>  is used as a header guard here, followed by #define of a different
>  macro [-Wheader-guard]
>  #ifndef KMB_PLATFORM_H_
>          ^~~~~~~~~~~~~~~
>  sound/soc/intel/keembay/kmb_platform.h:10:9: note: 'KMB_PLATFORMP_H_'
>  is defined here; did you mean 'KMB_PLATFORM_H_'?
>  #define KMB_PLATFORMP_H_
>          ^~~~~~~~~~~~~~~~
>          KMB_PLATFORM_H_
>  1 warning generated.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: KeemBay: Fix header guard
      commit: 9a7794bd4a28e274f9f247f1ea230f2f0f1077a2

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
