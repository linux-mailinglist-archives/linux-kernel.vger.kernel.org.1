Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBB911C394C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 May 2020 14:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbgEDM1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 May 2020 08:27:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:45964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726445AbgEDM1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 08:27:11 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B745A2073B;
        Mon,  4 May 2020 12:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588595231;
        bh=7HeWhzNq4ru7hIGiV66ihin7t3xTqFDGYRWsgtPc7XU=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=sZIg8UYNN5bxn5Rx2FiMN81huW/nF77JV6cFZJUtl59wlcwMot4nYILDk+Kt9M+6e
         ppNSd6OwE/QuFAzYsMJsj/MvJccnx0OH2SEl8ZvzLo/EgYvWsdJyZ3wCu/PklIoQi0
         wtRldDB+t7QjFmUEy8XjdQsTy0wIT6rxBtERAt50=
Date:   Mon, 04 May 2020 13:27:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, Wolfram Sang <wsa@kernel.org>
Cc:     alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
        kernel@pengutronix.de, Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <20200502142646.19033-1-wsa@kernel.org>
References: <20200502142646.19033-1-wsa@kernel.org>
Subject: Re: [PATCH] ASoC: codecs: max9768: update contact email
Message-Id: <158859522870.21499.16362674859345760035.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 May 2020 16:26:46 +0200, Wolfram Sang wrote:
> The 'pengutronix' address is defunct for years. Use the proper contact
> address.
> 
> Signed-off-by: Wolfram Sang <wsa@kernel.org>
> ---
>  sound/soc/codecs/max9768.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.7

Thanks!

[1/1] ASoC: codecs: max9768: update contact email
      commit: 454b3766de45f8508b343e509fdde959b4ff289c

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
