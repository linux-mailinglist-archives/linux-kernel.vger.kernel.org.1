Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3CD5259173
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 16:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbgIAOvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 10:51:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:36934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728740AbgIAOvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 10:51:04 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6853B21655;
        Tue,  1 Sep 2020 14:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598971861;
        bh=U9kVy65nnzvTM41H46euJ38ARji/idElYj/bQEfwOe0=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=yEj0FDjNHERndHIlmFK+60ckfBfP2xlsAxXCJWFPx1QbxzpEOcM+QXktMVEreCNZM
         uXVHYmMmZFY/eSjuHT51bixM7odLrLbwtUQVRusR294dBz8gPFVHklRjk9+zqSpEI8
         6bu5wRCE8yuJzzw7LfL7+9eA1MY4BNpY7f/McnQI=
Date:   Tue, 01 Sep 2020 15:50:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20200901111331.641072-1-vkoul@kernel.org>
References: <20200901111331.641072-1-vkoul@kernel.org>
Subject: Re: [PATCH v2] regmap: soundwire: remove unused header mod_devicetable.h
Message-Id: <159897181721.47861.11254515393563198578.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Sep 2020 16:43:31 +0530, Vinod Koul wrote:
> mod_devicetable.h does not seem to be required for this file, so
> remove it.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: soundwire: remove unused header mod_devicetable.h
      commit: 50df0eebbd49b894df7e5e3945d66cd80c322284

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
