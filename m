Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 724EA223FBF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 17:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgGQPjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jul 2020 11:39:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:58542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726256AbgGQPjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 11:39:51 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A79E22070A;
        Fri, 17 Jul 2020 15:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595000391;
        bh=e39FbaMvv9oiVrlJ/4cxLI+F98AGNWyL8YjtvnwozfU=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=TKXrsxpbg4OpY8A41Z8/ewdTz/7ojoSOqVn+SUXpfl8VBb20hvFaXA/u+XoYH/EMK
         1ilRRH+3fghv8Cu4OPVn14v7bG3TptidAFVsotVc9D7nuYNVl/N3MZRgq+YEYnyUo5
         zVCvs6luvW4EiZlhn439MEiTw2uyRVSPr9J+lAoE=
Date:   Fri, 17 Jul 2020 16:39:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, tiwai@suse.com, plai@codeaurora.org,
        bgoswami@codeaurora.org, Tang Bin <tangbin@cmss.chinamobile.com>,
        perex@perex.cz
Cc:     linux-kernel@vger.kernel.org,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>,
        alsa-devel@alsa-project.org
In-Reply-To: <20200714112744.20560-1-tangbin@cmss.chinamobile.com>
References: <20200714112744.20560-1-tangbin@cmss.chinamobile.com>
Subject: Re: [PATCH] ASoC: qcom: qdsp6: Use IS_ERR() instead of IS_ERR_OR_NULL()
Message-Id: <159500037997.27597.13743783362171527765.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jul 2020 19:27:44 +0800, Tang Bin wrote:
> In the function q6adm_open(), q6adm_alloc_copp() doesn't return
> NULL. Thus use IS_ERR() to validate the returned value instead
> of IS_ERR_OR_NULL(). And delete the extra line.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qcom: qdsp6: Use IS_ERR() instead of IS_ERR_OR_NULL()
      commit: 16bf5e82facd703ba8f206f00f064e786ea8318c

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
