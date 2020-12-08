Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 463CB2D30A4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 18:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730608AbgLHRLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 12:11:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:51938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730253AbgLHRLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 12:11:48 -0500
From:   Mark Brown <broonie@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Adam Ward <Adam.Ward.opensource@diasemi.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Support Opensource <support.opensource@diasemi.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
In-Reply-To: <cover.1607361013.git.Adam.Ward.opensource@diasemi.com>
References: <cover.1607361013.git.Adam.Ward.opensource@diasemi.com>
Subject: Re: [PATCH 0/2] regulator: da9121: bug fixes
Message-Id: <160744745469.29972.10628330212188147168.b4-ty@kernel.org>
Date:   Tue, 08 Dec 2020 17:10:54 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Dec 2020 17:15:14 +0000, Adam Ward wrote:
> This patch fixes a couple of bugs in the DA9121 driver.
> One in an uninialised string I forgot to remove when changing to of_parse_cb()
> The other is an index for an optional DT property which overflows
> 
> 
> Adam Ward (2):
>   regulator: da9121: Remove uninitialised string variable
>   regulator: da9121: Fix index used for DT property
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator: da9121: Remove uninitialised string variable
      commit: 416c29e9ce1347ba9a4ef7aeb4f30c8d9a3ada49
[2/2] regulator: da9121: Fix index used for DT property
      commit: 9536ce63705952be5214544e3b048c78f932e794

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
