Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7492A4E19
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 19:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbgKCSPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 13:15:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:38472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728379AbgKCSPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 13:15:24 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACDB722243;
        Tue,  3 Nov 2020 18:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604427324;
        bh=cT2jsvR/KFDX7a+p2qqIuBrqBmdcJ+7JnFLUCRs4E6Q=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=WsqqhoLgZSgFuHCiQYDWerF//l8URkKrrQxv/2CIQDzZvF5yDjPzzDlypfzu+tiK3
         ruyq7zyB4pLM0luOilIh1OUOtR4jsq2arbU/OJkCPVfGpw128W/oSioh8vOkJw532n
         1hPqwPGoUvDHjGHZ9ZS38R0OnJ/dRt/Vo7U/M0zk=
Date:   Tue, 03 Nov 2020 18:15:15 +0000
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, support.opensource@diasemi.com,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org, kernel@axis.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201103100021.19603-1-vincent.whitchurch@axis.com>
References: <20201103100021.19603-1-vincent.whitchurch@axis.com>
Subject: Re: [PATCH v2 0/2] DA9121 regulator support
Message-Id: <160442731509.14990.12967764099458293588.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Nov 2020 11:00:19 +0100, Vincent Whitchurch wrote:
> This series adds support for the DA9121, a "High-Performance, 10 A, Dual-Phase
> DC-DC Converter".  The datasheet is currently available here:
> 
>  https://www.dialog-semiconductor.com/sites/default/files/da9121_datasheet_2v3.pdf
> 
> v2:
> - Let the core get the constraints itself from a subnode in the device tree.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator: Add DA9121
      commit: 1119c59404141200125af31f775d3fbbba52c651
[2/2] regulator: Add support for DA9121 regulator
      commit: e6ff10f24c587c1af705b898761e5df615fb0e1a

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
