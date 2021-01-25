Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A88F73029AD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 19:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731236AbhAYSLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 13:11:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:43622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731389AbhAYSE2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 13:04:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8C1392251F;
        Mon, 25 Jan 2021 18:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611597827;
        bh=kHd1vjztpK98GssBUhEyIwyxCExvuJ7OgyNX0Uwd+70=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=PjAw92Z9nlCJs3d5U6PyqI2duJhnWZj7kq/UH/TkLx7QZ4a+sTbe7tbC8fO/AMQRS
         abFi7P41dB1YNRGN1Pvvg9YG1FE8uplyXRpiCjAZ1ztUob9lG+Fs2qDVZ3zNl5dsjL
         PaB660Tx5wN27rs2ijk5UjtG1D/F8ml+5n63jhGop+ngip4RLqiAhOottbFwUDYjMU
         9DroX4zqBvk2kXYfGYBSURHLegWAImPp5+PCuXYSkXw2BKVPE/w+D1yFmhlLkerxVF
         vkZNVFB4XsR1SuY40tBwdr8Zbp16hLwgk4U5rdEUNLzYOhUkmOMVs6vPHHCbEoKVBm
         GnhuWUiexREug==
From:   Mark Brown <broonie@kernel.org>
To:     Christoph Fritz <chf.fritz@googlemail.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Adrien Grassein <adrien.grassein@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <60d8eb8feefd26380cc9c6503f835e569be90465.camel@googlemail.com>
References: <60d8eb8feefd26380cc9c6503f835e569be90465.camel@googlemail.com>
Subject: Re: [PATCH] regulator: pf8x00: set ramp_delay for bucks
Message-Id: <161159778522.2496.12823600495022018154.b4-ty@kernel.org>
Date:   Mon, 25 Jan 2021 18:03:05 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jan 2021 17:13:41 +0100, Christoph Fritz wrote:
> This patch sets ramp_delay for bucks to the max value given by the
> datasheet.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: pf8x00: set ramp_delay for bucks
      commit: 4288b4ccda966c2a49ec7c67100208378bdb34d2

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
