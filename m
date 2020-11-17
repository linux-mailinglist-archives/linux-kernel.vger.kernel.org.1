Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCA3E2B71B1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 23:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbgKQWiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 17:38:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:41342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728044AbgKQWiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 17:38:03 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91B3020715;
        Tue, 17 Nov 2020 22:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605652683;
        bh=xJ9Pd7l3GU/MkR4nj1eWuIVcIYyomVZnVKN9YEHBkVc=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=Bc4R7dxUzVahvleAMpXicdadc7Wg5xSUEkrMntGqA8v6GyvUQHPwYkgiwBpxJCESl
         DWkfNPYo71fveHES6NAUwr3Sxkwu+wvVu4KdH2sUSqmLPSpqpM3aXFNNnMSKqMasCf
         EAKiZbGVPSjnCVgis0N5nTvBc9jaVzZJnH5QpAoc=
Date:   Tue, 17 Nov 2020 22:37:43 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20201110174904.3413846-1-geert@linux-m68k.org>
References: <20201110174904.3413846-1-geert@linux-m68k.org>
Subject: Re: [PATCH] ASoC: Fix 7/8 spaces indentation in Kconfig
Message-Id: <160565265704.23689.7331273235338322880.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Nov 2020 18:49:04 +0100, Geert Uytterhoeven wrote:
> Some entries used 7 or 8 spaces instead if a single TAB.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Fix 7/8 spaces indentation in Kconfig
      commit: 5268e0bf7123c422892fec362f5be2bcae9bbb95

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
