Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6994260433
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 20:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731418AbgIGSGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 14:06:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:33020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728916AbgIGSGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 14:06:38 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C46F82078E;
        Mon,  7 Sep 2020 18:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599501998;
        bh=VTpbtI+U+Oa0WV5lQWZOK3e6QHyJaTjJJb4i+y9WPMo=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=cAtgwNzjWCE6kF43vKXebrt0Bps4nWQQhpVLQJGxs8V2dTNJSuT5u40HkIfEO2DSt
         wSHZ9wQ6xzqM8nLYwT0fpEPKH78AoG8TsEOgOZ8uINawFnqw2474m29DHsytG9ONXJ
         XumREVHH0wLFcG6wi22+6bQVZoSAHio6Qa0NHth0=
Date:   Mon, 07 Sep 2020 19:05:54 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        patches@opensource.cirrus.com
In-Reply-To: <20200904122506.28017-1-ckeepax@opensource.cirrus.com>
References: <20200904122506.28017-1-ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH] regulator: lochnagar: Add additional VDDCORE range
Message-Id: <159950194953.52863.15525758301624487565.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Sep 2020 13:25:06 +0100, Charles Keepax wrote:
> In the case of an unrecognised mini-card the Lochnagar will not
> initialise the VDDCORE voltage register leading to a value outside of the
> current range. Add an additional range to cover these values, initially
> this wasn't done since they are duplicates of the existing minimum
> value.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: lochnagar: Add additional VDDCORE range
      commit: 6dc9674d95b8a8a81b85a4bed77f86d1b039be10

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
