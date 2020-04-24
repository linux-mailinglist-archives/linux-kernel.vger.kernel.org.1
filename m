Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 335B81B7703
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Apr 2020 15:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbgDXNcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Apr 2020 09:32:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:41248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbgDXNcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 09:32:16 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC8AA206D7;
        Fri, 24 Apr 2020 13:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587735136;
        bh=jjfD4t0EhuImzsXfQ/fF9aviECgkb/l+LSUG80W8/jc=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=wS1D2MbcluUeOQpv+ZDlrIT543Rk/a/b7d3ORjGrYLkYFUX6PJgMWFxrXP01uB6dd
         uWyV7vJnjnj0pIZwdDdcFI3C9ab9YZRoVtyZVnYNm716zS9dQtdEp607SkafAZsiE/
         dMavrJBO2Xpm9ZxdwrlB+oFc7ZGnX2KAxVn5kiOw=
Date:   Fri, 24 Apr 2020 14:32:13 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        AceLan Kao <acelan.kao@canonical.com>,
        Aaron Sierra <asierra@xes-inc.com>
In-Reply-To: <20200424123358.144850-1-acelan.kao@canonical.com>
References: <20200424123358.144850-1-acelan.kao@canonical.com>
Subject: Re: [PATCH v2] regmap-i2c: add 16-bit width registers support
Message-Id: <158773513373.17592.13504442892295140548.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Apr 2020 20:33:58 +0800, AceLan Kao wrote:
> This allows to access data with 16-bit width of registers
> via i2c SMBus block functions.
> 
> The multi-command sequence of the reading function is not safe
> and may read the wrong data from other address if other commands
> are sent in-between the SMBus commands in the read function.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-5.8

Thanks!

[1/1] regmap-i2c: add 16-bit width registers support
      commit: 82f25bd73c0bee4d29df47007a4f7290695b7db7

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
