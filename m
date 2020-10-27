Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9343F29CA77
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 21:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1831880AbgJ0Ujp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 16:39:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:45768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1831860AbgJ0Ujd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 16:39:33 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 219C420725;
        Tue, 27 Oct 2020 20:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603831172;
        bh=OioNNIMpmE73+hdu17irdscY8n2O0KgLmga33QfwV9k=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=JyinfZlG2CozbpmBQ6+cM9Yb/0avAmc9+61oDeEOKKDUHeeQzElkfQyIDwpzfIBgC
         2xQlKrFvAS6gksWtKBMBgqCUuCnX6BG27mjIVAQTJmJKI/AIBteAZjoNPclxqFAah9
         Dn6Ms/BwgMpixxJtXW2Yrxd8WFL6jtDdiAFz7ols=
Date:   Tue, 27 Oct 2020 20:39:27 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org
In-Reply-To: <20201027111526.12326-1-srinivas.kandagatla@linaro.org>
References: <20201027111526.12326-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2] ASoC: qcom: qdsp6: make use of devm_of_platform_populate
Message-Id: <160383115673.25818.13026629187393927150.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Oct 2020 11:15:26 +0000, Srinivas Kandagatla wrote:
> make use of devm_of_platform_populate to remove some redundant code!

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qcom: qdsp6: make use of devm_of_platform_populate
      commit: 023e1b1f1164a5e2da2ad20588cf164de9ef67bb

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
