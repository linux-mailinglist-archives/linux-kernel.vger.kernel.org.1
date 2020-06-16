Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 573361FAF63
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 13:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbgFPLkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jun 2020 07:40:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:59688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727969AbgFPLkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 07:40:08 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDAF5207DD;
        Tue, 16 Jun 2020 11:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592307607;
        bh=Y0Fm3RODkm2DHPjLeITM6HFypc3h8QJV26AcHv5bUkY=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=Qmznpg/6nGtHOwn8ClZFHWnAJl8yE0b6zPA3dcX6mSSRICCkhxf56WKO+f8nPW4Zh
         jV1IurwJmTZuE24Rg5KW9xF6N3vMBxWEQKSwfCnDeA2LJLyzG0sQpImEPnih7lU42g
         otM+juCJQ7HC9umbOFMLKCEVbNYBvIfz+BuocTH8=
Date:   Tue, 16 Jun 2020 12:40:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org, timur@kernel.org, tiwai@suse.com,
        Xiubo.Lee@gmail.com, nicoleotsuka@gmail.com,
        Shengjiu Wang <shengjiu.wang@nxp.com>, perex@perex.cz,
        festevam@gmail.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <034eff1435ff6ce300b6c781130cefd9db22ab9a.1592276147.git.shengjiu.wang@nxp.com>
References: <034eff1435ff6ce300b6c781130cefd9db22ab9a.1592276147.git.shengjiu.wang@nxp.com>
Subject: Re: [PATCH v3] ASoC: fsl_ssi: Fix bclk calculation for mono channel
Message-Id: <159230760496.48596.14192060058649440450.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jun 2020 10:53:48 +0800, Shengjiu Wang wrote:
> For mono channel, SSI will switch to Normal mode.
> 
> In Normal mode and Network mode, the Word Length Control bits
> control the word length divider in clock generator, which is
> different with I2S Master mode (the word length is fixed to
> 32bit), it should be the value of params_width(hw_params).
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_ssi: Fix bclk calculation for mono channel
      commit: ed1220df6e666500ebf58c4f2fccc681941646fb

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
