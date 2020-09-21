Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E31A27350E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 23:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbgIUVlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 17:41:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:58266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728043AbgIUVlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 17:41:39 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CA8723A61;
        Mon, 21 Sep 2020 21:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600724499;
        bh=4Jl1/4OoGFeuOMI2swv5kCfO1u/sDCnxpSb3SMt1cXw=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=HHpqEGjlTU9+AD5l8mPZgI6P6bIQ2/Q+Bs5Ni11pnnl6fpV0XgE6dVkdQrXPnNxTE
         BbyO1equGEeHmRTrMnZmN+SVhDU6Rhi15TyxaLuygKAt5Hjhseo2NHKO+OEDA5WZ0W
         j0rWjRZ7uQ/J8Rij0kfA7r4zWrDSoq2Ywpjr0i98=
Date:   Mon, 21 Sep 2020 22:40:47 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ben Whitten <ben.whitten@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20200917153405.3139200-1-dmitry.baryshkov@linaro.org>
References: <20200917153405.3139200-1-dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v2 1/2] regmap: fix page selection for noinc reads
Message-Id: <160072444712.56996.10601329042842573406.b4-ty@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Sep 2020 18:34:04 +0300, Dmitry Baryshkov wrote:
> Non-incrementing reads can fail if register + length crosses page
> border. However for non-incrementing reads we should not check for page
> border crossing. Fix this by passing additional flag to _regmap_raw_read
> and passing length to _regmap_select_page basing on the flag.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/2] regmap: fix page selection for noinc reads
      commit: 4003324856311faebb46cbd56a1616bd3f3b67c2
[2/2] regmap: fix page selection for noinc writes
      commit: 05669b63170771d554854c0e465b76dc98fc7c84

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
