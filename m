Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 674AC2B0E30
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 20:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgKLTj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 14:39:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:40368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbgKLTj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 14:39:28 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79F2922241;
        Thu, 12 Nov 2020 19:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605209966;
        bh=jliYW30t9Qox7bVSo8C39Fwar6QB/ZAQbjTl27nJY0c=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=BDxOZ3AOUqgNxgfDQySPAl+8DSVR8++Zxuavqpc8gdzn5Tohx0vBrT7mg5E9yTTjQ
         Gv8BOlfvVDAVjyiRNJ692WOaL98dbEWenC5SKRHeAKkKG7Z2ah4JY24MPpLNJJy0ay
         YXv8qOHp+PtdevFlfizv6jBHO9D1UrJwM9evMC+U=
Date:   Thu, 12 Nov 2020 19:39:10 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Cc:     linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
In-Reply-To: <20201112150217.459844-1-tanureal@opensource.cirrus.com>
References: <20201112150217.459844-1-tanureal@opensource.cirrus.com>
Subject: Re: [PATCH] regmap: Fix order of regmap write log
Message-Id: <160520995006.38771.3359445616478872976.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Nov 2020 15:02:17 +0000, Lucas Tanure wrote:
> _regmap_write can trigger a _regmap_select_page, which will call
> another _regmap_write that will be executed first, but the log shows
> the inverse order
> 
> Also, keep consistency with _regmap_read which only logs in case of
> success

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: Fix order of regmap write log
      commit: f7d01359b0d96331fce7bd4051d3b68a4bb5ea83

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
