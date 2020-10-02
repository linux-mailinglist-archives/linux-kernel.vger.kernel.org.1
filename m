Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C14F281D31
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 22:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725769AbgJBU4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 16:56:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:44480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgJBU4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 16:56:15 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F8052065D;
        Fri,  2 Oct 2020 20:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601672175;
        bh=s7RDbJSRahvKFYJrNcA14JYV8asj/ImPRRlYyNwGmdw=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=QwQHKB9uOQvGJ47KHmqTkJBTMyvi8BxbXZr7QHXhil+R1t0eITcOIYCs+uFTUHkzU
         8I8RD43wGq9d83nVXCrpdBIjVsrF/giMN4Ve3m0GK42/lJNirD+ElQ0/YdhjXuciF7
         KPO4gOsLm4Dy8jgGZiMOWI3ERcDG7zTp7AmKoKb8=
Date:   Fri, 02 Oct 2020 21:55:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        tiwai@suse.com, perex@perex.cz
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, patches@opensource.cirrus.com
In-Reply-To: <20201002165908.637809-1-christophe.jaillet@wanadoo.fr>
References: <20201002165908.637809-1-christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] ASoC: wm8523: Fix a typo in a comment
Message-Id: <160167211500.21762.1306114025374461159.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Oct 2020 18:59:08 +0200, Christophe JAILLET wrote:
> It is likely that this header file is about the WM8523.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: wm8523: Fix a typo in a comment
      commit: 98bd2b506a309faca2f5a8388dadfc983123e14a

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
