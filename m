Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 759301C1AC0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 May 2020 18:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729435AbgEAQpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 May 2020 12:45:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:43004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728896AbgEAQpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 12:45:34 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00FC2206D6;
        Fri,  1 May 2020 16:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588351534;
        bh=EdzADl1dqA/pSkvOdRE6yygS79Beu2SuHzIiA/XyE98=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=Nnmg1qfU3BIKXxQRAWlhBw57anIewhP1elOY9tKzrynlch8MVQ6C4JjAJswbP8FpD
         4IFQbjUETCKvIfzRPwlTiFD7MAorYdnDmWITtaxipWcnivHjNQrfanN++mx6mI9leU
         NsHB6H7HNjiC4CxW+4Deee+Dm/qre+7HYczgX0po=
Date:   Fri, 01 May 2020 17:45:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>,
        Jonathan Bakker <xc-racer2@live.ca>,
        patches@opensource.cirrus.com
In-Reply-To: <20200501133534.6706-1-krzk@kernel.org>
References: <20200501133534.6706-1-krzk@kernel.org>
Subject: Re: [PATCH] dt-bindings: sound: wm8994: Correct required supplies based on actual implementaion
Message-Id: <158835153189.13173.5201387267459150176.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 May 2020 15:35:34 +0200, Krzysztof Kozlowski wrote:
> The required supplies in bindings were actually not matching
> implementation making the bindings incorrect and misleading.  The Linux
> kernel driver requires all supplies to be present.  Also for wlf,wm8994
> uses just DBVDD-supply instead of DBVDDn-supply (n: <1,3>).
> 
> Reported-by: Jonathan Bakker <xc-racer2@live.ca>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.8

Thanks!

[1/1] dt-bindings: sound: wm8994: Correct required supplies based on actual implementaion
      commit: 8c149b7d75e53be47648742f40fc90d9fc6fa63a

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
