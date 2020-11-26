Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC502C5CD0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 21:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387602AbgKZUGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 15:06:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:35328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728118AbgKZUGB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 15:06:01 -0500
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net [92.233.91.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 451FB21D91;
        Thu, 26 Nov 2020 20:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606421160;
        bh=7rQmTmv1ksW+ZfZDI/e0wJHZOLdUZO3zjTXU1u/XYRg=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=SendZoJ+GTnIUWwxUbppNh9LNNQhZqfDbd82QiKtYOcnEe/bVOcvt5L451L0lmF/x
         AucA5PdvTJHLoxu1C27BT2lv0wJqoNb2mYtdXEAN8L+ZthqUG68b7aC3Znj0/on1jL
         FW/aebBnRyRvXFRMWNsq2shqbDkyoF6zxgP/+6vI=
Date:   Thu, 26 Nov 2020 20:05:35 +0000
From:   Mark Brown <broonie@kernel.org>
To:     jbrunet@baylibre.com, tiwai@suse.com,
        kuninori.morimoto.gx@renesas.com, cychiang@chromium.org,
        perex@perex.cz, tzungbi@google.com, lgirdwood@gmail.com,
        grandmaster@al2klimov.de, pankaj.laxminarayan.bharadiya@intel.com,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
In-Reply-To: <1606372608-2329-1-git-send-email-shengjiu.wang@nxp.com>
References: <1606372608-2329-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: hdmi-codec: Add RX support
Message-Id: <160642112480.9090.16664768187050244422.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Nov 2020 14:36:48 +0800, Shengjiu Wang wrote:
> HDMI interface can also be used as receiver, this patch is to
> add such support. The most difference compare with TX is that RX
> don't need to get edid information.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: hdmi-codec: Add RX support
      commit: 144f836646989783cb018d00fa69f3f8dab58349

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
