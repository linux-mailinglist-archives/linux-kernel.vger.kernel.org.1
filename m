Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2138287E6D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 00:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729730AbgJHWBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 18:01:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:53860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbgJHWBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 18:01:48 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C60322243;
        Thu,  8 Oct 2020 22:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602194508;
        bh=SJbewqLgKiH7DipcMNarxqI5TH6mS3oztln4+Iqn+hg=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=dgWdQjdSQu3eVskKMJFenWXb3VUi+tT38flhllaqOcKoiRlLfzP/eP0Prb9aN+INo
         a+yBriZcWNM0dPXFJ9PE/1msxo9BVGiFuOTzPHG24cxROHrVcLaIJLfs006k3NYDYt
         Enp+AGy1NN9xigJ3u7fscCaJ1HifO8vTZOAkSkrk=
Date:   Thu, 08 Oct 2020 23:01:45 +0100
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, lgirdwood@gmail.com, Dan Murphy <dmurphy@ti.com>,
        robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org
In-Reply-To: <20201006172341.16423-1-dmurphy@ti.com>
References: <20201006172341.16423-1-dmurphy@ti.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: tas2764: Add the TAS2764 binding doc
Message-Id: <160219448331.29664.11194939509733491326.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Oct 2020 12:23:40 -0500, Dan Murphy wrote:
> Add the binding for the TAS2764 Smart Amplifier.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] dt-bindings: tas2764: Add the TAS2764 binding doc
      commit: 696bef70438359c1be333b62b2d879953768450d
[2/2] ASoC: tas2764: Add the driver for the TAS2764
      commit: 827ed8a0fa50bdd365c9f4c9f6ef561ca7032e49

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
