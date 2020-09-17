Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA9926E4CE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 20:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbgIQS65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 14:58:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:59204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726244AbgIQS6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 14:58:35 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C721221E3;
        Thu, 17 Sep 2020 18:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600369113;
        bh=CVDmgxGyA7cpvTQu42ofHENQ5z/H41BZE5Ht5owFFoA=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=ADR2dVWRCVro7vZdLrnCBgcOfwqDA0PE+3WXzXoStrj0NnlkT6KPIIl1DmqTWC1x7
         gvjoCBT5eGhj1s1LTo36sQ3CKfGtdU0uCq0MMT+Elf2Uwkx3GxUlc3XNdUzzrDdGvs
         F34ICzyqNZBYWrNbmcwH9a0cjMzvIK4prIFT9BTE=
Date:   Thu, 17 Sep 2020 19:57:43 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jonathan Bakker <xc-racer2@live.ca>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20200902160025.20922-1-krzk@kernel.org>
References: <20200902160025.20922-1-krzk@kernel.org>
Subject: Re: [PATCH] ASoC: dt-bindings: aries-wm8994: Match compatibles with enum
Message-Id: <160036900935.20113.14067381532897187524.b4-ty@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Sep 2020 18:00:25 +0200, Krzysztof Kozlowski wrote:
> The common pattern for enumerating compatibles is enum, not oneOf.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: aries-wm8994: Match compatibles with enum
      commit: cac17861c950832a60d405f597c2acc2f40a0136

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
