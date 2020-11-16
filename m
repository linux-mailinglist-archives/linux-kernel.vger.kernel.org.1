Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00D232B5512
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 00:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730314AbgKPXdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 18:33:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:41168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbgKPXdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 18:33:50 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7491822280;
        Mon, 16 Nov 2020 23:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605569630;
        bh=lG8vjtafSwJlzpTe4ZWzO3xTe2KC9KSe1kymL1F6xJo=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=JlvKzOhlcrAT+uQ0LdSTp/rSUQoUXnPxaf0cJ3Bqu40UHuJVjP8qQpoMkmuwF3Q4f
         sla8xzK9k705EWOb6rMqXtHlYAwVmFXSFv1kGdT0WuVJWxoOQRn2EoA00j6E3QZy05
         SQSalKDIKfH3CXMc85AXKBnZBwByPKw7jXvo2YGU=
Date:   Mon, 16 Nov 2020 23:33:31 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>,
        alsa-devel@alsa-project.org
In-Reply-To: <20201116172423.546855-1-jbrunet@baylibre.com>
References: <20201116172423.546855-1-jbrunet@baylibre.com>
Subject: Re: [PATCH] ASoC: meson: fix COMPILE_TEST error
Message-Id: <160556956525.29683.11005029623520003708.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Nov 2020 18:24:23 +0100, Jerome Brunet wrote:
> When compiled with CONFIG_HAVE_CLK, the kernel need to get provider for the
> clock API. This is usually selected by the platform and the sound drivers
> should not really care about this. However COMPILE_TEST is special and the
> platform required may not have been selected, leading to this type of
> error:
> 
> > aiu-encoder-spdif.c:(.text+0x3a0): undefined reference to `clk_set_parent'
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: meson: fix COMPILE_TEST error
      commit: 299fe9937dbd1a4d9a1da6a2b6f222298534ca57

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
