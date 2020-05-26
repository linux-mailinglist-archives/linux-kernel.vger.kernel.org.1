Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2CC31AE541
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 20:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbgDQS4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 14:56:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:56498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726432AbgDQS4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 14:56:06 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E23BD206E9;
        Fri, 17 Apr 2020 18:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587149766;
        bh=Dm3R98EwUsHzxty01uoqbg4lClykQLLZ0/eLOPZF/aI=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=s84ng54P9XXBCp2gGV+A6cOqwWuqWzcbakKh/O/Bjvr2W3MXBlCBb48hpMi23Vkp3
         C++UWR1jhP0Zp3UopEesVXIaopvo5fQCXKi+Iw8+KraqZ1iqhrELT1EslYmXTXNMp9
         S9a4pcHAcd0AViiBUn3sXgKgSkAR7+nc9/R+ZavM=
Date:   Fri, 17 Apr 2020 19:56:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     alexandre.torgue@st.com, lgirdwood@gmail.com, tiwai@suse.com,
        Olivier Moysan <olivier.moysan@st.com>, perex@perex.cz
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
In-Reply-To: <20200417142122.10212-1-olivier.moysan@st.com>
References: <20200417142122.10212-1-olivier.moysan@st.com>
Subject: Re: [PATCH] ASoC: stm32: sai: fix sai probe
Message-Id: <158714975762.9428.15651619763000447218.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Apr 2020 16:21:22 +0200, Olivier Moysan wrote:
> pcm config must be set before snd_dmaengine_pcm_register() call.
> 
> Fixes: 0d6defc7e0e4 ("ASoC: stm32: sai: manage rebind issue")
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
> ---
>  sound/soc/stm/stm32_sai_sub.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> [...]

Applied, thanks!

[1/1] ASoC: stm32: sai: fix sai probe
      commit: e2bcb65782f91390952e849e21b82ed7cb05697f

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
