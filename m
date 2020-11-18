Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFB972B8625
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 22:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbgKRU7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 15:59:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:55362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727427AbgKRU7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 15:59:24 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A2882075B;
        Wed, 18 Nov 2020 20:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605733164;
        bh=DgN0ueKPhlpMnl248+5X9YV07WLhR3E+i+hScOY+X6Y=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=nP1wxYlM3ubihD8EhQ8o6vyWu9XK1ue1Kjlof6nAzW0M5rQo8q9k9ARfhPJvyV0vF
         kUH+yLL3EpuMEoq5pla8h6dCSxn4S+Zz6Z4GhgxfU89UzKWajT1Lb8riBrMyLIvdCh
         RtZjD8dWQis4uLZLrLjmNXa87C9AMhgo7XeVFnRA=
Date:   Wed, 18 Nov 2020 20:59:04 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Kyle Russell <bkylerussell@gmail.com>
Cc:     Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Daniel Mack <daniel@zonque.org>, linux-kernel@vger.kernel.org,
        Haojian Zhuang <haojian.zhuang@gmail.com>, lkundrak@v3.sk,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
In-Reply-To: <20201106145905.365903-1-bkylerussell@gmail.com>
References: <20201106145905.365903-1-bkylerussell@gmail.com>
Subject: Re: [PATCH] ASoC: mmp-sspa: clear transmit phase bit for non-stereo formats
Message-Id: <160573314460.46437.15997412834070266670.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Nov 2020 09:59:05 -0500, Kyle Russell wrote:
> The transmit phase register value is never cleared during hw params.
> So once hw params sets this bit to handle a two channel format, it
> remains configured for dual-phase, which is not desirable for mono
> playback.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mmp-sspa: clear transmit phase bit for non-stereo formats
      commit: b88b31f4fa0abcd698045362d4aefcddc50cba59

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
