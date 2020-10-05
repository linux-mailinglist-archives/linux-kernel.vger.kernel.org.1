Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90677283DCE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 19:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbgJERyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 13:54:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:49150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727901AbgJERyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 13:54:53 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05F34207BC;
        Mon,  5 Oct 2020 17:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601920493;
        bh=VCiW3dcVnJ9y8q1OkZqogcxkqkpP/n24rMjf80efbJM=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=UqXAPg5VeIwEKjcazvYt39IGVvbdXeFcre6MDtbS0LC/FB/LnmtcRYIPdAj0ZrptE
         dEozWDSkvha6ExelpFU7XGPGUTI6bbxEF67GuALuJuYBgXiDFoSRQv03AsiCFecAVA
         DeDD1YrWTFo+JLvpRvN6c1PdDFExcUGFxA46vTF8=
Date:   Mon, 05 Oct 2020 18:53:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc:     nicolas.ferre@microchip.com, tiwai@suse.com, lgirdwood@gmail.com,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com
In-Reply-To: <20201004094505.1041898-1-codrin.ciubotariu@microchip.com>
References: <20201004094505.1041898-1-codrin.ciubotariu@microchip.com>
Subject: Re: [PATCH] ASoC: mchp-spdifrx: convert to devm_platform_get_and_ioremap_resource
Message-Id: <160192043040.23051.5178430968539357804.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Oct 2020 12:45:05 +0300, Codrin Ciubotariu wrote:
> Use the helper function that wraps the calls to platform_get_resource()
> and devm_ioremap_resource() together.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mchp-spdifrx: convert to devm_platform_get_and_ioremap_resource
      commit: 8031b93efa8d393b7e38fa66b836ac157a2f354d

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
