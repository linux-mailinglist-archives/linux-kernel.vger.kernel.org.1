Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB902C16F4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 21:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730320AbgKWUi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 15:38:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:46328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727847AbgKWUi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 15:38:59 -0500
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net [92.233.91.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44D2A204FD;
        Mon, 23 Nov 2020 20:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606163938;
        bh=A8e5XsmrEj94F0Lbxy4tU9ohPxOZwgP/VW6wbdCvxdI=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=F1IFkrbsk2ZUP+5vsvu62iGXHiaCjEomOSw7B1hCcEu6ne6r9Vq3NlvF2FdwUk2l+
         UNk+lt6HuuoAXyvHKn2uSogZpgdB5YUt5NoxHYVO22Y5vhxjxveY8t5+pmdZF/dQsc
         vgOoQHbCyxfMximLrhvrqzecmlcxwQp9kGhC2l/Q=
Date:   Mon, 23 Nov 2020 20:38:35 +0000
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Cheng-Yi Chiang <cychiang@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Rohit kumar <rohitkr@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Srinivasa Rao <srivasam@codeaurora.org>,
        Matthias Brugger <matthias.bgg@gmail.com>, dgreid@chromium.org,
        judyhsiao@chromium.org, dianders@chromium.org,
        alsa-devel@alsa-project.org, tzungbi@chromium.org
In-Reply-To: <20201118043852.1338877-1-cychiang@chromium.org>
References: <20201118043852.1338877-1-cychiang@chromium.org>
Subject: Re: [PATCH v2] ASoC: hdmi-codec: Get ELD in before reporting plugged event
Message-Id: <160616391558.20973.12207964506823429764.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Nov 2020 12:38:52 +0800, Cheng-Yi Chiang wrote:
> In plugged callback, ELD should be updated from display driver so that
> user space can query information from ELD immediately after receiving jack
> plugged event.
> 
> When jack is unplugged, clear ELD buffer so that user space does not get
> obsolete information of unplugged HDMI.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: hdmi-codec: Get ELD in before reporting plugged event
      commit: 25ce4f2b3593fa6bba70ddabbd2ee297b262784f

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
