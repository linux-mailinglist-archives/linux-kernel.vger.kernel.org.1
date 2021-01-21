Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECAC2FF4F0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 20:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbhAUToG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 14:44:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:47218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbhAUTmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 14:42:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6963923A58;
        Thu, 21 Jan 2021 19:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611258082;
        bh=0QYR5KmCtKag9rOF6VidoID5aOHjcHwGjqdyHwpS1D4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=YOMZxoo895UzC5ALOjoWCgmA5syurHHcR7axlYutGzdIf20UE2qnib9VDuoc68dmT
         Y9P0+00Vyq31HyL7AK3Vo7eFOmUUI/mwebu50FOgi5Eo9GvMm/5jtCcx1q3lkoVF4r
         LI/0q1eFOBQz/a0makBubUsDvYod2EmBEUfusN7dL3isK/pLyF2Tfha9YUXeCdOwU/
         l2aSfRHOQccXkTtf8gXVtCcnZDgTVe7I4aadnU+j9IZzsj0IwVfLxSwhNWdJKuxD3F
         YVoF1kQDq77hXO6zZ8S4Y3Z4FR3MxAaHWjy2VVVQ1yQF7u2O220X6lPzpsoSmPTIrt
         LW5O5yxw2r8cg==
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20210120205844.12658-1-digetx@gmail.com>
References: <20210120205844.12658-1-digetx@gmail.com>
Subject: Re: [PATCH v1] regulator: consumer: Add missing stubs to regulator/consumer.h
Message-Id: <161125803281.35944.2080830659749037080.b4-ty@kernel.org>
Date:   Thu, 21 Jan 2021 19:40:32 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jan 2021 23:58:44 +0300, Dmitry Osipenko wrote:
> Add missing stubs to regulator/consumer.h in order to fix COMPILE_TEST
> of the kernel. In particular this should fix compile-testing of OPP core
> because of a missing stub for regulator_sync_voltage().

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: consumer: Add missing stubs to regulator/consumer.h
      commit: 51dfb6ca3728bd0a0a3c23776a12d2a15a1d2457

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
