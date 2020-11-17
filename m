Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4032E2B71B4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 23:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbgKQWiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 17:38:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:41536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbgKQWiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 17:38:15 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62F3D20709;
        Tue, 17 Nov 2020 22:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605652694;
        bh=JomUOrKOnqPHlPsPd61Zm+b963yBxA6emdmm5X3mM+s=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=zcIGSbyNvBScj/TIwOoPxCx7Q6MsgtTQ9TPqKlOu87uFVRll6s/pl+oiZd3/IwZ/g
         wWBYILidTcFUDw0BL10II/DS9mcYZsqeOC56yH5t9KwfGxdYzc95wSIKtK0uPeoHRL
         vHmjrfg8vy3eBzMFcg9mUIgUfcOpOHSqIdKX0/0I=
Date:   Tue, 17 Nov 2020 22:37:55 +0000
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     lgirdwood@gmail.com, tiwai@suse.com, bogdan.togorean@analog.com
In-Reply-To: <20201110152213.37811-1-alexandru.ardelean@analog.com>
References: <20201110152213.37811-1-alexandru.ardelean@analog.com>
Subject: Re: [PATCH] ASoc: adi: Kconfig: Remove depends on for ADI reference designs
Message-Id: <160565265704.23689.695597438692063700.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Nov 2020 17:22:13 +0200, Alexandru Ardelean wrote:
> Audio ADI reference designs are also used on some ZynqMP boards, and can
> also be used on Intel FPGA boards and also on some more complex FPGA
> combinations (FPGA cards connected through PCIe).
> 
> This change removes the dependency on Microblaze and Zynq architectures
> to allow the usage of this driver for the systems described above.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoc: adi: Kconfig: Remove depends on for ADI reference designs
      commit: e1ade4c55ae3559b082faf9f5207cc6caba1c546

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
