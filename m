Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C94D1D3772
	for <lists+linux-kernel@lfdr.de>; Thu, 14 May 2020 19:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbgENRFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 May 2020 13:05:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:35480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbgENRFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 13:05:37 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72C112065F;
        Thu, 14 May 2020 17:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589475937;
        bh=YW9wuTxuRvYF57tgugoM+Q4D773LEH8szJcXifA1DpU=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=VSFr/FWRfpW8XQKjLi8GnhOj6GcgNR7W+29Dzelr7M0k1jsiDgAk9uIOU4Pkp/Dp3
         fEYyM1iEqQ7k6I8TTt/jksD5k4X2P079gge+Dgp6Q4MD5NGSyFLZpgWXdwk9FHb5Kt
         VoLhw+BQcMLEWny2kTBy6kxBuljDquTHDq1RjzJ4=
Date:   Thu, 14 May 2020 18:05:34 +0100
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, lgirdwood@gmail.com, Dan Murphy <dmurphy@ti.com>,
        perex@perex.cz
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
In-Reply-To: <20200513200549.12213-1-dmurphy@ti.com>
References: <20200513200549.12213-1-dmurphy@ti.com>
Subject: Re: [PATCH v2 1/3] ASoC: tlv320adcx140: Add controls for PDM clk
Message-Id: <158947592846.11145.4394826289935781391.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 May 2020 15:05:47 -0500, Dan Murphy wrote:
> Add ALSA controls to configure the PDM clocks.
> The clocks need to be configurable to accommodate various microphones
> that use clocks for low power/low resolution modes to high power/high
> resolution modes.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.8

Thanks!

[1/3] ASoC: tlv320adcx140: Add controls for PDM clk
      commit: 7cfa610205d95357f9eface292dc70fce7571f65
[2/3] ASoC: tlv320adcx140: Add device tree property for PDM edges
      commit: 75b0adbb0806a141b0b5f074cd6bd58bb9870c0d
[3/3] ASoC: tlv320adcx140: Configure PDM sampling edge
      commit: 79fc48e41e39d7a98c5f8ae37f613d7ff9953c86

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
