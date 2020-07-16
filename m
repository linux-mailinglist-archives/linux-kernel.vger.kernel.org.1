Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C008222F85
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 01:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgGPX6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 19:58:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:58518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbgGPX6D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 19:58:03 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3CF52076D;
        Thu, 16 Jul 2020 23:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594943883;
        bh=v4Ay/F1H0JaocBvA5JJ9KZ2UYgb8EG9bL8tWNuwCi78=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=dHK+Rf43IpVbFUSWGoW1nKwlGlBGmr7bP4b7GW3PdwA2P6sidYu7luGsp6W3qMRci
         ihh/sYjZuDCnhbagvASkZZ2AyHQKHLU/Z0x1p6wRpVWgxiSQgnYlw9QnVWY3N53/OL
         th7wzQS+zVn8x6MGKJx7uGrDa9lfpduIUjiEU5Xg=
Date:   Fri, 17 Jul 2020 00:57:53 +0100
From:   Mark Brown <broonie@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <7ef41bfc-de3e-073a-8746-0b3fdf7628c0@infradead.org>
References: <7ef41bfc-de3e-073a-8746-0b3fdf7628c0@infradead.org>
Subject: Re: [PATCH] regmap: fix duplicated word in <linux/regmap.h>
Message-Id: <159494387342.42385.10110669627347720907.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jul 2020 18:30:12 -0700, Randy Dunlap wrote:
> Change doubled word "be" to "to be".

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: fix duplicated word in <linux/regmap.h>
      commit: 6611561a7a7ef925294353a4c2124bdb66eb831c

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
