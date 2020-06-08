Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 347FC1F1909
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jun 2020 14:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgFHMqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jun 2020 08:46:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:53978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728173AbgFHMqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 08:46:14 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 213622072F;
        Mon,  8 Jun 2020 12:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591620371;
        bh=FCAvqfmKFayKCxPdwRtAqVx7sG8HLE4jjh4Q6F84pqk=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=pvoyh0Wmbo79Pc12rA2pIrsB8hDaGNNVxeCDJUrDxMXEg53yWzsj/jpoCMVRQ/D+k
         iS4q0ZxJQwdYgnH5S5bPje7+IJARN2szNwFq7POidTzoZLNpDR/H7bW51LWAzgk6YT
         GT/iYSpw5umoi75sI57tbGb1OzSZk8hx6Qd8TspE=
Date:   Mon, 08 Jun 2020 13:46:09 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Colin King <colin.king@canonical.com>,
        linux-arm-kernel@lists.infradead.org,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-amlogic@lists.infradead.org, alsa-devel@alsa-project.org,
        Takashi Iwai <tiwai@suse.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <20200604171216.60043-1-colin.king@canonical.com>
References: <20200604171216.60043-1-colin.king@canonical.com>
Subject: Re: [PATCH] ASoC: meson: fix memory leak of links if allocation of ldata fails
Message-Id: <159162036934.23368.2440967052610831030.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jun 2020 18:12:16 +0100, Colin King wrote:
> Currently if the allocation of ldata fails the error return path
> does not kfree the allocated links object.  Fix this by adding
> an error exit return path that performs the necessary kfree'ing.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: meson: fix memory leak of links if allocation of ldata fails
      commit: 6e801dc411329aff592fbd48fb116183d0acdb00

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
