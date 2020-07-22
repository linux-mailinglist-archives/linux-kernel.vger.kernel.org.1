Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E35D228D3F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jul 2020 02:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731449AbgGVA46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 20:56:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:59026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726468AbgGVA45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 20:56:57 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BE07206E3;
        Wed, 22 Jul 2020 00:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595379417;
        bh=oIp8NKER4ssGNhyEtqI9MFmD3glq88VorUyW/2P2XK0=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=vmcZPhK/xcJyGS+wVWbJRtb32pQVTCYgLS+yY3QzNYn/tvFAZvUypvwXEOF2E43G4
         nV/OamqlgkzLIijE3ME12HkyHq+Js000DCmyHKqb4JgSbKkxvXHh9TF3lEfV/0pyNg
         1cvlkWJqI+NOgu/fnyHv6Yj9UEP4rAFGruj31UZU=
Date:   Wed, 22 Jul 2020 01:56:44 +0100
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, perex@perex.cz, Dan Murphy <dmurphy@ti.com>,
        lgirdwood@gmail.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20200710145016.384-1-dmurphy@ti.com>
References: <20200710145016.384-1-dmurphy@ti.com>
Subject: Re: [PATCH for-next v2 1/2] ASoC: tas2770: Fix reset gpio property name
Message-Id: <159537940424.49432.4655713572634784064.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jul 2020 09:50:15 -0500, Dan Murphy wrote:
> Fix the reset property name when allocating the GPIO descriptor.
> The gpiod_get_optional appends either the -gpio or -gpios suffix to the
> name.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: tas2770: Fix reset gpio property name
      commit: 58b868f51d6e38146e44cb09fcd92b5fc35d83bc
[2/2] dt-bindings: tas2770: Convert tas2770 binding to yaml
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
