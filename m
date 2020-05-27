Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 999E11E4697
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 16:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389446AbgE0O6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 10:58:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:53706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388738AbgE0O6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 10:58:13 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 753DB2088E;
        Wed, 27 May 2020 14:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590591493;
        bh=n3T3SCw7AuNm+LGdYO+r5qpnOKzrU0x+b1p1GFAuRg4=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=clIMJ+gt1V10YcDy1CW3cRioiIu1IIxtmB1+ghdi9LkQDIaTTRX/HryEFwOMSbSCH
         oxse4sGd3xANMflPwtPhJwIN0uX2HKBOtc9GZa8shaxIrcPNxZIFiHSiX9KTzr3s9O
         aVmnYXR9VZlp26At+IKdgWeccHt5ISL07FHx/yI0=
Date:   Wed, 27 May 2020 15:58:10 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Takashi Iwai <tiwai@suse.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Daniel Mack <daniel@zonque.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20200527030210.124393-1-weiyongjun1@huawei.com>
References: <20200527030210.124393-1-weiyongjun1@huawei.com>
Subject: Re: [PATCH -next] ASoC: mmp-sspa: Fix return value check in asoc_mmp_sspa_probe()
Message-Id: <159059147354.50918.14800110942668588703.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 May 2020 03:02:10 +0000, Wei Yongjun wrote:
> In case of error, the function devm_ioremap() returns NULL pointer not
> ERR_PTR(). The IS_ERR() test in the return value check should be
> replaced with NULL test.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mmp-sspa: Fix return value check in asoc_mmp_sspa_probe()
      commit: 185457632ba344d3100e6bdd8ba839b959521813

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
