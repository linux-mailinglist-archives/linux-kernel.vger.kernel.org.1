Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9FD727370C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 02:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729077AbgIVAHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 20:07:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:40832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729053AbgIVAHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 20:07:05 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B22521789;
        Tue, 22 Sep 2020 00:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600733225;
        bh=5POaIqdSqnIiJerU5wA2fwXcDuFcoCtEy3l5jo+m+QU=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=xQlPsYrv9hJ7CQa7A6v3A6Gcp43edCLQWeaFSZ5cn5/29BXHFGceC/GcJmHpGiHNQ
         7lQGUIO4B+CCqG5IK5sRopw01qLFTUArViqixBV3NrkICTEiIVVfKD0qSom/iq87m5
         HaWn8QzsQWbCRsfN3n4VBDy+QzlxjuPbYgL8OxAY=
Date:   Tue, 22 Sep 2020 01:06:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <20200920214107.6299-1-krzk@kernel.org>
References: <20200920214107.6299-1-krzk@kernel.org>
Subject: Re: [PATCH] regulator: enable compile testing for Maxim and Samsung PMIC drivers
Message-Id: <160073316152.6369.3858049397907012453.b4-ty@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Sep 2020 23:41:07 +0200, Krzysztof Kozlowski wrote:
> Most of Maxim and Samsung PMIC/MUIC regulator drivers can be compile
> tested to increase build coverage.  This allows to build them on
> configurations without I2C (as I2C is required by dependency - parent
> MFD driver).

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: enable compile testing for Maxim and Samsung PMIC drivers
      commit: 0c7d1b4d0c1e7c4309e01532b811392b11b81693

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
