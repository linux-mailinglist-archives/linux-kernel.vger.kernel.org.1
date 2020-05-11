Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB7BF1CD80D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 13:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729627AbgEKLZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 07:25:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:40428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbgEKLZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 07:25:14 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E24F72082E;
        Mon, 11 May 2020 11:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589196314;
        bh=o9AEQI9e96zEZttG7amAYMc86awjgUg84pO3XR7DIJU=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=rMLBl+BJv/8X5nWNIxPOLW9bCIQ0iiH4T+rrJ3LNlokdYz7vyJ1T+jbd1BNahhoeO
         3MDloWKijwzczMcVgRleCN5Dn82GfYyi9p0BrXrhWgrsWfw8RS6I7c/zX8HhYKiJF0
         zGTdx66urESUZcYG8t060Lg0adpPio3GLg+M5HaE=
Date:   Mon, 11 May 2020 12:25:11 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Baluta <daniel.baluta@nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>
Cc:     sound-open-firmware@alsa-project.org,
        Hulk Robot <hulkci@huawei.com>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
In-Reply-To: <20200509093337.78897-1-weiyongjun1@huawei.com>
References: <20200509093337.78897-1-weiyongjun1@huawei.com>
Subject: Re: [PATCH -next] ASoC: SOF: core: fix error return code in sof_probe_continue()
Message-Id: <158919630591.8372.2693006903071941501.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 May 2020 09:33:37 +0000, Wei Yongjun wrote:
> Fix to return negative error code -ENOMEM from the IPC init error
> handling case instead of 0, as done elsewhere in this function.

Applied to

   local tree asoc/for-5.7

Thanks!

[1/1] ASoC: SOF: core: fix error return code in sof_probe_continue()
      (no commit info)

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
