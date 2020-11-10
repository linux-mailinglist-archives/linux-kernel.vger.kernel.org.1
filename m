Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99E9C2AE1E5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 22:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731711AbgKJVir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 16:38:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:41006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732106AbgKJVin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 16:38:43 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20AAD20825;
        Tue, 10 Nov 2020 21:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605044322;
        bh=W6kPWSpDRV76sBY2CjO+E9rd9CE/qekDVftggdZGvf4=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=HR/lG7JvOCgTlHK0EETDATqkhgj+xe9XLPWybpl5fW+rGRgu0uMODHBWNEkbiVmoh
         Pcpk4GY9eqoShUpUoJumWOA2y7XleWoRlyRhLu3/oizfsZP10bBjsjeIvZxKSFdu4i
         P83kCmDBN3B9wLCZimTnEtSwGGmx1ieoAtGfoSV8=
Date:   Tue, 10 Nov 2020 21:38:27 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        "open list:VOLTAGE AND CURRENT REGULATOR FRAMEWORK" 
        <linux-kernel@vger.kernel.org>
In-Reply-To: <20201106064817.3290927-1-pihsun@chromium.org>
References: <20201106064817.3290927-1-pihsun@chromium.org>
Subject: Re: [PATCH] regulator: core: don't disable regulator if is_enabled return error.
Message-Id: <160504430244.42164.17292901950690336588.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Nov 2020 14:48:17 +0800, Pi-Hsun Shih wrote:
> In regulator_late_cleanup when is_enabled failed, don't try to disable
> the regulator since it would likely to fail too and causing confusing
> error messages.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: core: don't disable regulator if is_enabled return error.
      commit: c088a4985e5f6f6c2cbe5a6953357dfc30b7c57e

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
