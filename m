Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1F22AC554
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 20:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730686AbgKITrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 14:47:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:43016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730520AbgKITrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 14:47:51 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEC00206A4;
        Mon,  9 Nov 2020 19:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604951271;
        bh=SC0WlsUL7zB7Fa6m1SKYkKnl3mky8gHtZNC3j2/ha08=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=LHb2pUT44pXYJNr27HVID6Id8m0Qzi/ubUVctEoYzQ0zjvOMrVcrpkcNxo2mh3qaN
         qtAf75Oly6iydxwBkleCaFL+n8rKy3M0nI1RmIpYzfCLVQdly4ZKQqLqJXjc6uO1Na
         u+QKvG3GVc3S4PwJ8YrSvKK9fGwe4oefy/+QxuRA=
Date:   Mon, 09 Nov 2020 19:47:37 +0000
From:   Mark Brown <broonie@kernel.org>
To:     perex@perex.cz, festevam@gmail.com, nicoleotsuka@gmail.com,
        alsa-devel@alsa-project.org, Shengjiu Wang <shengjiu.wang@nxp.com>,
        Xiubo.Lee@gmail.com, tiwai@suse.com, timur@kernel.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <1604715643-29507-1-git-send-email-shengjiu.wang@nxp.com>
References: <1604715643-29507-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_aud2htx: Remove dev_err() usage after platform_get_irq()
Message-Id: <160495125733.49154.17421164873154285573.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Nov 2020 10:20:43 +0800, Shengjiu Wang wrote:
> platform_get_irq() would print error message internally, so dev_err()
> after platform_get_irq() is not needed

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_aud2htx: Remove dev_err() usage after platform_get_irq()
      commit: 1cc3245b2c7464b6d6ad210b0e333781676de519

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
