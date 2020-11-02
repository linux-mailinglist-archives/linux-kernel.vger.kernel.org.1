Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 928FF2A313D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 18:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbgKBRSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 12:18:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:39206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726860AbgKBRSK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 12:18:10 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5D9D20691;
        Mon,  2 Nov 2020 17:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604337490;
        bh=S9Ost0F6oyf1K0gMlJiyk7u6GV3N54pcPi2zPO/M92g=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=bbk0Ud3nLBDD0WRjUgP7/LxTe+2TK5ZSB6X7bmQd2j/P5DuZGtVjoWxepWmu4zmP4
         iCAbw0E+Invt8BvG/oomtyhPmvuw9Rrf+hME5DAsyYC9IM+V9bQSGxzCHejyWV7XZ+
         3aD9J29fiMGJbCjM/I0svy1sfXU9sLhy+NIqOT1I=
Date:   Mon, 02 Nov 2020 17:18:01 +0000
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, andriy.shevchenko@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, amit.kucheria@linaro.org,
        rafael.j.wysocki@intel.com, cezary.rojewski@intel.com,
        liam.r.girdwood@linux.intel.com,
        "trix@redhat.com" <trix@redhat.com>, perex@perex.cz,
        yuehaibing@huawei.com, yang.jie@linux.intel.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20201101171943.2305030-1-trix@redhat.com>
References: <20201101171943.2305030-1-trix@redhat.com>
Subject: Re: [PATCH] ASoC: Intel: remove unneeded semicolon
Message-Id: <160433748157.18840.14013334012819577591.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Nov 2020 09:19:43 -0800, trix@redhat.com wrote:
> A semicolon is not needed after a switch statement.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: remove unneeded semicolon
      commit: c1af06a28a0176ceb1fc71408b32aabf53db4470

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
