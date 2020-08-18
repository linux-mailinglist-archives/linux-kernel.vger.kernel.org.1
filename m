Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE03B248C2F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 18:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbgHRQ5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 12:57:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:39444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728521AbgHRQ4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 12:56:44 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A483220786;
        Tue, 18 Aug 2020 16:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597769804;
        bh=L5NFE2dpyKVFRZ6iymoAf/hn+0rB4iAkWFhLUMXiEVY=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=hsM+KWl8Nbs6zI18BQGvkX3vFxFHHRE/3SPS1EC58p5yFWQccguhS92+L2juvMb46
         7fVX0pKY4EGBJzapn23F+RdznsOT1lZzHkYPZWhpvdiSGyi9wPODRq7vUGgvc81tKb
         G9Uz+XJag3dq3podbXQ6FZYj15loWsfVeckX37Nc=
Date:   Tue, 18 Aug 2020 17:56:13 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     linux-kernel@vger.kernel.org,
        Daniel Jeong <gshark.jeong@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <20200802090638.380589-1-axel.lin@ingics.com>
References: <20200802090638.380589-1-axel.lin@ingics.com>
Subject: Re: [PATCH] regulator: lp8755: Get rid of lp8755_read/lp8755_write/lp8755_update_bits
Message-Id: <159776976827.56451.5617586391958320901.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Aug 2020 17:06:38 +0800, Axel Lin wrote:
> Just use regmap_read/regmap_write/regmap_update_bits instead.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: lp8755: Get rid of lp8755_read/lp8755_write/lp8755_update_bits
      commit: 4cf12735de56d2bfd058af82492b06eed761e111

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
