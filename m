Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26F932A83D7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 17:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731649AbgKEQqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 11:46:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:48908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731620AbgKEQqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 11:46:09 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38AD122210;
        Thu,  5 Nov 2020 16:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604594768;
        bh=dvounATz3cVDTeHGqKKStRGMVEsVV8CE5gX6mXYoZFY=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=C/e5Hrt2eJMfQUEb+sZgLHVI96Yq9yfMg2iUXmXATtoL7XdWWfxO+BdEYxyHIA9Y+
         mIB4yJ6zSIZ53lMEsTliJEK/LdN3WakVBwJomWfjBki51F5Mpm+j5nKxlMEY9LbVmN
         2/o0J/rMYvlasQzFX5TZgwbCr0N29F4b39fGtDN8=
Date:   Thu, 05 Nov 2020 16:45:57 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com
In-Reply-To: <20201105114435.22860-1-srinivas.kandagatla@linaro.org>
References: <20201105114435.22860-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] ASoC: q6afe-clocks: fix warning on symbol scope
Message-Id: <160459472201.54851.12441055496999387552.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Nov 2020 11:44:35 +0000, Srinivas Kandagatla wrote:
> This patch fixes below warning when module is compiled with W=1 C=1
> 
> sound/soc/qcom/qdsp6/q6afe-clocks.c:122:18: warning: symbol 'q6afe_clks'
> was not declared. Should it be static?

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: q6afe-clocks: fix warning on symbol scope
      commit: ee5d28e735082a5676c85bdc578653097e4e29e2

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
