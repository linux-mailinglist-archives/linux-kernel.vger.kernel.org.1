Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 507E420B447
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jun 2020 17:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbgFZPQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jun 2020 11:16:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:59646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbgFZPQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 11:16:51 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C5FA207E8;
        Fri, 26 Jun 2020 15:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593184610;
        bh=1ihjD1EqoCW2dLo+KX2P7PqXUWQQSPFNHKQDFXLZwHE=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=F8u+ZI3tQCTeiW1J2AvdhtEJPJYr9jNUUUJeVTyQ7qIZBbFDVUGo83tApa2pVKI2r
         qQjH8mZuVKwWu0PgbYXgRphVSTG/LOdqZ7FmW2ezpbvmxYCMmY0okpeG6VMBjuHTGF
         Zu4zKHucgeQpDjZaSoBl6hWXutjLTyEgV5PidM+4=
Date:   Fri, 26 Jun 2020 16:16:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>, lgirdwood@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20200625191708.4014533-1-lee.jones@linaro.org>
References: <20200625191708.4014533-1-lee.jones@linaro.org>
Subject: Re: [RESEND 00/10] Fix a bunch of W=1 warnings in Regulator
Message-Id: <159318460834.3136.15198327802374358899.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jun 2020 20:16:58 +0100, Lee Jones wrote:
> Attempting to clean-up W=1 kernel builds, which are currently
> overwhelmingly riddled with niggly little warnings.
> 
> Resent to include patch contributors/maintainers/MLs.
> 
> Lee Jones (10):
>   regulator: consumer: Supply missing prototypes for 3 core functions
>   regulator: devres: Fix issues with kerneldoc headers
>   regulator: of_regulator: Add missing colon for rdev kerneldoc argument
>   regulator: dbx500-prcmu: Remove unused function
>     dbx500_regulator_testcase()
>   regulator: ab8500: Remove unused embedded struct expand_register
>   regulator: wm8350-regulator: Repair odd formatting in documentation
>   regulator: cpcap-regulator: Remove declared and set, but never used
>     variable 'ignore'
>   regulator: cpcap-regulator: Demote kerneldoc header to standard
>     comment
>   regulator: da9063-regulator: Fix .suspend 'initialized field
>     overwritten' warnings
>   regulator: max14577-regulator: Demote kerneldoc header to standard
>     comment
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[01/10] regulator: consumer: Supply missing prototypes for 3 core functions
        commit: da6690767cbd344998f36081815c85f3d467e78c
[02/10] regulator: devres: Fix issues with kerneldoc headers
        (no commit info)
[03/10] regulator: of_regulator: Add missing colon for rdev kerneldoc argument
        (no commit info)
[04/10] regulator: dbx500-prcmu: Remove unused function dbx500_regulator_testcase()
        commit: d3cc3dfcc20e72d537550dbeebbe4a8faa7c2606
[05/10] regulator: ab8500: Remove unused embedded struct expand_register
        commit: aeee55b76bfd100d2612f50d2f9526d760ee2e37
[06/10] regulator: wm8350-regulator: Repair odd formatting in documentation
        commit: 2f5add1e42165c7eb7e4367e1180ae76aa13d394
[07/10] regulator: cpcap-regulator: Remove declared and set, but never used variable 'ignore'
        commit: b89a5effb3345a484584cc2b090af62e1ecb0871
[08/10] regulator: cpcap-regulator: Demote kerneldoc header to standard comment
        commit: 7b804ce0c2e0bbf77b3a1d4b457520145822c496
[09/10] regulator: da9063-regulator: Fix .suspend 'initialized field overwritten' warnings
        (no commit info)
[10/10] regulator: max14577-regulator: Demote kerneldoc header to standard comment
        commit: 0c32f8aa0711af177248c2cba9cb105f18e0c9bb

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
