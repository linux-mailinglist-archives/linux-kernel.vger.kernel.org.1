Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02D99230F3F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 18:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731318AbgG1Qat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 12:30:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:46370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731070AbgG1Qat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 12:30:49 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62FCD2074F;
        Tue, 28 Jul 2020 16:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595953848;
        bh=QH/fNpriLdWfgqzqml0LW6l6Cmgll/uf1nxBcMvnPWc=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=Sypy9P7CThuG/PVUmHOtNiWyyBtkreQbISYFIhWCpycCFVMaVPwsc0h6ZsNglEMiQ
         59R+yIvDg3i3ReGH2Vr8W4TYXvMRyCfwzRCMSOfBlybDtl+e7B3/zVQe9oVhQ52foV
         7FwVZCT3nNCAvN2bNSn9uQoHxnYW8ckN1Bna32ps=
Date:   Tue, 28 Jul 2020 17:30:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     robh@kernel.org, perex@perex.cz, Dan Murphy <dmurphy@ti.com>,
        lgirdwood@gmail.com, tiwai@suse.com
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20200612171412.25423-1-dmurphy@ti.com>
References: <20200612171412.25423-1-dmurphy@ti.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: tas2562: Convert the tas2562 binding to yaml
Message-Id: <159595383112.15027.8364475369374911747.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jun 2020 12:14:11 -0500, Dan Murphy wrote:
> Convert the TAS2562 text file to yaml format.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] dt-bindings: tas2562: Convert the tas2562 binding to yaml
      (no commit info)
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
