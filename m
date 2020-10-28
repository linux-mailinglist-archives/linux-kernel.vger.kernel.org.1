Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C27DB29D2E8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgJ1Vhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:37:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:35478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726950AbgJ1VhZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:37:25 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87D5E2483A;
        Wed, 28 Oct 2020 21:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603920136;
        bh=EJQkK2roS7SBBH2NKUDZvqNoOZjq9icIXI82V7St+Ek=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=hAIIgT2Wg3fIK/UjRyToe65sfkAbD3F8y8ciTb/Jbf1g+pEowfs9DNO9/NdmvyM3J
         498HO574eeR1JUDsfJlS+kqvp+UxUhdUQ3ZT5200M64xSSQpU9z9wyqqZo19krc087
         nSz91PVOCuz/EbTEgvhbPSLNxI2PX7/Tq7vHSook=
Date:   Wed, 28 Oct 2020 21:22:10 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Colin Ian King <colin.king@canonical.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com
In-Reply-To: <20201028142001.22431-1-srinivas.kandagatla@linaro.org>
References: <20201028142001.22431-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] ASoC: qcom: sm8250: Fix array out of bounds access
Message-Id: <160392012411.40829.8539672124304600568.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Oct 2020 14:20:01 +0000, Srinivas Kandagatla wrote:
> Static analysis Coverity had detected a potential array out-of-bounds
> write issue due to the fact that MAX AFE port Id was set to 16 instead
> of using AFE_PORT_MAX macro.
> 
> Fix this by properly using AFE_PORT_MAX macro.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qcom: sm8250: Fix array out of bounds access
      commit: 7c91d02068c342918003606bf378b259f37b31ba

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
