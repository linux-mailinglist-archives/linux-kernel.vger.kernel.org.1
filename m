Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBCD11CB572
	for <lists+linux-kernel@lfdr.de>; Fri,  8 May 2020 19:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgEHRNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 May 2020 13:13:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:49564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727801AbgEHRNh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 13:13:37 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A46242063A;
        Fri,  8 May 2020 17:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588958017;
        bh=5t7WJiL5EwvoF0nnqVxBZir0wWe3BIQcNbcs1QJffwA=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=rAgyn1AzkpzjDtU1+fwmVGaaW32AsL9fJeQxDyPG+4bENc1L72C8N/5TpqKgFGG9m
         fVSCnRSKUlW1rqiwWnyL1VjbOfKnkKZMqOtQYKcK7yW11nTwDAQx+SjIkWmXvVeTlh
         wIenW1KdCjcuSDpdquykMkHaJ9Bw5hXfIm1zBzdU=
Date:   Fri, 08 May 2020 18:13:34 +0100
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, perex@perex.cz, s.hauer@pengutronix.de,
        lgirdwood@gmail.com, shawnguo@kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20200429094023.12856-1-tangbin@cmss.chinamobile.com>
References: <20200429094023.12856-1-tangbin@cmss.chinamobile.com>
Subject: Re: [PATCH] ASoC: mxs-saif: Add variable dev to simplify code
Message-Id: <158895800277.30774.18095767521738841967.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Apr 2020 17:40:23 +0800, Tang Bin wrote:
> Add variable 'dev' to make the code cleaner in the function
> mxs_saif_probe(). And now that the function mxs_saif_mclk_init()
> have defined the variables 'ret' as the error returned value,
> then it should be used instead in this place.
> 
> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> 
> [...]

Applied to

   local tree regulator/for-5.7

Thanks!

[1/1] ASoC: mxs-saif: Add variable dev to simplify code
      (no commit info)

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
