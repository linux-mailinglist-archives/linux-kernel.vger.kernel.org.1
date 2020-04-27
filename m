Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 106B31BA439
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 15:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgD0NJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 09:09:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:46366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726651AbgD0NJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 09:09:02 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD0B52064C;
        Mon, 27 Apr 2020 13:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587992942;
        bh=bV1PKM7KpCxCRZJEtuGqiJ04oyD1/g2gNseB/UP8fgI=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=CjJmlxt9kCyLciLtehj1y6LsYtD7lEt182QGWIwd/60V5xjHrGMZAsfukZmihBSFA
         auMg1SAA7kev7CyJJclpfr2WF1wWU9qfEgz6PQKoCKZ2tPlRXp+Szv/TJaHiEtAHHc
         JCVJD2kv55UWmkiuNJLLDGIFI7XiuOy5tXQQgIH0=
Date:   Mon, 27 Apr 2020 14:08:59 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Tang Bin <tangbin@cmss.chinamobile.com>, s.hauer@pengutronix.de,
        shawnguo@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org,
        Shengju Zhang <zhangshengju@cmss.chinamobile.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
In-Reply-To: <20200420142509.9728-1-tangbin@cmss.chinamobile.com>
References: <20200420142509.9728-1-tangbin@cmss.chinamobile.com>
Subject: Re: [PATCH] ASoC: mxs-saif: Avoid unnecessary check
Message-Id: <158799293954.30174.3525396439519252505.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Apr 2020 22:25:09 +0800, Tang Bin wrote:
> The function mxs_saif_probe() is only called with an
> openfirmware platform device. Therefore there is no
> need to check that it has an openfirmware node.
> 
> Signed-off-by: Shengju Zhang <zhangshengju@cmss.chinamobile.com>
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.8

Thanks!

[1/1] ASoC: mxs-saif: Avoid unnecessary check
      commit: e66f385354b3bd29b713d8ab8556aa889723928f

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
