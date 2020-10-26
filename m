Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 304E6299AF0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 00:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408082AbgJZXpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 19:45:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:41620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408071AbgJZXpi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 19:45:38 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4A1820809;
        Mon, 26 Oct 2020 23:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603755938;
        bh=k1zrWp9O22qh+WuKS8rpiY1h0T+j/FYSrPVkMy4dspw=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=myP7uDKxoFHaZTQufI/w7gt5mGhd5IKADw2XCX+IEerj7nZ6LmVRP0QYc5oOU89nl
         hL998deP4S1ZUAOpVX/yhkmvkFqwBtcfD7Y035+MLEvDZRXceuggABVPKLXMSJYZx5
         Ijh8i+fMGeqmfavLlPxtAugRsKSgYgaG81pLgsOk=
Date:   Mon, 26 Oct 2020 23:45:33 +0000
From:   Mark Brown <broonie@kernel.org>
To:     mark.rutland@arm.com, lgirdwood@gmail.com, robh@kernel.org,
        perex@perex.cz, tiwai@suse.com, alexandre.torgue@st.com,
        Olivier Moysan <olivier.moysan@st.com>
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        arnaud.pouliquen@st.com, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20201009141051.27365-1-olivier.moysan@st.com>
References: <20201009141051.27365-1-olivier.moysan@st.com>
Subject: Re: [PATCH v4] ASoC: dt-bindings: stm32: convert sai to json-schema
Message-Id: <160375592347.31132.11608590385209657603.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Oct 2020 16:10:51 +0200, Olivier Moysan wrote:
> Convert the STM32 SAI bindings to DT schema format using json-schema.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: stm32: convert sai to json-schema
      commit: 49491418c1dceb11ccb2ab841e4e5590e844378c

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
