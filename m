Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD4ED2760B1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 21:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgIWTBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 15:01:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:44082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726419AbgIWTBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 15:01:19 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 429412145D;
        Wed, 23 Sep 2020 19:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600887678;
        bh=yiMx68etmYNKZYyK+lwpe3PrqKGSkAKVStfJBVS2MFs=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=yuL8j1rCswv7AO+0agMWAX+7z9Ua2xmPjLswafaSDkiNSzcmjN63c0gAXuD0s+Uoe
         iIJT2GmKxAy4APHXuSaSCK5KdR4B4L+FvrTMukAE3qvZ7Wr/9nTS3cFul1oSS+eklF
         sQLsyPzulSpH94s9r+Y4nKi6aTFBtxGkHs7O40eE=
Date:   Wed, 23 Sep 2020 20:00:24 +0100
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, lgirdwood@gmail.com, Dan Murphy <dmurphy@ti.com>,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
In-Reply-To: <20200923132600.10652-1-dmurphy@ti.com>
References: <20200923132600.10652-1-dmurphy@ti.com>
Subject: Re: [PATCH 1/6] dt-bindings: tas2770: Add shutdown gpio property
Message-Id: <160088761879.35939.9930139156490378021.b4-ty@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Sep 2020 08:25:55 -0500, Dan Murphy wrote:
> Add the shutdown-gpios property to the yaml to define the GPIO that can
> be used to place the device in shutdown mode or wake the device up.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] dt-bindings: tas2770: Add shutdown gpio property
      commit: 29d7b36ce98eb1bfba2c5c9b2ea0d58ff778a2d4
[2/5] ASoC: tas2770: Add shutdown capability via a GPIO
      commit: 5d0b9dfe0de26b8c4242145cbf7de3a5a2e98293
[3/5] ASoC: tas2770: Set regcache when shutting down and waking device
      commit: c0a30e2e07e35f219666788c8549156eb8d74105
[4/5] ASoC: tas2770: Remove ti,asi-format code
      commit: dd7d9052064b4bda94a89dbc1618927319602366
[5/5] ASoC: tas2770: Remove unused variables
      commit: 3121420cf9b4db7f2bafcdc0e562f60779bf365d

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
