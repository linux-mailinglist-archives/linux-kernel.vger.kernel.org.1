Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBBA82A4E11
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 19:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729087AbgKCSOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 13:14:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:37776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727901AbgKCSOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 13:14:39 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 569A620757;
        Tue,  3 Nov 2020 18:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604427278;
        bh=oBr6/A8lCcfHcLffpfnmhk9cxSSf3L6F0Tt4SgemAnY=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=BFwtZSU19nnkFwZf+hTTx8yDwYdxRjYpPB7E8n5jhdCqN9Nc9kpMVLAdM91dXrkDM
         V1BMNQO7WEDegw2WsGFPZc6Om3XaRll7L4wLYQ9bZvXbOANbILZgN7IIa2hTNxElD5
         O6tcf7f94nxMge8pNBlrSbdcvjUpI3c27RYUTUTQ=
Date:   Tue, 03 Nov 2020 18:14:29 +0000
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
Cc:     ludovic.desroches@microchip.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, lgirdwood@gmail.com
In-Reply-To: <20201103100554.1307190-1-codrin.ciubotariu@microchip.com>
References: <20201103100554.1307190-1-codrin.ciubotariu@microchip.com>
Subject: Re: [PATCH] ASoC: atmel-i2s: do not warn if muxclk is missing
Message-Id: <160442726962.14840.2168034632835702647.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Nov 2020 12:05:54 +0200, Codrin Ciubotariu wrote:
> Besides the fact that muxclk is optional, muxclk can be set using
> assigned-clocks, removing the need to set it in driver. The warning is
> thus unneeded, so we can transform it in a debug print, eventually to just
> reflect that muxclk was not set by the driver.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: atmel-i2s: do not warn if muxclk is missing
      commit: f4bf1f4d1385b7cb61a3fc811bb4912d49aa394a

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
