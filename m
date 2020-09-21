Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50CA6272FAB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 18:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730164AbgIUQ7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 12:59:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:39636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728985AbgIUQ64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 12:58:56 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BB8420C09;
        Mon, 21 Sep 2020 16:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600707535;
        bh=+knWzm3xj2gskwUc9VYhgeLl1eQQ+hq8DGmvHZBEvB0=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=DR67VkjkH2w8LYQ91CjXT9tVvpO+pyX9G1WD4sFJ/5T2McpNoiwky20+SpLMX6Gsj
         Kv9I3eDtc0/QRK+Yr3NmiTW0pNy+HPzOECEQpPlfsmMfLolofmbWAK2ozffESGYl6Q
         oZWmtT2AwIrkUBmmIRWXCYr0XaJn6QQXLC6y6f6w=
Date:   Mon, 21 Sep 2020 17:58:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     devicetree@vger.kernel.org, lgirdwood@gmail.com, dmurphy@ti.com,
        Camel Guo <camel.guo@axis.com>, tiwai@suse.com,
        robh+dt@kernel.org
Cc:     kernel@axis.com, linux-kernel@vger.kernel.org,
        Camel Guo <camelg@axis.com>, alsa-devel@alsa-project.org
In-Reply-To: <20200916075949.28479-1-camel.guo@axis.com>
References: <20200916075949.28479-1-camel.guo@axis.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: tlv320adcx140: Add GPIO config and drive config
Message-Id: <160070745846.56122.15642862327141755501.b4-ty@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Sep 2020 09:59:48 +0200, Camel Guo wrote:
> Add properties for configuring the General Purpose Input Output (GPIO).
> There are 2 settings for GPIO, configuration and the output drive type.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] dt-bindings: tlv320adcx140: Add GPIO config and drive config
      commit: 15b3d324c8980022071710b5096b705eb6b74fca
[2/2] ASoC: tlv320adcx140: Add support for configuring GPIO pin
      commit: d5214321498a43558d9ffcce4153775c2c296bad

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
