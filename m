Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB6FD2B23F0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 19:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbgKMSlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 13:41:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:34490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726113AbgKMSlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 13:41:19 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D08C0206FB;
        Fri, 13 Nov 2020 18:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605292879;
        bh=TwPDaum6HQpucG0VonsPFeNYA/JjIeFRzoJm17NQ5Vo=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=N6JwffnVvDL/b+H6TZFb23w014gEPTS8yzMR0He6wRi3sEIF+b2jiCNt8aAZ/qz7T
         Jnspjxn+4uQlR/rpOsrz63P6BpX88Tq40EOG2+cnCO11olV/M1en5+E2JoQgBlR5Gl
         ubgoDpLaHgayfZ/946HpKdjVEkrxAcr4ZVszl8tY=
Date:   Fri, 13 Nov 2020 18:41:02 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>, lgirdwood@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <1605290164-11556-1-git-send-email-claudiu.beznea@microchip.com>
References: <1605290164-11556-1-git-send-email-claudiu.beznea@microchip.com>
Subject: Re: [PATCH v4 1/1] regulator: core: do not continue if selector match
Message-Id: <160529286295.31222.1456786741188639170.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Nov 2020 19:56:04 +0200, Claudiu Beznea wrote:
> Do not continue if selector has already been located.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: core: do not continue if selector match
      commit: ab97800e088acf34d0014845ed93605dd5c1ea2a

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
