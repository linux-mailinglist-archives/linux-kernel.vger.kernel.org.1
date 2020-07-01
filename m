Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA6ED2115D0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jul 2020 00:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbgGAWX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jul 2020 18:23:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:50454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726235AbgGAWX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 18:23:28 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8126920853;
        Wed,  1 Jul 2020 22:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593642208;
        bh=fRMvfDs6J9ENx0nlOwqfVxCsvoO7J+T2mLixCLYaX1U=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=pZXU4aHHTet5AzCAWDUUeFp7P8yNUdkhA9uczFmW9YbhWeEHuSHtBc1vNrXpzQD+8
         3Th3pUvKqEa31N8xtDmQgH1LVj0iDOcK/24ghb9LgQ6clzH5dxsuRPp1LyGfbrXFLV
         iliDuxpJtAFAbzGokZ1wmaGR1/clk8a1oYE/lOTk=
Date:   Wed, 01 Jul 2020 23:23:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        allen <allen.chen@ite.com.tw>,
        Stephan Gerhold <stephan@gerhold.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        devicetree@vger.kernel.org
In-Reply-To: <87r1ub39hq.wl-kuninori.morimoto.gx@renesas.com>
References: <87r1ub39hq.wl-kuninori.morimoto.gx@renesas.com>
Subject: Re: ARM: dts: motorola-mapphone-common: remove unneeded "simple-graph-card"
Message-Id: <159364215575.10630.11362467369859592043.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Jun 2020 14:33:36 +0900, Kuninori Morimoto wrote:
> Audio Graph Card is using "audio-graph-card" prefix instead of
> "simple-graph-card", and moreover "widgets / routing" doesn't need it.
> This patch removes unsupported "simple-graph-card" prefix from
> motorola-mapphone-common.dtsi and vendor-prefixes.yaml.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ARM: dts: motorola-mapphone-common: remove unneeded "simple-graph-card"
      commit: eb83aa46dcb8198708787b969eee1ba0e5ca0be7

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
