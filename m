Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBAB1B2EF4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 20:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729408AbgDUSW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Apr 2020 14:22:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:35122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgDUSW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 14:22:26 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AE19206D4;
        Tue, 21 Apr 2020 18:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587493346;
        bh=/DKz1eOspQ/TtOHTkmj/WSzVJ0L8WJx/bY+4YpFt/e4=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=W31p4oxEgxDdzTACrPMkpBUXysMOBpPy/An7oSX7Y0ERC1jp43TgoGUmNs6jtBowl
         b/iQ/wRimgI2fkXnZ9xX1AsXkS6+K7slRDBWI1g5tbZKctXSSGhVHWOGoxIZ0fkeHA
         MwMrYM+TxtxQg2VbFnZWxgTS7GZsrmVtK+iFwZUw=
Date:   Tue, 21 Apr 2020 19:22:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20200417221341.31428-1-TheSven73@gmail.com>
References: <20200417221341.31428-1-TheSven73@gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: sound: add Microsemi ZL38060 binding
Message-Id: <158749333763.13706.411241319032866689.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Apr 2020 18:13:40 -0400, Sven Van Asbroeck wrote:
> Add devicetree binding for the Microsemi ZL38060 Connected
> Home Audio Processor.
> 
> Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
> ---
> 
> Tree: v5.7-rc1
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.8

Thanks!

[1/2] dt-bindings: sound: add Microsemi ZL38060 binding
      commit: 19f303caf63693502cf34897ade76202afe5f445
[2/2] ASoC: Add initial ZL38060 driver
      commit: 52e8a94baf9026276fcdc9ff21a50dc2ca0bc94b

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
