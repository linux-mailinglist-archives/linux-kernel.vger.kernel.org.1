Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56029248C15
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 18:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbgHRQzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 12:55:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:36102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728410AbgHRQy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 12:54:56 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7656420786;
        Tue, 18 Aug 2020 16:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597769696;
        bh=VDENEqRa3spXvo61gMfMbeFOL1694EOY8/Lq8AShAWc=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=13cPlREeEdoXjVjEZbR2s62IvRUyjy4O0+AeMU8JSaxSpo0xTZ5QcUWB4blvQZRJU
         nF/9VwkoV8fpg3o7znyVY7EeVroci5kt1iTphnAZbEwlBpl0BCq0p/WZyFjK04/zFB
         p9T0C7blGQHtomhvEJ7pWYv+sfr/splDINXlc0eQ=
Date:   Tue, 18 Aug 2020 17:54:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <20200808012143.10777-1-rdunlap@infradead.org>
References: <20200808012143.10777-1-rdunlap@infradead.org>
Subject: Re: [PATCH] ASoC: codecs: delete repeated words in comments
Message-Id: <159776961931.56094.6662814830000829351.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Aug 2020 18:21:43 -0700, Randy Dunlap wrote:
> Drop the repeated words {start, it, the} in comments.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: delete repeated words in comments
      commit: 85131d9489a8b745d4cfa2b549371e97758008f1

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
