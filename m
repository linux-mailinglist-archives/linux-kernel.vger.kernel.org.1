Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A73961DBAF9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 19:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgETRR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 13:17:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:34292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726697AbgETRR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 13:17:29 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0C012070A;
        Wed, 20 May 2020 17:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589995049;
        bh=d6NUyvFYDGWHlPsgpU3+zYL6kUQaKN3WtOd9D+KS4FU=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=Z7+gLnU7t0PfSj2/QUatQMAgakFvatLNxaUljXpUIfMCA1rXbzsqYcvUigSKns8p/
         JzCYBlWIM63cMzWFOxKdeMoWCnPcipkwVnuMCQWVkesdTc0xUVv+qlXYZbAGZJwnFb
         y0SOc1VZEdM7YRJ4Vm7uspcWh2tYH43T1n4TsUIU=
Date:   Wed, 20 May 2020 18:17:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        mazziesaccount@gmail.com
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        SebastianReichel <sre@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
In-Reply-To: <cover.1589866137.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1589866137.git.matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [PATCH 0/2] MAINTAINER entries for few ROHM power devices
Message-Id: <158999504664.5040.1190675211101208032.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 May 2020 09:10:22 +0300, Matti Vaittinen wrote:
> Add maintainer entries to a few ROHM devices and Linear Ranges
> 
> Linear Ranges helpers were refactored out of regulator core to lib so
> that other drivers could utilize them too. (I guess power/supply drivers
> and possibly clk drivers can benefit from them). As regulators is
> currently the main user it makes sense the changes to linear_ranges go
> through Mark's tree.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] MAINTAINERS: Add maintainer entry for linear ranges helper
      commit: 7e73861eb40d591a98628592c6f0182fbf2f6c4d

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
