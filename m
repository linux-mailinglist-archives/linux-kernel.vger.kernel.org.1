Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3CF12CA4C4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 15:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403866AbgLAN7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 08:59:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:45912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403858AbgLAN7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 08:59:53 -0500
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net [92.233.91.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB11021D42;
        Tue,  1 Dec 2020 13:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606831151;
        bh=Gd8u+h7Sijvfj4KYiDt/+NlliF956oJAuObxiK9AEIc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=VncYOzvMkRaukxKoiARjPGWh89eD1LwT8OO5I1FhSjfEYicxs+7UegnaaOKPn6qta
         zoo+BC4Xe4cngpCw9aut7VCAlp0ZxZrMdLEu55bpHUBPyJVcFHsrEVnjMxSHXI3KWs
         eesbu1m0ipAvQknMt0slCit+7qjBHs8Qr1vKz0NM=
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     s.hauer@pengutronix.de, axel.lin@ingics.com,
        linux-arm-kernel@lists.infradead.org, ttynkkynen@nvidia.com,
        linux-kernel@vger.kernel.org, linus.walleij@linaro.org
In-Reply-To: <1605280870-32432-1-git-send-email-claudiu.beznea@microchip.com>
References: <1605280870-32432-1-git-send-email-claudiu.beznea@microchip.com>
Subject: Re: [PATCH v3 0/6] regulator: mcp16502: add support for ramp delay
Message-Id: <160683107676.35139.5462793420865249234.b4-ty@kernel.org>
Date:   Tue, 01 Dec 2020 13:57:56 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Nov 2020 17:21:04 +0200, Claudiu Beznea wrote:
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

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/6] regulator: core: validate selector against linear_min_sel
      (no commit info)
[2/6] regulator: core: do not continue if selector match
      (no commit info)
[3/6] regulator: mcp16502: add linear_min_sel
      (no commit info)
[4/6] regulator: mcp16502: adapt for get/set on other registers
      (no commit info)
[5/6] regulator: mcp16502: add support for ramp delay
      (no commit info)
[6/6] regulator: mcp16502: remove void documentation of struct mcp16502
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
