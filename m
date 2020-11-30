Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB782C8A12
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 17:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbgK3Q47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 11:56:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:34530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727223AbgK3Q47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 11:56:59 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5AF0207F7;
        Mon, 30 Nov 2020 16:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606755372;
        bh=Owh+NMLy2ycA/oQvRVxMscv0VBgPG/PP8zaRcMEq6bc=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=LfYf4Ia+eg8ecAw/DxKmw+CKyrCiTcAxxT4LN8QSvDkBfRp8T+316GqGeIukuxDIK
         1xxLdBUbpH6Q2pKB0QNk+3dATOk9L3RymLpuYZllo57M5E3FEtKHCBIimPH9FcOl+y
         dOq05qnz9C+kxhjH7drgTUusgWA5FukKKHUL+o/o=
Date:   Mon, 30 Nov 2020 16:55:44 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Troy Kisky <troy.kisky@boundarydevices.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20201130112329.104614-1-jagan@amarulasolutions.com>
References: <20201130112329.104614-1-jagan@amarulasolutions.com>
Subject: Re: [PATCH 1/2] dt-bindings: regulator: Add pf8x00 regulator bindings
Message-Id: <160675534436.30570.9224420558776004921.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Nov 2020 16:53:28 +0530, Jagan Teki wrote:
> Add NXP PF8100/PF8121A/PF8200 regulators bindings.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator: Add pf8x00 regulator bindings
      commit: 4b748fb3448b5d39a58cdea55d72e8dcd128f4c6
[2/2] regulator: Add NXP PF8X00 regulator driver
      commit: d3795d6321ecaa55d94dc24c3b1e3cce608aabd6

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
