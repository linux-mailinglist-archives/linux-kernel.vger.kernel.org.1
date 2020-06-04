Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE7B1EE649
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jun 2020 16:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbgFDOFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jun 2020 10:05:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:50280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728496AbgFDOFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 10:05:16 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2478D2063A;
        Thu,  4 Jun 2020 14:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591279516;
        bh=yoZ+4NGxMSMul3HfyneR0IDhwul9qnZTStsDEn2Zgu4=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=oeFc3hPLn/eJQ8jT52aunzJxLu4etI3QaAS0voXxIyWb+xCQUXFs6CYPnG7kZSz4Z
         W02MtBf5aUl1PlWgDlyRlA8VcIuklXBwBcu1xxB/A88NyMLvcvI+DXZTmdPNF/jxy6
         d/80c9Z2fGRqsih7m2/4sskqDpGkrXcAosf72Ip4=
Date:   Thu, 04 Jun 2020 15:05:14 +0100
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz,
        nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, timur@kernel.org,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        linuxppc-dev@lists.ozlabs.org, festevam@gmail.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
In-Reply-To: <1591251930-4111-1-git-send-email-shengjiu.wang@nxp.com>
References: <1591251930-4111-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl-asoc-card: Defer probe when fail to find codec device
Message-Id: <159127951451.54171.5112369332405594522.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jun 2020 14:25:30 +0800, Shengjiu Wang wrote:
> Defer probe when fail to find codec device, because the codec
> device maybe probed later than machine driver.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl-asoc-card: Defer probe when fail to find codec device
      commit: e396dec46c5600d426b2ca8a01a877928b50d1d9

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
