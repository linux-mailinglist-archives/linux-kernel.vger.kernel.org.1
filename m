Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF662C8A07
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 17:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbgK3Q4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 11:56:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:34124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726505AbgK3Q4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 11:56:18 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F5B32067C;
        Mon, 30 Nov 2020 16:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606755337;
        bh=rBr8YtlXc+2AXACTkB4gNA9wQVJzRxTliFY7C0TWO3Y=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=1gCl4bVsz5iftTDm64p7k6IURVp2RgRve+bOgK/DBo4xevhr7NIzgXtej2qZQJfwM
         GPPYTBZhO5S0Q/XX6Z62Rxv4PP7SfbDXImKraW1l5ZSOaAhJXBobxuw2t7J+FUxJKr
         DJayfl8cMfhjddchVTvz2N1C3x1pkcluDlicuAGo=
Date:   Mon, 30 Nov 2020 16:55:09 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org
In-Reply-To: <20201104201209.907018-1-alexandre.belloni@bootlin.com>
References: <20201104201209.907018-1-alexandre.belloni@bootlin.com>
Subject: Re: [PATCH 1/2] dt-bindings: sound: adau1372: Add bindings documentation
Message-Id: <160675530954.30326.371904938338211202.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Nov 2020 21:12:08 +0100, Alexandre Belloni wrote:
> Add device tree binding documentation for Analog Devices ADAU1372.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: adau1372: Add bindings documentation
      commit: 32025c7c50c602a6c0bc3bef0e9a774003e2e7ae
[2/2] ASoC: Add ADAU1372 audio CODEC support
      commit: 6cd4c6459e47402ab90802eca61a18b231434053

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
