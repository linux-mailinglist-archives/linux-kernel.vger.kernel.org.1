Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C790299AF2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 00:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408102AbgJZXpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 19:45:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:41800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408071AbgJZXpo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 19:45:44 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E02C420872;
        Mon, 26 Oct 2020 23:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603755943;
        bh=yizclJtwFHsgpdbAeytsLNpgwGTh0czj9w5bj6puFao=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=HM/xoo0iHClbn3JNr7iBUB8MqDDL+S3IgGq4nMlUf5NisfoG+WdcI3CdUZKBkFTLW
         vj+Yue/oLQuqXpd9x3pvqu/Xlhytm1uOixd5CTmdsDFw6H1bnnuFJtIpKSiq918E62
         bpYGx+6MTtYDUlL6yIXNHJcizQe1K0Rx7S7LumfQ=
Date:   Mon, 26 Oct 2020 23:45:39 +0000
From:   Mark Brown <broonie@kernel.org>
To:     mark.rutland@arm.com, lgirdwood@gmail.com, robh@kernel.org,
        perex@perex.cz, tiwai@suse.com, alexandre.torgue@st.com,
        Olivier Moysan <olivier.moysan@st.com>
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        arnaud.pouliquen@st.com, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20201020155709.2621-1-olivier.moysan@st.com>
References: <20201020155709.2621-1-olivier.moysan@st.com>
Subject: Re: [PATCH v2 0/2] dt-bindings: stm32: convert audio dfsdm to json-schema
Message-Id: <160375592348.31132.11289357992457782423.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Oct 2020 17:57:07 +0200, Olivier Moysan wrote:
> Some audio properties documented in st,stm32-adfsdm.txt are already documented
> in Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml bindings.
> Move remaining properties from st,stm32-adfsdm.txt to st,stm32-dfsdm-adc.yaml,
> and remove st,stm32-adfsdm.txt.
> 
> Changes in v2:
> - Complete st,stm32-dfsdm-adc.yaml rather than converting st,stm32-adfsdm.txt
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] dt-bindings: stm32: dfsdm: update audio properties
      commit: f24fd10bea5961629f22e1da0f56e8c918bdb2da
[2/2] ASoC: dt-bindings: stm32: dfsdm: remove stm32-adfsdm.txt binding
      commit: ea8650730332ee3c707883a2de37756ea9122981

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
