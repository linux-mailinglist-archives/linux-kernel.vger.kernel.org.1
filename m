Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92960288C07
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 17:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389090AbgJIPBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 11:01:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:36482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388692AbgJIPBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 11:01:35 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA811222C4;
        Fri,  9 Oct 2020 15:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602255695;
        bh=T11muwXB2QxG8iDVQds+7//swDIvA2rVCBdLpoxNIn8=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=AYnaStWdxLfHwpszLEefwQ1igCqXzU60ES9X3xiPYt41ah2ptiup16z0/yhnIWyDP
         OkwegOqis5CrD13Pm7E2+lw/77eeZQOYEAwby7tj7qEhtyqBezs/OdtnyNAiVyJt/l
         1fwndb7GUASqjx5wHXwYFv+XTcYfchR07aEgPIhw=
Date:   Fri, 09 Oct 2020 16:01:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        alsa-devel@alsa-project.org
Cc:     lgirdwood@gmail.com, ludovic.desroches@microchip.com,
        alexandre.belloni@bootlin.com, nicolas.ferre@microchip.com
In-Reply-To: <20201009123527.2770629-1-codrin.ciubotariu@microchip.com>
References: <20201009123527.2770629-1-codrin.ciubotariu@microchip.com>
Subject: Re: [PATCH] ASoC: mchp-spdiftx: remove 'TX' from playback stream name
Message-Id: <160225569297.8995.15961322461162264832.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Oct 2020 15:35:27 +0300, Codrin Ciubotariu wrote:
> Do not include the 'TX' in the stream name since it's obvious for
> playback.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mchp-spdiftx: remove 'TX' from playback stream name
      commit: b899e4fd7a331065d01ca14809c9e55f113f7d05

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
