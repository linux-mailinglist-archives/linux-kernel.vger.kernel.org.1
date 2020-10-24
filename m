Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56FD02979F6
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 02:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756435AbgJXA2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 20:28:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:41690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756390AbgJXA2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 20:28:46 -0400
Received: from localhost (cpc102338-sgyl38-2-0-cust404.18-2.cable.virginm.net [77.102.33.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9958622274;
        Sat, 24 Oct 2020 00:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603499326;
        bh=32XWQhmf2fVSD8v1CY5v7gHT3K2lKMcNN/oPnMyqnMM=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=JPGAuEs7+4VUhMKKdXZG/LQTnx1a+EStQyyQ6fkoVqfPgjFgmepkBZDsV/h20Bd4B
         P8/Sm6HsBShl7Ko/IhG8Q/XiWPSgahyb4A/ColiqD4Bp4V2NuyHnN+DXyO3bC3cG8/
         +x+Cj8IJzevU9ULTEYXsTeiKGuhdL0W4QfHr/CoQ=
Date:   Sat, 24 Oct 2020 01:28:44 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
In-Reply-To: <20201023095849.22894-1-srinivas.kandagatla@linaro.org>
References: <20201023095849.22894-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] ASoC: qcom: sdm845: set driver name correctly
Message-Id: <160349931942.28438.7096729717850687887.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Oct 2020 10:58:49 +0100, Srinivas Kandagatla wrote:
> With the current state of code, we would endup with something like
> below in /proc/asound/cards for 2 machines based on this driver.
> 
> Machine 1:
>  0 [DB845c            ]: DB845c - DB845c
>                        DB845c
> Machine 2:
>  0 [LenovoYOGAC6301]: Lenovo-YOGA-C63 - Lenovo-YOGA-C630-13Q50
>                      LENOVO-81JL-LenovoYOGAC630_13Q50-LNVNB161216
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qcom: sdm845: set driver name correctly
      commit: 3f48b6eba15ea342ef4cb420b580f5ed6605669f

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
