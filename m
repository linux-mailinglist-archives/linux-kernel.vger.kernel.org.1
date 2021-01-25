Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86CBF3036BA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 07:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388047AbhAZGky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 01:40:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:57082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729696AbhAYOlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 09:41:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CC36723B04;
        Mon, 25 Jan 2021 14:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611585396;
        bh=lnbnWhYPygqLJRHRyoAjOYPsiePxQqvy8fWmCbYYWeM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=FXtv1UgHQCAxl2ixOim6IVlkwY6T98FDYakXd9TEYiQ4/itAIiypMaFwJ61me/MmH
         cBKj4NFjM+3irh7uX2qDw49/QjFPS4D36s9/grEBiwRxujVt5lZoEr7ilWmwRfUhK0
         +48R/gXHPIzkrsGbnlAB2f8zLgkcyYMfYnv+1vlJ7P6tiGHib9GTVeejutAQkmZE5H
         m09wBomyE83WGkv2DdBw+94l4S5DYGnZR/kQ4dxl/N6MWf3ZdwWQDvSZQ4xFN1296q
         HbwMdaL5nkh8AxAG/EOpsWRwqYurwXocFeqsfl9O89wq7SVPtKQhh5HtPmbP9UAWiO
         aUWLih6s+oehA==
From:   Mark Brown <broonie@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>,
        Christoph Fritz <chf.fritz@googlemail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Adrien Grassein <adrien.grassein@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4c2e79d4fa96befdc9a6c59c3ff27b0a34f9fb56.camel@googlemail.com>
References: <4c2e79d4fa96befdc9a6c59c3ff27b0a34f9fb56.camel@googlemail.com>
Subject: Re: [PATCH] regulator: pf8x00: Add suspend support
Message-Id: <161158534940.35689.848439196993404796.b4-ty@kernel.org>
Date:   Mon, 25 Jan 2021 14:35:49 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Jan 2021 21:49:17 +0100, Christoph Fritz wrote:
> This patch adds suspend/resume support so that it is possible to
> configure the LDOs and BUCKs as on or off during suspend phase as
> well as to configure suspend specific voltages.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: pf8x00: Add suspend support
      commit: 7fefe72b0f8c0d7e63af9810c4dcc88757eddcd5

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
