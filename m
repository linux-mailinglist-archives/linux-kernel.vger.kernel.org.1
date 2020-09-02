Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBCCF25B424
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 20:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbgIBSzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 14:55:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:52262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbgIBSzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 14:55:00 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6FE72083B;
        Wed,  2 Sep 2020 18:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599072900;
        bh=I5llEoIhVDK/sP5l2/ZYABr6gFCAD/Sc91qnDvkfxUo=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=Duim0MLaWaKmNcwg7OJY/IXUqoHsidLvYQqAwFVI+8nVpyJ1Ey1DhW5oZacihc4we
         rigZdgNlLsg0Wqe4R/1BXRS5lkGqcQDTGB+rZ8GJInxHnLf7RFjj87j3/421FeojDB
         QBNNlVaAS40RKpfewYOoDJZCfP745RI4lMSy+ats=
Date:   Wed, 02 Sep 2020 19:54:20 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     linux-kernel@vger.kernel.org, kernel@axis.com
In-Reply-To: <20200902130952.24880-1-vincent.whitchurch@axis.com>
References: <20200902130952.24880-1-vincent.whitchurch@axis.com>
Subject: Re: [PATCH] regulator: pwm: Fix machine constraints application
Message-Id: <159907285997.18126.1455609056387315109.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Sep 2020 15:09:52 +0200, Vincent Whitchurch wrote:
> If the zero duty cycle doesn't correspond to any voltage in the voltage
> table, the PWM regulator returns an -EINVAL from get_voltage_sel() which
> results in the core erroring out with a "failed to get the current
> voltage" and ending up not applying the machine constraints.
> 
> Instead, return -ENOTRECOVERABLE which makes the core set the voltage
> since it's at an unknown value.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: pwm: Fix machine constraints application
      commit: 59ae97a7a9e1499c2070e29841d1c4be4ae2994a

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
