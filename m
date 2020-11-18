Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8B552B862C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 22:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbgKRU7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 15:59:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:55674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726243AbgKRU7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 15:59:53 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2048D246CD;
        Wed, 18 Nov 2020 20:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605733192;
        bh=0PT8sm0MP3SCcXA3t5v2NDxg0TISz2eUCA5uxup6dZw=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=mrFf7UG32G0w/HAHFIHMBo+0BWaMBRTY6oVaGRmOkVTG4vIBuICaXyXW0p3Jx39Gk
         H7MODqDXhz0M0X/vmD7q+X79Jus01nF7dvRW45gDQV6qOYXc52riKZbsiekQNWNp9J
         XJ4px2ZmFKCeH6n6Q47i7Ma2noSuYd8gDBkUn62o=
Date:   Wed, 18 Nov 2020 20:59:32 +0000
From:   Mark Brown <broonie@kernel.org>
To:     srinivas.kandagatla@linaro.org,
        "xiakaixu1987@gmail.com" <xiakaixu1987@gmail.com>
Cc:     Kaixu Xia <kaixuxia@tencent.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1604652816-1330-1-git-send-email-kaixuxia@tencent.com>
References: <1604652816-1330-1-git-send-email-kaixuxia@tencent.com>
Subject: Re: [PATCH] ASoC: wcd9335: Remove unnecessary conversion to bool
Message-Id: <160573314460.46437.3151113690702719362.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Nov 2020 16:53:36 +0800, xiakaixu1987@gmail.com wrote:
> The '>=' expression itself is bool, no need to convert it to bool.
> Fix the following coccicheck warning:
> 
> ./sound/soc/codecs/wcd9335.c:3982:25-30: WARNING: conversion to bool not needed here

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: wcd9335: Remove unnecessary conversion to bool
      commit: a5ec7c9e007b1095d04146eb94bac3863d35a69d

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
