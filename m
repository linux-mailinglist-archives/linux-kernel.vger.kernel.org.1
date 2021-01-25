Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58A6B3036A1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 07:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388162AbhAZGfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 01:35:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:53098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729370AbhAYOTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 09:19:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 98AF923103;
        Mon, 25 Jan 2021 14:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611584346;
        bh=lnbnWhYPygqLJRHRyoAjOYPsiePxQqvy8fWmCbYYWeM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Or8I+Bq7kOaW0nopaD2xARATZb7/TB+1oUMz8ogynh+mG9O1hkHuSeztO2jZt8e2T
         TeNVELuSi62K0dbrJ8SkNtT8ze66shkDu4KTumuWoHHDwPvLcvwEsqmVD5wSxHK27L
         5Q+Iwu/jA3z+McAgb1ml/b1ABARFR5c9O0BZ2vufK0YMGof7TSBRsXKvvCM4ddXlAW
         ufCFQ94wIcO19LSoeE7xKDyYwoyNz2bBfBjm7saEh0UZU+iakXjZRZBN/RFwFjt2Zk
         55h9fEedF/f6L7NNXPeKSouJbRGPOV2t4bsT9gBQwxYkpZZcA//oidy7KJHXWFlQNh
         i6ENSiA6Gbk6g==
From:   Mark Brown <broonie@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>,
        Christoph Fritz <chf.fritz@googlemail.com>
Cc:     Adrien Grassein <adrien.grassein@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <4c2e79d4fa96befdc9a6c59c3ff27b0a34f9fb56.camel@googlemail.com>
References: <4c2e79d4fa96befdc9a6c59c3ff27b0a34f9fb56.camel@googlemail.com>
Subject: Re: [PATCH] regulator: pf8x00: Add suspend support
Message-Id: <161158430471.33385.2347092969080033673.b4-ty@kernel.org>
Date:   Mon, 25 Jan 2021 14:18:24 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Jan 2021 21:49:17 +0100, Christoph Fritz wrote:
> This patch adds suspend/resume support so that it is possible to
> configure the LDOs and BUCKs as on or off during suspend phase as
> well as to configure suspend specific voltages.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: pf8x00: Add suspend support
      commit: 7fefe72b0f8c0d7e63af9810c4dcc88757eddcd5

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
