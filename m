Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADCB92CA4AF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 15:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403828AbgLAN7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 08:59:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:45386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388324AbgLAN7G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 08:59:06 -0500
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net [92.233.91.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AB47206A5;
        Tue,  1 Dec 2020 13:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606831105;
        bh=ZciRQ0clP47O2viwbKF2X3XIXX0D+EsIIPHiUJWV+yQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=I6dIZxMUSZw5LJ3shd89RuTmtg360kVOOA2fGx4s5axpSNRlbHmBC5a3eKkZHYxmI
         MPFffHppvt8NQevpinVzBgb+PspgvKNYeYwlacpuXQ7QjEfjUq2tdx12drh+qIzCJ7
         QL6emIYViGizSLXptkGIqN/S81VItMlCGYboYyKU=
From:   Mark Brown <broonie@kernel.org>
To:     robh@kernel.org, lgirdwood@gmail.com, grandmaster@al2klimov.de,
        perex@perex.cz, dmurphy@ti.com,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        tiwai@suse.com
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        alsa-devel@alsa-project.org
In-Reply-To: <20201002192801.639743-1-christophe.jaillet@wanadoo.fr>
References: <20201002192801.639743-1-christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] ASoC: tlv320adcx140: Fix a typo in a comment
Message-Id: <160683107674.35139.8370464905366539450.b4-ty@kernel.org>
Date:   Tue, 01 Dec 2020 13:57:56 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Oct 2020 21:28:01 +0200, Christophe JAILLET wrote:
> It is likely that this header file is about the TLV320ADCX140. (0 and 4
> swapped)
> While at it fix a missing "H" in a comment related to the include guard.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tlv320adcx140: Fix a typo in a comment
      (no commit info)

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
