Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 445E329EBFB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 13:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbgJ2MkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 08:40:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:52858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbgJ2MkQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 08:40:16 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77FE02076B;
        Thu, 29 Oct 2020 12:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603975216;
        bh=p/WnSlwE7z/dV6rJKMbN+kl2u1f/wqMUmU+0pa8n5Ns=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=aGU1uq5J9Y+zzUHke9T4g5YAV6jpi5m5gbJ+5bhp4p0Tzx1xkbk+oq3utZsoF6AnT
         BIvJ8aNL0ZEXLS/DD7q75cOVzjnk9llEWu4+8Za/HyGIzLawRQiMfGEbnQN/Dah+LM
         Wdhg+xxTLP3vucNaCg5P17DaLD8qI4jAwhtiZx8o=
Date:   Thu, 29 Oct 2020 12:40:09 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Patrick Lai <plai@codeaurora.org>,
        Colin King <colin.king@canonical.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        V Sujith Kumar Reddy <vsujithk@codeaurora.org>,
        Takashi Iwai <tiwai@suse.com>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Srinivasa Rao <srivasam@codeaurora.org>,
        alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20201028115112.109017-1-colin.king@canonical.com>
References: <20201028115112.109017-1-colin.king@canonical.com>
Subject: Re: [PATCH][next] ASoC: qcom: fix unsigned int bitwidth compared to less than zero
Message-Id: <160397520896.55401.11950538848257876856.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Oct 2020 11:51:12 +0000, Colin King wrote:
> The check for an error return from the call to snd_pcm_format_width
> is never true as the unsigned int bitwidth can never be less than
> zero. Fix this by making bitwidth an int.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qcom: fix unsigned int bitwidth compared to less than zero
      commit: bcc96dc3cf8048c80af7c487af17e19be27ac57d

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
