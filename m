Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1B38279263
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 22:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbgIYUmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 16:42:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:50374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbgIYUmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 16:42:32 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 138FA20838;
        Fri, 25 Sep 2020 20:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601066551;
        bh=uU0NF2rOcIq+EQc/Dwe/4Q/5HYbBlFEAQ1nalXduhRI=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=wuZNf9SASFoPRiPSlyCtDOULTeWVHwWnKANKW3p4AmPocFST10bjPRTFdJ9GqM1Jl
         FPqoKvPRp16q1fmTkDY5XLkfYPBbAeDzVjJLLjB+FbTJgv7mJiGVP+2QyKJh4qh7y/
         cDu7BXGfeFA2uP/OUSjRNCOk0b8pgJWI+/CGk/QM=
Date:   Fri, 25 Sep 2020 21:41:36 +0100
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, robh+dt@kernel.org, Dan Murphy <dmurphy@ti.com>,
        lgirdwood@gmail.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
In-Reply-To: <20200924142641.12355-1-dmurphy@ti.com>
References: <20200924142641.12355-1-dmurphy@ti.com>
Subject: Re: [PATCH] dt-bindings: tas2770: Mark ti,asi-format to deprecated
Message-Id: <160106647646.2866.8134090264099146979.b4-ty@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Sep 2020 09:26:41 -0500, Dan Murphy wrote:
> Mark the property ti,asi-format to deprecated as it is no longer
> supported.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] dt-bindings: tas2770: Mark ti,asi-format to deprecated
      commit: ff1d9ff43878de14b6ee4a089eb9f4a7e8f28a7f

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
