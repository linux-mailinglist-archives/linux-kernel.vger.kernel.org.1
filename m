Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45EBE2979F8
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 02:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759010AbgJXA3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 20:29:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:42062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759003AbgJXA27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 20:28:59 -0400
Received: from localhost (cpc102338-sgyl38-2-0-cust404.18-2.cable.virginm.net [77.102.33.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B3EE22274;
        Sat, 24 Oct 2020 00:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603499339;
        bh=RsXFfkOEFfdLWi9HJazwWeceFHXhYczHHadtZ1Qy+3A=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=QjVBdlp2SyGhfe6Ci+sFakCTZaTWI7WVxrl9JX2o2xtjut1/DhdpmxZnUTvDX4sTn
         z9Dzc+V+jTU3Q337WvHvI4oUjB51IeSoo6l7dIIkYN2Z90W63SrjiRFYP4ajqxKEze
         nZKw2Rhkbb44KPzVIxm28uts35sWdi+HUOZ1oZ30=
Date:   Sat, 24 Oct 2020 01:28:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
In-Reply-To: <20201022130518.31723-1-srinivas.kandagatla@linaro.org>
References: <20201022130518.31723-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] ASoC: codecs: wsa881x: add missing stream rates and format
Message-Id: <160349931942.28438.14450797150315079803.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Oct 2020 14:05:18 +0100, Srinivas Kandagatla wrote:
> Add missing supported rates and formats for the stream, without
> which attempt to do playback will fail to find any matching rates/format.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: wsa881x: add missing stream rates and format
      commit: f47d0742515748162d3fc35f04331c5b81c0ed47

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
