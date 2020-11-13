Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35F9D2B21C2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 18:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgKMROj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 12:14:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:53682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726288AbgKMROi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 12:14:38 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3F1620759;
        Fri, 13 Nov 2020 17:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605287691;
        bh=ZWTdlG2/Uq7nJjMxy7LmYwoV97nc8Puua2WfqYC6Knw=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=py+0X5kHTB6MGgfsfyHOlebceejKXd8GHsuChPvJtikw3ddtJDjXiqx9uH827oTk6
         +7QXG7BOaMZqIjxZjHiZwYCpH5QcIf6AhrWqWChIuwzIsNkHDNGYchCbz+9YwFd5BD
         WFXNHHf0fZ+Dd12B0u8UYw81/0zDKogNgtpYnch4=
Date:   Fri, 13 Nov 2020 17:14:35 +0000
From:   Mark Brown <broonie@kernel.org>
To:     axel.lin@ingics.com, linus.walleij@linaro.org,
        ttynkkynen@nvidia.com, lgirdwood@gmail.com,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        s.hauer@pengutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <1604656384-827-1-git-send-email-claudiu.beznea@microchip.com>
References: <1604656384-827-1-git-send-email-claudiu.beznea@microchip.com>
Subject: Re: [PATCH 0/6] regulator: mcp16502: add support for ramp delay
Message-Id: <160528765435.56661.15898611465418470617.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Nov 2020 11:52:58 +0200, Claudiu Beznea wrote:
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
