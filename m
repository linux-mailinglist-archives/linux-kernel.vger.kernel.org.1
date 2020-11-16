Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 698922B5509
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 00:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730167AbgKPXdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 18:33:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:40598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbgKPXdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 18:33:16 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20CB02224B;
        Mon, 16 Nov 2020 23:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605569595;
        bh=W4iJDW29qaYIvsy6pPudjqFsYGbUiXej+ClOVk6wkbE=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=uyMntYXIAHZCuB2k0gyDph9z4nbpMEFfvhFwqbzmppERcIXSzZrTYQiJ3bDKKWWR2
         Kgkavfj80xQPfypABwXMougZwGNm0R9c5LDP/75xIHcxg3/3EYTHxkPRqWovjZf+CI
         C25tAWg1uuECCySkCFc+otv8CtXXXJkmPeZZnRKs=
Date:   Mon, 16 Nov 2020 23:32:56 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Kirill Marinushkin <kmarinushkin@birdec.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Takashi Iwai <tiwai@suse.com>
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        linux-kernel@vger.kernel.org, Matthias Reichl <hias@horus.com>,
        alsa-devel@alsa-project.org
In-Reply-To: <20201115122306.18164-1-kmarinushkin@birdec.com>
References: <20201115122306.18164-1-kmarinushkin@birdec.com>
Subject: Re: [PATCH v3 0/4] ASoC: pcm512x: Patch series to set fmt from `set_fmt()`
Message-Id: <160556956526.29683.6599781233206972727.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Nov 2020 13:23:02 +0100, Kirill Marinushkin wrote:
> Set format from `set_fmt()` func instead of `hw_params()`, plus supportive
> commits
> 
> Kirill Marinushkin (4):
>   ASoC: pcm512x: Fix not setting word length if DAIFMT_CBS_CFS
>   ASoC: pcm512x: Rearrange operations in `hw_params()`
>   ASoC: pcm512x: Move format check into `set_fmt()`
>   ASoC: pcm512x: Add support for more data formats
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: pcm512x: Fix not setting word length if DAIFMT_CBS_CFS
      commit: 6feaaa7c19bde25595e03bf883953f85711e4ac8
[2/4] ASoC: pcm512x: Rearrange operations in `hw_params()`
      commit: 798714b6121d833c8abe4161761a94fdd1e73a90
[3/4] ASoC: pcm512x: Move format check into `set_fmt()`
      commit: 26b97d95a05d0346e1ad6096deedac3f24a4607b
[4/4] ASoC: pcm512x: Add support for more data formats
      commit: 25d27c4f68d2040c4772d586be3e02ee99eb71af

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
