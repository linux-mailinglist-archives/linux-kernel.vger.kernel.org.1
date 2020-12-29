Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBF72E7168
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 15:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgL2Ocy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 09:32:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:57282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbgL2Ocx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 09:32:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6F69120825;
        Tue, 29 Dec 2020 14:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609252333;
        bh=+wEc4SDjjvQxCYzjg82D60rVExvdnzCs5DHAhhlUhZQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=LSlJmzceAFcWqgCqZZmKdw2E21UJ/HfgWyKRsrR+mR7Bp8EVYIkEtOvsKpex72ITn
         a0Ae0g7rrl5iuXX+nbqi0nW6bqdU4/9MSUyRLL43V7/cb9JfYwzC4e7sbiXMCAD9GN
         FUR/i6DFO2bJwm7FrV9QiciBGF4zAXIZcI9GQJBAMAgeLncKqRi67f8KdDssNqrwOK
         pH788++c5Ik93Ag95VjwgorvQSGEueqKVjyTw3DhW1Ia1FAnyLh/oAXnDLRVJYRrMb
         K3cZwcqWvldhjLNCXZAvHhrowF10jiBFTHcZD+iFkgAXsnIgHZXKmHni+ztZAbMkt4
         JyLZSjy7+VAAQ==
From:   Mark Brown <broonie@kernel.org>
To:     perex@perex.cz, Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        liam.r.girdwood@linux.intel.com, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, cezary.rojewski@intel.com
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        alsa-devel@alsa-project.org
In-Reply-To: <20201229085103.192715-1-christophe.jaillet@wanadoo.fr>
References: <20201229085103.192715-1-christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] ASoC: Intel: common: Fix some typos
Message-Id: <160925231113.47851.16711392922590085956.b4-ty@kernel.org>
Date:   Tue, 29 Dec 2020 14:31:51 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Dec 2020 09:51:03 +0100, Christophe JAILLET wrote:
> s/apci/acpi/
> 
> Turn an ICL into a TGL because it is likely a cut'n'paste error

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: common: Fix some typos
      commit: 49d411f2c93aae48dd379c77db887aa282e9fb51

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
