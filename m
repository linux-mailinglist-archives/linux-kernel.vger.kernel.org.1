Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0F61F6AF7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jun 2020 17:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbgFKP26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jun 2020 11:28:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:59208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728379AbgFKP25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 11:28:57 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C188206C3;
        Thu, 11 Jun 2020 15:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591889337;
        bh=fLkyOBJQDjmnRQSyH8H/HsxFUNXTfAnE6ogJem2ztkU=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=xX9SUKIiphda5w11zEjEpTM339FbXhZIMbbKcXbFsgeupaAdlUDPYbeLiZvfSu41K
         NvpShiP+V6p2mDBLoxvaDMsVWMsqjv1p6qqzcxbwNnIfOGiArYN0fTP2oBzv3Myl4V
         QSAseghuNGr2k1vVb6kaf5wDFwsiIzdBvLH7qstQ=
Date:   Thu, 11 Jun 2020 16:28:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org, vkoul@kernel.org, tiwai@suse.com,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org
In-Reply-To: <20200611124159.20742-1-srinivas.kandagatla@linaro.org>
References: <20200611124159.20742-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 0/8] ASoC: qcom: q6asm: few fixes and enhancements.
Message-Id: <159188933509.47193.8263889711751900487.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jun 2020 13:41:51 +0100, Srinivas Kandagatla wrote:
> While trying out gapless playback, I found few issues with the existing code
> This patchset has few fixes and some enhancement to the code to handle
> multiple streams per asm session and also handle buffers that are not aligned
> to period sizes.
> 
> I will send Gapless support patches once compressed gapless state machine is fixed.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: q6asm: handle EOS correctly
      commit: 6476b60f32866be49d05e2e0163f337374c55b06

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
