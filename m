Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E14827417A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 13:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgIVLtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 07:49:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:50922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726531AbgIVLth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 07:49:37 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC07A221EB;
        Tue, 22 Sep 2020 11:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600775377;
        bh=Q4KDNQJE+iH1DnDYsmw0dPu90gd1omWDNMB3ZeVjjGg=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=Q0kzW0fqgH/ZynkmIIsZ+Sk3TIZn1d1t5vPwcPmXgKloPcyO+FEfgbJPD2ON45Hz8
         OOhutiHnFCkdlS2Oq5dnBkZlt3W7mf2vS5wJL9kS7AQvzZ8+wJETBuTKgGLs+1yuJc
         NnwNw6eHuWv6vW9+hMhEnlq2sqh22UhUiTpgzLzI=
Date:   Tue, 22 Sep 2020 12:48:44 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Cheng-Yi Chiang <cychiang@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Rohit kumar <rohitkr@codeaurora.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Tzung-Bi Shih <tzungbi@google.com>, tzungbi@chromium.org,
        Srinivasa Rao <srivasam@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-mediatek@lists.infradead.org, alsa-devel@alsa-project.org,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>, dianders@chromium.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-rockchip@lists.infradead.org, dgreid@chromium.org
In-Reply-To: <20200922062316.1172935-1-cychiang@chromium.org>
References: <20200922062316.1172935-1-cychiang@chromium.org>
Subject: Re: [PATCH] ASoC: hdmi-codec: Use set_jack ops to set jack
Message-Id: <160077532459.10007.8996932486569302078.b4-ty@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Sep 2020 14:23:16 +0800, Cheng-Yi Chiang wrote:
> Use set_jack ops to set jack so machine drivers do not need to include
> hdmi-codec.h explicitly.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: hdmi-codec: Use set_jack ops to set jack
      commit: 55c5cc63ab3277aa20637dc20f6528987ac23743

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
