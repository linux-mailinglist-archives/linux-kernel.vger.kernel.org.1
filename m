Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3932F248C4C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 19:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbgHRRAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 13:00:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:39738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728338AbgHRQ4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 12:56:54 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFC6F20786;
        Tue, 18 Aug 2020 16:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597769814;
        bh=Bi2BYoO1sasfaI9P3x0mtCIVr/5sH0I1Clccjz0DwdI=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=1gG8lwi4cyqRsldcBcPJvUmc9EADxQSPsTcjOYaDnG/srPbkznqYtJaovVQrzGMLu
         e23plSU3tcHcAbk1QO0hSPSaDrhc/++7RE/9Rrbbnl9dGMGVAPO9ZAM/kxNpWD2hsD
         wIx48nvLxZ2FNcHNFsNdWABiPx0rIsKmtndxQdxQ=
Date:   Tue, 18 Aug 2020 17:56:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Daniel Kurtz <djkurtz@chromium.org>
In-Reply-To: <20200812133101.2513317-1-hsinyi@chromium.org>
References: <20200812133101.2513317-1-hsinyi@chromium.org>
Subject: Re: [PATCH] regulator: da9211: add cache_type
Message-Id: <159776976828.56451.55079634340734768.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Aug 2020 21:31:02 +0800, Hsin-Yi Wang wrote:
> Add regmap_cache to reduce wakeups events of interrupt if regulator is
> accessed frequently. This results in saving more power.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: da9211: add cache_type
      commit: 989e08c3d0044fc707c26c0329ed49e33e8e4c7b

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
