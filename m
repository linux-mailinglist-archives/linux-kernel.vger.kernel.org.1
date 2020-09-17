Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7F826E4CB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 20:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgIQS6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 14:58:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:58864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726375AbgIQS6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 14:58:13 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B2E4221E3;
        Thu, 17 Sep 2020 18:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600369092;
        bh=Hb/K8ZsiBzGs+A5mWIRqpLkTh6KT3vAf24qrmwesNvE=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=BTpzay5LMze2Qc0LojFYSVs1cLmpi/TeZgso+vxk5eNTufS9xvOIeKxt9hgzgsH/6
         WAit93JeSDMdDkQsyni4UTi5OJrI+H6D9t0qO0i6dSJ8UVUqd90vuCa3RWc8OSzJkP
         897soZrlyBX7b4pp7fqIn9mA2EasrUMwf57T3o3k=
Date:   Thu, 17 Sep 2020 19:57:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, lgirdwood@gmail.com,
        Camel Guo <camel.guo@axis.com>, dmurphy@ti.com
Cc:     alsa-devel@alsa-project.org, Camel Guo <camelg@axis.com>,
        linux-kernel@vger.kernel.org, kernel@axis.com
In-Reply-To: <20200908090417.16695-1-camel.guo@axis.com>
References: <20200908090417.16695-1-camel.guo@axis.com>
Subject: Re: [PATCH] ASoC: tlv320adcx140: Fix digital gain range
Message-Id: <160036900935.20113.13746695477949199568.b4-ty@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Sep 2020 11:04:17 +0200, Camel Guo wrote:
> According to its datasheet, the digital gain should be -100 dB when
> CHx_DVOL is 1 and 27 dB when CHx_DVOL is 255. But with the current
> dig_vol_tlv, "Digital CHx Out Volume" shows 27.5 dB if CHx_DVOL is 255
> and -95.5 dB if CHx_DVOL is 1. This commit fixes this bug.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tlv320adcx140: Fix digital gain range
      commit: 73154aca4a03a2ab4833fd36683feb884af06d4b

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
