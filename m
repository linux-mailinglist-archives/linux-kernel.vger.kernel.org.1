Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73A8029F15F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 17:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgJ2Q06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 12:26:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:45554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbgJ2Q06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 12:26:58 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 611922076E;
        Thu, 29 Oct 2020 16:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603988817;
        bh=t+PBJ0NHId5QAZDzuBrDGNlV6g1PCH9iZXJKI+sMxMw=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=AVQf49UmZSCKirXj8VEFT7AM5GxmOOW2d1zUOMzZL+fF9cKQfQPy+RA/vxrnvAdIl
         YNViTwonflNW7tToWEuTx/vKAURkz4BULmyNJGUGG++LI65Lizy/glAXE1wFc93ssu
         8XBUL51CsE7vfoA3hxd4g6Tgv/G9qmhgdf5E2m4I=
Date:   Thu, 29 Oct 2020 16:26:50 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, Rob Herring <robh@kernel.org>
In-Reply-To: <20201029101550.31695-1-srinivas.kandagatla@linaro.org>
References: <20201029101550.31695-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 1/2] ASoC: qcom: dt-bindings: sm8250: update compatibles
Message-Id: <160398881039.39922.12061096532284319098.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Oct 2020 10:15:49 +0000, Srinivas Kandagatla wrote:
> Update compatible string as board compatible and device compatible
> should not be same!. New compatible is now suffixed with -sndcard
> to be inline with other Qualcomm Sound cards.
> 
> This also fixes the warnings/error reported by dt_binding_check.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: qcom: dt-bindings: sm8250: update compatibles
      commit: a889583a19206636082c44625141b26392e46a62
[2/2] ASoC: qcom: sm8250: update compatible with new bindings
      commit: bbc4e1bb5fd6577ed668e7c2ba0705dff1783bce

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
