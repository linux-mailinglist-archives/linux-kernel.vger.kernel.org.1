Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43B2D27B563
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 21:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgI1Tgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 15:36:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:36670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726590AbgI1Tgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 15:36:31 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABD1020773;
        Mon, 28 Sep 2020 19:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601321791;
        bh=Uj+sz+Xs7Ywudhl2rn5RI1+auNOSn4V4ChTLsk2Xiok=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=pXKOMeuNJB7vudrFDOPCqN38Gyemp3GgbWMHOvgHGaxyzoNIQwy682NZu1QSFRTZc
         fCzUGRmV9LOk5/5CH9BpUpBVBkE3atMn9gWX5eRBMxAegdar0WgCv+1Xf3rsMO7qAg
         T6zqs/QsL2oAVRQdwXeOfK6zfjbKLYr/6HaFOmTA=
Date:   Mon, 28 Sep 2020 20:35:34 +0100
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, robh+dt@kernel.org,
        cy_huang <u0084500@gmail.com>
Cc:     linux-kernel@vger.kernel.org, cy_huang@richtek.com,
        devicetree@vger.kernel.org
In-Reply-To: <1601277584-5526-1-git-send-email-u0084500@gmail.com>
References: <1601277584-5526-1-git-send-email-u0084500@gmail.com>
Subject: Re: [PATCH v2 1/2] regulator: rtmv20: Adds support for Richtek RTMV20 load switch regulator
Message-Id: <160132173416.55513.3947354990218182662.b4-ty@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Sep 2020 15:19:43 +0800, cy_huang wrote:
> Add support for Richtek RTMV20 load switch regulator.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator: rtmv20: Adds support for Richtek RTMV20 load switch regulator
      commit: b8c054a5eaf0cf2b9532969e5168ce5e2d78c284
[2/2] regulator: rtmv20: Add DT-binding document for Richtek RTMV20
      commit: 9f4366ec2c50dc478a06cb2cf0fadd3b38495650

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
