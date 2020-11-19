Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57C922B990B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 18:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbgKSRJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 12:09:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:36610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726474AbgKSRJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 12:09:38 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 008222469D;
        Thu, 19 Nov 2020 17:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605805777;
        bh=70tCoEq9/FYcYDMF8Mq56bnaLykaoi8Dcb4Ao5hv/jo=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=x8+uAopbQoGBBj12OHyOQ4Ywx5KDw9pvIMKeoSNzkGffSpk+L0CpuA4OoV9j3WFdS
         DNT56KmYclVkEPfx254FJd1KEo++IMYL/ZjVSYEIQevxtgo9yxEdxcn9NfuskeoxZe
         Ewaa+2dsGlyWdsHjgFzf4L8oVSUWy5YtnBtZM+Vk=
Date:   Thu, 19 Nov 2020 17:09:17 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com
In-Reply-To: <20201105113458.12360-1-srinivas.kandagatla@linaro.org>
References: <20201105113458.12360-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v3 0/6] ASoC: codecs: add support for LPASS Codec macros
Message-Id: <160580573378.54454.13024216102656641940.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Nov 2020 11:34:52 +0000, Srinivas Kandagatla wrote:
> This patchset adds support for two Codec Macro blocks( WSA and VA) available in
> Qualcomm LPASS (Low Power Audio SubSystem).
> 
> There are WSA, VA, TX and RX Macros on LPASS IP, each of the Macro block
> has specific connectivity like WSA Macros are intended to connect
> to WSA Smart speaker codecs via SoundWire. VA Macro is intended for DMICs,
> and TX/RX for Analog codecs via SoundWire like other WCD Codecs to provide
> headphone/ear/lineout etc ..
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/6] ASoC: qcom: dt-bindings: add bindings for lpass wsa macro codec
      commit: ccbd847f15b0f08f8c6ed3ab5384e5f7055b08e5
[2/6] ASoC: codecs: lpass-wsa-macro: Add support to WSA Macro
      commit: 809bcbcecebff86003e13f07444d21b9d6652a64
[3/6] ASoC: codecs: lpass-wsa-macro: add dapm widgets and route
      commit: 2c4066e5d428d47a28f87407b3d73ebe40c06fd4
[4/6] ASoC: qcom: dt-bindings: add bindings for lpass va macro codec
      commit: 67d99b23c881b1411fc6907bc844d63565b536d6
[5/6] ASoC: codecs: lpass-va-macro: Add support to VA Macro
      commit: 908e6b1df26efc9d2df70c9a7bf4f5eae5c5702f
[6/6] ASoC: codecs: lpass-va-macro: add dapm widgets and routes
      commit: 58aad93015b9dc7cb8966c1dc775ec69f0280b79

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
