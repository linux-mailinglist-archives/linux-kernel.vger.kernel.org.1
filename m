Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D44E2A3140
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 18:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgKBRSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 12:18:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:39392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726860AbgKBRSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 12:18:21 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE5E821D91;
        Mon,  2 Nov 2020 17:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604337501;
        bh=DK5hG7Hl+usrKzyzofkycl7KuXmXYmJFS7OX+Znve1U=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=Epznq/QLQV+OUXgaAnagCRngDd7sAginMJhmFLejpPgmsHdhDOBZew7NH4j8xiD5n
         wUSjDU4NLAjOlpa3pNUJ5LRN+w6XgX0j1OL+kb8lblgDkYdBrLp6RAeykJH+Z/5dK+
         zOmy1ZpD03Ka5Xc6Br8vzl+M88V0sSzHNV2/2kE4=
Date:   Mon, 02 Nov 2020 17:18:13 +0000
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, f.fainelli@gmail.com, sbranden@broadcom.com,
        rjui@broadcom.com, sw0312.kim@samsung.com,
        ranjani.sridharan@linux.intel.com,
        kuninori.morimoto.gx@renesas.com, perex@perex.cz,
        "trix@redhat.com" <trix@redhat.com>, lgirdwood@gmail.com,
        nsaenzjulienne@suse.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com
In-Reply-To: <20201101160037.2295512-1-trix@redhat.com>
References: <20201101160037.2295512-1-trix@redhat.com>
Subject: Re: [PATCH] ASoC: bcm2835-i2s: remove unneeded semicolon
Message-Id: <160433748157.18840.3548192910799118546.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Nov 2020 08:00:37 -0800, trix@redhat.com wrote:
> A semicolon is not needed after a switch statement.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: bcm2835-i2s: remove unneeded semicolon
      commit: 46713ed258695e2de00ab2738160f89220c0a976

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
