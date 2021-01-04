Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5267E2E9C3B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 18:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbhADRlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 12:41:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:36366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727672AbhADRlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 12:41:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9980D206A4;
        Mon,  4 Jan 2021 17:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609782021;
        bh=TdktIRetHITr1rQkVosDcvCOXEpiK2F9oh+Iey8UjR4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=XVb0Nxi5lXFFYfDjuZaW1eha7r9nhpdKQwzq6nRNjJjtbSIgZS2IAH5iGhXywMnL+
         +B/6KHXWVV710kQDBAukAUqXDc7PS9uenGBKifkqn0SiTzqXQTGCr7afxMA8M9DySC
         HN7UK7NLhpBktpx/mvn1GUgzQzbrisN7bNnKvadw/9kfP7XCF+PK9NKlBuIFKZU3M8
         9OhVjnXluL3OuPiW6TiIF7Tk6qpVfLmA/oyS1xCK+gXcqlxfzWLM8paeq2aZFyUn4Z
         ERTq8jXbWGGVzXDmxeh9CLN+fVEuQaTHKMxK2HNaygFDEMhFG6LnIlpZw2C1EFBMnG
         wb0wdxwRRWVFQ==
From:   Mark Brown <broonie@kernel.org>
To:     Adam Ford <aford173@gmail.com>, alsa-devel@alsa-project.org
Cc:     aford@beaconembedded.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
In-Reply-To: <20201217162740.1452000-1-aford173@gmail.com>
References: <20201217162740.1452000-1-aford173@gmail.com>
Subject: Re: [PATCH] ASoC: wm8962: Add optional mclk device tree binding
Message-Id: <160978198913.14397.16832958229666174829.b4-ty@kernel.org>
Date:   Mon, 04 Jan 2021 17:39:49 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Dec 2020 10:27:40 -0600, Adam Ford wrote:
> The driver can request an optional clock for mclk.
> Update the txt file to reflect this.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: wm8962: Add optional mclk device tree binding
      commit: e33c93b2206fedee35df756940e07af7b1f29768

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
