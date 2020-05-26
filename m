Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 719B61C728E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 16:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbgEFORO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 10:17:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:57666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbgEFORO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 10:17:14 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F948206D5;
        Wed,  6 May 2020 14:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588774633;
        bh=E2FPRMOtJPQ28Jn0CD58CEFJGl3jwphHRxnRKSQWI6g=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=DaPlaRDy0v4tHoZdrLe0I2dX6GTf+R8IzmF1viAzoLmOMnZyexJZ8+pmrygf//lAH
         4MDE2hAsaLAVTfBR7wjPHzR40f4Vjpsd+ojmGE30XzdjdWTKRzIOd3TDQDSDyvB4A1
         gpAYD5ejPwZy9vWaZUm3zX51ZR3qhjJBYuFzTqUc=
Date:   Wed, 06 May 2020 15:17:11 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jason Yan <yanaijie@huawei.com>, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com
In-Reply-To: <20200506061726.19289-1-yanaijie@huawei.com>
References: <20200506061726.19289-1-yanaijie@huawei.com>
Subject: Re: [PATCH] regulator: db8500-prcmu: Use true,false for bool variable
Message-Id: <158877463128.38550.10089198425831753344.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 May 2020 14:17:26 +0800, Jason Yan wrote:
> Fix the following coccicheck warning:
> 
> drivers/regulator/db8500-prcmu.c:184:1-17: WARNING: Assignment of 0/1 to
> bool variable
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.8

Thanks!

[1/1] regulator: db8500-prcmu: Use true,false for bool variable
      commit: aab5fd7a1b7b931487694b527322f48f423701c7

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
