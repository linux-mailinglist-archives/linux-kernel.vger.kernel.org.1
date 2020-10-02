Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09D4C281D3C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 22:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725767AbgJBU7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 16:59:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:49412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgJBU7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 16:59:07 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25707206B6;
        Fri,  2 Oct 2020 20:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601672346;
        bh=FyJohXOK/KJdaykrGzT4mSI8I/QzPpTMyYnfVJll6sk=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=n6KZ9IX7fRgmg0IBJmHMXoRiSWLIQSlbE7GkHzJsOnDmgDQly+Ie05kTzgPmh6JPl
         P6ZT+izZDFWRCAybNsTkUhGD+a+CU2y5w74fRbYKYH0hAQaFpE1sD4P3Lx2nYKb0FQ
         STAv7rdtRXs/CDIxzOMuRONau91JRA22Pqdp9rrA=
Date:   Fri, 02 Oct 2020 21:58:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc:     alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Takashi Iwai <tiwai@suse.com>
In-Reply-To: <20201001183537.5781-1-rdunlap@infradead.org>
References: <20201001183537.5781-1-rdunlap@infradead.org>
Subject: Re: [PATCH -next] ASoC: qcom: fix SDM845 & QDSP6 dependencies more
Message-Id: <160167211499.21762.6643224130461458588.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Oct 2020 11:35:37 -0700, Randy Dunlap wrote:
> Fix a build error and Kconfig warning in sound/soc/qcom/.
> 
> ld: sound/soc/qcom/qdsp6/q6afe-clocks.o: in function `q6afe_clock_dev_probe':
> q6afe-clocks.c:(.text+0x182): undefined reference to `devm_clk_hw_register'
> ld: q6afe-clocks.c:(.text+0x19d): undefined reference to `of_clk_add_hw_provider'
> 
> After adding "depends on COMMON_CLK" for SND_SOC_QDSP6, the Kconfig
> warning appears because "select" does not honor any "depends on"
> clauses, so fix the dependency for SND_SOC_SDM845 also.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qcom: fix SDM845 & QDSP6 dependencies more
      commit: 2bc8831b135ce1a55285663505245cb79422af76

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
