Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7BE2BB853
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 22:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbgKTV3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 16:29:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:49686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728207AbgKTV3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 16:29:34 -0500
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net [92.233.91.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FA9E2242B;
        Fri, 20 Nov 2020 21:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605907773;
        bh=pOuyaDaW7QcHVNiuG61HXZ9kLTRtaijcK5eYNujh0+0=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=Z0lJzFhGoK28XF3F6vIVXTBkX2pA3XDHk2xe0o4BhccCxnTJYpu4EEpIbM1F1+Um6
         sIKsikzQvk/ali7PCAkrEak0Xzkjm7w1cgMUh4WbjtohAfbn0OWhCaSzwpQOEH5ryE
         CY4qV+xk8s76Q2apJ+7vFrv+IdG2C+gBW7ITV30E=
Date:   Fri, 20 Nov 2020 21:29:12 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
In-Reply-To: <20201120123813.14059-1-srinivas.kandagatla@linaro.org>
References: <20201120123813.14059-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] ASoC: codecs: lpass-va-macro: add missing MODULE_DEVICE_TABLE
Message-Id: <160590773742.47461.7039529678765787843.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Nov 2020 12:38:13 +0000, Srinivas Kandagatla wrote:
> Fix module loading due by adding missing MODULE_DEVICE_TABLE.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: lpass-va-macro: add missing MODULE_DEVICE_TABLE
      commit: 2b3f6f4af95594d8e9c137ddc8d6bec61f04dbb5

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
