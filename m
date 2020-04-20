Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7381B0CD1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 15:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbgDTNhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 09:37:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:44556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725550AbgDTNhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 09:37:15 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC4CA20735;
        Mon, 20 Apr 2020 13:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587389835;
        bh=LabIAdcjRXkFzanlO5dwkADJ/hSPssTCX7vloN7yEXM=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=iM1yKWrCDAx0nbJXQwLmEZfNlQFjZX7GQvb2CK2OLYBlINsvcNS34icauslzLlciW
         DsUmahSAchoUj66nhcnfnY9RB74I8l1SsDSgdmuUnx2syEbAj0IxSEmXBr/SAtAEak
         E7XF2p1uniIGZMiKKiNRrkQ925kj6RtAy3Qcb/rw=
Date:   Mon, 20 Apr 2020 14:37:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     pierre-louis.bossart@linux.intel.com, tiwai@suse.com,
        ranjani.sridharan@linux.intel.com, lgirdwood@gmail.com,
        amadeuszx.slawinski@linux.intel.com, perex@perex.cz,
        Jason Yan <yanaijie@huawei.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20200420042858.19298-1-yanaijie@huawei.com>
References: <20200420042858.19298-1-yanaijie@huawei.com>
Subject: Re: [PATCH] ASoC: topology: remove unneeded semicolon
Message-Id: <158738983288.28866.14153649784300796683.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Apr 2020 12:28:58 +0800, Jason Yan wrote:
> Fix the following coccicheck warning:
> 
> sound/soc/soc-topology.c:2344:2-3: Unneeded semicolon
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>  sound/soc/soc-topology.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> [...]

Applied to

	broonie/sound.git for-5.8

Thanks!

[1/1] ASoC: topology: Remove unneeded semicolon
      commit: 980f91778a2f4dcca43d16b7a83feda8df5c96e7

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
