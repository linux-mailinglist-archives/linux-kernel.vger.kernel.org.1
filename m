Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C08027926A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 22:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbgIYUm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 16:42:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:50834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbgIYUm4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 16:42:56 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5C7421D42;
        Fri, 25 Sep 2020 20:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601066576;
        bh=QSevX1flL8R5A+fqYXDssSpKP80IyBfwUR79zCY1bHU=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=urarfz8PuyF+GFxvTcJYGPU6CbYQ8EubrmxlSDW9MN3ATbi+2rDYcNTjBeE48/ruw
         crrsbsCFqMnUqSLnZQTb0cnZqgn/dcxsCC/GFG10dW40H5dXz45Mdu4W9z6BfPF+ok
         YKR556UJKd7h3q8k7lWpnMA3X9s5YP8+egymxK/I=
Date:   Fri, 25 Sep 2020 21:42:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, tiwai@suse.com,
        linux-arm-kernel@lists.infradead.org, festevam@gmail.com,
        Xiubo.Lee@gmail.com, linuxppc-dev@lists.ozlabs.org,
        nicoleotsuka@gmail.com, shawnguo@kernel.org, perex@perex.cz,
        linux-imx@nxp.com, s.hauer@pengutronix.de,
        Xu Wang <vulab@iscas.ac.cn>, shengjiu.wang@gmail.com,
        alsa-devel@alsa-project.org, kernel@pengutronix.de,
        timur@kernel.org
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20200921015918.24157-1-vulab@iscas.ac.cn>
References: <20200921015918.24157-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] fsl: imx-audmix : Use devm_kcalloc() instead of devm_kzalloc()
Message-Id: <160106647647.2866.12055149870190769449.b4-ty@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Sep 2020 01:59:18 +0000, Xu Wang wrote:
> A multiplication for the size determination of a memory allocation
> indicated that an array data structure should be processed.
> Thus use the corresponding function "devm_kcalloc".

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl: imx-audmix: Use devm_kcalloc() instead of devm_kzalloc()
      commit: f95cc5c18c15a425c3dceec48df6b4e27a202dda

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
