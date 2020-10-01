Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8CD9280A6D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 00:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733235AbgJAWrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 18:47:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:51748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726741AbgJAWrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 18:47:25 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2759F206C1;
        Thu,  1 Oct 2020 22:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601592444;
        bh=/Fld3Oecs3tTGcAezlLAYMe1AutM5l0b5mJQaJErGTU=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=0bUa94SfCCvLz4Cx6SJyWA9g719YoiuLRBD3C9Mrt9i1dDV7F29eNY0EzJci19icl
         OqzMujp7oz8LnCOLk8MM6b1kOmmDc/Rqn5Ys2GQmFDklWl7YUCFU00E+uvLdkxjP0I
         bqP27E5gAo0n+FLBUSfpj16dgx6e4e4w9cHxrabg=
Date:   Thu, 01 Oct 2020 23:46:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Qinglang Miao <miaoqinglang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
In-Reply-To: <20200929112932.46926-1-miaoqinglang@huawei.com>
References: <20200929112932.46926-1-miaoqinglang@huawei.com>
Subject: Re: [PATCH -next] ASoC: fsl: mx27vis-aic32x4: use
 devm_snd_soc_register_card()
Message-Id: <160159237543.44588.2335297978854378427.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Sep 2020 19:29:32 +0800, Qinglang Miao wrote:
> Using devm_snd_soc_register_card() can make the code
> shorter and cleaner.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl: mx27vis-aic32x4: use devm_snd_soc_register_card()
      commit: 1047bcac2169a05575476774bfd4a88f0a9c787d

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
