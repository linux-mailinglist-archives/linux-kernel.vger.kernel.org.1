Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAB1F1B7203
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Apr 2020 12:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbgDXKbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Apr 2020 06:31:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:45850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726193AbgDXKbW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 06:31:22 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE6722071E;
        Fri, 24 Apr 2020 10:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587724282;
        bh=h66Ml5FnOsOSWU6lMS3uLnKawUO+JUEIXmAgQhGYYbI=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=iPEubyNKFt0g7XIDtD7BIoymS6NCtN+DD747wgEWgF+cfYeYd1t6wh2B37G6Tlsni
         YyFxwMKh8JP9LtstkVzcy1x0b3PE3q8c4Nm6v1MZJzmxAt4KF2mKpfijSm/rEbovdc
         vj7YXG0cCEqssjx4gLYfN4Mc1EK8UX2OqUf+d53o=
Date:   Fri, 24 Apr 2020 11:31:19 +0100
From:   Mark Brown <broonie@kernel.org>
To:     perex@perex.cz, alsa-devel@alsa-project.org, tglx@linutronix.de,
        allison@lohutok.net, patches@opensource.cirrus.com, tiwai@suse.com,
        lgirdwood@gmail.com, Shengjiu Wang <shengjiu.wang@nxp.com>,
        linux-kernel@vger.kernel.org, info@metux.net
In-Reply-To: <6d25d5b36d4b9aeb8655b5e947dad52214e34177.1587693523.git.shengjiu.wang@nxp.com>
References: <6d25d5b36d4b9aeb8655b5e947dad52214e34177.1587693523.git.shengjiu.wang@nxp.com>
Subject: Re: [PATCH v2] ASoC: wm8962: set CLOCKING2 as non-volatile register
Message-Id: <158772427980.54572.3910251949812603149.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Apr 2020 10:01:38 +0800, Shengjiu Wang wrote:
> Previously CLOCKING2 is set as a volatile register, but cause
> issue at suspend & resume, that some bits of CLOCKING2 is not
> restored at resume, for example SYSCLK_SRC bits, then the output
> clock is wrong.
> 
> The volatile property is caused by CLASSD_CLK_DIV bits,
> which are controlled by the chip itself. But the datasheet
> claims these are read only and protected by the security key,
> and they are not read by the driver at all.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.7

Thanks!

[1/1] ASoC: wm8962: set CLOCKING2 as non-volatile register
      commit: c38b608504aa1ad8bfa00d85abd61cffad57f27f

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
