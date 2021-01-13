Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 306C42F4EB2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 16:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbhAMP3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 10:29:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:33642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbhAMP3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 10:29:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C2CD023383;
        Wed, 13 Jan 2021 15:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610551719;
        bh=hcGs1Tg0VufYsb/dAGJ/HYrAhRwx1KfX3wrMxZl1WmA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=r42+QDFRgzE7RTf3UN6N/mnFBikdAs7xXESJxilBqwFo1Tq//KMOIeDeZi1rbNyxb
         qXxyDoTlbb2ggr4s//FjgjbvqigzxNr5orUOMgAcUfdhooQJwVjU8YHc1EhEEOElFt
         KjAMQH3twqejNlU3M4+v7BouOLRRTbqNmGlfcM+4pggZc6BEojXQYmI7yuD2bMiBjG
         I+UgaT8lSFchxIoKMlR0PtbXwlrb99/7ZPSaT4WzE+y746bb9IhOD9TIwaC3ZadlkF
         XMjE3Iz4utMv3/n8iskq5yAV99CocLWxpCzk2twQwHTqyEuf8ZEAH3oFvjpAnSIZz1
         AXbZXyX0ug1lQ==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20201204140342.1640941-1-linus.walleij@linaro.org>
References: <20201204140342.1640941-1-linus.walleij@linaro.org>
Subject: Re: [PATCH 1/2] regulator: ab8500: Remove unused platform data
Message-Id: <161055168025.21791.13396170836042035409.b4-ty@kernel.org>
Date:   Wed, 13 Jan 2021 15:28:00 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Dec 2020 15:03:41 +0100, Linus Walleij wrote:
> The struct ab8500_regulator_platform_data was a leftover
> since the days before we probed all regulators from the
> device tree. The ab8500-ext regulator was the only used,
> defining platform data and register intialization that
> was never used for anything, a copy of a boardfile no
> longer in use.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator: ab8500: Remove unused platform data
      commit: c512150b266b5d173c5ba841e9c09e4830ea4eca
[2/2] regulator: ab8500: Decomission platform data header
      commit: 3acb64c07e95a75dc0af0bc958f2d09a44a9fd0d

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
