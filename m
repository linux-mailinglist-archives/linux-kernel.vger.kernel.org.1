Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 587471B102D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 17:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbgDTPbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 11:31:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:36014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbgDTPbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 11:31:05 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7721C206F9;
        Mon, 20 Apr 2020 15:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587396665;
        bh=mBtAU8+++LzfANGdd4dkRTMjCsIyXYRofREjG2ceEm0=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=dpNOykOHE/RuS4HaqLkJOiavP+sLIO3YbhFMCida0C+lvlDYhxvZVBieCZm/Z/CyW
         sdIlj3tYZmkKhjWZ6HEhWBVDrA5DKJdEF5dLfQ33T4yKWUVRCdyKVNvB/c6OsoI51U
         H+2ZzhYggMqKpQpWvHjBT01kpp10ETZPjwSrceiM=
Date:   Mon, 20 Apr 2020 16:31:02 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <87y2qqvdxu.wl-kuninori.morimoto.gx@renesas.com>
References: <87y2qqvdxu.wl-kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH] soundwire: intel: use asoc_rtd_to_cpu() / asoc_rtd_to_codec() macro for DAI pointer
Message-Id: <158739666242.39069.11002748203255634356.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Apr 2020 16:01:01 +0900, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Now ALSA SoC needs to use asoc_rtd_to_codec(),
> otherwise, it will be compile error.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Acked-By: Vinod Koul <vkoul@kernel.org>
> 
> [...]

Applied to

	https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.7

Thanks!

[1/1] soundwire: intel: use asoc_rtd_to_cpu() / asoc_rtd_to_codec() macro for DAI pointer
      commit: c74a793806537d8564064cfb1b58488c3d4b70c9

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
