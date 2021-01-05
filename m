Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5D352EAFAC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 17:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbhAEQIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 11:08:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:37734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728374AbhAEQIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 11:08:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7A55122C9E;
        Tue,  5 Jan 2021 16:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609862893;
        bh=swfUH3gag0V5GsZYXIrPTvkpjp51+xMC5RnldsGaBHE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=WUw2SreucnrbhyBqMBhNmJYCWgLvvuVzeDi5dO1Op0sPLqR/r8Z4d87CGgi7N0E6r
         QbEDUGKx7ihSR/JtLY+pSYHHcqdBC12ZerwSuFklsCifCsfhhST23DK+RCk1S12H6w
         BylyfWfrfRWNqVDI7i+a5fo92tzkEKOLgwmFzxTNEYwGKoZ70MNu0ZAetGVQwpEMa2
         eubdLuBscK8AjFhwOX3yPKFY3LORBZiEREuOMrR2u+RPYgdtkLmjdOjtbb80WJ4RoF
         cQ7pEB7iIFMqpQmN4tEHFNw2M49Hr0oIhjfx3fIyF7WRMAraCAFO5IQNhiU3qk/AqP
         mwpx7bVqJ8ChQ==
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        mazziesaccount@gmail.com
Cc:     linux-power@fi.rohmeurope.com, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210105130221.GA3438042@localhost.localdomain>
References: <20210105130221.GA3438042@localhost.localdomain>
Subject: Re: [PATCH] regulator: ROHM bd7xxxx: Do not depend on parent driver data
Message-Id: <160986286073.50149.3679177659912886124.b4-ty@kernel.org>
Date:   Tue, 05 Jan 2021 16:07:40 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jan 2021 15:02:21 +0200, Matti Vaittinen wrote:
> The ROHM PMIC regulator drivers only need the regmap pointer from
> the parent device. Regmap can be obtained via dev_get_regmap()
> so do not require parent to populate driver data for that.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: ROHM bd7xxxx: Do not depend on parent driver data
      commit: 3c14dbd4b8eea2da607b65fc9caf7aec91d6ccbf

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
