Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA63264673
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 14:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730203AbgIJM72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 08:59:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:36040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730777AbgIJMwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 08:52:49 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 351E720C09;
        Thu, 10 Sep 2020 12:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599742343;
        bh=9KB16qa8g5UTcrA9KtTZtF7YLYI9dYOREEUfdrIPmMs=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=Z7DT/ye01xUUhaR1XSTIZ4ytI/pnBQsOyg6nWptrYe6Ox4sP+ZiCaery0N1X3OObd
         q4qPLqBtvbJNUppqH6ACZmsWYvAkJ1LS4eX3cBFyHIVSTJF1kh3U8d0FRwJuJCfb21
         nMSMlyZI/xtYjGEJxhlTuG2q/6UWC6b0v0syyfe8=
Date:   Thu, 10 Sep 2020 13:51:38 +0100
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>,
        matti.vaittinen@fi.rohmeurope.com, lgirdwood@gmail.com
Cc:     linux-power@fi.rohmeurope.com, linux-kernel@vger.kernel.org
In-Reply-To: <20200910034240.37268-1-yuehaibing@huawei.com>
References: <20200910034240.37268-1-yuehaibing@huawei.com>
Subject: Re: [PATCH -next] regulator: bd718x7: Make some variable static
Message-Id: <159974229313.39285.15320584146723145441.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Sep 2020 11:42:40 +0800, YueHaibing wrote:
> Fix sparse warnings:
> 
> drivers/regulator/bd718x7-regulator.c:576:28: warning: symbol 'bd71847_swcontrol_ops' was not declared. Should it be static?
> drivers/regulator/bd718x7-regulator.c:585:28: warning: symbol 'bd71847_hwcontrol_ops' was not declared. Should it be static?
> drivers/regulator/bd718x7-regulator.c:902:28: warning: symbol 'bd71837_swcontrol_ops' was not declared. Should it be static?
> drivers/regulator/bd718x7-regulator.c:913:28: warning: symbol 'bd71837_hwcontrol_ops' was not declared. Should it be static?

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: bd718x7: Make some variable static
      commit: 02f8eaab0cb644478c170237f354db32b718e5ff

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
