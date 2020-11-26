Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0B32C5CD2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 21:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389585AbgKZUGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 15:06:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:35964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728118AbgKZUGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 15:06:16 -0500
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net [92.233.91.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 705F420678;
        Thu, 26 Nov 2020 20:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606421175;
        bh=EM0Gc7hlnQ4Cs9nEMQ22xspbkHodETF50L21WryubTw=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=1Za8wBXmvqp6zDKkhxRm/KTTcX+iZIfA2yWgsi5di58elphv2wjzubUVtM0UwCv4H
         pvTWgv2dyztFSu2GDuCl0gQJoTyI8mRy1J7JJqW+QCgDw6uaItaKn1vfpl+8Udzhns
         d388oFO8ZegfVpPvLZbVvFr/JUuw5lLqCic6gh48=
Date:   Thu, 26 Nov 2020 20:05:50 +0000
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org,
        Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     hui.wang@canonical.com, linux-kernel@vger.kernel.org,
        rander.wang@linux.intel.com, ranjani.sridharan@linux.intel.com,
        pierre-louis.bossart@linux.intel.com,
        srinivas.kandagatla@linaro.org, gregkh@linuxfoundation.org,
        sanyog.r.kale@intel.com, bard.liao@intel.com, jank@cadence.com,
        tiwai@suse.de, vinod.koul@linaro.org
In-Reply-To: <20201125130128.15952-1-yung-chuan.liao@linux.intel.com>
References: <20201125130128.15952-1-yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH] regmap: sdw: add required header files
Message-Id: <160642115072.9278.5484290158146538846.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Nov 2020 21:01:28 +0800, Bard Liao wrote:
> Explicitly add header files used by regmap SoundWire support.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: sdw: add required header files
      commit: d9a500b2985b139d7019231ec16e379d2031cb40

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
