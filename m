Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A61622EE0E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jul 2020 15:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgG0N5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 09:57:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:46748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728816AbgG0N5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 09:57:00 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BF6A2070A;
        Mon, 27 Jul 2020 13:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595858219;
        bh=Rl5KT2tTf2eHhzu8LdmjCElOjtbdqMSgnW5R852PXlQ=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=xuC9UyNx5AS91gh73QpiG3MVVY84hWFL3jO3KSMY66CiT/GUU/u3BNZP9LyrbLkpL
         Q5SJcqVRR3s55HN3ZauqS9eoKiLAwEIKBjWy1PR1WnVwP5fhC+WihhD36/HQLPPzqJ
         pez/NanBvM/iOQewzmGnjz4KYbRlveB73oF1F38Y=
Date:   Mon, 27 Jul 2020 14:56:42 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Robin Gong <yibin.gong@nxp.com>
In-Reply-To: <20200725014414.1825183-1-axel.lin@ingics.com>
References: <20200725014414.1825183-1-axel.lin@ingics.com>
Subject: Re: [PATCH] regulator: pca9450: Convert to use module_i2c_driver
Message-Id: <159585820266.22516.9633791623764970641.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Jul 2020 09:44:14 +0800, Axel Lin wrote:
> Use module_i2c_driver to simplify driver init boilerplate.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: pca9450: Convert to use module_i2c_driver
      commit: 3bda44ffd93bf91fb3326336acf7ff163b1ce97d

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
