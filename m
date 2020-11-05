Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8172A83D0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 17:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731537AbgKEQpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 11:45:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:48446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731499AbgKEQpp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 11:45:45 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 910AA20936;
        Thu,  5 Nov 2020 16:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604594745;
        bh=5GtUcMVbIbMwJINTBvMDEPNB9/OMZ9q79CwICoAHVno=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=yj5inxN+mnKyEYIugr+Z1fkoZh6rAraTbztF8eD02BARmtelJx0x7HaGKkXyrjJqh
         FaMrtz370+hPKjSnrI0pCNFTu1SG/ZAU2A8067G3rYZnp0XD4Kqsdc4/xRkK/Bhw4G
         PH+HAWASy/aWu7jbfrg+JCjnJVDuT2qdywnQVT8I=
Date:   Thu, 05 Nov 2020 16:45:33 +0000
From:   Mark Brown <broonie@kernel.org>
To:     perex@perex.cz, Zou Wei <zou_wei@huawei.com>, tiwai@suse.com,
        matthias.bgg@gmail.com, lgirdwood@gmail.com
Cc:     jiaxin.yu@mediatek.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-mediatek@lists.infradead.org
In-Reply-To: <1604579287-25251-1-git-send-email-zou_wei@huawei.com>
References: <1604579287-25251-1-git-send-email-zou_wei@huawei.com>
Subject: Re: [PATCH -next v2] ASoC: mediatek: mt8192: Make some symbols static
Message-Id: <160459472201.54851.5938224676364159324.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Nov 2020 20:28:07 +0800, Zou Wei wrote:
> Fix the following sparse warnings:
> 
> ./mt8192-dai-i2s.c:2040:5: warning: symbol 'mt8192_dai_i2s_get_share' was not declared. Should it be static?
> ./mt8192-dai-i2s.c:2060:5: warning: symbol 'mt8192_dai_i2s_set_priv' was not declared. Should it be static?
> ./mt8192-afe-gpio.c:15:16: warning: symbol 'aud_pinctrl' was not declared. Should it be static?
> ./mt8192-afe-pcm.c:70:5: warning: symbol 'mt8192_get_memif_pbuf_size' was not declared. Should it be static?
> ./mt8192-afe-pcm.c:2137:39: warning: symbol 'mt8192_afe_component' was not declared. Should it be static?

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8192: Make some symbols static
      commit: df3d6390fa0ad48eecbe0b48acb4d364a70cd378

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
