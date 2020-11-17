Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC5062B71B3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 23:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbgKQWiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 17:38:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:41446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726433AbgKQWiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 17:38:09 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D817B21D7E;
        Tue, 17 Nov 2020 22:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605652689;
        bh=RcLKHkW3XsWqdPM91oIiy4VtLboMA/41WJfQchqi9x0=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=RxRKJK3yjB1dsp1gwjslCASMai/Zic10iw+5JAJGi0cu9ymWMHBavzkCpe8mrbH0K
         iXNOjC7+iq+muHrgyjz7MfUPPhVPbcsoKJUykxee56Hkbma5wDKFlG7UC8yZF/ZgAd
         CnsiAAOvIHVBS+X8p39BuDHepBL5woFhjP0Gxwew=
Date:   Tue, 17 Nov 2020 22:37:49 +0000
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org, lars@metafoo.de
In-Reply-To: <20201110084754.46756-1-alexandru.ardelean@analog.com>
References: <20201106102052.32582-1-alexandru.ardelean@analog.com> <20201110084754.46756-1-alexandru.ardelean@analog.com>
Subject: Re: [PATCH v2] dt-bindings: adau1977: convert text binding to yaml format
Message-Id: <160565265702.23689.9722907741077657192.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Nov 2020 10:47:54 +0200, Alexandru Ardelean wrote:
> This change converts the old device-tree binding for ADAU1977 from text
> format to the new yaml format.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: adau1977: convert text binding to yaml format
      commit: f077770b2675feb2ea2188ef7109d5a41545e7a9

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
