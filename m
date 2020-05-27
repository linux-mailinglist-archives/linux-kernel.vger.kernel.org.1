Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90D4E1E4696
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 16:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389437AbgE0O6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 10:58:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:53532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389411AbgE0O6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 10:58:07 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03D56207CB;
        Wed, 27 May 2020 14:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590591487;
        bh=u2lDoZzGDayxtcZjIvEEOU3TwyrSTCxS9YF+ccmxFgI=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=kmFYNI8vmreNjgNmLh7kzEKqFdOwBfTIO/weUhPifpJjOaXfr5hc9W0JU/97B7wfl
         4C4Um1kgnay0VTQKlDKaQw75Z0u//XA11up42fz+ZwR9syaSwEsDxU/ZgX6ZeOYaJh
         V6qoD4rJSSo1HSePBbm88Xjn8ioZWZuihv8ftsLk=
Date:   Wed, 27 May 2020 15:58:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, tiwai@suse.com, Dan Murphy <dmurphy@ti.com>,
        perex@perex.cz
Cc:     linux-kernel@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org
In-Reply-To: <20200526175247.15309-1-dmurphy@ti.com>
References: <20200526175247.15309-1-dmurphy@ti.com>
Subject: Re: [PATCH] ASoC: tlv320adcx140: Fix warnings when using W=1
Message-Id: <159059147354.50918.15790917523378380090.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 May 2020 12:52:47 -0500, Dan Murphy wrote:
> Fix the warnings when using the W=1 compiler flag.
> 
> sound/soc/codecs/tlv320adcx140.c: In function ‘adcx140_reset’:
> sound/soc/codecs/tlv320adcx140.c:570:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
>   570 |  int ret = 0;
>       |      ^~~
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tlv320adcx140: Fix warnings when using W=1
      commit: 850ba84b5c6d4ad4d1259584ebc0338eb769f2ef

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
