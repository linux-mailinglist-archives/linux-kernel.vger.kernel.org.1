Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3712B9909
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 18:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbgKSRJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 12:09:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:36562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbgKSRJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 12:09:32 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72CF924695;
        Thu, 19 Nov 2020 17:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605805772;
        bh=Pl+VaTCd0Kg4ijGjNnnoD3cnGXyL0yjZsgVFyZZv8B4=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=q51cnzkA1wsaOBro1dZqgzSwM2FA2z5bpkQXLC2kDxqYB/xyLcwXj1/qhwclrEC0v
         Hf9Kk055Rr6PbrmS42lyq0x9H7V4i41L/N4Akoz/Pib7UKyQSnV65at2V+XKUC3kwh
         pFzBTtTfQhm03dNNG4J4BMAHawPWC7LsBwR1eu08=
Date:   Thu, 19 Nov 2020 17:09:11 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Xiubo.Lee@gmail.com, Shengjiu Wang <shengjiu.wang@nxp.com>,
        nicoleotsuka@gmail.com, timur@kernel.org, perex@perex.cz,
        festevam@gmail.com, alsa-devel@alsa-project.org, tiwai@suse.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <1605768038-4582-1-git-send-email-shengjiu.wang@nxp.com>
References: <1605768038-4582-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH v2] ASoC: fsl_sai: Correct the clock source for mclk0
Message-Id: <160580573380.54454.17925861225420646982.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Nov 2020 14:40:38 +0800, Shengjiu Wang wrote:
> On VF610, mclk0 = bus_clk;
> On i.MX6SX/6UL/6ULL/7D, mclk0 = mclk1;
> On i.MX7ULP, mclk0 = bus_clk;
> On i.MX8QM/8QXP, mclk0 = bus_clk;
> On i.MX8MQ/8MN/8MM/8MP, mclk0 = bus_clk;
> 
> So add variable mclk0_is_mclk1 in fsl_sai_soc_data to
> distinguish these platforms.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_sai: Correct the clock source for mclk0
      commit: 53233e40c142b1e0e1df9d9ac0ffc0945cfffbc9

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
