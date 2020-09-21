Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE0B272FA3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 18:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730132AbgIUQ6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 12:58:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:38998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730270AbgIUQ6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 12:58:36 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59410235F9;
        Mon, 21 Sep 2020 16:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600707515;
        bh=vdPFk/m6WXsYIcu6qFyKO/XgYVqq9Qd/B4X1xYNRWVU=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=QSdathMV6G2YefHMOsPSyRat6SqNm+D2nhn7MI/vdo7f6n+roqTBaAKlAhSgSxFTV
         YdAKbDZIAZJa+S94v+dELfMlg5/PEMr0qjW+K33tsDz6U4ODLSET/QiGFTxik0kdPR
         BmafINv7tndY5+qR6fRkgIOLQV2MMQLA2klQicWw=
Date:   Mon, 21 Sep 2020 17:57:43 +0100
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, Dan Murphy <dmurphy@ti.com>,
        robh+dt@kernel.org, tiwai@suse.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
In-Reply-To: <20200918150130.21015-1-dmurphy@ti.com>
References: <20200918150130.21015-1-dmurphy@ti.com>
Subject: Re: [PATCH 1/2] dt-bindings: tas2562: Add TAS2564 to binding
Message-Id: <160070745846.56122.6048803274459562486.b4-ty@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Sep 2020 10:01:29 -0500, Dan Murphy wrote:
> Add the TAS2564 compatible and data sheet link to the binding.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] dt-bindings: tas2562: Add TAS2564 to binding
      commit: 7a477213923fe07c17db7c3104cce6b316f75f60
[2/2] ASoC: tas2562: Add the TAS2564 compatible
      commit: 534c0f4391a497d10c2b5eb3df2016221b6ec4f6

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
