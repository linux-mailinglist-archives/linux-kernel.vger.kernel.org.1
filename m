Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C474A299AEC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 00:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408068AbgJZXpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 19:45:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:41444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408049AbgJZXpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 19:45:33 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7726320714;
        Mon, 26 Oct 2020 23:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603755933;
        bh=lLxjByEzEqHVGHizHikGSChzrt/ikoW1DrIWmsD1Oog=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=SWTwigaZOVO7f3S++lfl04YJUrkFgbnxmXPHO31eWkDjAHTzjRRxJUWcs/7YaUTZc
         ZC3mAbYhjZau+jyu1y3M2dHjO8sNBws+ZBr/jYLS+8rjghVgg50yv/S8HHL5XTtoCo
         k5VHv1MqWslDAxir2E9h6unNdsc33hGRRi8BsPlM=
Date:   Mon, 26 Oct 2020 23:45:28 +0000
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        linux-kernel@vger.kernel.org
Cc:     tiwai@suse.com, kernel@martin.sperl.org, florian.meier@koalo.de,
        lgirdwood@gmail.com
In-Reply-To: <20201012141911.3150996-1-codrin.ciubotariu@microchip.com>
References: <20201012141911.3150996-1-codrin.ciubotariu@microchip.com>
Subject: Re: [PATCH] ASoC: pcm5102a: Make codec selectable
Message-Id: <160375592346.31132.3991305992600286336.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Oct 2020 17:19:11 +0300, Codrin Ciubotariu wrote:
> The TI PCM5102A codec driver can be used with the generic sound card
> drivers, so it should be selectable. For example, with the addition
> of #sound-dai-cells = <0> property in DT, it can be used with simple/graph
> card drivers.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: pcm5102a: Make codec selectable
      commit: 76b5f68bbf7df9343b69fbee04d5edf50680c231

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
