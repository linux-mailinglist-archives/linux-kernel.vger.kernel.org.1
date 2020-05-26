Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 174831D7EBE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 May 2020 18:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbgERQlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 12:41:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:36120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbgERQlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 12:41:19 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D26B820758;
        Mon, 18 May 2020 16:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589820079;
        bh=hUrbPUnkx9sLpumkz9APRFvwFI3/14wZO/czESprIeQ=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=ykTtA9DFhGxlQjRWR3p2FXWxKwUWNAzU86nWeSFtYy8dKfbpHlOmyDpCygPAYQsCB
         Wwjj0sbE4hWc1QTNSV+RXBYlqi7voas2FH+IGofcW/HReUTh1LjhT21YiFKAey3nKu
         nR2AI9SRblXzU5a5hTClctb4L1T6ZBtmMLwJ80gI=
Date:   Mon, 18 May 2020 17:41:16 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Tang Bin <tangbin@cmss.chinamobile.com>, perex@perex.cz,
        timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20200518105951.19200-1-tangbin@cmss.chinamobile.com>
References: <20200518105951.19200-1-tangbin@cmss.chinamobile.com>
Subject: Re: [PATCH] ASoC: fsl_micfil: Fix indentation to put on one line affected code
Message-Id: <158982005877.28736.8093617646435280099.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 May 2020 18:59:51 +0800, Tang Bin wrote:
> In the function fsl_micfil_startup(), the two lines of dev_err()
> can be shortened to one line.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.8

Thanks!

[1/1] ASoC: fsl_micfil: Fix indentation to put on one line affected code
      commit: 11106cb37ade76719bb3feac9fa6ba68173a38a0

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
