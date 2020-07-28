Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF1C2230F49
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 18:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731426AbgG1Qba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 12:31:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:47126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731070AbgG1Qba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 12:31:30 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94F0C2074F;
        Tue, 28 Jul 2020 16:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595953890;
        bh=U2ae0+qxf5T7aHnxqe5Yy151vsXACiOFQ0qZgH3TxhQ=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=ow/wIniTZDzPUVFdpzhFD61DWmtDPjzS+GSVZk0YknUaqHxM89uMWdsnt18pv+4bj
         fXUUftnu4Vp2f22G8RpxVx14rCeq4ai5kvLUhnvEWGCNuULgWgcr6x1Fbj1VBFFPRx
         YiV47e9i99mh+vAQVrSaPzGRV4OzbXJEOYwFuoz0=
Date:   Tue, 28 Jul 2020 17:31:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Guenter Roeck <groeck@chromium.org>,
        "open list:VOLTAGE AND CURRENT REGULATOR FRAMEWORK" 
        <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Prashant Malani <pmalani@chromium.org>
In-Reply-To: <20200728091909.2009771-1-pihsun@chromium.org>
References: <20200728091909.2009771-1-pihsun@chromium.org>
Subject: Re: [PATCH] regulator: cros-ec-regulator: Fix double free of desc->name.
Message-Id: <159595387216.15267.9465724386859282869.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jul 2020 17:19:09 +0800, Pi-Hsun Shih wrote:
> The desc->name field is allocated with devm_kstrdup, but is also kfreed
> on the error path, causing it to be double freed. Remove the kfree on
> the error path.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: cros-ec-regulator: Fix double free of desc->name.
      commit: 176cf704425f3d22603d379ffa4a1033a24a779d

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
