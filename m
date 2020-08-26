Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C127253826
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 21:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbgHZTRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 15:17:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:40486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728012AbgHZTR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 15:17:27 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56E212078B;
        Wed, 26 Aug 2020 19:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598469446;
        bh=tje2jJ12gd9XIemyHJQgMO4DHFwCLig6InjjheE2uhk=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=DUJ9kj1n3SZ8m6ES5OKTBqsRNGHhONmJF42ZVse4w8PHTqm2f203MRlmMNl3QMkTp
         sUj8vKPh5gUZBygvT6feb2rdhyDFBFmhtuOm3I3y83CGzHyGiTfZy89b7tHPMLoZYH
         kTswt1rnNuZ3Jyb0GjW/rOLRoLm7/4v8OKpA2DYM=
Date:   Wed, 26 Aug 2020 20:16:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, lee.jones@linaro.org,
        Xu Yilun <yilun.xu@intel.com>
Cc:     hao.wu@intel.com, lgoncalv@redhat.com,
        matthew.gerlach@linux.intel.com, trix@redhat.com,
        russell.h.weight@intel.com
In-Reply-To: <1597822497-25107-1-git-send-email-yilun.xu@intel.com>
References: <1597822497-25107-1-git-send-email-yilun.xu@intel.com>
Subject: Re: [PATCH v4 0/2] add regmap-spi-avmm & Intel Max10 BMC chip support
Message-Id: <159846941049.39902.15220563960562003689.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Aug 2020 15:34:55 +0800, Xu Yilun wrote:
> This patchset adds the regmap-spi-avmm to support the Intel SPI Slave to
> AVMM Bus Bridge (spi-avmm) IP block. It also implements the usercase - the
> driver of Intel Max10 BMC chip which integrates this IP block.
> 
> Patch #1 implements the regmap-spi-avmm.
> Patch #2 implements the mfd driver of Intel Max10 BMC chip.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/2] regmap: add Intel SPI Slave to AVMM Bus Bridge support
      commit: 7f9fb67358a2bcaacbdfeee12e0f19e98c8bdf55
[2/2] mfd: intel-m10-bmc: add Max10 BMC chip support for Intel FPGA PAC
      commit: 53be8bbc2f4058d4a6bfff3dadf34164bcaafa87

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
