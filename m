Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 047EB259BD1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 19:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729905AbgIARHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 13:07:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:36598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729486AbgIAPSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:18:21 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9B09214F1;
        Tue,  1 Sep 2020 15:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598973501;
        bh=G9lRoCqtutdJhrTRAYTbOfsRmk/iYWksD4gRggGFpF0=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=PUHaCQ7MHB9fNoxA52ESx3JqtH57jOx6fl017yOgjt+PabE3DmJPNbHso4Kuzk2WI
         ooVNY52/SDRcDxZDZU3rzL/CcHT2PKnNR/xVd7zMhg+txyQqdSVkR5KkNFwHTAO6vP
         6M4AZop+jfTjbbP2PRygCSj552WxSa1hVgoXnxB4=
Date:   Tue, 01 Sep 2020 16:17:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Camel Guo <camel.guo@axis.com>, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, dmurphy@ti.com
Cc:     Camel Guo <camelg@axis.com>, kernel@axis.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
In-Reply-To: <20200901135736.32036-1-camel.guo@axis.com>
References: <20200901135736.32036-1-camel.guo@axis.com>
Subject: Re: [PATCH v4] ASoC: tlv320adcx140: Fix accessing uninitialized adcx140->dev
Message-Id: <159897346138.26776.4795793830784524613.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Sep 2020 15:57:35 +0200, Camel Guo wrote:
> In adcx140_i2c_probe, adcx140->dev is accessed before its
> initialization. This commit fixes this bug.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tlv320adcx140: Fix accessing uninitialized adcx140->dev
      commit: 2569231d71dff82cfd6e82ab3871776f72ec53b6

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
