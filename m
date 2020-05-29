Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 236551E840B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 18:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbgE2Qvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 12:51:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:43040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726887AbgE2Qvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 12:51:45 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 945C32077D;
        Fri, 29 May 2020 16:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590771105;
        bh=jKG+5WL5Zz7Oc177GyWEevQ9Pkd1eVJDyNJVuDzt2SU=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=pKHsDS2Q5gl+vblIPVNdkkz0MICmKAsHj2pAZ3S66PNQW1dcJSQluuI+YJgH7Wep2
         Jv4Nlr/hvBR/m7Nr/92YCoC1vK/SmBBrBncdtl/nel1Pv5PfX+rTJY+iNN9FMGWFi8
         Nf1xcBf2S0YcBD4M/WF5CJt55czRi1glkmEeZMDk=
Date:   Fri, 29 May 2020 17:51:42 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>, kjlu@umn.edu
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Allison Randal <allison@lohutok.net>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
In-Reply-To: <20200529012230.5863-1-dinghao.liu@zju.edu.cn>
References: <20200529012230.5863-1-dinghao.liu@zju.edu.cn>
Subject: Re: [PATCH] ASoC: img-i2s-out: Fix runtime PM imbalance on error
Message-Id: <159077105220.28617.10412316877041225353.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 May 2020 09:22:28 +0800, Dinghao Liu wrote:
> pm_runtime_get_sync() increments the runtime PM usage counter even
> the call returns an error code. Thus a pairing decrement is needed
> on the error handling path to keep the counter balanced.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: img-i2s-out: Fix runtime PM imbalance on error
      commit: 65bd91dd6957390c42a0491b9622cf31a2cdb140

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
