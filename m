Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C24F26E50E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 21:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbgIQTHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 15:07:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:58796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbgIQS6M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 14:58:12 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC9B521973;
        Thu, 17 Sep 2020 18:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600369087;
        bh=P4cVWJU8Vy0KqO0qWa8CEv9MKWSQemRligTWGadOC1Y=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=lW9r8afLTaOWjSq8T5o8+myt++LzeHQ4NyKuv7vowIG53OmtlCc0oITkYIXPt9gGm
         xYATJtxnubKHgP/JRhc1JbnILZiRi0kBR2/9KEuuYcdjWQKHYEkVLw5cYOQJSLiEBe
         FmaGF4jWq2BtFf50Xt35HSshq88Zmmi0ZJk3X5lM=
Date:   Thu, 17 Sep 2020 19:57:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, lgirdwood@gmail.com, perex@perex.cz,
        robh+dt@kernel.org, Shengjiu Wang <shengjiu.wang@nxp.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org
In-Reply-To: <1600178220-28973-1-git-send-email-shengjiu.wang@nxp.com>
References: <1600178220-28973-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH v3 1/2] ASoC: dt-bindings: ak4458: Add dsd-path property
Message-Id: <160036900934.20113.2210224805843126757.b4-ty@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Sep 2020 21:56:59 +0800, Shengjiu Wang wrote:
> Add "dsd-path" property, which is used for ak4497 codec
> to select the DSD input pin.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: ak4458: Add dsd-path property
      commit: fc50e26de9677206ae43a261ddc4181ed7e4af78
[2/2] ASoC: ak4458: Add DSD support for ak4458 and ak4497
      commit: 337d348b8399adf1a19c8d65f6407939b4743fc9

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
