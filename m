Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B01326E4C6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 20:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgIQS5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 14:57:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:58440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726607AbgIQS5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 14:57:44 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC5B3206A1;
        Thu, 17 Sep 2020 18:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600369064;
        bh=SJN4xfUdkl7bi48FKRfNPPAsTv9Fk8jme/sg3RpIUiI=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=xZiC/FkGQ0IWa40HGPG6OTJ68weDC26g+OAq/cpzzemPVP5Sdmya55zK6KGh1plmO
         VOFswtms6tVavILDSklQIXy4GxHQshtKaI32zl4jzteOyI/cDbVdzKrPXEisBwv3td
         BvkyJF8ttDOFDWWynnKVUhGDXof61/P8A97Uwk4U=
Date:   Thu, 17 Sep 2020 19:56:54 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>
In-Reply-To: <20200902133043.19504-1-matthias.schiffer@ew.tq-group.com>
References: <20200902133043.19504-1-matthias.schiffer@ew.tq-group.com>
Subject: Re: [PATCH 1/2] ASoC: codec: tlv320aic32x4: fix missing aic32x4_disable_regulators() in error path
Message-Id: <160036900935.20113.2391843531663465832.b4-ty@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Sep 2020 15:30:42 +0200, Matthias Schiffer wrote:
> The regulators need to be disabled in the aic32x4_register_clocks()
> failure case as well.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: codec: tlv320aic32x4: fix missing aic32x4_disable_regulators() in error path
      commit: 251e5c8694db01cd10828e39c07f90d958d7b303
[2/2] ASoC: codec: tlv320aic32x4: do software reset before clock registration
      commit: df44bc16e616809172cda90fd816596ded4ea219

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
