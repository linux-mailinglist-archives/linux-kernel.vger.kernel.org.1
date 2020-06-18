Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 515FC1FF2B8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jun 2020 15:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730133AbgFRNJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jun 2020 09:09:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:39042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726984AbgFRNJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 09:09:16 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FC4120707;
        Thu, 18 Jun 2020 13:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592485755;
        bh=Wz8/bOunSjW5fydHgst0DIKygPVfQS4J/kwnhHQlihs=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=sqTNnRwiIJ2ahkMXxnpiz373DvoGyA3TQdGseAAKA+kpq/zpJp8QjdqVDTgMgVuC5
         9NiQKthJcu+bzN8yRbIIqywYDPnfFnLM+ofTPsAPwhNywXx5endgDv6ufuBscXSAmz
         MWmGBaUUAEpxbFCilLZ0XCf3kEkE6i2K+2DU7EhI=
Date:   Thu, 18 Jun 2020 14:09:13 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     linux-kernel@vger.kernel.org, lgirdwood@gmail.com
In-Reply-To: <20200617223247.25566-1-rikard.falkeborn@gmail.com>
References: <20200617223247.25566-1-rikard.falkeborn@gmail.com>
Subject: Re: [PATCH 0/5] regulator: Constify some static struct variables
Message-Id: <159248575341.21561.10817745653684251777.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jun 2020 00:32:42 +0200, Rikard Falkeborn wrote:
> Constify some static struct variables to allow the compiler to put them
> in read-only memory. There are more of these, but I figured I could
> start small. Also, is one patch per driver a good resolution or too
> fine-grained?
> 
> Rikard Falkeborn (5):
>   regulator: anatop: Constify anatop_core_rops
>   regulator: cpcap: Constify cpcap_regulator_ops
>   regulator: ltc3676: Constify ltc3676_regulators
>   regulator: max8907: Constify static structs
>   regulator: max8997: Constify struct regulator_ops
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/5] regulator: anatop: Constify anatop_core_rops
      commit: cae62a937912bd4b3faf8e268cc0ffcf00ec5850
[2/5] regulator: cpcap: Constify cpcap_regulator_ops
      commit: bcf39c1eb1e059ec612bf06f4aa7b3972dcc85e8
[3/5] regulator: ltc3676: Constify ltc3676_regulators
      commit: b37f076d4bfdd29b3aa497480b226759f659e25f
[4/5] regulator: max8907: Constify static structs
      commit: b08af72d6e5319e96527816c4b3b08d0b1a6f242
[5/5] regulator: max8997: Constify struct regulator_ops
      commit: 9ed84d24de480e81294e00814c142234bc17ce0c

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
