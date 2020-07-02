Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD6F921286F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jul 2020 17:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgGBPrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jul 2020 11:47:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:59494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbgGBPq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 11:46:59 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDF0C20885;
        Thu,  2 Jul 2020 15:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593704819;
        bh=GlMtWaaBQ7ayJajZsemgytwD68eNWl0Zn8s3Dn5PCck=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=O/n8Worf/Aj21RCMin17umiYx/dtg6ZVsfLiUX8IjPr9N2aTWMyLxByg0LqTUxehL
         UTR+gpezmReiPiXffDRibiWE11Nzl/qd23ijLq0DEA65Xj0LJ1BDlpjsuZbfmIo4Ux
         R/9D9UU6KoaNVs9gKyIXf1tWXSzXtpl0it6wKW0I=
Date:   Thu, 02 Jul 2020 16:46:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     linux-mediatek@lists.infradead.org,
        Anand K Mistry <amistry@google.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        hsin-hsiung.wang@mediatek.com, drinkcat@chromium.org,
        devicetree@vger.kernel.org
In-Reply-To: <20200702062320.2903147-1-amistry@google.com>
References: <20200702062320.2903147-1-amistry@google.com>
Subject: Re: [PATCH v2 0/4] regulator: mt6397: Implement of_map_mode regulator_desc function
Message-Id: <159370481231.5599.8673864657809351284.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jul 2020 16:23:16 +1000, Anand K Mistry wrote:
> This patchset adds support for being able to change regulator modes for
> the mt6397 regulator. This is needed to allow the voltage scaling
> support in the MT8173 SoC to be used on the elm (Acer Chromebook R13)
> and hana (several Lenovo Chromebooks) devices.
> 
> Without a of_map_mode implementation, the regulator-allowed-modes
> devicetree field is skipped, and attempting to change the regulator mode
> results in an error:
> [    1.439165] vpca15: mode operation not allowed
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/3] regulator: mt6397: Move buck modes into header file
      commit: 1c537b2d729698717f01fcea13721818be5adde7
[2/3] regulator: mt6397: Document valid modes
      commit: 347f12d573412cb7ba4781b58f42f0ca7eecde6d
[3/3] regulator: mt6397: Implement of_map_mode
      commit: 8096236db4349c43a2b19b8ceb11b0b997354223

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
