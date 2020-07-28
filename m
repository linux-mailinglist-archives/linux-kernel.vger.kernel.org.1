Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47241230F48
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 18:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731417AbgG1Qb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 12:31:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:46934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731070AbgG1QbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 12:31:24 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFFC920825;
        Tue, 28 Jul 2020 16:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595953883;
        bh=PYdkKnxxcQFMv3YJQCfo1uY3iy0vMXSKSgcJLUonuwA=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=yv/UdIWHabVmupxBbnxvN2V/4hviSAwkU0frmQc0+sBWuMreFl7R+3jQ2neFgXLsI
         ghQfM2OzTMLrgzTNmIKO39WIsHG2gLQ4vd35oVPnHcdpaI6x7QIQvdXXiAnmkVGtH2
         EcbhCqFDxiTdmEy5dppbKv2Iq8ICfyInr7ftgGmY=
Date:   Tue, 28 Jul 2020 17:31:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org
In-Reply-To: <20200724155933.1040501-1-katsuhiro@katsuster.net>
References: <20200724155933.1040501-1-katsuhiro@katsuster.net>
Subject: Re: [PATCH v2] dt-bindings: sound: convert Everest ES8316 binding to yaml
Message-Id: <159595383113.15027.17968086750577561184.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Jul 2020 00:59:33 +0900, Katsuhiro Suzuki wrote:
> This patch converts Everest Semiconductor ES8316 low power audio
> CODEC binding to DT schema.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: convert Everest ES8316 binding to yaml
      commit: 92e67a9c4f206dc9c859c405e67448a8be59ac5d

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
