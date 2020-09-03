Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 597E825C238
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Sep 2020 16:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbgICOJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Sep 2020 10:09:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:51408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729069AbgICOFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 10:05:46 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D3092071B;
        Thu,  3 Sep 2020 13:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599140936;
        bh=JvSw5khXq0xtDTAtXhZfqiB6ak5kwj1ew7cgvmtjRVM=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=RRjwlLgkVyNA1+lGkllIRjLOtghwygdJX88Pp0V8ohS3x9GEn+WOekQARcLnrRwLB
         QR94hCSGT/pKvyVpFhbh0oZBLpeGczIPLNFqkCRML8fF2igkxx4s0mfmBXw9Jolfwd
         KcUgd0tEYZlMnk2Kj0RZ4qS0ZKzewYj0U7rzAEGg=
Date:   Thu, 03 Sep 2020 14:48:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org, tiwai@suse.com, timur@kernel.org,
        festevam@gmail.com, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        lgirdwood@gmail.com, perex@perex.cz,
        Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <1598958068-10552-1-git-send-email-shengjiu.wang@nxp.com>
References: <1598958068-10552-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Support multiple data channel enable bits
Message-Id: <159914089549.45733.4128299430192434595.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Sep 2020 19:01:08 +0800, Shengjiu Wang wrote:
> One data channel is one data line. From imx7ulp, the SAI IP is
> enhanced to support multiple data channels.
> 
> If there is only two channels input and slots is 2, then enable one
> data channel is enough for data transfer. So enable the TCE/RCE and
> transmit/receive mask register according to the input channels and
> slots configuration.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_sai: Support multiple data channel enable bits
      commit: 770f58d7d2c58b8ff31d3694ce14a785c2e75009

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
