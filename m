Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96C072FDE4E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 02:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389374AbhAUA6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 19:58:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:54858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392394AbhAUAKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 19:10:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B5A532376F;
        Thu, 21 Jan 2021 00:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611187705;
        bh=u1lGu8A3Y38MesgXg89v7XbVdNYDdcfouZL4Q25QiF4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=mEzD4RBTr9xzcjg1DdyPnDuHNBM3Y0tMZqL9yba6IBBiiGdbFGYQpLwtxerN5haRI
         wX/jQDhPB8p/v0CrK46q1JpKR+VcTa7XwNePatP+B76wjQvdIgdPD8a9g5PuyYhPO+
         PJU7CCWrVmtorXCEKMcNl86MLcTyWWsgWN1eaz5nVSd50+wonq5U9sDFLEm29lgWqq
         V+CvAHAzLhcYSC+nNr5lpzKFlbn/FcorJf+axvVtQnnwyxccj7nlirHtIdsH35dJNE
         k5P6LIp5kMrtfb8mjBWb04puuo7AJmuxSxpZUNWbufkV/ebBSiT3R3AnjNX6hLmPu7
         5m/uiBSpFWFvQ==
From:   Mark Brown <broonie@kernel.org>
To:     Carlo Caione <carlo@caione.org>, Chen-Yu Tsai <wens@csie.org>,
        Pan Bian <bianpan2016@163.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20210120123313.107640-1-bianpan2016@163.com>
References: <20210120123313.107640-1-bianpan2016@163.com>
Subject: Re: [PATCH] regulator: axp20x: Fix reference cout leak
Message-Id: <161118766212.46058.10778777770178572379.b4-ty@kernel.org>
Date:   Thu, 21 Jan 2021 00:07:42 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jan 2021 04:33:13 -0800, Pan Bian wrote:
> Decrements the reference count of device node and its child node.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: axp20x: Fix reference cout leak
      commit: e78bf6be7edaacb39778f3a89416caddfc6c6d70

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
