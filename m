Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABF4249D99
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 14:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgHSMQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 08:16:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:53040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727079AbgHSMQC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 08:16:02 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 095C220738;
        Wed, 19 Aug 2020 12:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597839361;
        bh=/MbaTQFZWMYuazygmw7csZlkRqCEGAQG/FDx2KXZmlo=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=oSMIeWMXMrvFp4voxI5iMdujeB+Lp+HlOztmKzG8LZawk9CdEMwsC/ITDxW+mXFOU
         kgcTmuGa0aYqB4rCCXpff0OZMhuWxZa5k6jZPJ2q0PM3NbYn5yAIgVkUWs92YGkz8g
         N3+j40AOGRzS2R4pR4ks6AdvUV8kBedw64d/kxZ0=
Date:   Wed, 19 Aug 2020 13:15:29 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-samsung-soc@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <20200806182059.2431-1-krzk@kernel.org>
References: <20200806181932.2253-1-krzk@kernel.org> <20200806182059.2431-1-krzk@kernel.org>
Subject: Re: [PATCH v2 01/41] ARM: s3c: Remove unneeded machine header includes
Message-Id: <159783932455.55025.7979458249415199743.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Aug 2020 20:20:18 +0200, Krzysztof Kozlowski wrote:
> Not all units use the contents of mach/hardware.h and
> mach/dma.h.  Remove these includes when not needed.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] ASoC: samsung: h1940: turn into platform driver
      commit: 2c5c4fdc710c5d3beff78ac5605c5732ebfa8ae5
[2/5] ASoC: samsung: neo1973: turn into platform driver
      commit: a65e8a320846b8c69f53a758dc3662e4b42e6a48
[3/5] ASoC: samsung: rx1950: turn into platform driver
      commit: a0f3315a2558e22e75873e1184d0c213c2f8315f
[4/5] ASoC: samsung: s3c2412-i2s: avoid hardcoded S3C2410_PA_IIS
      commit: 2f1525848844c996990aafd3104bddf0f0cb3a28
[5/5] ARM: s3c24xx: move iis pinctrl config into boards
      (no commit info)

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
