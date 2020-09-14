Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBE35268E68
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 16:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgINOxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 10:53:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:53134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726659AbgINOwf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 10:52:35 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1730920829;
        Mon, 14 Sep 2020 14:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600095154;
        bh=Yn6LJndEJ3tzSzC6KEHoAKdcl9DLcigX6eBX6tAwLyM=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=kvGTdnVlBfsxz1IUIUVn/6pS26bO4+GHW9lY3A7NX8Lg0u9c1KV1bEp6SekNQ3otI
         lLQREDSoMUVPXlOj4nhFxDKDUOu1+g7UUzwo0NTPTwFjPG4+FXyr6OpDxeDhcOQIqI
         VzLEPgYaytK+XCIbsIhRJE1I8elmxOf2RnST8c60=
Date:   Mon, 14 Sep 2020 15:51:46 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20200913084114.8851-1-rikard.falkeborn@gmail.com>
References: <20200913084114.8851-1-rikard.falkeborn@gmail.com>
Subject: Re: [PATCH 0/5] drivers/regulator: Constify static variables
Message-Id: <160009510609.5653.5132281509197932767.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Sep 2020 10:41:09 +0200, Rikard Falkeborn wrote:
> Constify a couple of static variables, most importantly regulator_ops to
> allow the compiler to put them in read-only memory.
> 
> Rikard Falkeborn (5):
>   regulator: dummy: Constify dummy_initdata and dummy_ops
>   regulator: fixed: Constify static regulator_ops
>   regulator: stw481x-vmmc: Constify static structs
>   regulator: pca9450: Constify static regulator_ops
>   regulator: ti-abb: Constify ti_abb_reg_ops
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/5] regulator: dummy: Constify dummy_initdata and dummy_ops
      commit: 087c09c2d273823bac906d590280f7e8052f7eff
[2/5] regulator: fixed: Constify static regulator_ops
      commit: 96ee75ffd4f63a3d5f9d6a3ea592b2c0ee97acb0
[3/5] regulator: stw481x-vmmc: Constify static structs
      commit: 9032693e218e69a9527fd5d08c4ce5cdbe90820f
[4/5] regulator: pca9450: Constify static regulator_ops
      commit: 72f2746c52e3fa6c0f6740df2d4fb70419533084
[5/5] regulator: ti-abb: Constify ti_abb_reg_ops
      commit: 2b37a18b58ed12b711591ec54c2b2a0e2068cf6e

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
