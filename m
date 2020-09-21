Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB80272FA9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 18:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730289AbgIUQ67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 12:58:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:39472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726611AbgIUQ6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 12:58:51 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48A662223E;
        Mon, 21 Sep 2020 16:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600707530;
        bh=jBvTMb6BSyyzBMg1bmcGhFcyq8Z54iV6+nKI7nSpAMA=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=yg3oJvW5Lr1N1++gn6kiiQCbI2x01EE1M4MTbSGe+uk9MqyENcSjxgNUiXMobQE9h
         OzW1kNiO34HzLBVgYO7LCBAH9nZDt6nc8h0wE01TCQE7q1zuQftM6qDn6I+Rq8chFg
         bx+6jFuf4Q2JVd9l8JQlzkTKGsvDWzufQ59vtmNY=
Date:   Mon, 21 Sep 2020 17:57:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, dmurphy@ti.com,
        Camel Guo <camel.guo@axis.com>, tiwai@suse.com,
        robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, kernel@axis.com,
        Camel Guo <camelg@axis.com>
In-Reply-To: <20200918114025.18205-1-camel.guo@axis.com>
References: <20200918114025.18205-1-camel.guo@axis.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: tlv320adcx140: Add GPIO config and drive config
Message-Id: <160070745846.56122.3144589484342330182.b4-ty@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Sep 2020 13:40:24 +0200, Camel Guo wrote:
> Add properties for configuring the General Purpose Input Output (GPIO).
> There are 2 settings for GPIO, configuration and the output drive type.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] dt-bindings: tlv320adcx140: Add GPIO config and drive config
      commit: 15b3d324c8980022071710b5096b705eb6b74fca
[2/2] ASoC: tlv320adcx140: Add support for configuring GPIO pin
      commit: d5214321498a43558d9ffcce4153775c2c296bad

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
