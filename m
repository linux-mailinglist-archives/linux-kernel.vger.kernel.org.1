Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00B982A313F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 18:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbgKBRSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 12:18:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:39306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727699AbgKBRSQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 12:18:16 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C408822265;
        Mon,  2 Nov 2020 17:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604337496;
        bh=rIlQqLI71vK+ZxCSq1CjmvcmTyDLZVhKtkIly/VcKS0=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=go90C1SvalxQUPofKKwjnKrZyIcQaUor3MaeiaeZf+Mir5giw/U4JLi0yIAY39TTq
         PJMN1Fi499TSxXdb2RIeybAJDcQ83H7vSs7l6qNhuCUoGrreGUS1nbgqugYb0GAOUt
         tbPCH9gjFUOzMvNUEx2mCQBkNCcmq+lfyvfF9nhQ=
Date:   Mon, 02 Nov 2020 17:18:07 +0000
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, Xu Wang <vulab@iscas.ac.cn>,
        alsa-devel@alsa-project.org, perex@perex.cz, lgirdwood@gmail.com,
        peter.ujfalusi@ti.com
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20201029082513.28233-1-vulab@iscas.ac.cn>
References: <20201029082513.28233-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] ASoC: ti: davinci-evm: Remove redundant null check before clk_disable_unprepare
Message-Id: <160433748156.18840.4266667524928264145.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Oct 2020 08:25:13 +0000, Xu Wang wrote:
> Because clk_disable_unprepare() already checked NULL clock parameter,
> so the additional check is unnecessary, just remove it.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: ti: davinci-evm: Remove redundant null check before clk_disable_unprepare
      commit: ff3cfccba4dd87bb89ca185b58b38b9a74260138

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
