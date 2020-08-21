Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3D824DB7A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 18:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbgHUQlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 12:41:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:55134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728634AbgHUQkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 12:40:35 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 527382072D;
        Fri, 21 Aug 2020 16:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598028034;
        bh=DtGgnPkg8Vi64C6+dKTHm1EqoFMOck2QxuISZD/5lx0=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=qMiOzNe6KP7t162HHbQjkPpYIlCVtFv8ltnH10opD/JDehV3q+upopsMV2bo60TM8
         6Z8WJGPJUdMhItnbU72Y6dskZsMOoGS2HMZSYzDh6KgmEGd3CpOKS9Q4VMnCh+7Qxa
         GA4kPln/R6m7gkeNxxk4N6dWGdmMey+I6ho9CHW8=
Date:   Fri, 21 Aug 2020 17:40:02 +0100
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org, Brent Lu <brent.lu@intel.com>
Cc:     Daniel Stuart <daniel.stuart14@gmail.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Sam McNally <sammc@chromium.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        linux-kernel@vger.kernel.org,
        Damian van Soelen <dj.vsoelen@gmail.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
In-Reply-To: <1596198365-10105-1-git-send-email-brent.lu@intel.com>
References: <1596020585-11517-1-git-send-email-brent.lu@intel.com> <1596198365-10105-1-git-send-email-brent.lu@intel.com>
Subject: Re: [PATCH v3 0/2] Add period size constraint for Atom Chromebook
Message-Id: <159802798182.25503.9357316995968776171.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Jul 2020 20:26:03 +0800, Brent Lu wrote:
> Two different constraints are implemented: one is in platform's CPU
> DAI to enforce the period to be multiple of 1ms to align with firmware
> design. The other is in Atom Chromebook's machine driver to use 240 as
> period size which is selected by google.
> 
> 
> Changes since v1:
> -Add comma at the end of media_period_size array declaration.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: intel: atom: Add period size constraint
      commit: 5e7820e369248f880767c4c4079b414529bc2125

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
