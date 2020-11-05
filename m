Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F32E2A83D3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 17:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731582AbgKEQqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 11:46:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:48762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730808AbgKEQqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 11:46:03 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9505921734;
        Thu,  5 Nov 2020 16:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604594763;
        bh=3mLgC7lshSCAhLLNfQFl7W9K+GdtDK4zxHxIeFZBLiY=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=CHLDGYX7UcSq3mV9D/0IPslYOkDMlbnKgtSUcm90v7qIoyeBsFpluSPKQU1vnXt7+
         5kYBFRkFNKuH+o/qUCxHt5zxydHnEN0jPW4bX3+bK0s9UDVdBRVRO43HXz+A2TB82m
         Uzr3fV2Tdc0kh+legu7WJG/NciKOW6hXopQZiuVw=
Date:   Thu, 05 Nov 2020 16:45:52 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com
In-Reply-To: <20201105114100.18647-1-srinivas.kandagatla@linaro.org>
References: <20201105114100.18647-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] ASoc: qcom: lpass-cpu: fix warning on symbol scope
Message-Id: <160459472201.54851.16145337656308904668.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Nov 2020 11:41:00 +0000, Srinivas Kandagatla wrote:
> This patch fixes below warning when module is compiled with W=1 C=1
> 
> lpass-cpu.c:677:22: warning: symbol 'lpass_hdmi_regmap_config'
> was not declared. Should it be static?

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qcom: lpass-cpu: fix warning on symbol scope
      commit: 20f64a1db8a06fdf4ed03375546f8d3555cb6cc9

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
