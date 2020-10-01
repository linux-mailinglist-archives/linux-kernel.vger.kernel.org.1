Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22075280A6C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 00:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733168AbgJAWrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 18:47:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:51474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726741AbgJAWrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 18:47:20 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13E772074B;
        Thu,  1 Oct 2020 22:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601592439;
        bh=Nw0bQWyAnCws4gXfnM3e/umkSOc68t+yKD9KWMksTaM=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=cI9xx8yzuCkVJClCAlKB3q8snrQNK03n71jWh4k5blrpkfEtjhRDrkhbry21yQGPl
         qEKUEGMqJ70lLE66uIHWVeABc+LW6knNFv3/WxncMjrH+MSQ7sNGv1HAG58hyOoQfJ
         HDVPadMg6MqPRhqKb6Qy8Ckbr+QSnKL6ce9DuIQY=
Date:   Thu, 01 Oct 2020 23:46:20 +0100
From:   Mark Brown <broonie@kernel.org>
To:     timur@kernel.org, lgirdwood@gmail.com,
        Tang Bin <tangbin@cmss.chinamobile.com>, perex@perex.cz,
        tiwai@suse.com
Cc:     Zhang Shengju <zhangshengju@cmss.chinamobile.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20200826150918.16116-1-tangbin@cmss.chinamobile.com>
References: <20200826150918.16116-1-tangbin@cmss.chinamobile.com>
Subject: Re: [PATCH] ASoC: fsl_spdif: Fix unnecessary check in
 fsl_spdif_probe()
Message-Id: <160159237545.44588.9742249781960285327.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Aug 2020 23:09:18 +0800, Tang Bin wrote:
> The function fsl_spdif_probe() is only called with an openfirmware
> platform device. Therefore there is no need to check that the passed
> in device is NULL.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_spdif: Fix unnecessary check in fsl_spdif_probe()
      commit: 601fd3a7d849cf8a5dbd3628b3c29af9e5377961

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
