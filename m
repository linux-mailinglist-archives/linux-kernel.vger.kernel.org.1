Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD1C222F81
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 01:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgGPX5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 19:57:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:58084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbgGPX5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 19:57:43 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EB922076D;
        Thu, 16 Jul 2020 23:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594943862;
        bh=0KEn9GGodMAd0GZ7nJ9P9iUYKaDti52GK2guzJb/P4w=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=XAIocMRK2IbotWianyYDXpavaPbno1JrNsGdRieeU6p/nLKKp8TYjuaPvzd8Jmwid
         Fl6z5R/ElUHBtrvDsmRq9ov6ZJKonxNpOsCHQTNWXB/41cfytpBn0nuwCLqEesKOSY
         efn3YpQdcJvpe+uPIEP0XSfH7W768BnAPDHbpn4E=
Date:   Fri, 17 Jul 2020 00:57:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>, lgirdwood@gmail.com
Cc:     alsa-devel@alsa-project.org, Fabio Estevam <festevam@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, Xiubo Li <Xiubo.Lee@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>
In-Reply-To: <20200715094447.3170843-1-lee.jones@linaro.org>
References: <20200715094447.3170843-1-lee.jones@linaro.org>
Subject: Re: [PATCH 1/1] ASoC: fsl: fsl-asoc-card: Trivial: Fix misspelling of 'exists'
Message-Id: <159494380521.42174.11701175343660094863.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jul 2020 10:44:47 +0100, Lee Jones wrote:
> 


Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl: fsl-asoc-card: Trivial: Fix misspelling of 'exists'
      commit: 1b58214113481616b74ee4d196e5b1cb683758ee

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
