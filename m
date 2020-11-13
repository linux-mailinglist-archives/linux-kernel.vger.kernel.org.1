Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB792B21BF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 18:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgKMRO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 12:14:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:53540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbgKMRO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 12:14:27 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56ED320759;
        Fri, 13 Nov 2020 17:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605287680;
        bh=05NwquX4tysFX1vEoWGhJ2DEyQ3PDWUEhSnn9l6x3PI=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=0YHriKY/Jo1dOsHUTV5XqDltlX2UszHDxOSqbqZFmQzh2UQ7WchfTqr46EnI1Ki8v
         FWGZLifHjBr4L9N6fNjzX8z1YtiNHSTrhMtkzqk/pYPI7HBxLRIHa70Auqfgc9kl0d
         2ctez9QVpTEPATSwEEVy86TJVT2FK7SUFqx2JN28=
Date:   Fri, 13 Nov 2020 17:14:24 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>, lgirdwood@gmail.com
Cc:     axel.lin@ingics.com, linus.walleij@linaro.org,
        ttynkkynen@nvidia.com, linux-kernel@vger.kernel.org,
        s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org
In-Reply-To: <1605085578-6783-1-git-send-email-claudiu.beznea@microchip.com>
References: <1605085578-6783-1-git-send-email-claudiu.beznea@microchip.com>
Subject: Re: [PATCH v2 0/6] regulator: mcp16502: add support for ramp delay
Message-Id: <160528765435.56661.4517753341786366604.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Nov 2020 11:06:12 +0200, Claudiu Beznea wrote:
> This series adds support for ramp delay on mcp16502. It also adds
> some cleanup on mcp16502.
> 
> Apart from that patches 1/6 fixes the selector validation in case
> the regulator::desc::linear_min_sel is not zero.
> 
> Thank you,
> Claudiu Beznea
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/6] regulator: core: validate selector against linear_min_sel
      commit: bdcd1177578cd5556f7494da86d5038db8203a16
[2/6] regulator: core: do not continue if selector match
      (no commit info)
[3/6] regulator: mcp16502: add linear_min_sel
      commit: 478f8089161e9a8f487ef3f560e59d1423b81c05
[4/6] regulator: mcp16502: adapt for get/set on other registers
      commit: 3e5532a011b09861abc2da3aa518b9aafc250570
[5/6] regulator: mcp16502: add support for ramp delay
      commit: 322eb8666d2f50556e89d73b54cf2dad8703c4e0
[6/6] regulator: mcp16502: remove void documentation of struct mcp16502
      commit: 842f44806efaddfae5ecff8f143c2607a4fa65d7

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
