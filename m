Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A15CF1CFB32
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 18:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbgELQo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 12:44:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:41802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbgELQo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 12:44:59 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D50F20720;
        Tue, 12 May 2020 16:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589301899;
        bh=HIPh/7Pej6FxAyJY1UIQvN4prK7E723HFpfiw6vDSfk=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=SdXK2HcDTUQNahZO54CHbOKW0fQNrt//a/8i+Nwgy52LLng9X2Gq9TmQ7UZltrKRT
         xkvuAbUYYxEDu3a/45b5sustEBFxAGcpuCPWjvNAQLxWNDKNVfHJ0wVJS8uGxbtTjX
         +XWOhYI0/02jNATWfj7kXndA0HqvJnY1UY0GCtyY=
Date:   Tue, 12 May 2020 17:44:56 +0100
From:   Mark Brown <broonie@kernel.org>
To:     lee.jones@linaro.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linus.walleij@linaro.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
In-Reply-To: <20200512100705.246349-1-christophe.jaillet@wanadoo.fr>
References: <20200512100705.246349-1-christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] ASoC: ux500: mop500: Fix some refcounted resources issues
Message-Id: <158930188456.55827.11720310632308061350.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 May 2020 12:07:05 +0200, Christophe JAILLET wrote:
> There are 2 issues here:
>    - if one of the 'of_parse_phandle' fails, calling 'mop500_of_node_put()'
>      is a no-op because the 'mop500_dai_links' structure has not been
>      initialized yet, so the referenced are not decremented
>    - The reference stored in 'mop500_dai_links[i].codecs' is refcounted
>      only once in the probe and must be decremented only once.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.8

Thanks!

[1/1] ASoC: ux500: mop500: Fix some refcounted resources issues
      commit: 4e8748fcaeec073e3ba794871ce86c545e4f961f

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
