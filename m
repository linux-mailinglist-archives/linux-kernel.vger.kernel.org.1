Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7A4A230F41
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 18:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731368AbgG1Qa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 12:30:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:46550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731070AbgG1Qa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 12:30:56 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AB31207F5;
        Tue, 28 Jul 2020 16:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595953856;
        bh=fu8BQVTYRHqSDmcTdXV9xFLRNxBetsC48Rb8C5QDh1I=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=1YLaHe372Df4C+OmkxB5LvO5WUv8a1r0Fc2ygts+NDilE1mBLB0Qa2mew3erHtD/a
         znZjKHMvBz8onC8sp0PX72hzzzT09WCgvyw9UYf4RQYPUOa4m3UsPF0dh3LwDrMd7g
         lzVZ14g6bA1GRiI9uEyt97Yskg9kGXN5f+tefu6k=
Date:   Tue, 28 Jul 2020 17:30:37 +0100
From:   Mark Brown <broonie@kernel.org>
To:     robh@kernel.org, perex@perex.cz, Dan Murphy <dmurphy@ti.com>,
        lgirdwood@gmail.com, tiwai@suse.com
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org
In-Reply-To: <20200723160838.9738-1-dmurphy@ti.com>
References: <20200723160838.9738-1-dmurphy@ti.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: tas2562: Convert the tas2562 binding to yaml
Message-Id: <159595383113.15027.14495128108452214806.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jul 2020 11:08:37 -0500, Dan Murphy wrote:
> Convert the TAS2562 text file to yaml format.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: tas2562: Convert the tas2562 binding to yaml
      commit: e35cf9f5edb18fd9daf1c6ba7a89f463334526c4
[2/2] ASoC: tas2562: Update shutdown GPIO property
      commit: f78a97003b8babb1c49e2e4a6b46f15ac31ecf49

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
