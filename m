Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 719292A6F17
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 21:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732332AbgKDUnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 15:43:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:59040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727637AbgKDUnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 15:43:11 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95E7420782;
        Wed,  4 Nov 2020 20:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604522591;
        bh=W9g2xF7W5N0mgEIaNycneqP7yHMgQppBrLRV9HdLquk=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=S5Mj8Am2PTfs/DciLSBpP+ny5hNyuR3522OCqk6/bsv/4ZfE2ccGyV/UdlYR2mHm1
         Rl6WelQUkGiN4FpNoFKx6/Rmx+SgXpVPYQLj4l3Wcr3FIR/4K5K9JdW9HMLV7jbADK
         MzWPfYn1HZ/t9b3sXaOVWNTI8cUDnjjHenBDdu5k=
Date:   Wed, 04 Nov 2020 20:43:00 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        alsa-devel@alsa-project.org
Cc:     nicolas.ferre@microchip.com, ludovic.desroches@microchip.com,
        lgirdwood@gmail.com, alexandre.belloni@bootlin.com
In-Reply-To: <20201104155738.68403-1-codrin.ciubotariu@microchip.com>
References: <20201104155738.68403-1-codrin.ciubotariu@microchip.com>
Subject: Re: [PATCH] ASoC: mchp-spdiftx: Do not set Validity bit(s)
Message-Id: <160452257412.7226.6443928434973904720.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Nov 2020 17:57:38 +0200, Codrin Ciubotariu wrote:
> The Validity bits (bit 28) must not be set in order to have the samples
> valid. Some controllers look for this bit and ignore the samples if it
> is set.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mchp-spdiftx: Do not set Validity bit(s)
      commit: f9d7c6eb23f7e55e7a0ca5451da06909bdfdd0e4

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
