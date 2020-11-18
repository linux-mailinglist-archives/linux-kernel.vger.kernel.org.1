Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABE72B862B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 22:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbgKRU7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 15:59:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:55632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726243AbgKRU7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 15:59:47 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 799DD2467A;
        Wed, 18 Nov 2020 20:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605733187;
        bh=5RWprzbLMs7k/C/+Hx17rkH3m12bB2Ubej9hmxGTPB4=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=JFxbt0lhqE33VJBveTFiwSaBwhb8YYUTKo5ZW7bgSTdJkAzGj7LP0U8gFPYzoqQ3i
         /P+oKZ/nB+Zxx6gpQFMuVwEm25fUFDIRHCT7ABKpoTTinJJCTaN/G8jsETTBQdsWVm
         +41x/hQ/1vIrwgYtKg/qa6g8/eU/+xs63Q3W0ZNw=
Date:   Wed, 18 Nov 2020 20:59:27 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>,
        Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     Brent Lu <brent.lu@intel.com>,
        Curtis Malainey <cujomalainey@chromium.org>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        linux-kernel@vger.kernel.org, Jie Yang <yang.jie@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org
In-Reply-To: <20201111205434.207610-1-linux@roeck-us.net>
References: <20201111205434.207610-1-linux@roeck-us.net>
Subject: Re: [PATCH] ASOC: Intel: kbl_rt5663_rt5514_max98927: Do not try to disable disabled clock
Message-Id: <160573314460.46437.5129841375589244492.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Nov 2020 12:54:34 -0800, Guenter Roeck wrote:
> In kabylake_set_bias_level(), enabling mclk may fail if the clock has
> already been enabled by the firmware. Attempts to disable that clock
> later will fail with a warning backtrace.
> 
> mclk already disabled
> WARNING: CPU: 2 PID: 108 at drivers/clk/clk.c:952 clk_core_disable+0x1b6/0x1cf
> ...
> Call Trace:
>  clk_disable+0x2d/0x3a
>  kabylake_set_bias_level+0x72/0xfd [snd_soc_kbl_rt5663_rt5514_max98927]
>  snd_soc_card_set_bias_level+0x2b/0x6f
>  snd_soc_dapm_set_bias_level+0xe1/0x209
>  dapm_pre_sequence_async+0x63/0x96
>  async_run_entry_fn+0x3d/0xd1
>  process_one_work+0x2a9/0x526
> ...
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASOC: Intel: kbl_rt5663_rt5514_max98927: Do not try to disable disabled clock
      commit: 879ee8b6f2bae0cc4a25536f8841db1dbc969523

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
