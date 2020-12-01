Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D325C2CA4B6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 15:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391525AbgLAN7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 08:59:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:45574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391492AbgLAN7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 08:59:22 -0500
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net [92.233.91.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10D472086A;
        Tue,  1 Dec 2020 13:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606831121;
        bh=CXjSiL5hvWtSjMiTwdtyZhoUE2ZQn85HkMUoJAFtBNQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=DxAIE96ZH2rpJ+5RpUudr4DFeAF3x6Bd2z0tHgsBAmyBfp69UDS3JgDJyCmxERtxq
         iPZZOnCFi7teBd0k0uGwbGyx7gWCAzsL2l5NZUFL7o9awsajH7c+yAt52asSE/dQFl
         mOC6drlxMHF86GXVbIQh6W8t6eLITb2Fpc5Vlu/w=
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Adam Ward <Adam.Ward.opensource@diasemi.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        devicetree@vger.kernel.org,
        Support Opensource <support.opensource@diasemi.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <cover.1606755367.git.Adam.Ward.opensource@diasemi.com>
References: <cover.1606755367.git.Adam.Ward.opensource@diasemi.com>
Subject: Re: [PATCH V3 00/10] regulator: da9121: extend support to variants, add features
Message-Id: <160683107677.35139.1688443189294014005.b4-ty@kernel.org>
Date:   Tue, 01 Dec 2020 13:57:56 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Nov 2020 16:59:04 +0000, Adam Ward wrote:
> This series extends the DA9121 driver to add support for related products:
> 
>   DA9130, 10A, Dual-Phase (Automotive Grade)
>   DA9122, 5A + 5A
>   DA9131, 5A + 5A (Automotive Grade)
>   DA9220, 3A + 3A
>   DA9132, 3A + 3A (Automotive Grade)
>   DA9217, 6A, Dual-Phase
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[01/10] regulator: Update DA9121 dt-bindings
        (no commit info)
[02/10] regulator: da9121: Add header file
        (no commit info)
[03/10] regulator: da9121: Add device variants
        (no commit info)
[04/10] regulator: da9121: Add device variant regmaps
        (no commit info)
[05/10] regulator: da9121: Add device variant descriptors
        (no commit info)
[06/10] regulator: da9121: Add support for device variants via devicetree
        (no commit info)
[07/10] regulator: da9121: Update registration to support multiple buck variants
        (no commit info)
[08/10] regulator: da9121: add current support
        (no commit info)
[09/10] regulator: da9121: add mode support
        (no commit info)
[10/10] regulator: da9121: add interrupt support
        (no commit info)

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
