Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A16911E6193
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 15:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390106AbgE1NCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 09:02:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:55540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390098AbgE1NCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 09:02:09 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 610DA206F1;
        Thu, 28 May 2020 13:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590670929;
        bh=F7jtwIuneGRzrzC8hmnOou8rcUKR1aHQAK/XGsUDTOM=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=ozGZ5r2ZCATYyVZy+ziSJzRmfOFenTjiKn9Tf5mHyyCS8e7cnxp/h8jyVN7z0zdrT
         /jlKcYkmOmcpM95n6bMnLtZzkj+PTyIE2lDPgF5uvGTIwaLi2WZcT4h8rHWqoPw88A
         LJMryBYJ4b58HL+fl6vTce2f9lS+KmR4XvilPRjs=
Date:   Thu, 28 May 2020 14:02:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Cc:     linux-kernel@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        alsa-devel@alsa-project.org, od@zcrc.me
In-Reply-To: <20200523125455.12392-1-paul@crapouillou.net>
References: <20200523125455.12392-1-paul@crapouillou.net>
Subject: Re: [PATCH] ASoC: ingenic: Unconditionally depend on devicetree
Message-Id: <159067091851.53762.14414848344217836155.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 May 2020 14:54:55 +0200, Paul Cercueil wrote:
> All boards with Ingenic SoCs probe with devicetree already, we have no
> use for a non-devicetree path.
> 
> This solves some compilation warnings that were caused by unused
> variables in the case where CONFIG_OF was disabled.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: ingenic: Unconditionally depend on devicetree
      commit: e6825bae26812e981c4d6f93214f0259ca9a4977

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
