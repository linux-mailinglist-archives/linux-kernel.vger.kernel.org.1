Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF8D1FA486
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 01:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgFOXlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 19:41:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:53664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725960AbgFOXlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 19:41:07 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32D46207D3;
        Mon, 15 Jun 2020 23:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592264466;
        bh=VGXtEY8OWog6D6i8nmaD+Vkxjr9FAlJzj627N7V72ho=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=0C7R+7R6WYfZpj/CC+40vi2c1BVl80ZVTCpEkr5F014UhV9fJaZtqlDtRJy8BIpG3
         n3J31NT78wT6u0CoP2GFhzkyMGnE81Zaw5m/RMkzZte3/NGsLs6bZb+OvXLpS4RN+G
         +MHCYiznSbag9R+dbK+qSNFBCC6BTPP8ewD4Azyk=
Date:   Tue, 16 Jun 2020 00:41:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20200615072313.11106-1-brgl@bgdev.pl>
References: <20200615072313.11106-1-brgl@bgdev.pl>
Subject: Re: [PATCH] regmap: convert all regmap_update_bits() and co. macros to static inlines
Message-Id: <159226446456.27625.1211990966951084710.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jun 2020 09:23:13 +0200, Bartosz Golaszewski wrote:
> There's no reason to have these as macros. Let's convert them all to
> static inlines for better readability and stronger typing.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: convert all regmap_update_bits() and co. macros to static inlines
      commit: 4b9e7edb5afc4e3c27d6623f5008bf53ae96cf1a

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
