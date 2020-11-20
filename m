Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95D7F2BB868
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 22:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbgKTVfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 16:35:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:50826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727248AbgKTVfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 16:35:41 -0500
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net [92.233.91.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73AC12237B;
        Fri, 20 Nov 2020 21:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605908141;
        bh=EFiexHFZKW7N+/KrKxGNqn62prfsHu7FTDQCJmxMJts=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=STsrivqAhf90GKlMJGc4Ab5vZuotHcUl+J6aFoNmwlmhupWVdNrgTBwS9GuuPcSNJ
         WNejah8Hw1fnaL/6Jc+Cp1GqGBEw9AUacZZWUYFBS89eQiib9EQIxX6JPSL0QzenjK
         I4M6/forAw2zSQBvIRmre7dM/7zXseMQHnEGFJck=
Date:   Fri, 20 Nov 2020 21:35:19 +0000
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, Jiaxin Yu <jiaxin.yu@mediatek.com>,
        matthias.bgg@gmail.com, tzungbi@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, robh+dt@kernel.org,
        alsa-devel@alsa-project.org
Cc:     Trevor.Wu@mediatek.com, shane.chien@mediatek.com
In-Reply-To: <1605841573-1442-1-git-send-email-jiaxin.yu@mediatek.com>
References: <1605841573-1442-1-git-send-email-jiaxin.yu@mediatek.com>
Subject: Re: [PATCH 0/2] ASoC: mt6359: Fix regulator_dev_lookup() fails for id "LDO_VAUD18"
Message-Id: <160590773742.47461.980400438580357576.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Nov 2020 11:06:11 +0800, Jiaxin Yu wrote:
> This series fixed "LDO_VAUD18-supply" regulator register fail.
> We can see the error log "mt6359-sound supply LDO_VAUD18 not found, using
> dummy regulator" when register the DAPM widget "LDO_VAUD18"
> Otherwise, the power can not be turned on correctly when recording.
> 
> Jiaxin Yu (2):
>   ASoC: mediatek: mt6359: Fix regulator_dev_lookup() fails for id
>     "LDO_VAUD18"
>   dt-bindings: mediatek: mt6359: remove unused property for mt6359
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: mediatek: mt6359: Fix regulator_dev_lookup() fails for id "LDO_VAUD18"
      commit: 9546c76c73a1ee8b662b09f7308bcb63d2cd0d51
[2/2] ASoC: mt6359: remove unused property for mt6359
      commit: 6e85530496a496616ece6c444df23522afc81520

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
