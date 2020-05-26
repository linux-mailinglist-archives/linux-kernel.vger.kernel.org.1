Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36C041D977E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 15:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbgESNTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 09:19:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:55916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727057AbgESNTF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 09:19:05 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E08F7206D4;
        Tue, 19 May 2020 13:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589894345;
        bh=/W235ZXLquPgLiHQpzwUCkiv/Zauu8a7ukvyN8H+274=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=ck1yJZW0nqJb1mw3mpDx4TAIjSEtLcBIHmMGPOjPkhQYLwt1k+IWvkA8C3fLsP3gq
         IbCRWzOuSC7JK4uuA1JuwDf1sI3iLj9BIIczAous/rzTcgjr/PsXgZMShWkqrvgZDH
         gSlrGv4Tvnvms8z7Hal67vJbV0aAe8Q09JTF//J8=
Date:   Tue, 19 May 2020 14:19:02 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>, timur@kernel.org,
        nicoleotsuka@gmail.com, lgirdwood@gmail.com, Xiubo.Lee@gmail.com,
        tiwai@suse.com, perex@perex.cz, festevam@gmail.com,
        alsa-devel@alsa-project.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <1589278979-31008-1-git-send-email-shengjiu.wang@nxp.com>
References: <1589278979-31008-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_asrc: Set ASR76K and ASR56K based on processing clock
Message-Id: <158989434292.51282.3388450779255544189.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 May 2020 18:22:59 +0800, Shengjiu Wang wrote:
> The processing clock is different for platforms, so it is better
> to set ASR76K and ASR56K based on processing clock, rather than
> hard coding the value for them.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.8

Thanks!

[1/1] ASoC: fsl_asrc: Set ASR76K and ASR56K based on processing clock
      commit: f8953043e6e24f9425249464605a541d00950709

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
