Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2522A83CD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 17:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731391AbgKEQpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 11:45:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:48330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730504AbgKEQpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 11:45:39 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8747A2080D;
        Thu,  5 Nov 2020 16:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604594739;
        bh=1RsXmYB4zCj2jaeADbfq59xOu2k8CzrD8CU1zJns5Ns=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=MLhqhGWkfnNlnY+Z8zzA1y2bzWmyu1mhidmsGBJGklbZ+cKftwN7eSvqPEuMpnF/O
         fjMkwh+1jgbrjLe2znUd1EBmSwFA3mJPvAMDeANBzPDckSLp+JTAUgfBZ/S53Bqebn
         xOq9V6y8L5GeUZ3EUwwEQDtuKA5c+7y1qoRvAcNc=
Date:   Thu, 05 Nov 2020 16:45:27 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20201105124747.18383-1-sudipm.mukherjee@gmail.com>
References: <20201105124747.18383-1-sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH] ASoC: mediatek: mt8192: Fix build failure
Message-Id: <160459472200.54851.16651455731881675062.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Nov 2020 12:47:47 +0000, Sudip Mukherjee wrote:
> A build of arm64 allmodconfig with next-20201105 fails with the error:
> ERROR: modpost: "mt8192_afe_gpio_request" undefined!
> ERROR: modpost: "mt8192_afe_gpio_init" undefined!
> 
> Export the symbols so that mt8192-mt6359-rt1015-rt5682.ko finds it.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8192: Fix build failure
      commit: 8bfe8c967546dc05385b52bac49ad972fea5887c

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
