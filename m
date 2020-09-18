Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98E2426FC22
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 14:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgIRMK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 08:10:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:44124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgIRMK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 08:10:27 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B12DE21582;
        Fri, 18 Sep 2020 12:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600431027;
        bh=jyB2TyUpI81SJwQVpbwWyHtiuHuyBzI5MEJhLBibCqs=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=L8yu8nvOEqfFSi3/nVfSdE1YKowGsG2pkLUCxjdX4tI0cr3QlG0R/JmTrNpAAfL7S
         lUp3Hh+pNOzVW+IiirHmDVdctd3xC15jBOBD8XiS5zdolIO6h3SmwdWDm1kdAo/19A
         KbgmeECLtfyIo229x+kOYFf3jR+6OzWBbw82oRzg=
Date:   Fri, 18 Sep 2020 13:09:36 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com
In-Reply-To: <20200918112002.15216-1-ckeepax@opensource.cirrus.com>
References: <20200918112002.15216-1-ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH] regmap: debugfs: Add back in erroneously removed initialisation of ret
Message-Id: <160043097646.49190.10255254268410310518.b4-ty@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Sep 2020 12:20:02 +0100, Charles Keepax wrote:
> 


Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: debugfs: Add back in erroneously removed initialisation of ret
      commit: d36cb0205f034e943aa29e35b59c6a441f0056b5

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
