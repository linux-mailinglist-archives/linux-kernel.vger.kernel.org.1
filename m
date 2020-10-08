Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D104C287E6B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 00:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729544AbgJHWBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 18:01:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:53764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728746AbgJHWBn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 18:01:43 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0ED3422243;
        Thu,  8 Oct 2020 22:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602194502;
        bh=a9Ail/qdFEZX2JwtyGVuRlxv0Gv5RrrOtq42kRFg5Vw=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=ZItfGq8P3wb9cQh63ObzPaVust3eYOQJ4rSjDNC4BrQvfn1NTQwlnnMQ2WdtuhBiQ
         kT5vIU8nfEOUhh9CsOSymeYWW1MMLQwRVEfbNyPZpRS1sfYcr9qFRXggYnLp5zenSQ
         umBD1hs30+3bJKCfY1DZxO6DsqPPA3chZUlz0sxo=
Date:   Thu, 08 Oct 2020 23:01:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, lgirdwood@gmail.com, Dan Murphy <dmurphy@ti.com>,
        robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org
In-Reply-To: <20201007155341.10139-1-dmurphy@ti.com>
References: <20201007155341.10139-1-dmurphy@ti.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: tas2764: Add the TAS2764 binding doc
Message-Id: <160219448332.29664.500640476412734254.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Oct 2020 10:53:40 -0500, Dan Murphy wrote:
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
