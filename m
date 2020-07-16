Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4127222F87
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 01:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgGPX6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 19:58:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:58702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbgGPX6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 19:58:14 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5F6120760;
        Thu, 16 Jul 2020 23:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594943894;
        bh=C5gqtBPLFtL4OUzEOkCjojpRVMajEn0tn0kkw1AVFFI=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=rQsYWVQ4s446ID97Dji6YG36oZldSIuv3Y+OnbSu2DxF+2yZdA7YCBQh4MyJYw5Wg
         bxvFHP8okJhIPrxeLkSG354uBp+Vr03tfM6i3zv14Py5jI5K2Qs2c0/Rj4UWtwpgKm
         pam+u6Tch9VcTETk78/hNRvN1pPJ+dAzursk9DiE=
Date:   Fri, 17 Jul 2020 00:58:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, Colton Lewis <colton.w.lewis@protonmail.com>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20200715191438.29312-1-colton.w.lewis@protonmail.com>
References: <20200715191438.29312-1-colton.w.lewis@protonmail.com>
Subject: Re: [PATCH] regulator: Correct kernel-doc inconsistency
Message-Id: <159494388411.42422.14343711838477555547.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jul 2020 19:15:00 +0000, Colton Lewis wrote:
> Silence documentation build warning by correcting kernel-doc comments.
> 
> ./include/linux/regulator/machine.h:196: warning: Function parameter or member 'max_uV_step' not described in 'regulation_constraints'
> ./include/linux/regulator/driver.h:206: warning: Function parameter or member 'resume' not described in 'regulator_ops'

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: Correct kernel-doc inconsistency
      commit: a98bcaa92d3d7a7753e23b3363d90ffdb82e8edb

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
