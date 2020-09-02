Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8694325B422
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 20:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbgIBSyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 14:54:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:52114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbgIBSyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 14:54:54 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CB5C2083B;
        Wed,  2 Sep 2020 18:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599072894;
        bh=VcqiHg/9pChnNavDC1Di/U5GAkv+0mC//IPqXNEpmAY=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=lp7lNglUMU23HkCjthf7bwJtc1D3JbUR+YyBkmfnlPW6HJzvPAzF/tXdKguFBFJif
         1QITBR6fyq8Ls9dOaFZZ9BUqSQ0FlmwhaDPGxNXfm3UATJAwLwIOCxleVZt3ZR6/m5
         10tzgnPluYCXDEJJDHpssNUzY1W/OYHInsZVSP2U=
Date:   Wed, 02 Sep 2020 19:54:14 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20200902141843.6591-1-digetx@gmail.com>
References: <20200902141843.6591-1-digetx@gmail.com>
Subject: Re: [PATCH v1] regmap: Add can_sleep configuration option
Message-Id: <159907285417.18097.12464279240190546948.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Sep 2020 17:18:43 +0300, Dmitry Osipenko wrote:
> Regmap can't sleep if spinlock is used for the locking protection.
> This patch fixes regression caused by a previous commit that switched
> regmap to use fsleep() and this broke Amlogic S922X platform.
> 
> This patch adds new configuration option for regmap users, allowing to
> specify whether regmap operations can sleep and assuming that sleep is
> allowed if mutex is used for the regmap locking protection.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: Add can_sleep configuration option
      commit: 21f8e4828c44da39b0670c5d99d5728b739542a1

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
