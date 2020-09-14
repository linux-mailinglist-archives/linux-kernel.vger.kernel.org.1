Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27F75268E94
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 16:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgINO5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 10:57:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:52692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726706AbgINOv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 10:51:58 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BAD520715;
        Mon, 14 Sep 2020 14:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600095117;
        bh=a1JalLnTBAaxUOfrKmYR9snF+OmsXWm89BgkakJgbtY=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=nHlZxjObjD7RILUNaeRVhzLzrOscBBQnb049NK7Yru+8eWh4YiKW/a3s0V8AA7qRi
         XjU463tCuCy+ATejyKUCV06FhpHxkXJ3afF+6hxo7gX5hYF/UtAwqno023/mh4W98f
         ZSsq9Le8WOkOHrA9gNfVNN7x7BiOihLCGyBRgOhQ=
Date:   Mon, 14 Sep 2020 15:51:09 +0100
From:   Mark Brown <broonie@kernel.org>
To:     perex@perex.cz, alexandre.torgue@st.com, arnaud.pouliquen@st.com,
        lgirdwood@gmail.com, Olivier Moysan <olivier.moysan@st.com>,
        tiwai@suse.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        alsa-devel@alsa-project.org
In-Reply-To: <20200911081507.7276-1-olivier.moysan@st.com>
References: <20200911081507.7276-1-olivier.moysan@st.com>
Subject: Re: [PATCH] ASoC: stm32: sai: add pm_runtime support
Message-Id: <160009506912.439.13820832041582523614.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Sep 2020 10:15:07 +0200, Olivier Moysan wrote:
> Enable support of pm_runtime on STM32 SAI driver to allow
> SAI power state monitoring.
> pm_runtime_put_autosuspend() is called from ASoC framework
> on pcm device close.
> The pmdown_time delay is available in runtime context, and may be set
> in SAI driver to take into account shutdown delay on playback.
> However, this shutdown delay is already handled in the DAPMs
> of the audio codec linked to SAI CPU DAI.
> So, the choice is made, not to support this delay on CPU DAI side.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: stm32: sai: add pm_runtime support
      commit: 4e723e7565c4031568fb9db18253cfbf6442831d

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
