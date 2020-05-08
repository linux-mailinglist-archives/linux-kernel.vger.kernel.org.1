Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 677EB1CB588
	for <lists+linux-kernel@lfdr.de>; Fri,  8 May 2020 19:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbgEHROD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 May 2020 13:14:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:50196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727976AbgEHROA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 13:14:00 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C197C206D3;
        Fri,  8 May 2020 17:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588958040;
        bh=Mi3mkL21mFkTxbfu4inxijc64euefMaBjgzvJAZkVr8=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=0kTPBDsV1m5zI5N7T6k4brBReXBdIzEmE0/ap0WDTIDdPHIdwKH2CuMPror9co+N+
         kR57GABl8RgrwiqR1mSCUb1pzwFyqdaiucXMqBhIoeCM6XDgzF6J1ScpEgHbDtzbzX
         zNbnMqGvsGThKWJA9++WOEDFQeeEpy0hwA9EYy24=
Date:   Fri, 08 May 2020 18:13:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     plai@codeaurora.org, Tang Bin <tangbin@cmss.chinamobile.com>,
        perex@perex.cz, bgoswami@codeaurora.org
Cc:     Zhang Shengju <zhangshengju@cmss.chinamobile.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20200504072820.5328-1-tangbin@cmss.chinamobile.com>
References: <20200504072820.5328-1-tangbin@cmss.chinamobile.com>
Subject: Re: [PATCH] ASoC: qcom: Use devm_platform_ioremap_resource_byname() to simplify code
Message-Id: <158895800278.30774.4078741389607548443.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 May 2020 15:28:20 +0800, Tang Bin wrote:
> Use devm_platform_ioremap_resource_byname() instead of
> platform_get_resource_byname() + devm_ioremap_resource().
> 
> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> ---
>  sound/soc/qcom/lpass-cpu.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> [...]

Applied to

   local tree regulator/for-5.7

Thanks!

[1/1] ASoC: qcom: Use devm_platform_ioremap_resource_byname() to simplify code
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
