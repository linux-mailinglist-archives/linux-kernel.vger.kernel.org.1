Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1EC42BB854
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 22:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgKTV3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 16:29:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:49774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726693AbgKTV3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 16:29:44 -0500
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net [92.233.91.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03D382242B;
        Fri, 20 Nov 2020 21:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605907783;
        bh=ChN2HwJmi1NiaE5ruSOq55VIUBiypuDKYbGvjhfCUfE=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=T5SZNLLSgvXsTE/DPUom4tWkzvM+dTF9fgX80/HVIr62l/+P+rVb+uL3EUzmgNIch
         7LwOo3/mqAZ3Z3n1NZgPIjYfRnV09ahGZYwJZ64L7r7sGK8J8G/7Asy9BHDtfGxnY6
         lYkPyjPpK5z5NN//vdgP+Nq8CZVWF+Gw/+7Xmj0E=
Date:   Fri, 20 Nov 2020 21:29:22 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Kyle Russell <bkylerussell@gmail.com>
Cc:     lkundrak@v3.sk, linux-arm-kernel@lists.infradead.org,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
        Takashi Iwai <tiwai@suse.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        alsa-devel@alsa-project.org
In-Reply-To: <20201119034106.1273906-1-bkylerussell@gmail.com>
References: <20201119034106.1273906-1-bkylerussell@gmail.com>
Subject: Re: [PATCH] ASoC: mmp-sspa: set phase two word length register
Message-Id: <160590773742.47461.544548810394256009.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Nov 2020 22:41:06 -0500, Kyle Russell wrote:
> If hw params enables dual phase transmission, then the word length for
> the second phase should be set to match the sample format instead of
> remaining at the reset default.  This matches the configuration already
> being done for the first phase.
> 
> This driver already sets the phase two sample size, so this should complete
> the phase two configuration.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mmp-sspa: set phase two word length register
      commit: 82d1aeb8a40740cf4208ce864cbcaa5e8bbabf4e

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
