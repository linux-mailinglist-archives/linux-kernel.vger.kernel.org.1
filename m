Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 277653036B7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 07:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729932AbhAZGkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 01:40:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:57074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729694AbhAYOlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 09:41:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 58D2B206C1;
        Mon, 25 Jan 2021 14:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611585390;
        bh=VY0BdzVk8lwdAASKNZugeQhr0krbpUilmr6rOKKq7/4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Rb/LAeCvNZBxAixNzF7uIy9UGw3WdUp6UJRGhoQWdKYW9ZI1tVzpzmCnJlO5n7RVs
         +PXIkTiihACb45DOOfwHERCfd3g4tXH8nVO6NHOnnb+jPkWickt3RJ6tckKlZDvoOT
         Xu2qk5Vqkaj+3Ym5JYv62HsjtvLDyNpwiWfIzNwanafezkLcnGvNTY0zV1HwB1zUyQ
         MU8iqgXS1EoEbLwGNF5RiNvD0lUSBfK0lRwr5xjhACO81rOkoZjCi7+IH5crqJOxRz
         CQ1qw7lqHVVi5qqedHpENTYPYtOdP0NGIYsje1XDm4AaM+SrRfGUluQKJizEeINsyl
         TnzWsJH1JgAcg==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>
In-Reply-To: <20210122183250.370571-1-hdegoede@redhat.com>
References: <20210122183250.370571-1-hdegoede@redhat.com>
Subject: Re: [PATCH] regulator: core: Avoid debugfs: Directory ... already present! error
Message-Id: <161158534939.35689.1275386802086098799.b4-ty@kernel.org>
Date:   Mon, 25 Jan 2021 14:35:49 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jan 2021 19:32:50 +0100, Hans de Goede wrote:
> Sometimes regulator_get() gets called twice for the same supply on the
> same device. This may happen e.g. when a framework / library is used
> which uses the regulator; and the driver itself also needs to enable
> the regulator in some cases where the framework will not enable it.
> 
> Commit ff268b56ce8c ("regulator: core: Don't spew backtraces on
> duplicate sysfs") already takes care of the backtrace which would
> trigger when creating a duplicate consumer symlink under
> /sys/class/regulator/regulator.%d in this scenario.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: core: Avoid debugfs: Directory ... already present! error
      commit: dbe954d8f1635f949a1d9a5d6e6fb749ae022b47

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
