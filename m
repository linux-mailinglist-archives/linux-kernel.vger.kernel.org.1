Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCF12D30A2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 18:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730586AbgLHRLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 12:11:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:51746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730253AbgLHRLm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 12:11:42 -0500
From:   Mark Brown <broonie@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Adam Ward <Adam.Ward.opensource@diasemi.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
In-Reply-To: <X85soGKnWAjPUA7a@mwanda>
References: <X85soGKnWAjPUA7a@mwanda>
Subject: Re: [PATCH] regulator: da9121: Potential Oops in da9121_assign_chip_model()
Message-Id: <160744745469.29972.2193088415551214848.b4-ty@kernel.org>
Date:   Tue, 08 Dec 2020 17:10:54 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Dec 2020 20:55:44 +0300, Dan Carpenter wrote:
> There is a missing "return ret;" on this error path so we call
> "da9121_check_device_type(i2c, chip);" which will end up dereferencing
> "chip->regmap" and lead to an Oops.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: da9121: Potential Oops in da9121_assign_chip_model()
      commit: 8db06423e079b1f6c0657e5bebda0006acf75c3c

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
