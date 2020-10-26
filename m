Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0EB1299B05
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 00:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408364AbgJZXrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 19:47:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:43818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408354AbgJZXrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 19:47:01 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E14F20714;
        Mon, 26 Oct 2020 23:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603756021;
        bh=XWR7MwsgfltmFj47sfd/dwRi90Ev/Ns1xGylwEDA998=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=aIQQpbC1MGatxk8DEmQC51e09WaeB8M+qR5pa4ZbWyflREu/AGE5rzEY9CkjuR2F+
         +BVI+vmO3i09T7rYouZAIY6BEAOxDdoXla6I65R2peTzlm0xqqQpFRR37ih1YIO2+z
         rds1GcA7lJtNsV+EjyUwyu4xxAONoBCWDZUZM3fI=
Date:   Mon, 26 Oct 2020 23:46:55 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Adrian Ratiu <adrian.ratiu@collabora.com>
Cc:     linux-kernel@vger.kernel.org, kernel@collabora.com,
        "Rafael J. Wysocki" <rafael@kernel.org>
In-Reply-To: <20201014203024.954369-1-adrian.ratiu@collabora.com>
References: <20201014203024.954369-1-adrian.ratiu@collabora.com>
Subject: Re: [PATCH v2] regmap: mmio: add config option to allow relaxed MMIO accesses
Message-Id: <160375601585.32276.1378661556975438111.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Oct 2020 23:30:24 +0300, Adrian Ratiu wrote:
> On some platforms (eg armv7 due to the CONFIG_ARM_DMA_MEM_BUFFERABLE)
> MMIO R/W operations always add memory barriers which can increase load,
> decrease battery life or in general reduce performance unnecessarily
> on devices which access a lot of configuration registers and where
> ordering does not matter (eg. media accelerators like the Verisilicon /
> Hantro video decoders).
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: mmio: add config option to allow relaxed MMIO accesses
      commit: 6e1e90ec027509a7e8d4efbd77a65b32b5a8b3ec

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
