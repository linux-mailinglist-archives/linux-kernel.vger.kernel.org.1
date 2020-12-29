Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B33792E7169
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 15:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgL2OdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 09:33:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:57412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726388AbgL2OdX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 09:33:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EEA4E20867;
        Tue, 29 Dec 2020 14:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609252362;
        bh=o8G01+EUJ4PFnjk2eLKaq/MrDAUuZ0xOUrjXHZwYqGE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=X+9rYKhVsGuc9wHvNx5+mzgOh23QKwo4c2931HBq5/z/KxQFEPYwX8cTppMWdM0RW
         g7jY32S770rWMEMr8Lc8emWtZWNjOHVZp8wgL0AsyYkCB6NdiCIc8yaFHw4xkbD71U
         oi7dvM67rbvnvA5hj6ss53mQSEeuXqx8nyBFoX0jnXTdRFzgChyrRjgQIE5LLGNVz0
         zRfu7W48+woEV28aZ47cMOrzoBwSjROh33wT58rjFY1hYO5Mri1x+Z3GTNrtjVAqy5
         ezA99u6aIa5Y/7EGtgn9o38GmVauOTPG+b/bYjTA2ppwPscdyWkPeMFHnqWysM1pYl
         mVB+fBKXkT0Rw==
From:   Mark Brown <broonie@kernel.org>
To:     Xiaolei Wang <xiaolei.wang@windriver.com>
Cc:     linux-kernel@vger.kernel.org, david@lechnology.com,
        gregkh@linuxfoundation.org, rafael@kernel.org
In-Reply-To: <20201229105046.41984-1-xiaolei.wang@windriver.com>
References: <20201229105046.41984-1-xiaolei.wang@windriver.com>
Subject: Re: [PATCH v3] regmap: debugfs: Fix a memory leak when calling regmap_attach_dev
Message-Id: <160925234119.47920.2670168056681998812.b4-ty@kernel.org>
Date:   Tue, 29 Dec 2020 14:32:21 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Dec 2020 18:50:46 +0800, Xiaolei Wang wrote:
> After initializing the regmap through
> syscon_regmap_lookup_by_compatible, then regmap_attach_dev to the
> device, because the debugfs_name has been allocated, there is no
> need to redistribute it again
> 
> unreferenced object 0xd8399b80 (size 64):
>   comm "swapper/0", pid 1, jiffies 4294937641 (age 278.590s)
>   hex dump (first 32 bytes):
> 	64 75 6d 6d 79 2d 69 6f 6d 75 78 63 2d 67 70 72
> dummy-iomuxc-gpr
> 	40 32 30 65 34 30 30 30 00 7f 52 5b d8 7e 42 69
> @20e4000..R[.~Bi
>   backtrace:
>     [<ca384d6f>] kasprintf+0x2c/0x54
>     [<6ad3bbc2>] regmap_debugfs_init+0xdc/0x2fc
>     [<bc4181da>] __regmap_init+0xc38/0xd88
>     [<1f7e0609>] of_syscon_register+0x168/0x294
>     [<735e8766>] device_node_get_regmap+0x6c/0x98
>     [<d96c8982>] imx6ul_init_machine+0x20/0x88
>     [<0456565b>] customize_machine+0x1c/0x30
>     [<d07393d8>] do_one_initcall+0x80/0x3ac
>     [<7e584867>] kernel_init_freeable+0x170/0x1f0
>     [<80074741>] kernel_init+0x8/0x120
>     [<285d6f28>] ret_from_fork+0x14/0x20
>     [<00000000>] 0x0

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: debugfs: Fix a memory leak when calling regmap_attach_dev
      commit: cffa4b2122f5f3e53cf3d529bbc74651f95856d5

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
