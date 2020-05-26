Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF301D7EC0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 May 2020 18:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbgERQlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 12:41:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:36252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbgERQlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 12:41:31 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C9DA207D8;
        Mon, 18 May 2020 16:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589820090;
        bh=l4OKSpQb7xCEPsp2YagYvuWupUCN1pS/UdfClZttRgs=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=VVYUxCnvNuGjTe/K/9RKDzSX19HReSwm5EnLARdFb6d46jsXVop1hldKsi4yp8+Kv
         1O/nkv5EDOxQNkJJMixHYYgc7IWfKdggRvNBznMseYaO+3gshk1H2mOKk4QabD1t/a
         kQHKGZaGPRmPmdrSajdGjDz2p8jADyowt827G4QQ=
Date:   Mon, 18 May 2020 17:41:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Tang Bin <tangbin@cmss.chinamobile.com>, perex@perex.cz,
        timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com
Cc:     alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20200518110040.18036-1-tangbin@cmss.chinamobile.com>
References: <20200518110040.18036-1-tangbin@cmss.chinamobile.com>
Subject: Re: [PATCH] ASoC: fsl_micfil: Fix unused assignment in fsl_set_clock_params()
Message-Id: <158982005877.28736.11025452668323550718.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 May 2020 19:00:40 +0800, Tang Bin wrote:
> Delete unused initialized value of 'ret', because it will
> be assigned by the function fsl_micfil_set_mclk_rate().

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.8

Thanks!

[1/1] ASoC: fsl_micfil: Fix unused assignment in fsl_set_clock_params()
      commit: 15b5c496ff99ce99ab3c5e98e96981d015b3168a

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
