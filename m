Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECCEE2CC36F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 18:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730827AbgLBRVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 12:21:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:39226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388140AbgLBRVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 12:21:05 -0500
From:   Mark Brown <broonie@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Rob Herring <robh+dt@kernel.org>,
        Adam Ward <Adam.Ward.opensource@diasemi.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Support Opensource <support.opensource@diasemi.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        devicetree@vger.kernel.org
In-Reply-To: <cover.1606908582.git.Adam.Ward.opensource@diasemi.com>
References: <cover.1606908582.git.Adam.Ward.opensource@diasemi.com>
Subject: Re: [PATCH V2 0/1] regulator: da9121: add IRQ free to release function
Message-Id: <160692959560.34198.16327737736892832990.b4-ty@kernel.org>
Date:   Wed, 02 Dec 2020 17:19:55 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Dec 2020 11:32:46 +0000, Adam Ward wrote:
> This patch fixes the DA9121 driver to disable the IRQ before cancelling
> the work, to be sure the IRQ doesn't restart it before all IRQs are
> masked
> 
> V2:
> 
>  - Fix to release IRQ if regmap error fails probe
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: da9121: Request IRQ directly and free in release function to avoid masking race
      commit: 5e191d2e05a4fe098632006bb3afa5e21c8789db

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
