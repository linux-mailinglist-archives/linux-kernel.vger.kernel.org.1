Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2317F20E511
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jun 2020 00:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730092AbgF2VcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jun 2020 17:32:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:60606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728718AbgF2SlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:41:10 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA1A6255C6;
        Mon, 29 Jun 2020 18:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593454514;
        bh=IBzxuR0hFcqeAgG2EU4dUDO26QpO4vvo3eIUQ7aMYKs=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=HhFbS7Xj84k5nI21HMV4EP97C8ujn6/pwl4GBB890EsnHh3ZXTOLzkKgzqeZl81WU
         Xijs/8HCFr6FhZk9osR4uMa+tVN+OsJjzUheuC352EhRUC14A0dbpu4dyacGK2brPJ
         ZP7SQkQ9NYQ3oZ7m0FAZXPHq8rzV3OnVtt3UpK/Q=
Date:   Mon, 29 Jun 2020 19:15:11 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>, Takashi Iwai <tiwai@suse.de>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        moderated for non-subscribers <alsa-devel@alsa-project.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <a9f59f30-8cf2-ea82-567c-1706fd64fe62@infradead.org>
References: <a9f59f30-8cf2-ea82-567c-1706fd64fe62@infradead.org>
Subject: Re: [PATCH -next] ASoC: Documentation: fix reference to renamed source file
Message-Id: <159345450675.54191.15555131185550091270.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Jun 2020 20:23:33 -0700, Randy Dunlap wrote:
> sound/soc/soc-io.c was merged into sound/soc/soc-component.c, so fixup
> the Documentation to use the updated file name.
> 
> Error: Cannot open file ../sound/soc/soc-io.c
> WARNING: kernel-doc '../scripts/kernel-doc -rst -enable-lineno ../sound/soc/soc-io.c' failed with return code 1

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Documentation: fix reference to renamed source file
      commit: 4946cd45ef665d99074796fdd8ce04ba37ce1bdf

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
