Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD2A240D38
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Aug 2020 20:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbgHJS6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 14:58:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:53832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728071AbgHJS6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 14:58:19 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3DD920774;
        Mon, 10 Aug 2020 18:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597085899;
        bh=u7PuXZEqeKunOaHhKj/3xF6yMMpUtKNV+V4e9KEv7Tk=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=KKnzD8ZWmOJcfG/H5Vbx7+ZyeLnZ7euP6YBDAI4H07NvU9Z3uJyzaaZjhnXdG0ke0
         Qt/57iuE1sRTs9OEqXCHuuYXF99LrEB+xmYDU1ICxqJZOlq3TJbsLiE0ZD+hqB/Ly5
         fmhS6Xo5IGW1aH8Vrp4bhZqvIjDZHABKWusbFJuE=
Date:   Mon, 10 Aug 2020 19:57:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Colin King <colin.king@canonical.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <20200810093931.50624-1-colin.king@canonical.com>
References: <20200810093931.50624-1-colin.king@canonical.com>
Subject: Re: [PATCH] regulator: fix spelling mistake "Cant" -> "Can't"
Message-Id: <159708587290.21583.4925368980262499422.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Aug 2020 10:39:31 +0100, Colin King wrote:
> There is a spelling mistake in a dev_err message. Fix it.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: fix spelling mistake "Cant" -> "Can't"
      commit: 09dad81e0f1701ea26babe2442a1478d6ad447d3

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
