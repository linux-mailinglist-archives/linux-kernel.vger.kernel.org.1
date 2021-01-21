Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB32C2FDE3E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 01:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732123AbhAUAzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 19:55:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:53972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388124AbhAUAID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 19:08:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D266E23719;
        Thu, 21 Jan 2021 00:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611187643;
        bh=8FKYosXPvv3FUOJpSS4TQL6/pMTyAw/0IsBrN+udhPw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=gdvtbe+8eGrpAOj4KN+Et0uer2Vm1lXoFwKueZUFL32p8SDMfpMUu5t+/O3PbyHSr
         7BChQlPzicvM2R/IzUHKZr2uJgpBoTSt7kZTr53VkUHd+/MzkDAfL6j7y5419AC9c0
         qq3PA/OvZ6JJy9JggHWx/I0i3d6imBx/95iQUhsR/RCIScMQWwH7ZxVmVODAlPtH0C
         9oL1TQRMRE0diauObEHal926C17qoxtwOXnDDd5DvJxRLxdMT8Pevcb3di9uHdYr2e
         uj8CyqykFyUOkXNte+3JNeaG0KwXUaq0EhnX66sJol9WtoXERgEOtYd3OVHl6quLDb
         XnMHgedfIz96w==
From:   Mark Brown <broonie@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <20210120162553.21666-1-arnd@kernel.org>
References: <20210120162553.21666-1-arnd@kernel.org>
Subject: Re: [PATCH 0/2] ASoC: remove obsolete drivers
Message-Id: <161118753484.45718.5745796421689353764.b4-ty@kernel.org>
Date:   Thu, 21 Jan 2021 00:05:34 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jan 2021 17:25:51 +0100, Arnd Bergmann wrote:
> A few Arm platforms are getting removed in v5.12, this removes
> the corresponding sound drivers.
> 
> Link: https://lore.kernel.org/linux-arm-kernel/20210120124812.2800027-1-arnd@kernel.org/T/
> 
> Arnd Bergmann (2):
>   ASoC: remove sirf prima/atlas drivers
>   ASoC: remove zte zx drivers
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: remove sirf prima/atlas drivers
      commit: 61fbeb5dcb3debb88d9f2eeed7e599b1ed7e3344
[2/2] ASoC: remove zte zx drivers
      commit: dc98f1d655ca4411b574b1bd2629e7132e502c1c

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
