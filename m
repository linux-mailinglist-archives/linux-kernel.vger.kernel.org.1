Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30F1A233B47
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jul 2020 00:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730263AbgG3W1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jul 2020 18:27:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:40042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728607AbgG3W1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 18:27:46 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4563C20829;
        Thu, 30 Jul 2020 22:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596148065;
        bh=K4EIQkVucQIypGxjb3zMkbMkirLR/phA6rgBGD9rC/I=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=VX1BfAV6AV/R/d2DFWcv7Z9VgP2UdlzP9Fkl6MXsmjn9M9LcRvsme9CAL8EJIAbPY
         sdphS+Tlg+QMb//o+GKleCyGP6MEDgbvo4MXopGR/rH3+GmUir/ebz+zZ3veYaY/aZ
         u23PFRfJPHpO6F2w5lenAoUhVeNULhtbqbfJtXts=
Date:   Thu, 30 Jul 2020 23:27:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>, alsa-devel@alsa-project.org,
        linux-rockchip@lists.infradead.org, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <20200721182709.6895-1-alpernebiyasak@gmail.com>
References: <20200721182709.6895-1-alpernebiyasak@gmail.com>
Subject: Re: [PATCH] ASoC: rk3399_gru_sound: Add DAPM pins, kcontrols for jack detection
Message-Id: <159614804536.1473.678464665429263160.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jul 2020 21:27:10 +0300, Alper Nebi Yasak wrote:
> PulseAudio (and perhaps other userspace utilities) can not detect any
> jack for rk3399_gru_sound as the driver doesn't expose related Jack
> kcontrols.
> 
> This patch adds two DAPM pins to the headset jack, where the
> snd_soc_card_jack_new() call automatically creates "Headphones Jack" and
> "Headset Mic Jack" kcontrols from them.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rk3399_gru_sound: Add DAPM pins, kcontrols for jack detection
      commit: d0508b4f16049a658d68a7c276ba08296c5a76bc

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
