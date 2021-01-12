Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84ACE2F3604
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 17:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403882AbhALQn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 11:43:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:37896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727590AbhALQn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 11:43:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7C9C323107;
        Tue, 12 Jan 2021 16:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610469766;
        bh=kvA6EzFMifrlgziq/mCenSbkFpe3vuE+zD9SvpBIBaM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=M0NwxyZWDCsqKIT+E54qzEYbDdNlntT1M1W5fTrJyP+jIpl0OFHTEVxN/whiq73E/
         xcD7w6H9LBMJD2vPvqmnuxzkq3gHfmNSBK/0z4BCSXX9ZKpQuyySQXQ9ZnDxT41xVc
         quyJgpdqcY6wIdoUk0ZbbDxfDDEZpNhDj0HBcW9CqaVwy6bPRwFE5f+gXLM38fR/3x
         f3bXRNQy7uT07YdbOG9iV9FESo8Xt7s1/9ujpoJw6w8AveL6y+gBdK5oKh1AC9HFOf
         przWUtEHRPNJQxrBrb9eJhOV/rMeRz4wo2XXnQAUob22t7GtX7Ua0qgLsqfuft6G4Z
         Wvoor/7v/f6Yw==
From:   Mark Brown <broonie@kernel.org>
To:     nuno.sa@analog.com, Xu Wang <vulab@iscas.ac.cn>,
        alsa-devel@alsa-project.org, tiwai@suse.com, lgirdwood@gmail.com,
        perex@perex.cz, lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20210108084456.6603-1-vulab@iscas.ac.cn>
References: <20210108084456.6603-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] ASoC: adau17x1: Remove redundant null check before clk_disable_unprepare
Message-Id: <161046972100.805.6254857210248726641.b4-ty@kernel.org>
Date:   Tue, 12 Jan 2021 16:42:01 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Jan 2021 08:44:56 +0000, Xu Wang wrote:
> Because clk_disable_unprepare() already checked NULL clock parameter,
> so the additional check is unnecessary, just remove it.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: adau17x1: Remove redundant null check before clk_disable_unprepare
      commit: 554a1b00957ec1033994a2d03b5b8eac59a24f3c

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
