Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7812F248C34
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 18:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbgHRQ60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 12:58:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:40252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728544AbgHRQ5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 12:57:10 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A79D2086A;
        Tue, 18 Aug 2020 16:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597769829;
        bh=fG2J0o6NC1OzfaBdXE1TsFsuqYACRpapQBiapTK7+5I=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=tMbuNjqYcLlypNjI62t4NoijRQpbUzXY9Oh1+RA4CXPM18Z6QbjXLCukyr+b1+gZr
         A8F62YfZ+esWNvqzCFugtUgp1upYPskoPa7/7tWbosDKD4hTXddg1rvoq5dw6zzAlu
         eBIn7eo0TzeSjXKLvvn8nGpXwcRTQ/1eK1MGO1t8=
Date:   Tue, 18 Aug 2020 17:56:39 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     "Angelo G . Del Regno" <kholk11@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>
In-Reply-To: <20200801054820.134859-1-axel.lin@ingics.com>
References: <20200801054820.134859-1-axel.lin@ingics.com>
Subject: Re: [PATCH] regulator: qcom_spmi: Improve readability for setting up enable/mode pin control
Message-Id: <159776976826.56451.2281400490501559923.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Aug 2020 13:48:20 +0800, Axel Lin wrote:
> By checking data->pin_ctrl_enable / data->pin_ctrl_hpm flags first, then
> use switch-case to improve readability.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: qcom_spmi: Improve readability for setting up enable/mode pin control
      commit: 6a1fe83bf14b87fd8b02f391ea629f69624d9c34

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
