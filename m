Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 734C9273708
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 02:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729046AbgIVAGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 20:06:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:40486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726537AbgIVAGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 20:06:54 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CBE521789;
        Tue, 22 Sep 2020 00:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600733214;
        bh=pcuZbv7wIKPsCmBBLhS3eTcZBiFjhoPECq+gUU7NHio=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=cb4cMFhqG9PWBR9bzmyuqF2ulW5TPAFi7ZP94b3mxQTe807Dhl0d2sNfJr3ZWd+0y
         s2rINmYzw2d1jrt8fSZV/fPpy+A1D2J5b8Vgfm2U0pJ0yhW/RAXVadjGSJ0igZUMdp
         ma/sO8e6mpgdTbkuAvP8g1hbUYcb5qkKt+EC0TJs=
Date:   Tue, 22 Sep 2020 01:06:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sangbeom Kim <sbkim73@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
In-Reply-To: <20200921203616.19623-1-krzk@kernel.org>
References: <20200921203616.19623-1-krzk@kernel.org>
Subject: Re: [RFT] regulator: s5m8767: initialize driver via module_platform_driver
Message-Id: <160073316153.6369.11503371469666905357.b4-ty@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Sep 2020 22:36:16 +0200, Krzysztof Kozlowski wrote:
> The driver was using subsys_initcall() because in old times deferred
> probe was not supported everywhere and specific ordering was needed.
> Since probe deferral works fine and specific ordering is discouraged
> (hides dependencies between drivers and couples their boot order), the
> driver can be converted to regular module_platform_driver.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: s5m8767: initialize driver via module_platform_driver
      commit: 8d23b0b8fc950cba2046840c46b21db9b5c0573c

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
