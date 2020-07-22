Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 060F6228D4B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jul 2020 02:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731608AbgGVA53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 20:57:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:59702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731561AbgGVA52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 20:57:28 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B723B208E4;
        Wed, 22 Jul 2020 00:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595379448;
        bh=7iBO9qAzu3W4vqYwTj8OAZVdpjSA840j43rS3hv9c30=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=yTDpiXat221JvH0s1ZIbnHZugIYl8yvvTN9C9/WUTUWO0Y11KHNSe0fQeQKZZwPp+
         KNwexfPqW2jV+yQBXvBqKXSD6/GUxm5lsGbazPIrh5QHb1Q6F25pwwDezmgejQnZeW
         5jwE/cQVbzpWytI1M+fYolijFv2wXknw/kqjk/Rk=
Date:   Wed, 22 Jul 2020 01:57:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org, kernel-team@android.com
In-Reply-To: <20200716042053.1927676-1-saravanak@google.com>
References: <20200716042053.1927676-1-saravanak@google.com>
Subject: Re: [PATCH v3 0/4] regulator_sync_state() support
Message-Id: <159537943520.49645.15927719980916646550.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jul 2020 21:20:49 -0700, Saravana Kannan wrote:
> Consider the following example:
> - regulator-X is provided by device-X.
> - regulator-X is a supplier to device-A, device-B and device-C.
> - device-A is off/inactive from boot.
> - device-B and device-C are left on/active by the bootloader
> - regulator-X is left on boot by the bootloader at 2000 mV to supply
>   device-B and device-C.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: core: Add destroy_regulator()
      commit: e1794aa43f17bf2512c10370c6be6ea24a6f29d0

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
