Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 319D52E6688
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 17:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633054AbgL1QOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 11:14:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:54324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394270AbgL1QOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 11:14:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 13F7E2084D;
        Mon, 28 Dec 2020 16:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609172001;
        bh=ITfs0W/+RpXTKRzJEvABqjsZfGEPs/V/z9bip7jFNo4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=d1V40PzHeYxxfXzjxWxCzHwYJE/Ad5XkchDbhQVuLAWHfe4rQm0aDo5d7Jg2HZLqO
         uzfDnBAlu7LrI1gOh2yJca4caskyNzU8hNQHt3IjD0FxNdxNYK+Oflvpc6XxuJAA7X
         vh+ywvK9BSYIXn6d9SeVYuvQfKN6HTvvTWBOAkaKbGPJW+wiSwzNLwV3el35VsPfbB
         PY5AAH96HhK7npELSbEXC7W9uJRRWf3pnoJ6GPqXZ7at4l3/GaIXJQNXdpWM8K3GvX
         HAWU7lwJ57nIOIIhub3zETK/XAOTpcSrjCUI8rclVKXMs2kpi2BtEs18bBcI4h8Z9H
         BeHO/RTroOa2Q==
From:   Mark Brown <broonie@kernel.org>
To:     Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Takashi Iwai <tiwai@suse.com>, Alexander.Deucher@amd.com,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
In-Reply-To: <20201222115929.11222-1-Vishnuvardhanrao.Ravulapati@amd.com>
References: <20201222115929.11222-1-Vishnuvardhanrao.Ravulapati@amd.com>
Subject: Re: [PATCH] ASoC: amd:Replacing MSI with Legacy IRQ model
Message-Id: <160917197014.51862.14166013678155131576.b4-ty@kernel.org>
Date:   Mon, 28 Dec 2020 16:12:50 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Dec 2020 17:29:18 +0530, Ravulapati Vishnu vardhan rao wrote:
> When we try to play and capture simultaneously we see that
> interrupts are genrated but our handler is not being acknowledged,
> After investigating further more in detail on this issue we found
> that IRQ delivery via MSI from the ACP IP is unreliable and so sometimes
> interrupt generated will not be acknowledged so MSI model shouldn't be used
> and using legacy IRQs will resolve interrupt handling issue.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd:Replacing MSI with Legacy IRQ model
      commit: a523e1538fdd5f00ea3289cc0b3c6c1785b89814

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
