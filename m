Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 080BF21DEB3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 19:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730178AbgGMR2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 13:28:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:53312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729644AbgGMR2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 13:28:06 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C86E320663;
        Mon, 13 Jul 2020 17:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594661286;
        bh=mda1KYJa8jMzutT3sFOkf1x3bT2HgB0n+bFgHnA9638=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=obeGCXoXN6quEH5ACDh21ZkU0lBtu/kT5WLlSmQpiBmCoT4t13GPZ9tBUsBNjmAqT
         cOUhkzz2gpAe4HIy1eV35BNid0Tro44dksgbDgm5i/2k09DLw9UYhJd+eUaq2O4q5A
         MvVn1PO9/zUP6l2fwKCrZ0dltYJ+zBVtqaDNQveg=
Date:   Mon, 13 Jul 2020 18:27:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sugar Zhang <sugar.zhang@rock-chips.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, Takashi Iwai <tiwai@suse.com>
In-Reply-To: <1594635960-67855-1-git-send-email-sugar.zhang@rock-chips.com>
References: <1594635960-67855-1-git-send-email-sugar.zhang@rock-chips.com>
Subject: Re: [PATCH] ASoC: rockchip: spdif: Handle clk by pm runtime
Message-Id: <159466127771.57184.7108021750802359859.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jul 2020 18:26:00 +0800, Sugar Zhang wrote:
> This patch handle the clk by pm runtime mechanism to simplify
> the clk management.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rockchip: spdif: Handle clk by pm runtime
      commit: f50d67f9eff62f8078fe6e98ede3f4fb1defc361

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
