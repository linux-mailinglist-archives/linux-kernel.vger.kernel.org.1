Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D38A1C71ED
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 15:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbgEFNnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 09:43:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:50516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728714AbgEFNnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 09:43:43 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 179F32068E;
        Wed,  6 May 2020 13:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588772622;
        bh=ae3GP0U6pasVaUKLtgU6Vciyjz+k7sQFS9ZHzrnCFHM=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=rzc0nC+zJlDFCMYnNFoRcU1mMgvethdBUp285FEq2HQTA6OZdGS+GbTdPPdXlYG2l
         YfQvJmifunxdaRK8ObfDGCcOPm9Gu7Iv44t/2305zxM4r/LbwHFF6leH9C1pDU1OV5
         kxSH8u2xzbq94NHydjwEOOdW3157navLgyxx1ft0=
Date:   Wed, 06 May 2020 14:43:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Takashi Iwai <tiwai@suse.com>,
        Colin Ian King <colin.king@canonical.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        open list <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>
In-Reply-To: <20200506102602.140790-1-akshu.agrawal@amd.com>
References: <20200506102602.140790-1-akshu.agrawal@amd.com>
Subject: Re: [PATCH] ASoC: amd :High hw_level while simultaneous capture
Message-Id: <158877262009.52279.13901500480638545510.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 May 2020 15:56:00 +0530, Akshu Agrawal wrote:
> Simultaneous capture on dmic and headset mic is having
> issue with high hw_level being reported.
> 
> Issue Can be reproduced by:
> arecord -D hw:2,0 -f dat -d 60 /tmp/test0 &
> arecord -D hw:2,2 -f dat -d 60 /tmp/test1 &
> cat /proc/asound/card2/pcm?c/sub0/status
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.7

Thanks!

[1/1] ASoC: amd :High hw_level while simultaneous capture
      commit: 5a8117840a8c654c3cdf2f465e9406112d7e492d

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
