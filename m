Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1632B2C5CD1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 21:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389432AbgKZUGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 15:06:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:35528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728118AbgKZUGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 15:06:06 -0500
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net [92.233.91.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27F3A221E9;
        Thu, 26 Nov 2020 20:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606421165;
        bh=Wqwm9STBFzNnMy/CB+5wRkk6aIx+t9Lpuhu2scKh5Xc=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=JIYP54KJCgcohFyO3pbrXUtpoy7JWFsw5+woTe/i7R8N0T79xefqqEe2hKC2O5syu
         ZpigwylXfdT3FyYhD471R1anAqwKpRj73RRM4urQDjmfR99pHwnMHeDd2FgB2Gs8+g
         ETQxD9YPjOCeu3FM48yBD2bzL0ZgZEkbSrzxDgb0=
Date:   Thu, 26 Nov 2020 20:05:40 +0000
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, timur@kernel.org, perex@perex.cz,
        festevam@gmail.com, Xiubo.Lee@gmail.com,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        alsa-devel@alsa-project.org, nicoleotsuka@gmail.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <1606371293-29099-1-git-send-email-shengjiu.wang@nxp.com>
References: <1606371293-29099-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl: Fix config name of CONFIG_ARCH_MXC
Message-Id: <160642112480.9090.10420790643480941582.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Nov 2020 14:14:53 +0800, Shengjiu Wang wrote:
> CONFIG_ARCH_MXC should be ARCH_MXC

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl: Fix config name of CONFIG_ARCH_MXC
      commit: c61d1142cfd45f58b63bf9d2d59523f91096e873

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
