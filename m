Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83166273705
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 02:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbgIVAGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 20:06:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:40218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726537AbgIVAGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 20:06:41 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A963D21789;
        Tue, 22 Sep 2020 00:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600733201;
        bh=eQm4+4KLm1xSwr5sg6h3TpmW1fONFAnc7NAdHhTHU8E=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=L3q3mcJ8t6ySMY6obEzhyeNnflr3IqDDMC13/lO9Ca6AM3Bh2mOHUTf1CO9D9/76I
         WIlI6Ndb04i4e4MXnaQv+XYHXHuJyztRiudAM3eg413ttsDzzUJFQDvL26m6KbjqWv
         lSXhS2bpUS4kGJuYYA2lfMbsaL38ha8u3/r4HxTI=
Date:   Tue, 22 Sep 2020 01:05:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     robh+dt@kernel.org, tiwai@suse.com, lgirdwood@gmail.com,
        Dan Murphy <dmurphy@ti.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20200918190548.12598-1-dmurphy@ti.com>
References: <20200918190548.12598-1-dmurphy@ti.com>
Subject: Re: [PATCH 1/9] ASoC: tas2770: Fix calling reset in probe
Message-Id: <160073312817.6173.8370528321313703432.b4-ty@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Sep 2020 14:05:40 -0500, Dan Murphy wrote:
> tas2770_reset is called during i2c probe. The reset calls the
> snd_soc_component_write which depends on the tas2770->component being
> available. The component pointer is not set until codec_probe so move
> the reset to the codec_probe after the pointer is set.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] dt-bindings: tas2770: Fix I2C addresses for the TAS2770
      commit: b23d9eb897a1209e4d741fd69e5490f1b5b9e7cf
[2/5] ASoC: tas2770: Fix unbalanced calls to pm_runtime
      commit: d3d71c99b541040da198f43da3bbd85d8e9598cb
[3/5] ASoC: tas2770: Convert bit mask to GENMASK in header
      commit: ec9377dca2ca77eaf4fbdb09ac803f379b10d731
[4/5] ASoC: tas2770: Fix the spacing and new lines
      commit: d3964aff7331cd9695d0c18655e053b08837ff78
[5/5] ASoC: tas2770: Refactor sample rate function
      commit: be05ab41c61858cce557a1fe863ed00f38e31e97

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
