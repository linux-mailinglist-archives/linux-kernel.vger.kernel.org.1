Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAD6B222F7E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 01:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgGPX5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 19:57:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:57850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbgGPX5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 19:57:33 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72A1E20760;
        Thu, 16 Jul 2020 23:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594943853;
        bh=tqSXCtQMiwyHKYqnkOiUB8d1vIXUdyzeQuCAtZwzcwA=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=TLEinxrqka8m9BTv0FjH6e3kkytw7kZ7bIkPRQ964IYe+KLT9UPxK9OLYuJSg3EU6
         ebEVIhuD0I80Fqj196UxQ+vRAUw5QWYftf7w1/lYPKmZfsL7RARB6EcLOPmrlrBXwU
         dOZfjvUaTTW/iKirx0GeYmwL17t7HLkETwBn3wxw=
Date:   Fri, 17 Jul 2020 00:57:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        linux-kernel@vger.kernel.org, ranjani.sridharan@linux.intel.com,
        tiwai@suse.com, perex@perex.cz, lgirdwood@gmail.com
In-Reply-To: <1594876028-1845-1-git-send-email-shengjiu.wang@nxp.com>
References: <1594876028-1845-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH v2] ASoC: soc-component: Add missed return for calling soc_component_ret
Message-Id: <159494380521.42174.17727599837039579846.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jul 2020 13:07:08 +0800, Shengjiu Wang wrote:
> Add missed return for calling soc_component_ret, otherwise the return
> value is wrong.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: soc-component: Add missed return for calling soc_component_ret
      commit: be75db5772f93da3a6b52552f260ce9da8fbfff8

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
