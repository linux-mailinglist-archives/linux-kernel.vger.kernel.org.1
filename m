Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7946B273706
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 02:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729039AbgIVAGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 20:06:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:40350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726537AbgIVAGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 20:06:46 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A9FC21789;
        Tue, 22 Sep 2020 00:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600733206;
        bh=EhzmG1ygIYfdVs1FCC08dch9FwoZFJ/0uNZb1xzH138=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=qOlgwh5LoUf6J3zizXY6+Lt+T/JscyBvvJwnuZ6UjIS+m7zGhvAa5sDgr4wf3wjS2
         CNIwvmEhwpOKFApE0xrIfz1iKZdRZHAW7h6cAUPpf+jNrlxPoNEvY/7bkg2vRr/oEL
         t1D6Ja4Ro8vv2+iO5odQK9bDB3Fo8ARPoT1Tz35Y=
Date:   Tue, 22 Sep 2020 01:05:54 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     dan.carpenter@oracle.com, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
In-Reply-To: <20200918152212.22200-1-ckeepax@opensource.cirrus.com>
References: <20200918152212.22200-1-ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH] regmap: debugfs: Fix more error path regressions
Message-Id: <160073315415.6334.11055443374225512470.b4-ty@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Sep 2020 16:22:12 +0100, Charles Keepax wrote:
> Many error paths in __regmap_init rely on ret being pre-initialised to
> -EINVAL, add an extra initialisation in after the new call to
> regmap_set_name.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: debugfs: Fix more error path regressions
      commit: 1d512ee861b80da63cbc501b973c53131aa22f29

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
