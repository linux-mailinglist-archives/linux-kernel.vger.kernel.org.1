Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81370248D5B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 19:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgHRRkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 13:40:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:58764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726716AbgHRRkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 13:40:09 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6245820738;
        Tue, 18 Aug 2020 17:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597772408;
        bh=Mun8Zvwkueefix/PFumh0SshTrCepY55qD9WD9GM0qw=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=wMkSFmSI0UreojJOy+MK4zR7JDQkK9smVf9sxLirFHenZpY0bQ73o8UmOcZKwqy4Z
         WAww+UDCCdYLUQocD3sr5u3wf/15p8Ys1DVmYCnRbI5reZ2msd5atBubMkBLf75Lze
         OY4dPuRK5/ohBG9NvzSU1PA52oLAbpjXEatZwYeM=
Date:   Tue, 18 Aug 2020 18:39:38 +0100
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <20200818133701.462958-1-gregkh@linuxfoundation.org>
References: <20200818133701.462958-1-gregkh@linuxfoundation.org>
Subject: Re: [PATCH] regulator: dbx500: no need to check return value of debugfs_create functions
Message-Id: <159777237821.25048.13792265408778074283.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Aug 2020 15:37:01 +0200, Greg Kroah-Hartman wrote:
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: dbx500: no need to check return value of debugfs_create functions
      commit: 8bdaa43808b7481eb61b251ae0e4ca308ee1093d

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
