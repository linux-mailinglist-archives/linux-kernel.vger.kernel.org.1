Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAEA279268
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 22:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbgIYUmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 16:42:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:50690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbgIYUmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 16:42:46 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8DDE221E5;
        Fri, 25 Sep 2020 20:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601066566;
        bh=+4al6pagugF66uVaMI40JCvZvv0PlvcfCKSRy+WGfZY=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=Fu7OqcPP4P+rE8SSiIyZYBvHPz4Z4b7b1o1hK1r54C2GMpoFL4ctKRZEhXjocAp/+
         2Ggfy9Bo4yjDs+nNPULI2f9jvGCUxsKMohBMnTVgKvdbB/FCge2lYbJFnca9JjOIfG
         3kxFqOP0ImEnXPYUzVMlX7ymeIdll0RSyOXc30jE=
Date:   Fri, 25 Sep 2020 21:41:51 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
In-Reply-To: <20200925091830.7675-1-rf@opensource.cirrus.com>
References: <20200925091830.7675-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH 1/2] ASoC: cs47l15: Fix EPOUT->HPOUT1 Mono Mux routing
Message-Id: <160106647647.2866.8685096288506841458.b4-ty@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Sep 2020 10:18:29 +0100, Richard Fitzgerald wrote:
> EPOUT is always mono so should have a permanent routing through the
> HPOUT1 Mono Mux.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: cs47l15: Fix EPOUT->HPOUT1 Mono Mux routing
      commit: 64952377548517a14d0a6521856dde9fd8356c90
[2/2] ASoC: cs47l35: Fix EPOUT->HPOUT1 Mono Mux routing
      commit: b03acae25e4a4ad600e91a8737c7eff2efe7d66a

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
