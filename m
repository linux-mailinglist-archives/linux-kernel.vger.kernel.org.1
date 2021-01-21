Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 087BC2FF4EB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 20:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbhAUTne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 14:43:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:47186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726588AbhAUTmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 14:42:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2863723A40;
        Thu, 21 Jan 2021 19:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611258076;
        bh=mK8ZBd6+aLnUQg2YdqOioJ1XgwXpNWUllaTM7z4jHDM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=rVZiREjclkXuZcjdwq3erYISSIpZW7sGZVNBGwfASS0z5xJIE+Aab0L727juDl8Wv
         zsPlPlpmplYI4+y5s6T6TAq4+vebdtcRFyPajS3gs+otUt5zKAUuSEl0bAWvxIprk+
         RthUkssidHcWilVU4Iscqpsh4gakC72jFc0fhT7FYSbNET9AVqDKM87egnnTr5zpyh
         g54CROEA6WFjC2vT6ht1+wM5/+K3C0VeSV56RafKg4wDfOCv8577VMLA0qKWxxMube
         rAMZ/3djkTaZi1BQZKznKHlRUEJ0kb+IEJ8EkDpbTOGqNyDbAuTsM7xez9z6mF+4Iz
         1j5vZAfGQBe8w==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210120151307.1726876-1-arnd@kernel.org>
References: <20210120151307.1726876-1-arnd@kernel.org>
Subject: Re: [PATCH] regulator: remove ab3100 driver
Message-Id: <161125803282.35944.14775326202406486822.b4-ty@kernel.org>
Date:   Thu, 21 Jan 2021 19:40:32 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jan 2021 16:12:24 +0100, Arnd Bergmann wrote:
> The ST-Ericsson U300 platform is getting removed, so this driver is no
> longer needed.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: remove ab3100 driver
      commit: d93d6f52bd9e3aa6f37b7ea5657e4bee50a4b0a4

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
