Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25CCD2FF4DB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 20:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbhAUTmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 14:42:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:46894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726641AbhAUTl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 14:41:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C42623A56;
        Thu, 21 Jan 2021 19:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611258046;
        bh=s1jlUfMfsaHTIc9gkEQJ9sgRg12jc7rlJoxdPRyWv10=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=qaeDy2xteG1xN7RtCPJ7OZFTwqgEvwz6MHWpN2ZuYhqbeJaGT8GzeHWlNj4SobKkJ
         sFY1zYdZQyN/Nj3evDp4ytHl4F0pGlCMGXAabU7FT8SYKXH2GKdUfazFhsKespdtIz
         tPQyzN6InuQaCbtVUwuyLYhF+WREDxeFQjhnzqKQGNq77jAi9jIAifhNWNJGMRivyo
         d95Gz854KmUppyXBXw2NPCYKqwW2t3gUkzdMqxoQSvQZMMrByklP58NI6uzVmWL1jG
         nIvBwgm9OovYpV0Zt4sKVRMi+p+oyUAEkcd3GzWfC+Pvg92NozkXQS0vCQJZ5JFUI9
         Au0LrUetmI7Og==
From:   Mark Brown <broonie@kernel.org>
To:     Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        rafael@kernel.org
In-Reply-To: <1611215961-33725-1-git-send-email-abaci-bugfix@linux.alibaba.com>
References: <1611215961-33725-1-git-send-email-abaci-bugfix@linux.alibaba.com>
Subject: Re: [PATCH] regmap: Assign boolean values to a bool variable
Message-Id: <161125800693.35914.5495500952038765066.b4-ty@kernel.org>
Date:   Thu, 21 Jan 2021 19:40:06 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jan 2021 15:59:21 +0800, Jiapeng Zhong wrote:
> Fix the following coccicheck warnings:
> 
> ./drivers/base/regmap/regcache.c:71:3-18: WARNING: Assignment of
> 0/1 to bool variable.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: Assign boolean values to a bool variable
      commit: b67498d630037f509a14b208b1994b38714372ad

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
