Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD2281FA487
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 01:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgFOXlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 19:41:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:53852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725960AbgFOXlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 19:41:11 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2377D208D5;
        Mon, 15 Jun 2020 23:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592264471;
        bh=jPCWYHNI6TyLaxa7nvZ24dvreUVjXc00ndoYeTCoSEk=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=0AA8NmYD8wjeUBWNtTyoPErztaLoVWDLd33Y8IvYlEw5yTNCGfsz+u7pvMYGKzsYq
         NQFZIIFdh8T8nOjVkmrLk7Dxs5rpYwhHLB9SdKYxIEV+XAXcal1f60qcypKuiXD3kV
         9SgLmw+csIxWnuZmk4NW38mvRcjTF2GpZP2Na2jo=
Date:   Tue, 16 Jun 2020 00:41:09 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20200615072507.11303-1-brgl@bgdev.pl>
References: <20200615072507.11303-1-brgl@bgdev.pl>
Subject: Re: [PATCH] regmap: remove stray space
Message-Id: <159226446455.27625.17639277925722975250.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jun 2020 09:25:07 +0200, Bartosz Golaszewski wrote:
> There are two spaces between arguments in regmap_fields_update_bits_base()
> so remove one.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: remove stray space
      commit: 9fb9b7715e5e08b58e70b9fcaf1f3072fbf99a22

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
