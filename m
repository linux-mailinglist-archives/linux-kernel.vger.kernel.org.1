Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C621330060C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 15:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbhAVOvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 09:51:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:50410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728664AbhAVOuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 09:50:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D9B3C23444;
        Fri, 22 Jan 2021 14:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611326975;
        bh=yv1cXnquJ7xKTzg9wrnPvggtL9hbHc6eRB67CpvdF2U=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=lA7FwLo8ukz+p/C4QIlTT2KMW7k0r0Zy8yLGyz8vIZfh0cNN7ZsFYybCvjB0LbVvN
         teSXd8hfXkjSmgnlwB1pKjrFTgfhEHYXvc2wjX5Me2/w+DuU14ZSa2cyfL0HwKEoZc
         v+izevaYvvLJhwcM0BNa/6p6wZjpbkS1C09sSVgtrHatR2QvEZ2IQeg0NM4oDG807B
         2USV22NPPAzjEThat6KEZw6qNErsj03hCWdd1fJL83mJbOpC9umGSe/2QvAqvjNPH0
         c8EH9uYsnbO0jB1J46Fmd1Y1pHISXh4HpnO8Vnk+5tYTifyuWxoSBfz1mJsKp4pvav
         I6IErX6dFTOZg==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210122132042.10306-1-broonie@kernel.org>
References: <20210122132042.10306-1-broonie@kernel.org>
Subject: Re: [PATCH] regulator: Fix lockdep warning resolving supplies
Message-Id: <161132693560.45400.5805860404255875218.b4-ty@kernel.org>
Date:   Fri, 22 Jan 2021 14:48:55 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jan 2021 13:20:42 +0000, Mark Brown wrote:
> With commit eaa7995c529b54 (regulator: core: avoid
> regulator_resolve_supply() race condition) we started holding the rdev
> lock while resolving supplies, an operation that requires holding the
> regulator_list_mutex. This results in lockdep warnings since in other
> places we take the list mutex then the mutex on an individual rdev.
> 
> Since the goal is to make sure that we don't call set_supply() twice
> rather than a concern about the cost of resolution pull the rdev lock
> and check for duplicate resolution down to immediately before we do the
> set_supply() and drop it again once the allocation is done.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: Fix lockdep warning resolving supplies
      commit: 14a71d509ac809dcf56d7e3ca376b15d17bd0ddd

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
