Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC47A26E4CA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 20:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgIQS6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 14:58:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:58720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726646AbgIQS6M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 14:58:12 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D2832072E;
        Thu, 17 Sep 2020 18:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600369080;
        bh=h2oBzSRlDP6lx+rd4sKX9zHni5NLmneiOlwvYFS28v4=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=COy9VIGawcbUC2qB47O6ifSy3VHIHqyKV/Slg/r590Y0r1xhwDQLyjWdTHieGTVa1
         ekqEU3m4TvI+HUfQNCzoMc529Mwgs4mau+JK2IkbI+5LX0EnIdCgSeDb8uOPgAgvep
         WjSJoYVYU9b70EnDGw7VXkRzUdzV7YrrpEAiKQhs=
Date:   Thu, 17 Sep 2020 19:57:10 +0100
From:   Mark Brown <broonie@kernel.org>
To:     robh+dt@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     tiwai@suse.com, lgirdwood@gmail.com, bgoswami@codeaurora.org,
        plai@codeaurora.org, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org
In-Reply-To: <20200910135708.14842-1-srinivas.kandagatla@linaro.org>
References: <20200910135708.14842-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 0/2] ASoC: q6afe: add clocks support
Message-Id: <160036900935.20113.3270260230921504372.b4-ty@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Sep 2020 14:57:06 +0100, Srinivas Kandagatla wrote:
> q6afe already exposes clocks using apis, but not as proper
> clock controller driver. This patch puts those clocks
> in to a proper clock controller so that other drivers that
> depend on those clocks can be properly expressed.
> 
> 
> Srinivas Kandagatla (2):
>   ASoC: q6afe: dt-bindings: add q6afe clock bindings
>   ASoC: q6afe-clocks: add q6afe clock controller
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: q6afe: dt-bindings: add q6afe clock bindings
      commit: 4e398353a7e51410c34fd19f8b7dfc56fff5901b
[2/2] ASoC: q6afe-clocks: add q6afe clock controller
      commit: 520a1c396d1966b64884d8e0176a580150d5a09e

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
