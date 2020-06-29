Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8D1A20E7C7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jun 2020 00:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391731AbgF2WAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jun 2020 18:00:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:56782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726382AbgF2SfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:35:24 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D89642547B;
        Mon, 29 Jun 2020 18:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593454530;
        bh=fh6z+o2kX3OCDHFVklxd+omRgVFgEg9o+2UO27yW1rE=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=OGYHtyoPO/82nwg53+O+RHGwr9XZ8dGoMgQtgMZQrt1ZrXAGDSrLYKkE1/s++Tk9C
         XKmHBlKA6L4zRT0W78uqbgS7xCw/FmHuX7lBWDxkt+r0+3sQzQa7rsqWXAf1IBeNYR
         knebfWFkqMTdtDh7JtbX/A5ciFyCbo7wTODtr3tY=
Date:   Mon, 29 Jun 2020 19:15:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Seth Forshee <seth.forshee@canonical.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     kernel-janitors@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Support Opensource <support.opensource@diasemi.com>,
        linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>
In-Reply-To: <20200628180229.5068-1-lukas.bulwahn@gmail.com>
References: <20200628180229.5068-1-lukas.bulwahn@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: remove obsolete entry after file renaming
Message-Id: <159345452820.54333.17324184729359258423.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Jun 2020 20:02:29 +0200, Lukas Bulwahn wrote:
> Commit f16861b12fa0 ("regulator: rename da903x to da903x-regulator") missed
> to adjust the DIALOG SEMICONDUCTOR DRIVERS section in MAINTAINERS.
> 
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains:
> 
>   warning: no file matches    F:    drivers/regulator/da903x.c
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] MAINTAINERS: remove obsolete entry after file renaming
      commit: 412847fb47336c58885ac6231a5f34ac7ac862a0

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
