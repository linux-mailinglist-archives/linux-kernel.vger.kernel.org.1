Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0C824DB8E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 18:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbgHUQmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 12:42:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:54738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728139AbgHUQkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 12:40:20 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EF0C207BB;
        Fri, 21 Aug 2020 16:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598028019;
        bh=pRIfmNaiNOw1L35y4l06tL/wHSPMxVTsjUkGjVve9oA=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=qTTDKWveXPeCEbKj/21q8Q3uNVUNe1ETGOUcRV3IABy7DtksxhPMSWk2CCZPezbFa
         PvTZHgcJxYEOfb4IJbTUJT/c5AaQVUpPwW+aueWZHQngGv2B3Lpa4its2rHT8VHFXU
         0UAwBVCBnScmbmCIAxsvWbHiqjVTihrgLydy/GJg=
Date:   Fri, 21 Aug 2020 17:39:46 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Timur Tabi <timur@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shengjiu Wang <shengjiu.wang@gmail.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
In-Reply-To: <20200821071153.7317-1-matthias.schiffer@ew.tq-group.com>
References: <20200821071153.7317-1-matthias.schiffer@ew.tq-group.com>
Subject: Re: [PATCH 1/2] ASoC: bindings: fsl-asoc-card: add compatible string for TLV320AIC32x4 codec
Message-Id: <159802798182.25503.6288597388971978944.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Aug 2020 09:11:52 +0200, Matthias Schiffer wrote:
> The TLV320AIC32x4 is commonly used on TQ-Systems starterkit mainboards
> for i.MX-based SoMs (i.MX6Q/DL, i.MX6UL, i.MX7) and LS1021A.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: bindings: fsl-asoc-card: add compatible string for TLV320AIC32x4 codec
      commit: 6d3029e92f320531805e6aed33c74185e5e3f8fa
[2/2] ASoC: fsl-asoc-card: add support for TLV320AIC32x4 codec
      commit: b50747558855ff94523dbb7f08a8c9fadfdd9110

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
