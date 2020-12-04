Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 123FE2CF790
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 00:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730995AbgLDXbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 18:31:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:42276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730986AbgLDXbu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 18:31:50 -0500
From:   Mark Brown <broonie@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Adam Ward <Adam.Ward.opensource@diasemi.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
In-Reply-To: <20201204165229.3754763-1-arnd@kernel.org>
References: <20201204165229.3754763-1-arnd@kernel.org>
Subject: Re: [PATCH] regulator: da9121: include linux/gpio/consumer.h
Message-Id: <160712467175.7793.586955639326816020.b4-ty@kernel.org>
Date:   Fri, 04 Dec 2020 23:31:11 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Dec 2020 17:52:22 +0100, Arnd Bergmann wrote:
> When CONFIG_GPIOLIB is disabled, the declarations from linux/gpio/consumer.h
> are not visible:
> 
> drivers/regulator/da9121-regulator.c:371:14: error: implicit declaration of function 'fwnode_gpiod_get_index' [-Werror,-Wimplicit-function-declaration]
>         ena_gpiod = fwnode_gpiod_get_index(of_fwnode_handle(np), "enable", 0,
>                     ^
> drivers/regulator/da9121-regulator.c:372:7: error: use of undeclared identifier 'GPIOD_OUT_HIGH'
>                                                 GPIOD_OUT_HIGH |
>                                                 ^
> drivers/regulator/da9121-regulator.c:373:7: error: use of undeclared identifier 'GPIOD_FLAGS_BIT_NONEXCLUSIVE'
>                                                 GPIOD_FLAGS_BIT_NONEXCLUSIVE,
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: da9121: include linux/gpio/consumer.h
      commit: b4b277760a2167ddb28a309b81363889efd5cc22

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
