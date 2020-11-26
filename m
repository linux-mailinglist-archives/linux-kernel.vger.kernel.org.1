Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFE142C5CD8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 21:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390107AbgKZUGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 15:06:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:36684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728118AbgKZUGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 15:06:32 -0500
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net [92.233.91.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34B9320DD4;
        Thu, 26 Nov 2020 20:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606421191;
        bh=sBT7bn7VejPsdukWpI8QDrdOk3m1GS5gMWAwG2jG0Tw=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=PRLOqp71XKR4m2Tr15QlFJHao8RnjXLSnWhgkSuVJeeOz9HxKSe5Thf6VOS3qLmJ6
         rqAB2g/2Bshe6QeBy9dy6MBqhCXpKIz868fzbaYME9s89+5fD+vQeedobIRvp0f+un
         oICRPFxlNpjGMVLmRMXKGROeYkvw5AZi7jxu+8KM=
Date:   Thu, 26 Nov 2020 20:06:06 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>, lgirdwood@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jonathanh@nvidia.com
In-Reply-To: <1606325147-606-1-git-send-email-claudiu.beznea@microchip.com>
References: <1606325147-606-1-git-send-email-claudiu.beznea@microchip.com>
Subject: Re: [RESEND PATCH] regulator: core: return zero for selectors lower than linear_min_sel
Message-Id: <160642116162.9318.1338696690812308259.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Nov 2020 19:25:47 +0200, Claudiu Beznea wrote:
> Selectors lower than linear_min_sel should not be considered invalid.
> Thus return zero in case _regulator_list_voltage(),
> regulator_list_hardware_vsel() or regulator_list_voltage_table()
> receives such selectors as argument.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: core: return zero for selectors lower than linear_min_sel
      commit: 55cca73931c3a08eb74f5ad06e88304af7a292e0

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
