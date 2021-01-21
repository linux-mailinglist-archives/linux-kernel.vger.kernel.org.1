Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE2A02FF4D8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 20:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbhAUTlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 14:41:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:46708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726599AbhAUTk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 14:40:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BC0AF23A40;
        Thu, 21 Jan 2021 19:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611258016;
        bh=FRCZ4e5i8h7FJWzAWrXVkKAdLyevp/j6/ZDUmvuTogA=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=YPSnm+OBrSKTNtsgv0TfK3yS6YfstFBu+7VVqPgNZfItrq//GH70KAavgkIQqzWXF
         FcXubMilZUCBZCRK2Sh+d7ldwVuSfkDcX2js1a8uRWchQONkshWVK2YYYGz7c8xt7f
         4nWm8tsXyBKMyUuN7Ckbeba/lPHd0LHrLQik948uWG/Ou1xnk9YW9yuH9gAo026hEY
         xce/RfjkL/fqiQHm8Ve6ZTzrEqB+9uWDZSed+2qUaE6PgIHslwOd1RCABdehZ0wiqI
         +WhTOjhGKd0S8sZzHqhjhLtwimvyFcv9W19UymBNPsiF5aUGTn74qsPRGUCr8G5Fwm
         oWNRAuv3hEpjQ==
From:   Mark Brown <broonie@kernel.org>
To:     Ricardo Ribalda <ribalda@chromium.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Mateusz Gorski <mateusz.gorski@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Lukasz Majczak <lma@semihalf.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>
In-Reply-To: <20210121171644.131059-1-ribalda@chromium.org>
References: <20210121171644.131059-1-ribalda@chromium.org>
Subject: Re: [PATCH v2 1/2] ASoC: Intel: Skylake: skl-topology: Fix OOPs ib skl_tplg_complete
Message-Id: <161125795422.35635.2779871383414045346.b4-ty@kernel.org>
Date:   Thu, 21 Jan 2021 19:39:14 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jan 2021 18:16:43 +0100, Ricardo Ribalda wrote:
> If dobj->control is not initialized we end up in an OOPs during
> skl_tplg_complete:
> 
> [   26.553358] BUG: kernel NULL pointer dereference, address:
> 0000000000000078
> [   26.561151] #PF: supervisor read access in kernel mode
> [   26.566897] #PF: error_code(0x0000) - not-present page
> [   26.572642] PGD 0 P4D 0
> [   26.575479] Oops: 0000 [#1] PREEMPT SMP PTI
> [   26.580158] CPU: 2 PID: 2082 Comm: udevd Tainted: G         C
> 5.4.81 #4
> [   26.588232] Hardware name: HP Soraka/Soraka, BIOS
> Google_Soraka.10431.106.0 12/03/2019
> [   26.597082] RIP: 0010:skl_tplg_complete+0x70/0x144 [snd_soc_skl]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: Intel: Skylake: skl-topology: Fix OOPs ib skl_tplg_complete
      commit: c1c3ba1f78354a20222d291ed6fedd17b7a74fd7
[2/2] ASoC: Intel: Skylake: Zero snd_ctl_elem_value
      commit: 1d8fe0648e118fd495a2cb393a34eb8d428e7808

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
