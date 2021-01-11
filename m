Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24B842F1AE8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 17:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731069AbhAKQ3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 11:29:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:37032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725858AbhAKQ3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 11:29:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A9772223E4;
        Mon, 11 Jan 2021 16:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610382508;
        bh=DxCU3KTWi4TR+plfEQqeb91xnsxQqrV47FrVpoqwwbs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=lPZKKfF0suyd1EFM0Bnjrl5Nh2cp7JUIfhoMR9cLowrflq/aKBivmgx59U7vVpFJI
         rfoHxil6MZjRjxI0Pn+0MPOmbIarkziSXRQoU/3vnRgeAm3Hh7InJLLhHkICBlVkK6
         mABh7FhvJyYZWpQrx5eFyg8ONdzUE0hJC4p6ZaANKkbbuG73aWNu1YRK1+HeSbZMj+
         vJbFNTOhAC9f8wpRRSlquYNm9d2x7FGi7+62HuIMQjNKjCiytT74R5a8Bw29BlBOff
         KxovRzplV7y9sQE3t0dmZ+Ly6JSQxOylzqC0gV9Xz9lhL4vdGdYnnkDXx81jBpl8cV
         iMS7a70cx7mAA==
From:   Mark Brown <broonie@kernel.org>
To:     perex@perex.cz, lgirdwood@gmail.com, tiwai@suse.com,
        Souptick Joarder <jrdr.linux@gmail.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <1610163901-5523-1-git-send-email-jrdr.linux@gmail.com>
References: <1610163901-5523-1-git-send-email-jrdr.linux@gmail.com>
Subject: Re: [PATCH] ASoC: soc-pcm: return correct -ERRNO in failure path
Message-Id: <161038245912.32701.902192524271148760.b4-ty@kernel.org>
Date:   Mon, 11 Jan 2021 16:27:39 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Jan 2021 09:15:01 +0530, Souptick Joarder wrote:
> Kernel test robot throws below error ->
> 
> sound/soc/soc-pcm.c:2523 dpcm_run_update_startup() error: uninitialized
> symbol 'ret'.
> 
> Initializing ret = 0 and returning correct -ERRNO in failure path.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: soc-pcm: return correct -ERRNO in failure path
      commit: 4eeed5f40354735c4e68e71904db528ed19c9cbb

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
