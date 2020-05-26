Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2A91D3814
	for <lists+linux-kernel@lfdr.de>; Thu, 14 May 2020 19:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgENR0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 May 2020 13:26:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:42924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbgENR0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 13:26:21 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A68D2065D;
        Thu, 14 May 2020 17:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589477181;
        bh=swTa2jeOy30xyajhmS+81o4FCN/7U8HQcKY0XCdgjF8=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=xNaTqkcAaG+c31MZtS6uJtEp5P0mWAxX2FI1rY8SHtaRA2fsBa7umAJs9awZw9+3m
         RPRmMrZPmyBctpiuBPEPQzXqafwjNTWm2gtdaJggiwo6WO+MZ3oTFdO/c5iHmq2ybn
         BzJcFOtwzEElstWCpOdwywN7hWnA9FCjoRI9ZVzE=
Date:   Thu, 14 May 2020 18:26:19 +0100
From:   Mark Brown <broonie@kernel.org>
To:     mazziesaccount@gmail.com,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <20200513143921.GA22143@localhost.localdomain>
References: <20200513143921.GA22143@localhost.localdomain>
Subject: Re: [PATCH] regulator: bd718x7: remove voltage change restriction from BD71847 LDOs
Message-Id: <158947717907.53448.6753704116559690057.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 May 2020 17:39:21 +0300, Matti Vaittinen wrote:
> The BD71837 had a HW "feature" where changing the regulator output
> voltages of other regulators but bucks 1-4 might cause spikes if
> regulators were enabled. Thus SW prohibit voltage changes for other
> regulators except for bucks 1-4 when regulator is enabled.
> 
> The HW colleagues did inadvertly fix this issue for BD71847 and
> BD71850.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.8

Thanks!

[1/1] regulator: bd718x7: remove voltage change restriction from BD71847 LDOs
      commit: 9bcbabafa19b9f27a283777eff32e7d66fcef09c

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
