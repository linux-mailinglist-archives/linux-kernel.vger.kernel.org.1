Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F39C24DB84
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 18:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbgHUQm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 12:42:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:55002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726956AbgHUQka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 12:40:30 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7ED4820738;
        Fri, 21 Aug 2020 16:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598028030;
        bh=eeD33E/GM5/WtGmv+bjQ9EqZZdzjh3+IGMJzdajAfKk=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=So0tK9r4QCjDNUgTZ/eg3qedxTbwmYbxb50oP3TgYxxRoEvV38q69vk0rsrwy/RBl
         sWtJzrkOI5yoyFlO37/Txe2OY/aQJz/54m/eJUqQla0YcV5WE0cNJBOMZ1ntjRM2On
         nVyCOpqof/gih7HGjjkqfAFg243X3YaGIr4UXFiM=
Date:   Fri, 21 Aug 2020 17:39:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20200821142259.C2ECE3FB96@swsrvapps-01.diasemi.com>
References: <20200821142259.C2ECE3FB96@swsrvapps-01.diasemi.com>
Subject: Re: [PATCH] ASoC: da7219: Fix I/O voltage range configuration during probe
Message-Id: <159802798182.25503.9768924803803430146.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Aug 2020 15:22:59 +0100, Adam Thomson wrote:
> Previous improvements around handling device and codec level
> probe functionality added the possibility of the voltage level
> being undefined for the scenario where the IO voltage retrieved
> from the regulator supply was below 1.2V, whereas previously the
> code defaulted to the 2.5V to 3.6V range in that case. This
> commit restores the default value to avoid this happening.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: da7219: Fix I/O voltage range configuration during probe
      commit: fcea8b023a5f06ea0180ae65b01520b0414ee325

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
