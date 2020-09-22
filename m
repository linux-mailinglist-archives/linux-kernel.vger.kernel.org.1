Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC66D273701
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 02:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbgIVAGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 20:06:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:39650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726537AbgIVAGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 20:06:21 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36335207C4;
        Tue, 22 Sep 2020 00:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600733180;
        bh=puHOFQFO8c+3FJiXRCoOWFvOPzC6ktrPZjVmalHSDO8=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=sy0uzIp0fsyWHl12/CpfdGikWyMQ/W2aiRNDPTSxkMSV224v7u73vbtp7iLgSC2kE
         PxS9EvJ4jc5k7fKQafho5jlmRb5rWaLt2GD47PpisZ6DHy2wZdZE49vmNvIdWds04d
         ztyY9NWXiF/GepSCM2qdjcmMd5TCr+MX0EiQTWA4=
Date:   Tue, 22 Sep 2020 01:05:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     robh+dt@kernel.org, tiwai@suse.com, lgirdwood@gmail.com,
        Dan Murphy <dmurphy@ti.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20200921153820.18357-1-dmurphy@ti.com>
References: <20200921153820.18357-1-dmurphy@ti.com>
Subject: Re: [PATCH 1/2] dt-bindings: tas2562: Add the TAS2110 amplifier
Message-Id: <160073312817.6173.18247828257698591331.b4-ty@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Sep 2020 10:38:19 -0500, Dan Murphy wrote:
> Add the TAS2110 amplifier compatible.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] dt-bindings: tas2562: Add the TAS2110 amplifier
      commit: 9074a078435eb9c4e16862ec08faaf19aee6190f
[2/2] ASoC: tas2562: Add the TAS2110 class-D amplifier
      commit: 8adcdbe63aa7745ecd253b6dcf03cd2d30ece8f5

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
