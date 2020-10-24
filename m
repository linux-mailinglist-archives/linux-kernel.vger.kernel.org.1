Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C30552979F7
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 02:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758819AbgJXA24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 20:28:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:41920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755505AbgJXA2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 20:28:55 -0400
Received: from localhost (cpc102338-sgyl38-2-0-cust404.18-2.cable.virginm.net [77.102.33.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B76A42225E;
        Sat, 24 Oct 2020 00:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603499335;
        bh=+FhP76HiOXe3pLSCqtvML2xh8BV++5Vbe3/EWxwGkS0=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=dQ4WtqDRR9mWnKyBXxnLs1n5kJnoMWQ+fNdXS+7h3F1eWUPtwmG/YfyflQSUmTckJ
         xSD5QvPO5yw1C+LiYg1Az8ytrcMrDCZHcvBxNpCoKDe+qMjjf6bR40myzgnrLgS6QJ
         XP5lQqGlOZopAoGcU4sp8UyUKud4YuN/z10SQ0s4=
Date:   Sat, 24 Oct 2020 01:28:53 +0100
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, perex@perex.cz,
        Olivier Moysan <olivier.moysan@st.com>,
        alexandre.torgue@st.com, tiwai@suse.com, arnaud.patard@rtp-net.org
Cc:     alsa-devel@alsa-project.org, arnaud.pouliquen@st.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20201020150109.482-1-olivier.moysan@st.com>
References: <20201020150109.482-1-olivier.moysan@st.com>
Subject: Re: [PATCH v2] ASoC: cs42l51: manage mclk shutdown delay
Message-Id: <160349931941.28438.14503960964995572782.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Oct 2020 17:01:09 +0200, Olivier Moysan wrote:
> A delay must be introduced before the shutdown down of the mclk,
> as stated in CS42L51 datasheet. Otherwise the codec may
> produce some noise after the end of DAPM power down sequence.
> The delay between DAC and CLOCK_SUPPLY widgets is too short.
> Add a delay in mclk shutdown request to manage the shutdown delay
> explicitly. From experiments, at least 10ms delay is necessary.
> Set delay to 20ms as recommended in Documentation/timers/timers-howto.rst
> when using msleep().

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs42l51: manage mclk shutdown delay
      commit: 20afe581c9b980848ad097c4d54dde9bec7593ef

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
