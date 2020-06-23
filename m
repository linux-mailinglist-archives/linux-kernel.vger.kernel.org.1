Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 404462052AA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 14:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732650AbgFWMjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 08:39:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:51590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729667AbgFWMjn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 08:39:43 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A79620774;
        Tue, 23 Jun 2020 12:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592915983;
        bh=MNlYhtOrwegmLUatDSj0GJ7uks95+bTD84bfn7I33Is=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=sMdP5em7lWklcwmhbdt9lo+mfi09bwnxeHUGir7ezljB9n6M/Z1yVql7NsB9qXrJ2
         QQiaO79MtJpO0PLRZJeqqRDE2kiOhStKN5qt4FE30rKFRlvPJpNDvss1JeOlKPyHhm
         Tkh146tHSYEBPbZ1aO3nOe5ygaRTxBheMghBRP/k=
Date:   Tue, 23 Jun 2020 13:39:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Robin Gong <yibin.gong@nxp.com>, lgirdwood@gmail.com
Cc:     linux-imx@nxp.com, linux-kernel@vger.kernel.org
In-Reply-To: <1592920870-12693-1-git-send-email-yibin.gong@nxp.com>
References: <1592920870-12693-1-git-send-email-yibin.gong@nxp.com>
Subject: Re: [PATCH v1] regulator: pfuze100: add condition check for 'ramp_delay = 0'
Message-Id: <159291598139.44727.7254402275143225680.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jun 2020 22:01:10 +0800, Robin Gong wrote:
> Checking for 'ramp_delay = 0' to avoid Coverity warning report.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: pfuze100: add condition check for 'ramp_delay = 0'
      commit: a7503a9d8fcfac3fefdb63fc61efedef41635e94

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
