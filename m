Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7036A1BC3E2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Apr 2020 17:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbgD1PlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 11:41:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:47658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728212AbgD1PlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 11:41:01 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21E21206D7;
        Tue, 28 Apr 2020 15:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588088461;
        bh=m3hQm8gosMVcEzwy0eRzhmbhb9xpXvL9MpTX2D3IkBg=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=lxqkJh4chgjEtNIOCO5x/UqvWUOjcx7z/KGvdDrwKEPx5xYj89TjLuQtxgx9vSnf3
         JQpSUSWGQCA4GNDypq6TfgEbaSst2iifF5p6g6iGna7Hc6dNofOzy33E5pUF6cGRau
         OoOM72nLdxg0zm7JV5OwUMd4A9CE+CduxQtzEB4c=
Date:   Tue, 28 Apr 2020 16:40:59 +0100
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org
Cc:     kjlu@umn.edu, yuanxzhang@fudan.edu.cn,
        Xin Tan <tanxin.ctf@gmail.com>
In-Reply-To: <1587818916-38730-1-git-send-email-xiyuyang19@fudan.edu.cn>
References: <1587818916-38730-1-git-send-email-xiyuyang19@fudan.edu.cn>
Subject: Re: [PATCH] ASoC: davinci-mcasp: Fix dma_chan refcnt leak when getting dma type
Message-Id: <158808845301.38316.4295335202430928614.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Apr 2020 20:48:35 +0800, Xiyu Yang wrote:
> davinci_mcasp_get_dma_type() invokes dma_request_chan(), which returns a
> reference of the specified dma_chan object to "chan" with increased
> refcnt.
> 
> When davinci_mcasp_get_dma_type() returns, local variable "chan" becomes
> invalid, so the refcount should be decreased to keep refcount balanced.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.7

Thanks!

[1/1] ASoC: davinci-mcasp: Fix dma_chan refcnt leak when getting dma type
      commit: a697ae6ea56e23397341b027098c1b11d9ab13da

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
