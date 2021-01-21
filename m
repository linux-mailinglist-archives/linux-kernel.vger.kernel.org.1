Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 550872FDE3B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 01:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730462AbhAUAy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 19:54:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:53676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731255AbhAUAHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 19:07:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D695023718;
        Thu, 21 Jan 2021 00:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611187598;
        bh=HEKEkHysRBuy+PeeILPFJYalzK0RmedOTwrVoRREE8c=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=upMOudlv+WUULDlia6UY3uV0AGbhzfW5mDLZBDMntNTjVU95pZwKM8bjAObC29O+O
         xpJ1P1Dngb8ln6ypxdl5SZsS1L4PcCFWPx8UoxZYZtPcJg+m3ieY8VfpQN8eKAf3bQ
         f9wzRtahsTu29rCOce2Mgz0zyZTJKl2e9ShJdJimgbrrCp8LaJrbn6bgQOHuQlL2nT
         7584sXJd3iDkRtLOusahYXP/crpSupz2Vz09naxrKWNZFbRlRBTaKs0bEmenw3OVLu
         JPnhM1aoPxzxxq1NPWju2JBxlh65lS28aKpDe0zWjRspndpki0xpVFJEk11zoMxY0P
         RYtQ9sBu3pTvg==
From:   Mark Brown <broonie@kernel.org>
To:     peter.ujfalusi@ti.com, lgirdwood@gmail.com, tony@atomide.com,
        Pavel Machek <pavel@ucw.cz>, perex@perex.cz,
        linux-kernel@vger.kernel.org, tiwai@suse.com,
        alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com
Cc:     Sebastian Reichel <sre@kernel.org>,
        "Arthur D." <spinal.by@gmail.com>,
        Merlijn Wajer <merlijn@wizzup.org>
In-Reply-To: <20210112174704.GA13496@duo.ucw.cz>
References: <20210112174704.GA13496@duo.ucw.cz>
Subject: Re: ASoC: cpcap: Implement set_tdm_slot for voice call support
Message-Id: <161118753482.45718.9232559568095752872.b4-ty@kernel.org>
Date:   Thu, 21 Jan 2021 00:05:34 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jan 2021 18:47:04 +0100, Pavel Machek wrote:
> From: Tony Lindgren <tony@atomide.com>
> 
> ASoC: cpcap: Implement set_tdm_slot for voice call support
> 
> For using cpcap for voice calls, we need to route audio directly from
> the modem to cpcap for TDM (Time Division Multiplexing). The voice call
> is direct data between the modem and cpcap with no CPU involvment. In
> this mode, the cpcap related audio mixer controls work for the speaker
> selection and volume though.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cpcap: Implement set_tdm_slot for voice call support
      commit: 0dedbde5062dbc3cf71ab1ba40792c04a68008e9

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
