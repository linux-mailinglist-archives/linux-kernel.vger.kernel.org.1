Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A689299B06
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 00:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408389AbgJZXrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 19:47:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:44208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408372AbgJZXrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 19:47:19 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F74820809;
        Mon, 26 Oct 2020 23:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603756038;
        bh=8e+JQ2x+eeQocyNPZN+4ob1xi20n6Ei8E+bl7jF11K0=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=QtYTOTdvAySWrJF70q4ODepiLXBFL6igOAC9lFp2BBCla+Y+12P1w3vdf/2UR71zH
         bj8dOUVQmENpoauFpvYkP3SKQPBmBXbFmsLBRIUHo8EWjVsR2m/VUmv5WT8NhZVfTV
         +g/O7bMaoLjHjAJCZE080R/Xc/vGJ18rJdBTNvWw=
Date:   Mon, 26 Oct 2020 23:47:14 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Colin King <colin.king@canonical.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <20201016222235.686981-1-colin.king@canonical.com>
References: <20201016222235.686981-1-colin.king@canonical.com>
Subject: Re: [PATCH] regulator: lp872x: make a const array static, makes object smaller
Message-Id: <160375603445.32304.3851545649708481770.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Oct 2020 23:22:35 +0100, Colin King wrote:
> Don't populate const array lp872x_num_regulators  on the stack but
> instead make it static. Makes the object code smaller by 29 bytes.
> 
> Before:
>    text	   data	    bss	    dec	    hex	filename
>   18441	   4624	     64	  23129	   5a59	drivers/regulator/lp872x.o
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: lp872x: make a const array static, makes object smaller
      commit: 390d828f56a602c9201601bff1170d9d2bf5801c

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
