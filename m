Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 598E32DE2A7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 13:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgLRMRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 07:17:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:57698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbgLRMRa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 07:17:30 -0500
From:   Mark Brown <broonie@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     alsa-devel@alsa-project.org, tiwai@suse.com,
        Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
        plai@codeaurora.org, devicetree@vger.kernel.org,
        rohitkr@codeaurora.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, srinivas.kandagatla@linaro.org,
        bjorn.andersson@linaro.org, agross@kernel.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, bgoswami@codeaurora.org,
        perex@perex.cz
In-Reply-To: <1608192514-29695-1-git-send-email-srivasam@codeaurora.org>
References: <1608192514-29695-1-git-send-email-srivasam@codeaurora.org>
Subject: Re: [PATCH v6 0/2] Platform driver update to support playback recover after resume
Message-Id: <160829377017.10885.961383820010560969.b4-ty@kernel.org>
Date:   Fri, 18 Dec 2020 12:16:10 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Dec 2020 13:38:32 +0530, Srinivasa Rao Mandadapu wrote:
> This patch set is to add support for playback recover after hard suspend and resume.
> It includes:
> 1. Reverting part of previous commit, which is for handling registers invalid state
> after hard suspend.
> 2. Adding pm ops in component driver and do regcache sync.
> Changes Since v1 and v2:
>   -- Subject lines changed
> Changes Since v3:
>   -- Patch is splitted into 2 patches
> Changes Since v4:
>   -- Subject lines changed
> Changes Since v5:
>   -- Removed redundant initialization of map variable in lpass-platform.c
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: qcom: Fix incorrect volatile registers
      commit: 315fbe4cef98ee5fb6085bc54c7f25eb06466c70
[2/2] ASoC: qcom: Add support for playback recover after resume
      commit: 8d1bfc04c97407767559f6389a0f0fb060cbe25e

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
