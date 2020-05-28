Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7751E6197
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 15:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390124AbgE1NC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 09:02:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:55714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390108AbgE1NCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 09:02:24 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AA38207F5;
        Thu, 28 May 2020 13:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590670943;
        bh=Cc7Ez2FTnEVe9mVi0XRAGO+B55CjnD6FpLRvrlsoSi0=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=HwjvmpetjbwDwCZhm/gyi2wky783acBxHuHHtBg+4T0XeeqzP9cx11gl1G2oW7VNN
         9Njm0afft0CtUxKHf8hksNf5CcTVFwLzd7aE1c278stTLUuKohyEpRJJ/1ywnU6VTi
         zEN+YaByhAYaWFJjoiaSFBTkOwCHk9T4J0B/QdZo=
Date:   Thu, 28 May 2020 14:02:20 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>
In-Reply-To: <20200528102004.911653-1-hslester96@gmail.com>
References: <20200528102004.911653-1-hslester96@gmail.com>
Subject: Re: [PATCH] ASoC: sta32x: add missed function calls in error paths
Message-Id: <159067091850.53762.2058034425301081343.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 May 2020 18:20:04 +0800, Chuhong Yuan wrote:
> sta32x_probe() forgets to call undo functions when it fails, add
> the missed function calls to fix it.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: sta32x: add missed function calls in error paths
      commit: 8dc1011470315501914a4527276b7b93301f3d38

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
