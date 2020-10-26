Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11675299AF7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 00:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408170AbgJZXqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 19:46:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:42284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408142AbgJZXqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 19:46:00 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD3A820714;
        Mon, 26 Oct 2020 23:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603755960;
        bh=We4cdzGBDbRGEyCoU6OWymvSRmeCba+BnioTbAIZiNk=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=olvGEJR0odQ2kDH7Qp2DHq32wXNxiSwvBni1eu1s8nnZ2wJhif7biOs7zkMfpj1Xo
         QIRQALE/TQLbs1OjML4U+us6UAjnKC+buc+NGO0aea2xvGTGycmBKWxj0B60/EicVU
         x0S5AGQt6xdzHrNHVpCnq3Kbs9D2QZhhZha0tASk=
Date:   Mon, 26 Oct 2020 23:45:56 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     lars@metafoo.de, tiwai@suse.com, nuno.sa@analog.com,
        lgirdwood@gmail.com
In-Reply-To: <20201019105313.24862-1-alexandru.ardelean@analog.com>
References: <20201019105313.24862-1-alexandru.ardelean@analog.com>
Subject: Re: [PATCH] ASoC: adau1977: remove platform data and move micbias bindings include
Message-Id: <160375592347.31132.7208017773603046861.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Oct 2020 13:53:13 +0300, Alexandru Ardelean wrote:
> The change removes the platform_data include/definition. It only contains
> some values for the MICBIAS.
> These are moved into 'dt-bindings/sound/adi,adau1977.h' so that they can be
> used inside device-trees. When moving then, they need to be converted to
> pre-compiler defines, so that the DT compiler can understand them.
> 
> The driver then, also needs to include the new
> 'dt-bindings/sound/adi,adau1977.h' file.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: adau1977: remove platform data and move micbias bindings include
      commit: ab589bac553f79d559952aa088480a72258ac5bc

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
