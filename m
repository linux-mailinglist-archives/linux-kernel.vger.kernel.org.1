Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3722EE67F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 21:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbhAGUCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 15:02:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:50502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726805AbhAGUCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 15:02:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 15AAD23433;
        Thu,  7 Jan 2021 20:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610049725;
        bh=1X1G1hW6sIZIwyycWB4gF6zqPsP3v89e4NkXmk/Jm7E=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=CxWED5S3ehiDfNCtYcMdJwi5Tlm563AEXWlsvVVPqSRYf/Msj8aQY70kscOlyG7D4
         fQQ50WdyBY/osup0U/ndGDwbeLvEULmzYwW9OI2Q7sWXJqXBk4lBntP9HxsxOylvAM
         d1Mr2Q4caEnyOtqIFcy2wH8zrAFWQ8hm1LMyf53qoyOaZJKdn6mLx+sdJZPmb1zvUs
         BG//Q2Dkj0rW/gDEaXmg13j8ap9GoX+/rbVYkFpqV7zMKmjLpbyAHC3g2WJwarHzjW
         isryxIlUEWv+eRpJQdcdQ/VNBp3HJV4H0sOSdyla6euhjE6vlnAXv+oJbHstaTynqq
         RL4nO0u9ua3Qg==
From:   Mark Brown <broonie@kernel.org>
To:     mazziesaccount@gmail.com,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-power@fi.rohmeurope.com
In-Reply-To: <20210107122355.GA35080@localhost.localdomain>
References: <20210107122355.GA35080@localhost.localdomain>
Subject: Re: [PATCH] regulator: bd718x7: Stop using parent data
Message-Id: <161004969535.33528.14982464083424403882.b4-ty@kernel.org>
Date:   Thu, 07 Jan 2021 20:01:35 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Jan 2021 14:23:55 +0200, Matti Vaittinen wrote:
> The ROHM PMIC regulator drivers only need the regmap pointer from
> the parent device. Regmap can be obtained via dev_get_regmap()
> so do not require parent to populate driver data for that.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: bd718x7: Stop using parent data
      commit: 907dfdc945aa3d183cdc6a81b963ee3b42ece306

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
