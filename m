Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6C00248C37
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 18:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbgHRQ6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 12:58:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:40976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728582AbgHRQ5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 12:57:35 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C649A20786;
        Tue, 18 Aug 2020 16:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597769855;
        bh=YUgeli4C6oBA4lmghDvhoFd0Y6GobmPBwB0dZlS1kso=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=HVB1bZu3HRuufpjkFl5tdyY45sQICLE7rAbZu1HB/hTzLJk3c82eEcAdWV4cV0DR7
         mp13ep6gV7XcKkuhW892L4qYgC2zc9nHfR23bZR4u71jJ6NjkRtl6wb92HsNfvHXfs
         CHlQJjnWUSTe/XhU+WWiiQMVM/jDhbVyZA5rKS+c=
Date:   Tue, 18 Aug 2020 17:57:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20200810095753.59ce9f75@xhacker.debian>
References: <20200810095753.59ce9f75@xhacker.debian>
Subject: Re: [PATCH] regulator: sy8827n: Fix W=1 build warning when CONFIG_OF=n
Message-Id: <159776976827.56451.1428375330310144519.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Aug 2020 09:57:53 +0800, Jisheng Zhang wrote:
> Fixing W=1 build warning when no support for device tree is there.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: sy8827n: Fix W=1 build warning when CONFIG_OF=n
      commit: a16138a32eeeca01e2603193288ff0714bead11d

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
