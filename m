Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A514621AA1A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 00:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgGIWA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 18:00:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:44038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbgGIWA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 18:00:28 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08D6320774;
        Thu,  9 Jul 2020 22:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594332028;
        bh=yUJ6j5WjQRrE5AVdb3fA0p+w+6twBV/hlDzA98oNUVM=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=kPwMqEXgehtuG7TAZYY+oZ2MsReJ7SsJ44mVJZT/g5qkP288wiBiiIeHjny41FApR
         5vheVuaTjY/HyaKRLaBKJzBKYg/ivxhZ9qy5PXZuBAtO19Cy2STALUpKDBNEf0y7p5
         ROU7RS+V4cz+y013LPVA8VX7KJ1FBjswRiNUSTyU=
Date:   Thu, 09 Jul 2020 23:00:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, perex@perex.cz, lgirdwood@gmail.com,
        Dan Murphy <dmurphy@ti.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20200709185129.10505-1-dmurphy@ti.com>
References: <20200709185129.10505-1-dmurphy@ti.com>
Subject: Re: [PATCH 1/2] ASoC: tlv320adcx140: Add ASI enable for channel 5-8
Message-Id: <159433200032.57213.9046850356730797696.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jul 2020 13:51:28 -0500, Dan Murphy wrote:
> Add the ALSA controls to enable the ASI for channels 5-8

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: tlv320adcx140: Add ASI enable for channel 5-8
      commit: 91cb940c2c953b9282700178b32300e4da84c636
[2/2] ASoC: tlv320adcx140: Add tx offset slot programming
      commit: 336c129139cd50faf5bd68acc343da817d13839b

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
