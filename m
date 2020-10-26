Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E490299AFB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 00:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408252AbgJZXq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 19:46:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:43116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408241AbgJZXq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 19:46:26 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D00CA20809;
        Mon, 26 Oct 2020 23:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603755986;
        bh=4F6i81r5LS+FRPkxH0xgnsavevu9gaX/KuKprU82Egk=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=pyJpf/eEY+TAWPrSMbCDjdQToBWKsI6DxCCMm22sNVPpQvoeTNBYqc4kqsrtIcCL8
         0Ch8pAm7xS9qL0gGMerXMBqAeeRCXoxjOhaA19bHb57jeGI3SvSaeKPa6gQTbQhllG
         scilAEyKxFLQME38YPQnIqObqB92nOcQy0t8Vk7o=
Date:   Mon, 26 Oct 2020 23:46:22 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     spapothi@codeaurora.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        plai@codeaurora.org
In-Reply-To: <20201026170947.10567-1-srinivas.kandagatla@linaro.org>
References: <20201026170947.10567-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v1 0/2] ASoC: qcom: add support for QRB5165 RB5 machine
Message-Id: <160375592348.31132.700517684060539910.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Oct 2020 17:09:45 +0000, Srinivas Kandagatla wrote:
> This patchset adds support to Qualcomm Robotics RB5 Development Kit based on
> QRB5165 Robotics SoC. This board has 2 WSA881X smart speakers with onboard
> DMIC connected to internal LPASS codec via WSA and VA macros respectively.
> 
> Srinivas Kandagatla (2):
>   ASoC: qcom: dt-bindings: Add SM8250 sound card bindings
>   ASoC: qcom: sm8250: add sound card qrb5165-rb5 support
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: qcom: dt-bindings: Add SM8250 sound card bindings
      commit: 765c37598494cdb6c8f833e8e46f494af5c7d39e
[2/2] ASoC: qcom: sm8250: add sound card qrb5165-rb5 support
      commit: aa2e2785545aab21b6cb2e23f111ae0751cbcca7

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
