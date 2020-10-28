Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D90FA29E22C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 03:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733222AbgJ2CLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 22:11:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:35436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726930AbgJ1VhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:37:23 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2EB224838;
        Wed, 28 Oct 2020 21:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603920130;
        bh=6OAbUy4jL6Bx1P3st+/vdMDyglfJGd3vOkanNKHQnkA=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=B0lch2UHpafpd1SgSfTrs7u2APbezZCJcbm1+rN+3tSYW+odtUqfaF/lXiykxj16J
         xl5HeqCshjUNhFE2z+7CxkuYB94LQfTkG5UbJwJYXbIjwdHXyamWKC3FBfiO18Hdcf
         3ZQ9zHhpGCOFItmP3jhNy/+WYKkdZXzFxhYTXYgQ=
Date:   Wed, 28 Oct 2020 21:22:04 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com
In-Reply-To: <20201028154340.17090-1-srinivas.kandagatla@linaro.org>
References: <20201028154340.17090-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 1/2] ASoC: codecs: wcd934x: Set digital gain range correctly
Message-Id: <160392012411.40829.13831056962403963010.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Oct 2020 15:43:39 +0000, Srinivas Kandagatla wrote:
> digital gain range is -84dB min to 40dB max, however this was not
> correctly specified in the range.
> 
> Fix this by with correct range!

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: codecs: wcd934x: Set digital gain range correctly
      commit: fc0522bbe02fa4beb95c0514ace66b585616f111
[2/2] ASoC: codecs: wcd9335: Set digital gain range correctly
      commit: 6d6bc54ab4f2404d46078abc04bf4dee4db01def

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
