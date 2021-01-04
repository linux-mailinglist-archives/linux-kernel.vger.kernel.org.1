Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40F012E9C3D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 18:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbhADRlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 12:41:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:36534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727391AbhADRlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 12:41:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B8ABA20679;
        Mon,  4 Jan 2021 17:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609782064;
        bh=h2V7FsqK/tn56abG9/YmZFGqipy5NSVJ0VDuzMipBaI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=rXdPRfDZGh6pxNB/AyTUHKmDnPFYx6ekC05lQzYVk1eEr1YiXm2tAQKvn8veuM6xO
         OTyf3PDbpkoUCMPQrOVUZZ2hFqT2y3TS1bUC86y1zgZmAUYwQvBukX7v3EN71f8ZBP
         jkRP+0EDgQ95GFsNnh4A1zH5wzyZhbOA8C/64w9tqdrQ7nTykPbxnvivLhgk7DyVru
         ypJjiiRu5eBQ6UjGjuv7x8qyQbm4h+Bf+3xBgSrBLNoL2hZbFqmEPdynz2+wOJqL9P
         ivsEwtWRdwXBxOjATL1CBfNou8J6FnNuIHvAwXPQyKjOYCJhQjdbaLX+P9SBxyEBju
         ItpJ0L0h2cWPg==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        David Collins <collinsd@codeaurora.org>,
        Arnd Bergmann <arnd@arndb.de>,
        John Stultz <john.stultz@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201230145712.3133110-1-arnd@kernel.org>
References: <20201230145712.3133110-1-arnd@kernel.org>
Subject: Re: [PATCH] regulator: qcom-rpmh: add QCOM_COMMAND_DB dependency
Message-Id: <160978203768.14485.9660040055767141148.b4-ty@kernel.org>
Date:   Mon, 04 Jan 2021 17:40:37 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Dec 2020 15:56:23 +0100, Arnd Bergmann wrote:
> A built-in regulator driver cannot link against a modular cmd_db driver:
> 
> qcom-rpmh-regulator.c:(.text+0x174): undefined reference to `cmd_db_read_addr'
> 
> There is already a dependency for RPMh, so add another one of this
> type for cmd_db.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: qcom-rpmh: add QCOM_COMMAND_DB dependency
      commit: d957d1610c661e758426654de3b04bea6fb29f8b

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
