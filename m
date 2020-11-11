Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF112AF55C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 16:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbgKKPr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 10:47:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:42776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726274AbgKKPr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 10:47:28 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D8A92072C;
        Wed, 11 Nov 2020 15:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605109647;
        bh=m1RD4uBreG/nk+7WyTBCXLAvl3XYethrGPLEyqQk6SQ=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=STeXlcSm0ejPuQEanT1pBulB1iXwiCbiEAvdaGUbYvt7eyllglcKJOKaKuw6LuB22
         01zLtXZE7Q3fHb2JUS17ngT3pw9Be4GjV4eieyhgk9lHGIsbid1WT9DyTzl8eDMO25
         GXpchpOOghwjZgPUyUQieuYirwPkWHmCBjkzadpo=
Date:   Wed, 11 Nov 2020 15:47:12 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Shane Chien <shane.chien@mediatek.com>
Cc:     wsd_upstream@mediatek.com, jiaxin.yu@mediatek.com,
        chipeng.chang@mediatek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
In-Reply-To: <1605068096-12587-1-git-send-email-shane.chien@mediatek.com>
References: <1605068096-12587-1-git-send-email-shane.chien@mediatek.com>
Subject: Re: [PATCH] ASoC: Remove mt6359_platform_driver_remove
Message-Id: <160510963229.12073.13028752584402276909.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Nov 2020 12:14:56 +0800, Shane Chien wrote:
> remove mt6359_platform_driver_remove due to it is
> useless.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Remove mt6359_platform_driver_remove
      commit: 6b0e12a5c668c6b77c3e6d6c55c3ae7ed8bf5bd5

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
