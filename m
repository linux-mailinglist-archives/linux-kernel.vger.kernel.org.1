Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B86432760B2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 21:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgIWTBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 15:01:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:44200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726419AbgIWTBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 15:01:32 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C82B208B6;
        Wed, 23 Sep 2020 19:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600887692;
        bh=e51bCfoMc8BjvB6DfeUQ+2JjeDgUGSX8r3S02m5t1GA=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=wDwS2YA1lwc/n+GFlMaIQOlHFDDMgB6kPhONCzBXRsi2UJIkYx5FSkV0rL7eLrF8j
         csF03dpn0mkTRe1I/Xsey6mCf+i1BsUMqX+E2xGUr1oJd0g9gkom2C4p+0+XmymzTm
         Kva4IX4DkH/L6WOPykk3DhsZhPovQrYZxaZwH/XY=
Date:   Wed, 23 Sep 2020 20:00:37 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Olliver Schinagl <oliver@schinagl.nl>,
        Chen-Yu Tsai <wens@csie.org>, Priit Laes <plaes@plaes.org>
Cc:     linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
In-Reply-To: <20200923005142.147135-1-icenowy@aosc.io>
References: <20200923005142.147135-1-icenowy@aosc.io>
Subject: Re: [PATCH] regulator: axp20x: fix LDO2/4 description
Message-Id: <160088763759.36155.1482459215779599768.b4-ty@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Sep 2020 08:51:42 +0800, Icenowy Zheng wrote:
> Currently we wrongly set the mask of value of LDO2/4 both to the mask of
> LDO2, and the LDO4 voltage configuration is left untouched. This leads
> to conflict when LDO2/4 are both in use.
> 
> Fix this issue by setting different vsel_mask to both regulators.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: axp20x: fix LDO2/4 description
      commit: fbb5a79d2fe7b01c6424fbbc04368373b1672d61

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
