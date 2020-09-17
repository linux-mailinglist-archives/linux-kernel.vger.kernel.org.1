Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3502626E50D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 21:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbgIQTHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 15:07:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:58976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726338AbgIQS6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 14:58:18 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D39E2072E;
        Thu, 17 Sep 2020 18:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600369098;
        bh=nwlmr/nrxCKk3FOZ0xka91UMZCHg4uCL4upZMkWRGEc=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=PGjs5BHCobqirbFWM8mpEUuKBKpfISGdqiLYg5GVueXj14qZKKjVYgkK8hspbq+oU
         l7Kjmy4rvVEZAGXgQ1lwZwa04qgiins9mBoyBeCwa4mDl0TEi8ubaN4pCgpW40qXYx
         VJRqAHHl9TmR7N1JlJD1iboIldCahMLIi6SASZ5Y=
Date:   Thu, 17 Sep 2020 19:57:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20200908145954.4629-1-krzk@kernel.org>
References: <20200908145954.4629-1-krzk@kernel.org>
Subject: Re: [PATCH] ASoC: dt-bindings: Correct interrupt flags in examples
Message-Id: <160036900934.20113.12883722261775477796.b4-ty@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Sep 2020 16:59:54 +0200, Krzysztof Kozlowski wrote:
> GPIO_ACTIVE_x flags are not correct in the context of interrupt flags.
> These are simple defines so they could be used in DTS but they will not
> have the same meaning:
> 1. GPIO_ACTIVE_HIGH = 0 = IRQ_TYPE_NONE
> 2. GPIO_ACTIVE_LOW  = 1 = IRQ_TYPE_EDGE_RISING
> 
> Correct the interrupt flags, assuming the author of the code wanted some
> logical behavior behind the name "ACTIVE_xxx", this is:
>   ACTIVE_HIGH => IRQ_TYPE_LEVEL_HIGH

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: Correct interrupt flags in examples
      commit: abe42b09118914f01246f880dd9029150fdc727c

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
