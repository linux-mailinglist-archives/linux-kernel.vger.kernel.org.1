Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4CCB2A4E13
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 19:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbgKCSOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 13:14:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:37934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbgKCSOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 13:14:50 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E38A20757;
        Tue,  3 Nov 2020 18:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604427289;
        bh=ALXzQE2fcGXC/HZ3VGTSEZUD0TE16Sre/6edOvYV9CY=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=rNG+8niD3W31+DSXl54KO3V0sGuMehX8Rn86Vtcox28BxFJugzqf9sEZDl8xj/0Rk
         lqOtoY9LKHtsSWLozHW2sS/1n3MrE7fpVkRi5x+dKL9uXscDa6tZGYKgp3nWbriARc
         uaEquhkiu6OG2xHPrsjeMi4p5Mb89MeM3hG5vlVs=
Date:   Tue, 03 Nov 2020 18:14:40 +0000
From:   Mark Brown <broonie@kernel.org>
To:     perex@perex.cz, steven.eckhoff.opensource@gmail.com,
        "trix@redhat.com" <trix@redhat.com>, lgirdwood@gmail.com,
        tiwai@suse.com
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
In-Reply-To: <20201101171742.2304458-1-trix@redhat.com>
References: <20201101171742.2304458-1-trix@redhat.com>
Subject: Re: [PATCH] ASoC: TSCS454: remove unneeded semicolon
Message-Id: <160442726961.14840.4470080067281230825.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Nov 2020 09:17:42 -0800, trix@redhat.com wrote:
> A semicolon is not needed after a switch statement.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: TSCS454: remove unneeded semicolon
      commit: 99503469bdb54868fc9566480f1897c85dddd256

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
