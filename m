Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 503E4273703
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 02:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbgIVAGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 20:06:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:39916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726537AbgIVAGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 20:06:31 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7682221789;
        Tue, 22 Sep 2020 00:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600733191;
        bh=s5dUcarZmio2YYfXTULqBJzhaIWKGjOQf2x0nvA/GrI=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=eMNPJ/4BEuU24Kodl56/I1E0z3XmHRRU8GA0fCjT8AWiyZUGD9/DtDTTaUfVFHAkl
         oSsahVRqMEERD9wEUKzVSGPrQcxqlyESpQsSKegBaBkanpaucXVc7yItj/CNbyv6Wi
         GxBdN0N6UdinMUkBcQR4KL8tugfYAMY+pud8Bdlc=
Date:   Tue, 22 Sep 2020 01:05:38 +0100
From:   Mark Brown <broonie@kernel.org>
To:     robh+dt@kernel.org, tiwai@suse.com, lgirdwood@gmail.com,
        Dan Murphy <dmurphy@ti.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20200918164320.11577-1-dmurphy@ti.com>
References: <20200918164320.11577-1-dmurphy@ti.com>
Subject: Re: [PATCH] dt-bindings: tas2770: Fix I2C addresses for the TAS2770
Message-Id: <160073312816.6173.10659050151011957467.b4-ty@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Sep 2020 11:43:20 -0500, Dan Murphy wrote:
> The I2C addresses listed in the yaml are not correct. The addresses can
> range from 0x41 through 0x48 based on register configurations. Fix the
> example and the description.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] dt-bindings: tas2770: Fix I2C addresses for the TAS2770
      commit: b23d9eb897a1209e4d741fd69e5490f1b5b9e7cf

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
