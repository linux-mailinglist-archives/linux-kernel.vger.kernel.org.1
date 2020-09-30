Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C121D27E816
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 14:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729759AbgI3MAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 08:00:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:51210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbgI3MAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 08:00:07 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 744DB2085B;
        Wed, 30 Sep 2020 12:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601467207;
        bh=/9SvyBBYs3IgSi5OubLgm0zLFJxvEi+e0ogNZktW6Sw=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=TVAbfgEU9dIAGm1Tw5FPY+jCbPHGowPJo9WwlozR/8zFU0BHZ2tMnLb3loWcml5oz
         dn3qbeh5Ok2hLxL4Xmy/IAQgzvBXpv2Kvk1U3E5kZFa4WD9WsVSazTr5+oHCmXbwdm
         C+cxUDjIFLy9emHlv55n72W229xKa8L4/GRioE7k=
Date:   Wed, 30 Sep 2020 12:59:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     cy_huang <u0084500@gmail.com>, robh+dt@kernel.org
Cc:     lgirdwood@gmail.com, cy_huang@richtek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <1601460480-4259-1-git-send-email-u0084500@gmail.com>
References: <1601460480-4259-1-git-send-email-u0084500@gmail.com>
Subject: Re: [PATCH] regulator: rtmv20: Update DT binding document and property name parsing
Message-Id: <160146714296.40216.643020252480635401.b4-ty@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Sep 2020 18:08:00 +0800, cy_huang wrote:
> 1. Add vendor suffix to all proprietary properties.
> 2. Fix typo.
> 3. Change lsw to normal property, not pattern property.
> 4. Due to item 1, modify source code for property parsing.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: rtmv20: Update DT binding document and property name parsing
      commit: 89a5f77e3f3a7fb8d6cf25668489d66069ebe4b7

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
