Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B25FB223FCA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 17:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbgGQPkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jul 2020 11:40:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:59010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726256AbgGQPkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 11:40:06 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD3F3207DD;
        Fri, 17 Jul 2020 15:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595000406;
        bh=zZZXKkoo6jRo9cnEc915dxdlDYp+1O3LpZF62jp+s98=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=wCWypbZZF7PLbOUbetRlsgfqG3+u73IGwbKUGEPdUuXOLMwHzN+f+DZ+/7TKvV0JI
         osW7ch72As13d4Dc9d38g2D99ZnGpzLIsPL0QCWJMziadUCdX5I3S76a6fPKQjTSl/
         JB/IN903+jeKxLY/cxvXNV2tPW6jZ9+shlCQ+rTo=
Date:   Fri, 17 Jul 2020 16:39:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, kuninori.morimoto.gx@renesas.com,
        lgirdwood@gmail.com, Jing Xiangfeng <jingxiangfeng@huawei.com>,
        perex@perex.cz, khilman@baylibre.com, jbrunet@baylibre.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        alsa-devel@alsa-project.org, linux-amlogic@lists.infradead.org
In-Reply-To: <20200717082242.130627-1-jingxiangfeng@huawei.com>
References: <20200717082242.130627-1-jingxiangfeng@huawei.com>
Subject: Re: [PATCH v2] ASoC: meson: fixes the missed kfree() for axg_card_add_tdm_loopback
Message-Id: <159500037996.27597.11571662104348843402.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jul 2020 16:22:42 +0800, Jing Xiangfeng wrote:
> axg_card_add_tdm_loopback() misses to call kfree() in an error path. We
> can use devm_kasprintf() to fix the issue, also improve maintainability.
> So use it instead.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: meson: fixes the missed kfree() for axg_card_add_tdm_loopback
      commit: bd054ece7d9cdd88e900df6625e951a01d9f655e

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
