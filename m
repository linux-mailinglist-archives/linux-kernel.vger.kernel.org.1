Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B34D42E66B1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 17:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633091AbgL1QPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 11:15:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:54676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2633076AbgL1QOx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 11:14:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D0974207FB;
        Mon, 28 Dec 2020 16:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609172053;
        bh=lpQg7KEIaNjzaVRL5PdEW5Sw6Kl0BuNVVJChQmSvcws=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=EE3/XBxTEkj9kyGWxu8xMgld8BGNzUtEJl85Qd7Sdno2Q+yYAud+wy/5T3+nJ+lWQ
         XaHYJ9nSXZkDLGr68+sc3kQhQ62AbNMNwG+nI9ghcrHdlv8dNxUIvfR6LyUjPSmvZs
         W5k5Zj9ipkBH2dwbsGzLxWmCYEhoVCHWnSdbV8QaC5DYLi1tNaXJnYG8UNmLrZ0BM0
         bAY0w8+l/kJJzAQxQVWcrTFyR5c2XhV3xqF8TeNFBzzsWWtoWI9hItktqLFErFqU7J
         I7QffXOL+y9WzbR7vV4mJlZLLrxljDIusiy4WKAgIM6Bd6B+szqwNIITlo3TPrOSxt
         gNe2VYgAuGTpw==
From:   Mark Brown <broonie@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20201221040610.12809-1-rdunlap@infradead.org>
References: <20201221040610.12809-1-rdunlap@infradead.org>
Subject: Re: [PATCH] lib/linear_ranges: fix repeated words & one typo
Message-Id: <160917202696.51934.15084967539647503221.b4-ty@kernel.org>
Date:   Mon, 28 Dec 2020 16:13:46 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Dec 2020 20:06:10 -0800, Randy Dunlap wrote:
> Change "which which" to "for which" in 3 places.
> Change "ranges" to possessive "range's" in 1 place.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] lib/linear_ranges: fix repeated words & one typo
      commit: 4d5270e70981c278307e6c25666c300653ed5f4c

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
