Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFE322C82B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 16:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbgGXOhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 10:37:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:54322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726366AbgGXOhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 10:37:32 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 542FF20674;
        Fri, 24 Jul 2020 14:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595601451;
        bh=Y3rRNtfg71nMx6qz6rx66JXD55K1Y0yFf+scRNRURBs=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=ZAlWr5O+XTfG91n0rqwmKp3rshphbA6EIBLmuQCyb8izj8jCMReYWja4yrnPq6RYd
         tcrzxLEoNG6tNr+r9BYGi93QBbwbJscxNs1A5nxmIqgTjor/Mewkq9ihkkhFtf3eYP
         QihSAcIqt3ewMLFv2S61Lz0msGDRp+q7xneMvyRc=
Date:   Fri, 24 Jul 2020 15:37:16 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20200723142020.1338740-1-jbrunet@baylibre.com>
References: <20200723142020.1338740-1-jbrunet@baylibre.com>
Subject: Re: [PATCH] ASoC: soc-component: don't report of_xlate_dai_name failures
Message-Id: <159560143160.13017.4077278524631889799.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jul 2020 16:20:20 +0200, Jerome Brunet wrote:
> With commit e2329eeba45f ("ASoC: soc-component: add soc_component_err()")
> every error different for ENOTSUPP or EPROBE_DEFER will log an error.
> 
> However, as explained in snd_soc_get_dai_name(), this callback may error
> to indicate that the DAI is not matched by the component tested. If the
> device provides other components, those may still match. Logging an error
> in this case is misleading.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: soc-component: don't report of_xlate_dai_name failures
      commit: cc4d8cebbf2a1239aab71a8077fbe20f24ec2165

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
