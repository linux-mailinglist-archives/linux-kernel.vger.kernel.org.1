Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09FE71B73BD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Apr 2020 14:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgDXMTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Apr 2020 08:19:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:50316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbgDXMTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 08:19:31 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3600620700;
        Fri, 24 Apr 2020 12:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587730770;
        bh=v4Wkb61I3GAFJWdNX/2z2spkJ9EdzvizSv/i0EDffmE=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=uT/kEZTDgmc9s1QnZZQABvTRIpFhViBjaq7eAlt+cACmVWabqxkbRHVp3Ssx0SWTX
         Rw7r9KFyJIeIGFvBYE6SH+k91wkSwyzwD7BTqSjCIdxdk7lJWjMSXkx/M5Pd+TE+d1
         QGnmCBnN1PMZXcijEX8kotpqAZaxsX+Me8BsJU34=
Date:   Fri, 24 Apr 2020 13:19:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, Rong Chen <rong.a.chen@intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, Vinod Koul <vkoul@kernel.org>,
        alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>
Cc:     kbuild test robot <lkp@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
In-Reply-To: <20200422073543.1671-1-rong.a.chen@intel.com>
References: <202004201540.vYPhhYMs%lkp@intel.com> <20200422073543.1671-1-rong.a.chen@intel.com>
Subject: Re: [PATCH] ASoC: soc-compress: avoid false-positive Wuninitialized warning
Message-Id: <158773076811.21878.6316435664619684333.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Apr 2020 15:35:43 +0800, Rong Chen wrote:
> gcc-6.5 and earlier show a new warning:
> 
> sound/soc/soc-compress.c: In function ‘soc_compr_open’:
> sound/soc/soc-compress.c:75:28: warning: ‘component’ is used uninitialized in this function [-Wuninitialized]
>   struct snd_soc_component *component, *save = NULL;
>                               ^~~~~~~~~
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.8

Thanks!

[1/1] ASoC: soc-compress: avoid false-positive Wuninitialized warning
      commit: 3e645a4add53eec22f3818c9da01c19191525096

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
