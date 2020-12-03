Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCCE2CDA51
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 16:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389160AbgLCPqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 10:46:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:37364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389098AbgLCPqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 10:46:50 -0500
From:   Mark Brown <broonie@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     lgirdwood@gmail.com, Zou Wei <zou_wei@huawei.com>,
        support.opensource@diasemi.com
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <1606994795-36182-1-git-send-email-zou_wei@huawei.com>
References: <1606994795-36182-1-git-send-email-zou_wei@huawei.com>
Subject: Re: [PATCH -next] regulator: da9121: Mark some symbols with static keyword
Message-Id: <160701036614.3303.4039988837649392583.b4-ty@kernel.org>
Date:   Thu, 03 Dec 2020 15:46:06 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Dec 2020 19:26:35 +0800, Zou Wei wrote:
> Fix the following sparse warnings:
> 
> drivers/regulator/da9121-regulator.c:55:21: warning: symbol 'da9121_10A_2phase_current' was not declared. Should it be static?
> drivers/regulator/da9121-regulator.c:63:21: warning: symbol 'da9121_6A_2phase_current' was not declared. Should it be static?
> drivers/regulator/da9121-regulator.c:71:21: warning: symbol 'da9121_5A_1phase_current' was not declared. Should it be static?
> drivers/regulator/da9121-regulator.c:79:21: warning: symbol 'da9121_3A_1phase_current' was not declared. Should it be static?
> drivers/regulator/da9121-regulator.c:151:32: warning: symbol 'status_event_handling' was not declared. Should it be static?

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: da9121: Mark some symbols with static keyword
      commit: c8dbf2f200de8c9cba3b332522fabad114cf9f53

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
