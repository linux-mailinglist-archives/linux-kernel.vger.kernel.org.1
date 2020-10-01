Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 560FC280A73
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 00:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733270AbgJAWru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 18:47:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:54402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726741AbgJAWrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 18:47:49 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1808120754;
        Thu,  1 Oct 2020 22:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601592469;
        bh=dgOc7PzkS9dX0GvioWzqzTEvNibcFB20VrGfE/OrTRc=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=I0UhHf1/EEu41m0bagSshbbuYJCNcGfX9njUCUn6rJWKBBT9pwc0FPAKVK3pIflnp
         TS0rrRkVPHF8UE556VyO/Al3BasgRON1mQpme3kE3CmDI6L0VusmW/gnnvZp9SRySG
         /y/EsxFrPbgOOaFki3noODayaYq1VANex4yH86BU=
Date:   Thu, 01 Oct 2020 23:46:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Qinglang Miao <miaoqinglang@huawei.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
In-Reply-To: <20200929112939.47661-1-miaoqinglang@huawei.com>
References: <20200929112939.47661-1-miaoqinglang@huawei.com>
Subject: Re: [PATCH -next] ASoC: tegra: trimslice.c: use
 devm_snd_soc_register_card()
Message-Id: <160159237544.44588.10343139613050328062.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Sep 2020 19:29:39 +0800, Qinglang Miao wrote:
> Using devm_snd_soc_register_card() can make the code
> shorter and cleaner.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tegra: trimslice.c: use devm_snd_soc_register_card()
      commit: 27f41dfebf226c74691b4b30527459417b6510e8

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
