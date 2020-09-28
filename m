Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0704227B55B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 21:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgI1Tfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 15:35:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:36174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726424AbgI1Tfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 15:35:50 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09B792080C;
        Mon, 28 Sep 2020 19:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601321749;
        bh=UQgq/R/rvV1UHO3MgvdAQZgvrq/shbSpegQaL/xvcJA=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=cXl7/thhxHT77u2AwqILgPQ1d+exVsro9lK3+ocWeaZsvBL/2UczbeiByYNny2ZIX
         yXsCQbydYPFZRuOwdOo0tZXaD6wfx6ZLrsbL7symgAb+6JJcPeoNYkFt9lx/ANlxOb
         7T95CvKERe6hh+76hiDotGBXisdYW4gOuo24LAcM=
Date:   Mon, 28 Sep 2020 20:34:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     alsa-devel@alsa-project.org, lukas.bulwahn@gmail.com,
        linux-kernel@vger.kernel.org, tiwai@suse.com
In-Reply-To: <20200926171844.7792-1-srinivas.kandagatla@linaro.org>
References: <20200926171844.7792-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] ASoC: q6afe-clocks: Fix typo in SPDX Licence
Message-Id: <160132168198.55254.5121932439754252927.b4-ty@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Sep 2020 18:18:44 +0100, Srinivas Kandagatla wrote:
> Looks like there was a major typo in SPDX Licence version,
> Not sure how it was missed.
> This patch is to fix it.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: q6afe-clocks: Fix typo in SPDX Licence
      commit: d56a7ed2d8f93d95de3f3217c8d563233fde858b

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
