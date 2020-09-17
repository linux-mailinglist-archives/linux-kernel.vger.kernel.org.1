Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1D326E508
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 21:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgIQTGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 15:06:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:59128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726544AbgIQS6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 14:58:30 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D67AB221F1;
        Thu, 17 Sep 2020 18:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600369108;
        bh=XKnazpfmRK7Z8j3eyFrJRLYU8mkw0ZAcQ1dMq+PPpVU=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=GI21qcXEg+RVsZ7JgoRVYBzO4tZIcIjM9M7rL8mXnsr9jaw3pah3t+yPhmqutdDau
         ACQtlPA8Z3M/9OOEeOuebD1raviy0FpK7A53FbkpdUwu7r9dFNPUoWigcUzjaKh/WS
         GQ57WUwN3nOmcqldV9cD49Op4PMzPYgfpnymV66A=
Date:   Thu, 17 Sep 2020 19:57:38 +0100
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, lgirdwood@gmail.com, robh+dt@kernel.org,
        Dan Murphy <dmurphy@ti.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        camel.guo@axis.com, devicetree@vger.kernel.org
In-Reply-To: <20200915190606.1744-1-dmurphy@ti.com>
References: <20200915190606.1744-1-dmurphy@ti.com>
Subject: Re: [PATCH 1/6] ASoC: tlv320adcx140: Idle the device while writing registers
Message-Id: <160036900934.20113.7109708512695608892.b4-ty@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Sep 2020 14:06:01 -0500, Dan Murphy wrote:
> It was observed that if the device was active and register writes were
> performed there were some unwanted behaviors particularly when writing
> the word length and some filter options. So when writing to the device
> the device should be placed in sleep mode and then exit sleep mode once
> the register update is complete.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/6] ASoC: tlv320adcx140: Idle the device while writing registers
      commit: df16e2210454ca0b8a59caf364dd287fbb76a804
[2/6] ASoC: tlv320adcx140: Fix BCLK inversion for DSP modes
      commit: 244ac15de75ca62ed7a09c7291b67aeead9e12ac
[3/6] ASoC: tlv320adcx140: Add ASI Tx drive
      commit: 38b9b7ca6f08489f3065e081e71c743775ed50c8
[4/6] ASoC: tlv320adcx140: Add the config to configure Tx ASI output
      commit: 42d5031d3ee858bc14df704439eefdbf38b8f628
[5/6] dt-bindings: tlv320adcx140: Add slot programming property
      (no commit info)
[6/6] ASoC: tlv320adcx140: Add channel slot programming
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
