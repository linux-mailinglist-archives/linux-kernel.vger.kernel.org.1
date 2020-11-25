Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15C632C3F78
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 13:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgKYMAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 07:00:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:42246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726295AbgKYMAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 07:00:44 -0500
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net [92.233.91.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98A49206E0;
        Wed, 25 Nov 2020 12:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606305644;
        bh=KARyiXu/jCiIjiMGnFS9Ve6VJVHAOJGpFiYmksm8/HU=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=IcljVwU6wBrzXtXbo/M/0aMT+gsuCHUbsnOz0TWVExPEXCXOmr698jQzfmR4dz9xs
         NsccEKPUr0PJgf5+gO5TnlEMIuFpy9Gmyqwhr95t6brSqgpFo5GoirThCgpkgKhfAs
         sEpG5KAAyiBYPN1UEKsKd9jzbfWLSkQj+SzS8NHo=
Date:   Wed, 25 Nov 2020 12:00:19 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Andrei Stefanescu <andrei.stefanescu@microchip.com>,
        Michael Klein <michael@fossekall.de>,
        Support Opensource <support.opensource@diasemi.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     trivial@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20201124183730.2250690-1-michael@fossekall.de>
References: <20201124183730.2250690-1-michael@fossekall.de>
Subject: Re: [PATCH 0/2] Fix spelling of "regulator"
Message-Id: <160630561913.41405.12171704480755025355.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Nov 2020 19:37:28 +0100, Michael Klein wrote:
> Michael Klein (2):
>   Documentation: mcp16502-regulator: fix spelling mistake
>   mfd: fix spelling mistakes
> 
>  .../devicetree/bindings/regulator/mcp16502-regulator.txt      | 2 +-
>  drivers/regulator/da9055-regulator.c                          | 4 ++--
>  include/linux/mfd/da9055/reg.h                                | 4 ++--
>  include/linux/mfd/si476x-core.h                               | 2 +-
>  4 files changed, 6 insertions(+), 6 deletions(-)

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: mcp16502-regulator: fix spelling mistake
      commit: 33f369efbce15e034db4faabeec8502d7d236859

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
