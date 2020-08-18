Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 497F2248C0A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 18:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbgHRQyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 12:54:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:34862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728241AbgHRQyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 12:54:15 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 957D3207D3;
        Tue, 18 Aug 2020 16:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597769655;
        bh=Rofmd0QiMs/9k+UeK1IF5bpm3qfZbJPjgTGC8mXF5mo=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=RuLvDdVLs1Oeefo7spMC8e0Ij5aM8bFFrsLuPKzM9D5Wzsz2MvNc7mMhAsl1hALMl
         Nf11Lqt2Y3X5wb/dzEbKuj7NJExtqMZv/o18SmuzEq8vQALb9lxqvlOaffeuFza0OI
         +O2nP3ITQ9psaIqAM7xB7MSgL915CJ7g4RBtHDfM=
Date:   Tue, 18 Aug 2020 17:53:44 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     john.stultz@linaro.org, tiwai@suse.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
In-Reply-To: <20200811105818.7890-1-srinivas.kandagatla@linaro.org>
References: <20200811105818.7890-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] ASoC: qcom: add a dedicated menuconfig
Message-Id: <159776961932.56094.5932457968960769416.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Aug 2020 11:58:18 +0100, Srinivas Kandagatla wrote:
> Currently list of Qualcomm drivers is growing, so put them in to a
> proper menu so that it does not mix up with other ASOC configs in menuconfig.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qcom: add a dedicated menuconfig
      commit: db24fa5756e944a711a66692af7e25a2189bfe52

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
