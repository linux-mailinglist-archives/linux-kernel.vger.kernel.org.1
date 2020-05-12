Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44CE31CFB2D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 18:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgELQor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 12:44:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:41458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbgELQor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 12:44:47 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1198206B9;
        Tue, 12 May 2020 16:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589301887;
        bh=Trwo38OmVBD2TlImzx3c+TlSZBTuSuR0SffTOf0cwTA=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=nASl9ChizvQCSHZxqM5SKnNBNtsxJze1bOhEBm/r+ek96uRhxFd21jPbl4IkHLDtY
         g/4XQcCzQEALbK6PoUnVZG1pZ0itOTInxIIrK99bvUOF9VbhlUUi/jqwiISyUndL0j
         EemoVeSFjbqGZkFTHccsawGsW9qlKRal6xO7BUYc=
Date:   Tue, 12 May 2020 17:44:44 +0100
From:   Mark Brown <broonie@kernel.org>
To:     heiko@sntech.de, Johan Jonker <jbx6244@gmail.com>
Cc:     linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20200507113238.7904-1-jbx6244@gmail.com>
References: <20200507113238.7904-1-jbx6244@gmail.com>
Subject: Re: [PATCH v1] ASoC: rockchip-i2s: add description for rk3308
Message-Id: <158930188455.55827.16068992221946601782.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 May 2020 13:32:38 +0200, Johan Jonker wrote:
> The description below is already in use for rk3308.dtsi,
> but was somehow never added to a document, so add
> "rockchip,rk3308-i2s", "rockchip,rk3066-i2s"
> for i2s nodes on a rk3308 platform to rockchip-i2s.yaml.
> One of the rk3308 i2s nodes also has a different dma layout,
> so change that as well.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.8

Thanks!

[1/1] ASoC: rockchip-i2s: add description for rk3308
      commit: ab436c974e08d9254999d7a84d86b1d4c1749230

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
