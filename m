Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D91E62159CC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jul 2020 16:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbgGFOne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jul 2020 10:43:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:50850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729148AbgGFOnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 10:43:33 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12C68206CB;
        Mon,  6 Jul 2020 14:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594046613;
        bh=rlzagGQBcRGRZWKw6YaO2zHFVOcuKVe4GkiWu9xaOmM=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=oXyJ7GtiMR8F/fhos4+aNn4Bf0AUh4v3ulykmcfCMUxE08LTpPjM5GORlVrfgm4Jj
         OgkVMCGMdDWlLgigAX3QUMzNGNYm9iEujGljmq1+hnG4My/wEc+HzXYgJLF1NB27Gx
         P5YZWfxViuW0aLIUH3VvsivRKf39eeDOOyhqzbHs=
Date:   Mon, 06 Jul 2020 15:43:29 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     linux-kernel@vger.kernel.org,
        Christoph Fritz <chf.fritz@googlemail.com>,
        Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <20200706080944.663750-1-axel.lin@ingics.com>
References: <20200706080944.663750-1-axel.lin@ingics.com>
Subject: Re: [PATCH] regulator: fan53880: Add missing .owner field in regulator_desc
Message-Id: <159404660937.36664.2923875369342917442.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jul 2020 16:09:44 +0800, Axel Lin wrote:
> Add missing .owner field in regulator_desc, which is used for refcounting.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: fan53880: Add missing .owner field in regulator_desc
      commit: 6c814b676e8bab850b64ab76a035571773c65727

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
