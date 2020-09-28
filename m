Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8D6627B55A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 21:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgI1Tfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 15:35:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:36044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726424AbgI1Tfj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 15:35:39 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A5182075F;
        Mon, 28 Sep 2020 19:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601321739;
        bh=BsXKWSu4s+YcxxERLVTSYjv5y7Zks6n3V7+kJsb3bbw=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=P7XicuHA/iSQk1m1xETPeweXYvFwdngvjD/KndXNvoKvF0Gmxi4/zxJc5BcVg31cx
         qkXyxOycqAfOf1VdeywnVyWZRfTFVh7RbEWde3z5Yn2rSqZiktRGvUGHeLLV7Za6hW
         5s9+SNyl9jSG/IQg76v30Gj7ZOPW4BAvUaByQUx4=
Date:   Mon, 28 Sep 2020 20:34:42 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     alsa-devel@alsa-project.org, rohitkr@codeaurora.org,
        rafael@kernel.org, gregkh@linuxfoundation.org,
        srivasam@codeaurora.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, tiwai@suse.com
In-Reply-To: <20200925164856.10315-1-srinivas.kandagatla@linaro.org>
References: <20200925164856.10315-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 0/2] regmap: add support to regmap_field_bulk_alloc/free
Message-Id: <160132168199.55254.1303533504124900914.b4-ty@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Sep 2020 17:48:54 +0100, Srinivas Kandagatla wrote:
> Usage of regmap_field_alloc becomes much overhead when number of fields
> exceed more than 3. Most of driver seems to totally covered up with these
> allocs/free making to very hard to read the code! On such driver is QCOM LPASS
> driver has extensively converted to use regmap_fields.
> 
> This patchset add this new api and a user of it.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] regmap: add support to regmap_field_bulk_alloc/free apis
      commit: 95892d4075db67fb570a5d43c950318057e8a871
[2/2] ASoC: lpass-platform: use devm_regmap_field_bulk_alloc
      commit: 44e755fb54feda74e7af7c2ddc04cc23b64ee39c

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
