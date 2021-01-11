Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 145F72F1AEB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 17:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733133AbhAKQ3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 11:29:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:37214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725858AbhAKQ3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 11:29:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C00D22B30;
        Mon, 11 Jan 2021 16:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610382518;
        bh=aSEP22RVIp/nVYRhctvQJEglPOgklG5HtjTl5BfbCkE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Xbv/W/pqgqqIExXYNi2EDYMrMUgRROcOifZUtDfEysa3+N5ju3TaTdmW73Au70hZJ
         q4daF5k1TwEttx1mH3mPBKutryk8lioK2KIra3FmQwqEvxQf0eZITTqjpYQlM5RTq+
         QP6MC1EUhQiUsYHfEbDyMkBp1nDWzPl94i9ctoi3EOR0IdFc0ryPHETOn6fPSwCU9e
         6dOf/strL06jT87qY84nL8HFo2xY75cNoYCs6eK7PjOFTcQ2HiaumXc3iekSgaEvum
         +8a7NQgMA+Hzb036WoXnLNqt/92VZnk2px1MTDVIbj10uJfXFSW46gjYDpMnGBC06+
         9k0fakQCS86KQ==
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
In-Reply-To: <20210111133825.8758-1-rf@opensource.cirrus.com>
References: <20210111133825.8758-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: wm_adsp: Fix uninitialized variable warnings
Message-Id: <161038245912.32701.15008025253298695654.b4-ty@kernel.org>
Date:   Mon, 11 Jan 2021 16:27:39 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jan 2021 13:38:25 +0000, Richard Fitzgerald wrote:
> wm_adsp_read_data_word() used if (ret) to check for an error from
> wm_adsp_read_raw_data_block(). While this is perfectly valid,
> wm_adsp_read_raw_data_block() itself uses if (ret < 0) and three
> calls to wm_adsp_read_data_word() also use if (ret < 0).
> 
> This creates an error check chain like this:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: wm_adsp: Fix uninitialized variable warnings
      commit: fe9989fb25b0cea6414e72e0514c70ed8b158c28

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
