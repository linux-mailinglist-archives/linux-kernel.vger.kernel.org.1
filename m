Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A62DF299AFC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 00:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408267AbgJZXqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 19:46:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:43226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408256AbgJZXqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 19:46:31 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DADB220809;
        Mon, 26 Oct 2020 23:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603755991;
        bh=BLWQdGveENT5XNgZCgOzbVEsd7JBaWFXeH+L88FYIEA=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=fRRUXQ87VQ35k5AiPOFfP5uCLFQRav0PIoxXOGXqlKUOm7tP9zt0x4BvNSGB2YZ4x
         dWhGaqR6H097WyeQhrKcdJm4Rzbkd/ro84VMFR91UWN9HjX0G5dqV81HSuO6iei6Ej
         726ncxBFzokKXyvuXsvMqLYklLuB7C5yoLT3vYLs=
Date:   Mon, 26 Oct 2020 23:46:27 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201015102703.24622-1-rf@opensource.cirrus.com>
References: <20201015102703.24622-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: wm5102: Use get_unaligned_be16() for dac_comp_coeff
Message-Id: <160375592347.31132.15459397417777380498.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Oct 2020 11:27:03 +0100, Richard Fitzgerald wrote:
> Replace the two-step copy-and-convert in
> wm5102_out_comp_coeff_put() with get_unaligned_be16(). Apart from
> looking nicer, it avoids this sparse warning:
> 
> wm5102.c:687:35: sparse: sparse: cast to restricted __be16

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: wm5102: Use get_unaligned_be16() for dac_comp_coeff
      commit: 79405e3e5375875f8edc7dd6c1cf5376b1ded6e7

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
