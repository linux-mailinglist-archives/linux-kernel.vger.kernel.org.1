Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC3A22624E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 16:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbgGTOim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jul 2020 10:38:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:32842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgGTOil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 10:38:41 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FCD122B4D;
        Mon, 20 Jul 2020 14:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595255921;
        bh=X2LRtrjy0ZD8br3AOM4dhUe7N7ZAD27D37HYWNVITWY=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=k4CcmkKaOvP+8bV8Ky8i9NPGZZWxUeIls3Cc42KpoNkgeknIp3wq+yoQKjqk5GcxF
         0UqZxTqUjdObTFaElcD3Th8gboRgseUYb/no7KH89tAFXTAV+JyWYcIR3W2l8HzkwS
         9VbeDMM7017lMDGOVsOrwOCXVddgtvIvB4PhzEl4=
Date:   Mon, 20 Jul 2020 15:38:29 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     alsa-devel@alsa-project.org
In-Reply-To: <20200719180901.30720-1-rdunlap@infradead.org>
References: <20200719180901.30720-1-rdunlap@infradead.org>
Subject: Re: [PATCH] ASoC: wcd9335.h: fix duplicated word
Message-Id: <159525589435.6792.17128171130773560089.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Jul 2020 11:09:01 -0700, Randy Dunlap wrote:
> Fix the doubled word "in" in a comment by adding punctuation
> in 3 places and capitalization.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: wcd9335.h: fix duplicated word
      commit: 09e5209087294f444efa7af07442faf886fcc6b9

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
