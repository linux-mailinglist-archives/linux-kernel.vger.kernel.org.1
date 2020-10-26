Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA395299AFA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 00:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408235AbgJZXqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 19:46:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:42926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408220AbgJZXqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 19:46:21 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0B5020714;
        Mon, 26 Oct 2020 23:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603755981;
        bh=9AbYxVaOs4JLDjH4TqJYrI1yDoSHClRW3bLhQND9QQc=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=ff0ltz1/baOuGcau/EHKSBsbDpjYtpS/+w4a196NqNZbOV09MvIQbqSe3lcPBS6v/
         VTjjxO6kXUm/95xoLikQuzTjXoRawaDc60RDg5oUspU/JAIqBLRLmVeHabJMKciP+B
         D53DOs3yz8C+/pHISFUY5D9sY3k5UtBmUomQduW4=
Date:   Mon, 26 Oct 2020 23:46:16 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Xiubo.Lee@gmail.com, timur@kernel.org, lgirdwood@gmail.com,
        Shengjiu Wang <shengjiu.wang@nxp.com>, perex@perex.cz,
        devicetree@vger.kernel.org, tiwai@suse.com, festevam@gmail.com,
        robh+dt@kernel.org, alsa-devel@alsa-project.org,
        nicoleotsuka@gmail.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <1602739728-4433-1-git-send-email-shengjiu.wang@nxp.com>
References: <1602739728-4433-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: fsl_spdif: Add new compatible string for i.MX8QM
Message-Id: <160375592348.31132.8709437914280376392.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Oct 2020 13:28:47 +0800, Shengjiu Wang wrote:
> Add new compatible string "fsl,imx8qm-spdif" for supporting spdif
> module on i.MX8QM.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: fsl_spdif: Add new compatible string for i.MX8QM
      commit: 87b2fc1139a13cf81d0a95fb2cbaba7daeee8908
[2/2] ASoC: fsl_spdif: Add support for i.MX8QM platform
      commit: 516232e3609f485be04445b03723fbaed64a5321

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
