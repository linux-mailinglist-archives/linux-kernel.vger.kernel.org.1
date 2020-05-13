Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89AE21D1258
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 14:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731612AbgEMMKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 08:10:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:52892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728379AbgEMMKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 08:10:41 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DE3720740;
        Wed, 13 May 2020 12:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589371841;
        bh=y4c8k8sIHtDvVeycegIP+HQkIua+/Rw4sNa/whQ2JOY=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=iOfUFBJpkZp+XrNKpQsewM6MDkaZZPJ/BHVjes9LpstYaEC08/9ZgvcYRNHmQmOaK
         +wp26bxtPkq1roUIdClQa2kawhHigfMThRHka0cWXRIriCs6bENj44Va8zIM0K6aHN
         nMoA3HxR4XA6eWBP/V0M+sMMTzR9TGKU5lIE5X5Y=
Date:   Wed, 13 May 2020 13:10:38 +0100
From:   Mark Brown <broonie@kernel.org>
To:     tglx@linutronix.de, Shengjiu Wang <shengjiu.wang@nxp.com>,
        alsa-devel@alsa-project.org, info@metux.net, lgirdwood@gmail.com,
        patches@opensource.cirrus.com, tiwai@suse.com,
        linux-kernel@vger.kernel.org, allison@lohutok.net, perex@perex.cz
In-Reply-To: <1589347835-20554-1-git-send-email-shengjiu.wang@nxp.com>
References: <1589347835-20554-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: wm8962: Use force clear for WM8962_SYSCLK_ENA after reset
Message-Id: <158937183894.38875.12948868475258654279.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 May 2020 13:30:35 +0800, Shengjiu Wang wrote:
> When CLOCKING2 is non-volatile register, we need force clear
> the WM8962_SYSCLK_ENA bit after reset, for the value in cache
> maybe 0 but in hardware it is 1. Otherwise there will issue
> as below statement in driver.
> 
> /* SYSCLK defaults to on; make sure it is off so we can safely
>  * write to registers if the device is declocked.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.7

Thanks!

[1/1] ASoC: wm8962: Use force clear for WM8962_SYSCLK_ENA after reset
      commit: 65e412a01bc0161175a962abd5a7fef6a62d5c8e

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
