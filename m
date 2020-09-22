Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6761E273709
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 02:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbgIVAHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 20:07:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:40684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726537AbgIVAHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 20:07:00 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 707A2207C4;
        Tue, 22 Sep 2020 00:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600733220;
        bh=90gCaWC1kc0PD8Hy2UX++BGa6s7lujDgPwSt6K5iqws=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=ySiwoydH41o8/zzdnIZjAP/A9UcFb7bgGTgTq4bv/WOlfoFLcKBUVMs+aucTL+Qqq
         HQhhWHER92iJCMhFDyEUmjUBZHL5OGjOmnsDFWT5ZJmaVFUd9M2dSSX3WCSouY9S6g
         msXlXJkI0/56mY7ZzbyZTjkdWwk3ztd2ye0+XPwI=
Date:   Tue, 22 Sep 2020 01:06:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Colin King <colin.king@canonical.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <20200920142454.33352-1-colin.king@canonical.com>
References: <20200920142454.33352-1-colin.king@canonical.com>
Subject: Re: [PATCH] regulator: fix indentation issue
Message-Id: <160073316153.6369.11968491435935833807.b4-ty@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Sep 2020 15:24:54 +0100, Colin King wrote:
> There is a return statement that is indented with an extra
> space, fix this by removing it.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: fix indentation issue
      commit: be35cc4695aa1b26d00b30bfd1d8408eddd357ec

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
