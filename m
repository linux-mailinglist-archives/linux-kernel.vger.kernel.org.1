Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 323B02E66B2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 17:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633111AbgL1QPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 11:15:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:54986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2633095AbgL1QO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 11:14:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EBD1822573;
        Mon, 28 Dec 2020 16:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609172058;
        bh=At5QBs5LrAolsS4iW61tkcj7jS7sEiNHbz6TCez/3uo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=VlcI1iq46wBJNMDiirTwtKKd8mI6N3lmfZ+PqgNXvIf8/lpgLuPAVkaSjh++Vy3n8
         R63hOIAYcpkcC69kFY/ecSf5RNnYMaLpHBLLx74zy7XbEAK2v87/QPoUJRmURN9dr1
         T8/dAMxziZQ0uEGarBSRZQxN23n4NOHrwpkh89LhXdf5sLWG8ZRMJdnZIMVHs6DyaI
         MslUAsjaRViDDf/mopdmFZjQhvxb8wMxDYC+0jO13a9Ve6TvEwjWS06O8rV92iF/Ca
         jqOFyuXhQjaHYWuT7XQxbAnqjgXdJeMn2Qn+4Vg6xiCt+LwPLhqJ8TVy60B3ywvpBx
         zuvQyP8SLWXPw==
From:   Mark Brown <broonie@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Lina Iyer <ilina@codeaurora.org>,
        kernel test robot <lkp@intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <20201225185004.20747-1-rdunlap@infradead.org>
References: <20201225185004.20747-1-rdunlap@infradead.org>
Subject: Re: [PATCH -next] regulator: qcom-rpmh: fix build after QCOM_COMMAND_DB is tristate
Message-Id: <160917202697.51934.13442140381410565121.b4-ty@kernel.org>
Date:   Mon, 28 Dec 2020 16:13:46 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Dec 2020 10:50:04 -0800, Randy Dunlap wrote:
> Restrict REGULATOR_QCOM_RPMH to QCOM_COMMAND_DB it the latter is enabled.
> 
> Fixes this build error:
>   microblaze-linux-ld: drivers/regulator/qcom-rpmh-regulator.o: in function `rpmh_regulator_probe':
>   (.text+0x354): undefined reference to `cmd_db_read_addr'

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: qcom-rpmh: fix build after QCOM_COMMAND_DB is tristate
      commit: ac6b559d818981406e587f4784777e9112d553f4

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
