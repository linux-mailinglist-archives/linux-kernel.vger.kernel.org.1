Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAC32B8629
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 22:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbgKRU7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 15:59:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:55528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726234AbgKRU7g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 15:59:36 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60F61246CA;
        Wed, 18 Nov 2020 20:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605733176;
        bh=a7U2C6v9GVw424t93GzLhDnAmyo5rTt0U8ggDVQHPNc=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=VGNVT6PbRD5ZSvhWK+DD132RQ8L6fi0PAchfARO199l2reE5tjWIt/dnVBWKk7DOf
         t6onpdmbau6n1JopMwyLRO/ZLRv3WPhx0oUInSCbY8Qrqegdu6Gsm+/MffFvZBUeQ4
         nyDuGE4bRylQuz3C07pwPv8qYi6bw7IZgwCvt1c0=
Date:   Wed, 18 Nov 2020 20:59:15 +0000
From:   Mark Brown <broonie@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, matthias.bgg@gmail.com,
        Jiaxin Yu <jiaxin.yu@mediatek.com>, robh+dt@kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        tzungbi@google.com, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc:     shane.chien@mediatek.com, Trevor.Wu@mediatek.com
In-Reply-To: <1605081920-11848-1-git-send-email-jiaxin.yu@mediatek.com>
References: <1605081920-11848-1-git-send-email-jiaxin.yu@mediatek.com>
Subject: Re: [PATCH] dt-bindings: mediatek: mt8192: revert "add audio afe document"
Message-Id: <160573314459.46437.12225896346683178113.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Nov 2020 16:05:20 +0800, Jiaxin Yu wrote:
> This reverts commit 1afc60e00de3abbb6c559da409c5c1bb8c1d98ec.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mt8192: revert "add audio afe document"
      commit: 7d94ca3c8acd0117200f34523536ee01615e7dc3

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
