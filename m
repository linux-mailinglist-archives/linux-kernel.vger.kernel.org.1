Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2257C22B77E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 22:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgGWUUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 16:20:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:35806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725979AbgGWUUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 16:20:32 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6AA8206E3;
        Thu, 23 Jul 2020 20:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595535632;
        bh=78hQl5KUO1Gn565TFq0EiLyGKeKiV2pAj9ARRZGNUsc=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=eI2iZ+bPR+hc2ODo9wOxYYYsE0Ws4LOmX782GrTwbRNURH/BlgQH2XosT/UsKuv0B
         w157IJNk+BatYXuvS9IXbSTxdpOZ6ybS6gGgAN+ovd7+I28FiHVg+fd//5if+dcos1
         nCaJfJRwvPto+DNW3OCjv57iOFGY7tp3vzmagj7U=
Date:   Thu, 23 Jul 2020 21:20:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     perex@perex.cz, nicoleotsuka@gmail.com,
        Shengjiu Wang <shengjiu.wang@nxp.com>, festevam@gmail.com,
        Xiubo.Lee@gmail.com, tiwai@suse.com, alsa-devel@alsa-project.org,
        timur@kernel.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <1595476808-28927-1-git-send-email-shengjiu.wang@nxp.com>
References: <1595476808-28927-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_esai: add IRQF_SHARED for devm_request_irq
Message-Id: <159553557414.41908.17763476955607586934.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jul 2020 12:00:08 +0800, Shengjiu Wang wrote:
> ESAI interfaces may share same interrupt line with EDMA on
> some platforms (e.g. i.MX8QXP, i.MX8QM).
> Add IRQF_SHARED flag to allow sharing the irq among several
> devices

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_esai: add IRQF_SHARED for devm_request_irq
      commit: c8361757a712dff4db49e18b736635e367b0f473

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
