Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA2461EA320
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 13:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgFALyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 07:54:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:36408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbgFALyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 07:54:13 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B1C9206E2;
        Mon,  1 Jun 2020 11:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591012452;
        bh=eZswvM1h8ScKV1GDIeYKrvgxUA7YEXgOvpLgITB8YGQ=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=CVBcfsSgtOKiYV78+U6up1xnx+ZmBZ6lpWqxIFjmXBcLQq8uZkUFyjY9ZG8GK6DG+
         61jkIhuCTvIjBszUG763ejEWDrcjAlMcDp+whgeEtIr01314hsbD/E165ADi22rfVj
         Nx/Qq0FhWKQEiDxxVqpuKjIrYGAzg91EOgTrF+jQ=
Date:   Mon, 01 Jun 2020 12:54:10 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Jonathan, Bakker," <xc-racer2@live.ca>,
        kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20200530130314.GA73557@d7d8dbfb64ff>
References: <202005302128.HV9kPNGq%lkp@intel.com> <20200530130314.GA73557@d7d8dbfb64ff>
Subject: Re: [RFC PATCH regulator] regulator: max8998: max8998_set_current_limit() can be static
Message-Id: <159101245057.15502.12546606590584178.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 May 2020 21:03:14 +0800, kbuild test robot wrote:
> 


Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: max8998: max8998_set_current_limit() can be static
      commit: 0b0c0bd818ef76a20f58c3cb1ac96a3056ccb681

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
