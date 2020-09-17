Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16DE226E4F6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 21:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgIQTDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 15:03:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:59640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726664AbgIQS7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 14:59:16 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E0D42072E;
        Thu, 17 Sep 2020 18:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600369134;
        bh=rr3dqiLdvWkyEd1pfoXZ2dEs5VJ/LPeZYXSEk8qGaeU=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=WT/5cMsw/rbv3BnUcqZRGNf/BOUINNMTlTZ+pOjSZQCF/e3upkj9SF/lYLH0xbIHk
         knAvevwoH1pJVEONygW3spCBkpPbc/eFU6Xc9GFvWmZCT87Vb73Y4/BfTmWbp+9et/
         eIAveXNHZV8oI7X59dCPx2weHGAwA56qUpy6iyXE=
Date:   Thu, 17 Sep 2020 19:58:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
In-Reply-To: <20200917120828.12987-1-ckeepax@opensource.cirrus.com>
References: <20200917120828.12987-1-ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v2] regmap: debugfs: Fix handling of name string for debugfs init delays
Message-Id: <160036907918.20286.4753770618414417911.b4-ty@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Sep 2020 13:08:28 +0100, Charles Keepax wrote:
> In regmap_debugfs_init the initialisation of the debugfs is delayed
> if the root node isn't ready yet. Most callers of regmap_debugfs_init
> pass the name from the regmap_config, which is considered temporary
> ie. may be unallocated after the regmap_init call returns. This leads
> to a potential use after free, where config->name has been freed by
> the time it is used in regmap_debugfs_initcall.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: debugfs: Fix handling of name string for debugfs init delays
      commit: 94cc89eb8fa5039fcb6e3e3d50f929ddcccee095

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
