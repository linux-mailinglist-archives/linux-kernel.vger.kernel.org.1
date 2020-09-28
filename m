Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4387F27B55F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 21:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgI1TgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 15:36:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:36320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726812AbgI1TgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 15:36:00 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4002C2075F;
        Mon, 28 Sep 2020 19:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601321759;
        bh=lAI06F3qb6LpwpM9MrrzxKHv7dM8IzJK13Nh++HlPLo=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=EFSzjanCXxnXF1kwKXY+K9ugGFSYhmZ1PRyYdWftcBDt6jOsfh+ecFXbtHmI9sxZc
         vrCO2VImgdrZVQAMWUwUQ43mTYHliptDGjmvvwaEoIhGyZ1w9BLAqy01YLL2Y6mDQ/
         4o+7Vertp3qlQYezkDTcrJoT5RsYf2Lo9rvfiME4=
Date:   Mon, 28 Sep 2020 20:35:02 +0100
From:   Mark Brown <broonie@kernel.org>
To:     robh+dt@kernel.org, Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
In-Reply-To: <20200928111821.26967-1-rf@opensource.cirrus.com>
References: <20200928111821.26967-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH v2 1/2] ASoC: cs4234: Add dtschema binding document
Message-Id: <160132168199.55254.6586119876179093156.b4-ty@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Sep 2020 12:18:20 +0100, Richard Fitzgerald wrote:
> Document the bindings for the CS4234 ASoC codec driver.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: cs4234: Add dtschema binding document
      commit: 5ebba5e7d71c965763f722e68cc60b8a4aa9cb31
[2/2] ASoC: cs4234: Add support for Cirrus Logic CS4234 codec
      commit: d4edae9c508c845d92bd59c60c4089c3addad6a8

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
