Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08C762C8A0D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 17:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbgK3Q40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 11:56:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:34232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729003AbgK3Q4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 11:56:24 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE00B20789;
        Mon, 30 Nov 2020 16:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606755343;
        bh=tZw6aamMH+u2d50z6nDTuvts6EhVQvI/WN8Xk7fNSbA=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=2Ftp/roPr9kwocPZY5HaMgB1yNGgx1obvp2gEB4Tbc13Vc3IKcXPOc2Ug9maXSl2C
         g9k3aSIeusQ72zfqlZK2xmIzqAGmyrY207W4g1Nxk57iyvhsVsVnjnzxrExxyY1lxN
         aRApbzzuHLm0xJ6e4lZ32CBjwKIWcnThtmnCyntU=
Date:   Mon, 30 Nov 2020 16:55:15 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org
In-Reply-To: <20201127123030.1610574-1-alexandre.belloni@bootlin.com>
References: <20201127123030.1610574-1-alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: sound: adau1372: Add bindings documentation
Message-Id: <160675530955.30326.5536551063969425427.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Nov 2020 13:30:29 +0100, Alexandre Belloni wrote:
> Add device tree binding documentation for Analog Devices ADAU1372.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: adau1372: Add bindings documentation
      commit: 32025c7c50c602a6c0bc3bef0e9a774003e2e7ae
[2/2] ASoC: Add ADAU1372 audio CODEC support
      commit: 6cd4c6459e47402ab90802eca61a18b231434053

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
