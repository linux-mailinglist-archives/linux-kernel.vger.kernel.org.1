Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 065ED2EF5B8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 17:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbhAHQaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 11:30:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:39070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726386AbhAHQav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 11:30:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B197A238E8;
        Fri,  8 Jan 2021 16:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610123411;
        bh=wcMtwzIrYkV0N//ezKy6wESkf9IHM1UZrLFcLkpuC6M=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=fCPitXXkUMbOM3eAeVjC+zWBVv5QsraUqy0cND1O++fVskhgSfmghT3afUhmlFO6K
         TjnZOqqH1Tld3Ol2QuiNsU3pjHbB9DRj3gfktm+6oAyF55ywM9JjwdnK4QkAEONZcO
         jBOfLU+FuDVYQyhemTRYSkL3u9JHVfYw7sEtaJnoi0OZ6I9u5WVEGejYxO4JVvbLwB
         2FTg1aQ7fmVSsLCbzyr6pYrQo4BSf9vmRtGYucy/NJFWzG71/OyPRNM76jH+jqCwAU
         Vn3O4br0yS5U7XttIORPf9Ir9DGfa1BQKBEeWn4kwJJL2oyMcSu/br9y7ey4pGKrPr
         Z1qkytWS6x5hw==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, alsa-devel@alsa-project.org, perex@perex.cz,
        tiwai@suse.com, kuninori.morimoto.gx@renesas.com,
        peter.ujfalusi@ti.com, Xu Wang <vulab@iscas.ac.cn>,
        gustavoars@kernel.org
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20210108085834.7168-1-vulab@iscas.ac.cn>
References: <20210108085834.7168-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] ASoC: es8328: Remove redundant null check before clk_disable_unprepare
Message-Id: <161012338172.40879.13082564120833365290.b4-ty@kernel.org>
Date:   Fri, 08 Jan 2021 16:29:41 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Jan 2021 08:58:34 +0000, Xu Wang wrote:
> Because clk_disable_unprepare() already checked NULL clock parameter,
> so the additional check is unnecessary, just remove it.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: es8328: Remove redundant null check before clk_disable_unprepare
      commit: 31c51a424f5163ee6f14fcc251f81078457123e1

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
