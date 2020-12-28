Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7F5D2E65EE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 17:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633013AbgL1QHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 11:07:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:50948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2632999AbgL1QHY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 11:07:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BC06820719;
        Mon, 28 Dec 2020 16:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609171603;
        bh=2oLXmg6ZIwbx9eqtsFZM89qawNb6c+iz5KCVUIu01QA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=iSsbvISm7je79fraVplJB5Pf4mzovl3cO8ij4QnR6ytpLrbRY+Fo0LYniIeaOcPIp
         gQd58RQm9jMIQ84YHbq5U7FJ3SpPAuvJp8F7F4NAOy3ePGkh2jkUcV5unE+ibfKpKm
         Yb7zaqM/OYag68Bx3N8yM1LDsMUFoOy3pQe4iPJpmB/USJceDEk4Fuw0Rn7I3niXui
         XX2LXKs9Gb/tnpvahFQTrkDCk67XXHku4m4Y3Iz/AaZhHQ5XGFPKOGMfJdb3m7qyZn
         vqfGs+62ljW1AHeMugBm7BwowZOYF9+1tuZBVEDS1LcGoA/+NSQ1vGxdqJ0KW0R0xh
         iH2vlibv+1TZA==
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com
In-Reply-To: <20201216112512.26503-1-rf@opensource.cirrus.com>
References: <20201216112512.26503-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: wm_adsp: Improve handling of raw byte streams
Message-Id: <160917143257.51553.714728097367902102.b4-ty@kernel.org>
Date:   Mon, 28 Dec 2020 16:03:52 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Dec 2020 11:25:12 +0000, Richard Fitzgerald wrote:
> As the register map is 16-bit or 32-bit big-endian, the 24-bit
> DSP words appear padded and with the bytes swapped. When reading a
> raw stream of bytes, the pad bytes must be removed and the data bytes
> swapped back to their original order.
> 
> The previous implementation of this assumed that the be32_to_cpu() in
> wm_adsp_read_data_block() would swap back to little-endian. But this is
> obviously only true on a little-endian CPU. It also made two walks
> through the data, once to endian-swap and again to strip the pad bytes.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: wm_adsp: Improve handling of raw byte streams
      commit: 7726e49837af634accaec317c8d246d1d90d8fc5

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
