Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C87D11BE3C7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Apr 2020 18:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbgD2Q0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Apr 2020 12:26:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:42290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbgD2Q0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 12:26:21 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 699DD208E0;
        Wed, 29 Apr 2020 16:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588177581;
        bh=ZxG00pU6mh+bsa3od1jPgbNbeOCwD7dTA7vu7VZxcds=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=BIiFzqNu5iPwGOBNXDpDBcob5SyW973d/kLZVuKjlbT/FfPFk7AhvVXaBtHd+IN8z
         zz7sXxBd9dC76ogdj2LICsR6t/mZV0bwK2HV0fANXCvrZndi8LhmxVlsGP96t1V/7Y
         M078OF279W+7Cls7Q7UdZiNdmngc2M/DYut3PoFg=
Date:   Wed, 29 Apr 2020 17:26:18 +0100
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, s.hauer@pengutronix.de, lgirdwood@gmail.com,
        shawnguo@kernel.org, perex@perex.cz,
        Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     linux-kernel@vger.kernel.org,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20200429093823.1372-1-tangbin@cmss.chinamobile.com>
References: <20200429093823.1372-1-tangbin@cmss.chinamobile.com>
Subject: Re: [PATCH] ASoC: mxs-saif: Fix unused assignment
Message-Id: <158817756638.27768.4592113861894397863.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Apr 2020 17:38:23 +0800, Tang Bin wrote:
> Delete unused initialized value, because 'ret' will be assigined
> by the function of_alias_get_id().
> 
> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> ---
>  sound/soc/mxs/mxs-saif.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.8

Thanks!

[1/1] ASoC: mxs-saif: Fix unused assignment
      commit: da33574f7f1c110ec58ea43251a9a85801d6e015

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
