Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4348D27B561
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 21:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgI1Tg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 15:36:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:36608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726590AbgI1TgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 15:36:25 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0425D20773;
        Mon, 28 Sep 2020 19:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601321785;
        bh=ZlH4z7EsnyADXXqZd0kdjXfIQHbGbd1ZAYlzGj5ytSo=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=JuTeujpmd3nhQWB6sm4+hFZjq4WUiG4as4efhaOHUGhy8muY6W47wI8zcOa3jFGFy
         IvkONTbd5CmrZVcoRuaLeUEYafkNz6r9gBVM5MBr8jTpSuddBBfQRdz0zyYE4oVTyO
         RMLJEdWyHB2lBensI3jovReNGy2cpBd0mGkHBjRo=
Date:   Mon, 28 Sep 2020 20:35:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20200928120614.23172-1-brgl@bgdev.pl>
References: <20200928120614.23172-1-brgl@bgdev.pl>
Subject: Re: [PATCH] regmap: destroy mutex (if used) in regmap_exit()
Message-Id: <160132172369.55460.16149724356043449310.b4-ty@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Sep 2020 14:06:14 +0200, Bartosz Golaszewski wrote:
> While not destroying mutexes doesn't lead to memory leaks, it's still
> the correct thing to do for mutex debugging accounting.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: destroy mutex (if used) in regmap_exit()
      commit: f74d63b8c24ad90ee56b5723b72feb0d1f894177

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
