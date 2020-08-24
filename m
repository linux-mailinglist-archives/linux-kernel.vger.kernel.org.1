Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C55424FEF5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Aug 2020 15:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbgHXNdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Aug 2020 09:33:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:58574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727110AbgHXNcW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 09:32:22 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E297E2063A;
        Mon, 24 Aug 2020 13:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598275942;
        bh=RwBqFz941Jt/SoLTcwza2Sjh1YRsxek+wKn59iLih64=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=VDJob3z4g8SfZlGkZJdO47OAJ3aFcr1Pysg+cEPSPqc6ZdbgCzYTclHQKwmkRofP7
         OR+Swz/nxkb+Iri0+EMFCZfLp5EISySn/gWdK3XMFGzCvpCqks8BEaVth9W/mxJnZ9
         YMDRc6tqs4At4z4nENzBNfPmEgqf1uU8ud/Mux0I=
Date:   Mon, 24 Aug 2020 14:31:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20200824102402.4047fa5f@xhacker.debian>
References: <20200824102402.4047fa5f@xhacker.debian>
Subject: Re: [PATCH] regulator: mp886x: use "mps,switch-frequency-hz"
Message-Id: <159827590802.48129.18246424059084988195.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Aug 2020 10:32:14 +0800, Jisheng Zhang wrote:
> As Rob suggested, use the "mps,switch-frequency-hz" instead of the
> "mps,switch-frequency" for switch frequency. Fortunately, the switch
> frequency support isn't released, so we can modify it now without
> any concern.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: mp886x: use "mps,switch-frequency-hz"
      commit: a5f7949570dc7262d3239739b0cdaa001f935d4b

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
