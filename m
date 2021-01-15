Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 745A72F841E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388731AbhAOSU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:20:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:43480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388191AbhAOSUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:20:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 816D523A5A;
        Fri, 15 Jan 2021 18:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610734782;
        bh=Qh5LMHea6iPvxBJvzMNldDED2n75eq5O/wUJoTO3pCM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=J8PnzQUvOyTok8zcKdRpmYHXxddHq8PKlQMrAZ2xekPVT1fvLkdrYLKm7F7CxKo82
         AzISDLAmwKMdISVJoA4/qeKo0Fv38yU6UPgIBvkfAjySAE3GkU4eSThlMdW9jl7occ
         WlAtOjQrhaYxxCAdpCkK5+9UFhFaO6Rw9bN7WPXgW96HeDWPnZPMYD8slXyvuixZgq
         IqaaQT2TARu8RarntQ7zn/sw9SM0VuTF+jRy6ZMTin1er4GtbzLJF0voy6itfU2SbR
         N8Us0AwUp4JRtUhPwxBoJ8Z7zJXo/O2qaSvBJwMak5TJ3RNVwneJG5Uh5RKllYLRrD
         5foDuBrUMbCrw==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     plai@codeaurora.org, bgoswami@codeaurora.org,
        alsa-devel@alsa-project.org
In-Reply-To: <20210115165520.6023-1-srinivas.kandagatla@linaro.org>
References: <20210115165520.6023-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 1/2] MAINTAINERS: update maintainers of qcom audio
Message-Id: <161073473698.12268.8770023938274455760.b4-ty@kernel.org>
Date:   Fri, 15 Jan 2021 18:18:56 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jan 2021 16:55:19 +0000, Srinivas Kandagatla wrote:
> Add myself as maintainer of qcom audio drivers, as Patrick
> has very little time to look at the patches.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] MAINTAINERS: update maintainers of qcom audio
      commit: 9b268be3adbb410cc1a857477b638a71258891a8
[2/2] MAINTAINERS: update qcom ASoC drivers list
      commit: 7505c06dabb5e814bda610c8d83338544f15db45

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
