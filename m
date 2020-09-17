Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0481426E50C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 21:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgIQTGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 15:06:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:59040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbgIQS6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 14:58:23 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD793206A1;
        Thu, 17 Sep 2020 18:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600369103;
        bh=5R9gtjhHhcMCnrJQNNabILcr69G809RQMX4/tJDkkBc=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=N2tPqO7UTGYgoShgpBbrS+rSXaIi55gXDoTUtCCq472M8psVK9hQeRBTPUv6sUQJY
         ZfK+vfB3v4VS7jNzElC1Iod2znR1DPQMeS+fTWxJnoTNjA/MrWwQXIzuFK+NlqZths
         RbQbGBEn070sBDdb88V7gapTe4PPRwgivGTILraY=
Date:   Thu, 17 Sep 2020 19:57:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Patrick Lai <plai@codeaurora.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org,
        Banajit Goswami <bgoswami@codeaurora.org>,
        cychiang@chromium.org, Ajit Pandey <ajitp@codeaurora.org>,
        alsa-devel@alsa-project.org
In-Reply-To: <20200916111545.1.I4c3758817d94c433bafeac344a395e21ea6657e3@changeid>
References: <20200916111545.1.I4c3758817d94c433bafeac344a395e21ea6657e3@changeid>
Subject: Re: [PATCH] ASoC: qcom: lpass-sc7180: Add MODULE_DEVICE_TABLE
Message-Id: <160036900933.20113.7349379554042558829.b4-ty@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Sep 2020 11:15:55 -0700, Douglas Anderson wrote:
> The lpass-sc7180 driver can be built as a module but is lacking a
> MODULE_DEVICE_TABLE.  This means it won't auto-load.  Fix this
> oversight.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qcom: lpass-sc7180: Add MODULE_DEVICE_TABLE
      commit: dcde34c47d8f7befc647fda65e8efa8cc0e795ca

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
