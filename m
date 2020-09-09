Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 299B6263196
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 18:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730690AbgIIQUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 12:20:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:40950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731011AbgIIQRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 12:17:39 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 459B3206A2;
        Wed,  9 Sep 2020 16:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599668240;
        bh=ZWI8ZIwwaG0xk3zDY/v0B7Ja0OHPsLcZD8PYPK+ImiM=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=mviIVirCVmP0xqdQRsgVrxrWvJf3fZlkLSRYDAmQKaurnCBPjlwrNAjI7tAGt5VTt
         O4QUFP4EMiyuaNE4nOc2qS1kKCAI9R8ljt4PptFEUIIe+52cPzmh65awNDDKRi2SfD
         JW+rckVFPgX+7omG043GtVSFGaiBGj7GSkM8P834=
Date:   Wed, 09 Sep 2020 17:16:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        alsa-devel@alsa-project.org,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        devicetree@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>, tiwai@suse.com,
        alexandre.belloni@bootlin.com, lgirdwood@gmail.com,
        nicolas.ferre@microchip.com, ludovic.desroches@microchip.com,
        robh+dt@kernel.org
In-Reply-To: <20200909145348.367033-1-codrin.ciubotariu@microchip.com>
References: <20200909145348.367033-1-codrin.ciubotariu@microchip.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: sound: add DT bindings for Microchip S/PDIF TX Controller
Message-Id: <159966819527.17677.10566984537165572569.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Sep 2020 17:53:47 +0300, Codrin Ciubotariu wrote:
> This patch adds DT bindings for the new Microchip S/PDIF TX Controller
> embedded inside sama7g5 SoCs.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: add DT bindings for Microchip S/PDIF TX Controller
      commit: 7a8cca56f75ec9fe94550f846e66d62bc3a2778c
[2/2] ASoC: mchp-spdiftx: add driver for S/PDIF TX Controller
      commit: 06ca24e98e6bcc17c32ebe4b2fc579e5bf9ff5b2

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
