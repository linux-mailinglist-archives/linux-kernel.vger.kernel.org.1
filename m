Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9F52F8420
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388555AbhAOSVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:21:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:43598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388494AbhAOSVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:21:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AF08323A7C;
        Fri, 15 Jan 2021 18:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610734826;
        bh=QE9Yei7sjCPLtHD7KESy7qt2oI0VHOCi99x9kBzhGm4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=LOCfWv9+OJgUcC9jZyzEeryRATTuy8ZH8TJZnFyAkAnfrJbHqjDO7KeJ0HoEHsOiL
         xqhBJaSUrFfF94H5ZCpAV9Bovzzth0S+TOD5/+DQfgbHV4Tm8YCP3Y0UdsampMrBp6
         6pTw3UD0rgQ2PZcmm0L5Ohx3HSjGXsDBRmPL1KqHSm2CBOIyN9iaLCsMJBMp5FJqG8
         PaiqUNuOD7TOOENoApJiPDw0tjg0cqdJNkMYZIne+BDgPiFZZpq79IK+Uo6GIyKIhQ
         MirzVnbamnsriQCHgt56OSR5YJJ7FPJjIK/ae+iZFf7W+tesGxH6/Gao2XnRxfCBl8
         iOl/uDJucnULw==
From:   Mark Brown <broonie@kernel.org>
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        jagan@amarulasolutions.com, devicetree@vger.kernel.org,
        lgirdwood@gmail.com
In-Reply-To: <20210114174714.122561-1-adrien.grassein@gmail.com>
References: <20210114174714.122561-1-adrien.grassein@gmail.com>
Subject: Re: [PATCH v5 0/6] Fix issues on pf8x00 driver
Message-Id: <161073479107.12431.4350059208898304988.b4-ty@kernel.org>
Date:   Fri, 15 Jan 2021 18:19:51 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jan 2021 18:47:08 +0100, Adrien Grassein wrote:
> this patch set aims is to fix some issues contains in the pf8x00 driver.
> Some issues are documentation ones, some others are in code.
> 
> These issues where found while developing another version of the same
> driver. I prefer to share with you the patch for it.
> 
> I do these patches on the master branch of the linux-next repository.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/6] regulator: pf8x00: add a doc for the module
      commit: 4d23b84d1fcd1eadbc5c6cd93e76b02a8d191d66
[2/6] regulator: dt-bindings: pf8x00: fix nxp,phase-shift doc
      commit: 988d0d42509a2c1fad0844a6e8f9c7bce7c930dd
[3/6] regulator: dt-bindings: pf8x00: mark nxp,ilim-ma property as deprecated
      commit: 34b860aa0b6221b21eea6bac76357063f525b561
[4/6] regulator: pf8x00: mark nxp,ilim-ma property as deprecated
      commit: 245f5f65229a6c6f5b04fa90221b44818a928916
[5/6] regulator: pf8x00: use linear range for buck 1-6
      commit: 35a93349932e0e04c284f8a4954f3d1236c97d85
[6/6] regulator: pf8x00: fix nxp,phase-shift
      commit: 475a5d85ff62f7ca73f51f23977e7e3ec8c9f906

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
