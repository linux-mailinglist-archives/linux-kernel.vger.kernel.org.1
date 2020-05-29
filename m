Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1CF1E8413
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 18:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgE2QwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 12:52:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:43774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726616AbgE2QwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 12:52:07 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A3B22075A;
        Fri, 29 May 2020 16:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590771127;
        bh=5zNuNRdEEMN6EdCZYpsVn85TUPsvLHkwvBubM+EfuTw=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=RtSSjcmtKAyPV/u5Jvxo2OxuBQ5iUwf5492iSO3Qpy4fjwxXRcn+X660Hv0pFs6d0
         VnmktaRUr4eEl6euEmYiZUwfAUFbyr8ZqBbkx4njGsZC7133J9LdJBnI7DEOn2+hwQ
         uUavOpw1x7oplXStrHcQo/2L/e5s9v4kyWNJHJeY=
Date:   Fri, 29 May 2020 17:52:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com
In-Reply-To: <20200529152216.9671-1-ckeepax@opensource.cirrus.com>
References: <20200529152216.9671-1-ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH] regulator: core: Add regulator bypass trace points
Message-Id: <159077112408.28818.9453261560595350658.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 May 2020 16:22:16 +0100, Charles Keepax wrote:
> Add new trace points for the start and end of enabling bypass on a
> regulator, to allow monitoring of when regulators are moved into bypass
> and how long that takes.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: core: Add regulator bypass trace points
      commit: 48325655290869dbcdc356478bde4606d79d600e

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
