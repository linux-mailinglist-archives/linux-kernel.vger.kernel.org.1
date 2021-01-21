Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6AB02FDEED
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 02:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732389AbhAUA50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 19:57:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:54018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730471AbhAUAIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 19:08:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 51FDC2371F;
        Thu, 21 Jan 2021 00:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611187648;
        bh=fJmBuuQz1f9NwhONIikUc47J0yR0liG2Nz8foWUbmEk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=SnPsPXl1tiPS+azOKnNIvzhGrwT4/YsQ63jr5C1n3T4hL4SWX9mRhcHx7O8HIS0uQ
         2ImssWH4HdpuYfd2hgF303mSaC7eaysm/WVETJ8oUQxa7TSZbhArcaQ9zOASmwi/OF
         FIqqiIuWIFPj7RTk1wpJpInHK4HnF3xD6FepnjxTVZoJvA+r66T3SIRKetAYy9Jvpu
         iOIrcef9mu29soIhGZnGLNJIV/1NaHCiWa2doZWPI1Md5gMC9n7+hr44VEOQDcgj+n
         Rwl/KVAL/OXdRN+2ZujJdbJenTeB8dUsBvPxnZtCvPXmsrl/lJCNrFBV+rqwI/Ztxo
         TASnIVbV6hD/w==
From:   Mark Brown <broonie@kernel.org>
To:     Yu-Hsuan Hsu <yuhsuan@chromium.org>, linux-kernel@vger.kernel.org
Cc:     "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        alsa-devel@alsa-project.org, Pi-Hsun Shih <pihsun@chromium.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <20210115075301.47995-1-yuhsuan@chromium.org>
References: <20210115075301.47995-1-yuhsuan@chromium.org>
Subject: Re: [PATCH v7 1/2] cros_ec_commands: Add EC_CODEC_I2S_RX_RESET
Message-Id: <161118753483.45718.10581891654341693206.b4-ty@kernel.org>
Date:   Thu, 21 Jan 2021 00:05:34 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jan 2021 15:53:00 +0800, Yu-Hsuan Hsu wrote:
> Add the new command EC_CODEC_I2S_RX_RESET in ec_codec_i2s_rx_subcmd,
> which is used for resetting the EC codec.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] cros_ec_commands: Add EC_CODEC_I2S_RX_RESET
      commit: f4d3bd8be4f2bc43e4b13490cbc9969d15c2f058
[2/2] ASoC: cros_ec_codec: Reset I2S RX when probing
      commit: 7f1f7ae102ea082745e320b3c8c003f43c063edf

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
