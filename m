Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17C4C218DC1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 19:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730753AbgGHRAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 13:00:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:37002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbgGHRAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 13:00:42 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 670AD206F6;
        Wed,  8 Jul 2020 17:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594227641;
        bh=G7ytfgAutePRk2DsxfrWnVcTCtwzUqPCwmz681Huy/A=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=RhdXNdaF2qdQ+AFizSp9k6T13cFGk1cIk7jl/RT78+J8MQuLGhQT4xEdllFrcY1Ht
         lWiFmZH8wD2GcgN9wwEMNL3Cj/9gADMkHSaerinsJGOXRudvM9PeeFyio3GT9/09i7
         jaZFX7YDxok1SdJC7i7fQ+mpeFQLGpTVne64uvy4=
Date:   Wed, 08 Jul 2020 18:00:36 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>, lgirdwood@gmail.com
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20200708124832.3441649-1-lee.jones@linaro.org>
References: <20200708124832.3441649-1-lee.jones@linaro.org>
Subject: Re: [PATCH 0/3] W=1 loose ends for Regulator
Message-Id: <159422763672.28837.17771120905724125938.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jul 2020 13:48:29 +0100, Lee Jones wrote:
> These either needed small fix-ups for a rebase.
> 
> Lee Jones (3):
>   regulator: devres: Fix issues with kerneldoc headers
>   regulator: of_regulator: Add missing colon for rdev kerneldoc argument
>   regulator: devres: Standardise on function documentation headers
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/3] regulator: devres: Fix issues with kerneldoc headers
      commit: 9565cccd64876dd1f8732fad3a04f8daa41fcef9
[2/3] regulator: of_regulator: Add missing colon for rdev kerneldoc argument
      commit: 45e8446e7a153a011ae099bb8c5657bb853c0ad0
[3/3] regulator: devres: Standardise on function documentation headers
      commit: a7c15187b391d7fe9903903475a94e5cd5b796d6

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
