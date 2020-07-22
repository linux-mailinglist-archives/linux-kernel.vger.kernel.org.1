Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABC69228D4F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jul 2020 02:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731627AbgGVA5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 20:57:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:59972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731474AbgGVA5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 20:57:38 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7161206E3;
        Wed, 22 Jul 2020 00:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595379458;
        bh=DAIdFDmW+h5zF5hFqyKn+jR4F9cSr3ZBHMIP0qp/9ds=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=HOmpgAhDx6nTg7lEBnKxil1dtOP5haLT2NcN1WdjaNTkNxwCwP1NTOdhJg5uYsxcU
         M6jQtG5HT9Zs0VvsqEEO/8W9P7K3AV4gtPzKSaRHFabzYCy4kF/wS135qlvVUkFTfJ
         Xil2czF3lyidjPoM8VpOhDEq8OzgVZQSX3iki+PY=
Date:   Wed, 22 Jul 2020 01:57:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20200720132809.26908-1-wens@kernel.org>
References: <20200720132809.26908-1-wens@kernel.org>
Subject: Re: [PATCH v3] regulator: gpio: Honor regulator-boot-on property
Message-Id: <159537943520.49645.14773067675144419268.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jul 2020 21:28:09 +0800, Chen-Yu Tsai wrote:
> When requesting the enable GPIO, the driver should do so with the
> correct output level matching some expected state. This is especially
> important if the regulator is a critical one, such as a supply for
> the boot CPU. This is currently done by checking for the enable-at-boot
> property, but this is not documented in the device tree binding, nor
> does it match the common regulator properties.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: gpio: Honor regulator-boot-on property
      commit: 3acff11cef1dece31cd29956f19181895996a7c5

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
