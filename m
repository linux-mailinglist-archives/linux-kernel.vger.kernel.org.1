Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0FB222F84
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 01:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgGPX57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 19:57:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:58398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbgGPX56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 19:57:58 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85897207DD;
        Thu, 16 Jul 2020 23:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594943878;
        bh=oFW1cl+r20hCLJ4pfkKV3RYD8Qs6TkPlxv0gjk1ZC/4=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=dmrjWPZfs03JsoBSLG00UWERkRjDmkCCpfqFocx4AtXOzxNIBEbeqfiDmulKpfhu9
         LX9QjhTPsPjfJZnyzmfPzjbT48DveeTsySr6eZSkxI9CeltjMh7N8YpbDdPa5YC6iE
         xUNuDY3L2xc+m354XKAyf1nPh7Rx4KR5rRJiM9jI=
Date:   Fri, 17 Jul 2020 00:57:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     pierre-louis.bossart@linux.intel.com,
        kuninori.morimoto.gx@renesas.com, hdegoede@redhat.com,
        paul@crapouillou.net, yang.jie@linux.intel.com,
        liam.r.girdwood@linux.intel.com, cezary.rojewski@intel.com,
        Jing Xiangfeng <jingxiangfeng@huawei.com>, tiwai@suse.com,
        perex@perex.cz
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20200714080918.148196-1-jingxiangfeng@huawei.com>
References: <20200714080918.148196-1-jingxiangfeng@huawei.com>
Subject: Re: [PATCH] ASoC: Intel: bytcht_es8316: Add missed put_device()
Message-Id: <159494380522.42174.15064040875252381887.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jul 2020 16:09:18 +0800, Jing Xiangfeng wrote:
> snd_byt_cht_es8316_mc_probe() misses to call put_device() in an error
> path. Add the missed function call to fix it.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: bytcht_es8316: Add missed put_device()
      commit: b3df80ab6d147d4738be242e1c91e5fdbb6b03ef

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
