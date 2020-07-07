Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B450D216E86
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 16:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbgGGORk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 10:17:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:52060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727090AbgGGORj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 10:17:39 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C28220771;
        Tue,  7 Jul 2020 14:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594131459;
        bh=TK5Cmeh9M/MUfKwtkEO+yW3fxeLeyY7PEeljzDxg6Ss=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=S9GITpcSEv1WJqH3IKUE+Ppu4DyA6YBHZG1krJj2NErR/mlM0kb8OXdjllSTmX+WB
         30TKI4qU9XgipwupbpksKfiQpKe8Y9RgZvh0ooOYlIRiuAtBlBwO2ccRvty9Ew0zbS
         jFz8/dT3SqtISBb0Wxp4w2LJLW7ANSCuFjGXP1sg=
Date:   Tue, 07 Jul 2020 15:17:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     timur@tabi.org, shengjiu.wang@nxp.com,
        linux-kernel@vger.kernel.org, festevam@gmail.com,
        Xiubo.Lee@gmail.com, shengjiu.wang@gmail.com,
        linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org
In-Reply-To: <20200707045829.10002-1-nicoleotsuka@gmail.com>
References: <20200707045829.10002-1-nicoleotsuka@gmail.com>
Subject: Re: [PATCH v2] MAINTAINERS: Add Shengjiu to reviewer list of sound/soc/fsl
Message-Id: <159413142466.34737.3295058697996171604.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jul 2020 21:58:29 -0700, Nicolin Chen wrote:
> Add Shengjiu who's actively working on the latest fsl/nxp audio drivers.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] MAINTAINERS: Add Shengjiu to reviewer list of sound/soc/fsl
      commit: 503ed52225ed3d369c8e0dedf13556a7bc1e5c2b

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
