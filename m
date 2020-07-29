Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17E08231F9E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jul 2020 15:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgG2Nwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jul 2020 09:52:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:52270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbgG2Nwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 09:52:31 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE98F22D2C;
        Wed, 29 Jul 2020 13:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596030751;
        bh=CiATFAX2ENWtL7XGl9y/KMHm4CWjbPuuZ50kAWq9B10=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=UDJLImNE4Xj/OlhPe4563hYtrS8TlH+R8bnJLI4807Xs7LrHfNCLwyCVpUldjJtq2
         M/mTkvncT4sultxlZnB9PX6ZGV2LXR59QEjxhKDUb0/ANLT13Odivzt6Rht4dOqTz/
         3F3jpc8J1T80+YrZWDK8cuXG18jtccFiWAL7OFXo=
Date:   Wed, 29 Jul 2020 14:52:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
In-Reply-To: <20200728164339.16841-1-dmurphy@ti.com>
References: <20200728164339.16841-1-dmurphy@ti.com>
Subject: Re: [PATCH] ASoC: tlv320adcx140: Fix various style errors and warnings
Message-Id: <159603073223.46331.3803625262961660773.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jul 2020 11:43:39 -0500, Dan Murphy wrote:
> Fix white space issues and remove else case where it was not needed.
> Convert "static const char *" to "static const char * const"

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tlv320adcx140: Fix various style errors and warnings
      commit: e5448d7ec656e6c5ed59f4adfc979742fd1f9b07

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
