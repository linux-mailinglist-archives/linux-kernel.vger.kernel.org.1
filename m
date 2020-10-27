Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2EC29CA76
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 21:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1831873AbgJ0Ujm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 16:39:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:45684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1831857AbgJ0Uj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 16:39:27 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA80D21D24;
        Tue, 27 Oct 2020 20:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603831167;
        bh=mYpKtnquAkaw0Puhc9R5givJhzU92gCc5aMlJAvKy5A=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=yuWXYEvWJqnUWwZ4LArKjQ2rNVy5ldDSAbAh5w030eTKUu/0QoxGDghRhsVEe967e
         fdki/g21ZM1CyWRCyb4OSNjxGYZPVPKe2SvScRP/cGDL6whBEeawOjQvRtcINcf2to
         VytAQ5NV5Bf6PmhFvqXEiKa9l3/dp1GIfg/k9CjM=
Date:   Tue, 27 Oct 2020 20:39:22 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org
In-Reply-To: <20201022130254.29937-1-srinivas.kandagatla@linaro.org>
References: <20201022130254.29937-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] ASoC: qcom: qdsp6: make use of devm_of_platform_populate
Message-Id: <160383115672.25818.3206390931221282078.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Oct 2020 14:02:54 +0100, Srinivas Kandagatla wrote:
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
