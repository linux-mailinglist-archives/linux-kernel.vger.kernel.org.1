Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18248299AEA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 00:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408024AbgJZXp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 19:45:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:40908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408014AbgJZXp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 19:45:28 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E9D220714;
        Mon, 26 Oct 2020 23:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603755927;
        bh=W0GHurfLARJJgjJlVQfEHZ2+dhsR3twtgbYlogiwXaA=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=Yz8lb+7H9sq3ef9LwgvLJkqXJdBGord+M51p3ULMYoUFXPA5UZ0JECfvUu2GR56w5
         ifKXrxvwpf7S4k3iXGP7Ype3JA9Ie+K5C6/eCplWzMHZ38QP1N/3q5XqC/qsJXzjQl
         cWQoutw5FwocAGv9T24Hqhzl+c+9HmpElL+cSwPg=
Date:   Mon, 26 Oct 2020 23:45:23 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Xiubo.Lee@gmail.com, timur@kernel.org,
        Shengjiu Wang <shengjiu.wang@nxp.com>, perex@perex.cz,
        tiwai@suse.com, festevam@gmail.com, alsa-devel@alsa-project.org,
        nicoleotsuka@gmail.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <1602557360-18795-1-git-send-email-shengjiu.wang@nxp.com>
References: <1602557360-18795-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH v2] ASoC: fsl_spdif: Add support for higher sample rates
Message-Id: <160375592346.31132.5202638686787064614.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Oct 2020 10:49:20 +0800, Shengjiu Wang wrote:
> Add 88200Hz and 176400Hz sample rates support for TX.
> Add 88200Hz, 176400Hz, 192000Hz sample rates support for RX.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_spdif: Add support for higher sample rates
      commit: 1bfa3eaa4511256ab14555ab2573e6e75194b1fa

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
