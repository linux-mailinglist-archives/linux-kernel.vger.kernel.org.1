Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABDD2EAFA1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 17:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbhAEQIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 11:08:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:37572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbhAEQIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 11:08:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F360422C9D;
        Tue,  5 Jan 2021 16:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609862864;
        bh=mylrgq0PAWXH2hnWzRXIeuIL0j2NzAqyNr6yCHc88Pc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=f6Lmn0zgZg/CJ6+k2ocRb/YbolwppDmYpelwUiOETIkwke7lxd4T/J3mrhVSoM6Hx
         cqACCy0nhIzzxwqS05IgjV0V7tjT9w3NfF0RFCrFSPV1gauafFPfkRqp1UVIBCcqU/
         Vdbpe9Y249XH6FEvu7TF6f0/byPiZ8ovDhXkkh5IJTq6pfqJtSM5OQGT7LqfFcV7sH
         juwlM/8yVI9BGlSNRBZQyMFJidQ9qpsIfidc5pWMdbPDr5hzpRsHgG8GifmzQcHb31
         R9/LGn9riYCPfKj88m6ZgaP1/jdPSYhmRf6Gq3lsLq/WeaIv/a16xWUS7YRWkpvX3t
         HXQ4BZhpGorbQ==
From:   Mark Brown <broonie@kernel.org>
To:     Xiaolei Wang <xiaolei.wang@windriver.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel-janitors@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
In-Reply-To: <X/RQpfAwRdLg0GqQ@mwanda>
References: <X/RQpfAwRdLg0GqQ@mwanda>
Subject: Re: [PATCH] regmap: debugfs: Fix a reversed if statement in regmap_debugfs_init()
Message-Id: <160986283724.50112.3615715959178419195.b4-ty@kernel.org>
Date:   Tue, 05 Jan 2021 16:07:17 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jan 2021 14:42:29 +0300, Dan Carpenter wrote:
> This code will leak "map->debugfs_name" because the if statement is
> reversed so it only frees NULL pointers instead of non-NULL.  In
> fact the if statement is not required and should just be removed
> because kfree() accepts NULL pointers.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: debugfs: Fix a reversed if statement in regmap_debugfs_init()
      commit: f6bcb4c7f366905b66ce8ffca7190118244bb642

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
