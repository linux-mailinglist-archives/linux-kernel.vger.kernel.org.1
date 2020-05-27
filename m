Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54DE41E469D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 16:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389465AbgE0O6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 10:58:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:53966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389378AbgE0O6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 10:58:23 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17FF420C56;
        Wed, 27 May 2020 14:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590591503;
        bh=A1rZCKGNuvf1MTV654hcIRa9McjyaPyThd8WHu7x8iw=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=eGmpzXZ5yvoRCPYJlL3WlCT9MB8J7dDGXXkbVHgwB4Qx1mUlhWw1WHaJLZNNjULbP
         qh0bo2V15YxYUewddeFr5AQQo/0mlF8ZYoLZBeO9H2fQDHcnjOQLsRW/kyt+bdAoLC
         s/TJHkmaGqIJkx5RPn+ulOGytU/gu5aHknnSihls=
Date:   Wed, 27 May 2020 15:58:21 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>, kjlu@umn.edu
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Takashi Iwai <tiwai@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>
In-Reply-To: <20200527084326.4131-1-dinghao.liu@zju.edu.cn>
References: <20200527084326.4131-1-dinghao.liu@zju.edu.cn>
Subject: Re: [PATCH] ASoC: img-spdif-in: Fix runtime PM imbalance on error
Message-Id: <159059147354.50918.16899788154507501504.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 May 2020 16:43:24 +0800, Dinghao Liu wrote:
> pm_runtime_get_sync() increments the runtime PM usage counter even
> the call returns an error code. Thus a pairing decrement is needed
> on the error handling path to keep the counter balanced.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: img-spdif-in: Fix runtime PM imbalance on error
      commit: 53865b3259554389e40aeead392151c819b52a71

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
