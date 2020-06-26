Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 219FE20B446
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jun 2020 17:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbgFZPQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jun 2020 11:16:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:59528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbgFZPQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 11:16:40 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5765A20702;
        Fri, 26 Jun 2020 15:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593184599;
        bh=SHkQoBXRBLIPW/EiIB4pLILisGVHuTDU+mw6nCaSIkI=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=xtYj4JEdIw+GwLT+lwVdx4Jor6YNwWd93csB4u1/+gy+TWAzJvoRw/SnA55+u0PCT
         3UrOLq1rD2yl5NALTgX8VrlOzdWX66C4qHSoAlrpsdpKwvsSxEwJFV+PVD/CBp98mB
         4dVKU5qXt8mzcIWSmf8/nApPGq9r+cIDuGC622G0=
Date:   Fri, 26 Jun 2020 16:16:37 +0100
From:   Mark Brown <broonie@kernel.org>
To:     s.nawrocki@samsung.com, krzk@kernel.org, sbkim73@samsung.com,
        Masanari Iida <standby24x7@gmail.com>,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com
In-Reply-To: <20200626142958.253614-1-standby24x7@gmail.com>
References: <20200626142958.253614-1-standby24x7@gmail.com>
Subject: Re: [PATCH] ASoc:samsung: Fix a typo in Kconfig
Message-Id: <159318459767.2904.15476409336473301819.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jun 2020 23:29:58 +0900, Masanari Iida wrote:
> This patch fixes a spelling typo in samsung/Kconfig.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: samsung: Fix a typo in Kconfig
      commit: f6de798eca429881ac7938fc31d55b3739c6387f

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
