Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1BC127925F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 22:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbgIYUmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 16:42:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:50172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbgIYUmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 16:42:21 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8FC02086A;
        Fri, 25 Sep 2020 20:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601066541;
        bh=HonZv4hNRo+3wBNx9Gmw1MHWUnZgz2J0kg7+tpl7x6U=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=UKbEk/8rJ74U5rMYLVMWNTSrXYqlhZJucwj0Rl8k1vQ80+sTQcQsRb9A/G7G2Bra6
         Jy78NrSKv/cxswUeV5t28NOeYdZM9WX5AZjvtQm59h7KCnk7r+ibkQZUMJq1j5Yte5
         Yy33ex/GgewHTuOsCdEQ/Aw6hMI0uolqRp+duG7U=
Date:   Fri, 25 Sep 2020 21:41:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     robh+dt@kernel.org, Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org
In-Reply-To: <20200925105908.20640-1-rf@opensource.cirrus.com>
References: <20200925105908.20640-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH 1/3] ASoC: cs4234: Add dtschema binding document
Message-Id: <160106647647.2866.786430937655896288.b4-ty@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Sep 2020 11:59:06 +0100, Richard Fitzgerald wrote:
> Document the bindings for the CS4234 ASoC codec driver.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] MAINTAINERS: Update Cirrus Logic Codecs maintainers
      commit: 6bf28e8a05fda0547658fd51d0acc83dcac6c703

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
