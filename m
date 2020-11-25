Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68D6F2C418B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 14:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729743AbgKYN6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 08:58:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:34462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726992AbgKYN6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 08:58:32 -0500
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net [92.233.91.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28D522067D;
        Wed, 25 Nov 2020 13:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606312711;
        bh=Cyu0AkwxzQsIHLMFSvu3ENgdx8wUHEaoXwxzg6oGcxk=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=attU8U+1cTDuzsvE9HmP+erKurMSIQZOrE+O4MxZ2dgulzI8FN7I0xPcWQOSvundg
         aHTZK9hujZTNeyoPXsXy1uSePSW2PLYaWHy+QBEKCDKJbd04TUtQg/qC8b7SDVsZhf
         9us5cwFGC5oHlYnymcfnfTp55S/kbZq//1ESjyVE=
Date:   Wed, 25 Nov 2020 13:58:06 +0000
From:   Mark Brown <broonie@kernel.org>
To:     linuxppc-dev@lists.ozlabs.org, Fabio Estevam <festevam@gmail.com>,
        alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, Timur Tabi <timur@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>
Cc:     Viorel Suman <viorel.suman@nxp.com>
In-Reply-To: <20201124141957.20481-1-viorel.suman@oss.nxp.com>
References: <20201124141957.20481-1-viorel.suman@oss.nxp.com>
Subject: Re: [PATCH] ASoC: fsl_xcvr: fix potential resource leak
Message-Id: <160631268108.29388.9517071791344841145.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Nov 2020 16:19:57 +0200, Viorel Suman (OSS) wrote:
> "fw" variable must be relased before return.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_xcvr: fix potential resource leak
      commit: 373c2cebf42772434c8dd0deffc3b3886ea8f1eb

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
