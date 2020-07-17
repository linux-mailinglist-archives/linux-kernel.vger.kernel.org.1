Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB3D222F75
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 01:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbgGPX4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 19:56:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:57284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbgGPX4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 19:56:55 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD9002076D;
        Thu, 16 Jul 2020 23:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594943815;
        bh=zeAWV8quqJcjNdKGBpwqdnxqQ3lUBTZRlol3e/xmC50=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=EhlCQmpQ7D8+Rn5PCJWFdB4BBXPH3Bk1PrJuvJj6/Oj1ZgeuiK1NWg2XGZijXsYHB
         aNqNi/XV32KgqSAOZNPTEWDRLdQUGTFAVvK8pQSOub7lzDtWaLt/4byf4UdFLNhh4v
         LMr7SSnohO5HKgSSliZeGyjXVSOegfT+XDRKhN+U=
Date:   Fri, 17 Jul 2020 00:56:45 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>, lgirdwood@gmail.com
Cc:     alsa-devel@alsa-project.org, Fabio Estevam <festevam@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, Xiubo Li <Xiubo.Lee@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>
In-Reply-To: <20200715150009.407442-1-lee.jones@linaro.org>
References: <20200715150009.407442-1-lee.jones@linaro.org>
Subject: Re: [PATCH v2 1/1] ASoC: fsl: fsl-asoc-card: Trivial: Fix misspelling of 'exists'
Message-Id: <159494380521.42174.8014458780867404653.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jul 2020 16:00:09 +0100, Lee Jones wrote:
> 


Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl: fsl-asoc-card: Trivial: Fix misspelling of 'exists'
      commit: 1b58214113481616b74ee4d196e5b1cb683758ee

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
