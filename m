Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34BD52A95D3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 12:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbgKFLyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 06:54:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:52448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726565AbgKFLyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 06:54:33 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFDC820720;
        Fri,  6 Nov 2020 11:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604663672;
        bh=uajC+yCxqwMRDpmS8LKphYFTZOXNRJlq1O5B9n/FUwg=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=Nut+t71K1QLfsGV5Z84ZT/UAF3iYgWxXAonnqb4K1HqIsuRRgK9fCIHrZcYLdYmXL
         QZgvyE+EdWgVTfon/QKg/XWgyDLIs9LK8HDzsWm3WTAgVAaTHjGgaivIeOqwcnKH2G
         2z00OS7Kj65xRr35+ScXVH/0Oi+YDTXQcYS2Zj70=
Date:   Fri, 06 Nov 2020 11:54:20 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>, perex@perex.cz,
        Xiubo.Lee@gmail.com, festevam@gmail.com, robh+dt@kernel.org,
        nicoleotsuka@gmail.com, timur@kernel.org, tiwai@suse.com,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <1604281947-26874-1-git-send-email-shengjiu.wang@nxp.com>
References: <1604281947-26874-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH v3 1/2] ASoC: dt-bindings: fsl_aud2htx: Add binding doc for aud2htx module
Message-Id: <160466365499.22812.9217467877032314221.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Nov 2020 09:52:26 +0800, Shengjiu Wang wrote:
> AUD2HTX (Audio Subsystem TO HDMI TX Subsystem) is a new
> IP module found on i.MX8MP.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: fsl_aud2htx: Add binding doc for aud2htx module
      commit: 40f4c56d08f2a95f4f3b036987f171dde69ddd36
[2/2] ASoC: fsl_aud2htx: Add aud2htx module driver
      commit: 8a24c834c053ef1b0cdefbd9c5bcb487cbc5068f

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
