Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFB1F2E8030
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 14:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgLaN32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Dec 2020 08:29:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:40498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbgLaN32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Dec 2020 08:29:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 18AD920786;
        Thu, 31 Dec 2020 13:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609421327;
        bh=syL2yE+tntkgSTyF3VynGhZ4nc47tn0RNbecRMAL9Lw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=L4C9cJmWb/chfLXI+nTycET9UKhRkQSULtLDvLGfLATu2F1WBDAuE5T9RMjBYQIvT
         7H0mICW3ug4nxp0WpCcRjuyDd2+0aWsrz+bDYGN8pB6jtw1ZjO0orEAqsl/QGl0iA9
         FugQ5FbOcLTzJhTBzTxh8s8Oi2GKywF52cR5x/FrqDseA7Bz28HhuRVchk0zjY3XjB
         WJIdV9jyrm5MRQkJUeatEa2E0hPjhW8MERINOFcTKxBNsT3iAZo0sOuHVAEH6yJzE3
         Qa5CgopQb73dVyJT655MnlROEVn5q4z//H+LyhEkEIuCKEl+Ckv4E9oZPlwznOBP17
         YFBQxxENniR9A==
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201230172427.13865-1-rf@opensource.cirrus.com>
References: <20201230172427.13865-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH 1/2] ASoC: wm_adsp: Only use __be32 for big-endian data
Message-Id: <160942130384.56416.4203389160143679656.b4-ty@kernel.org>
Date:   Thu, 31 Dec 2020 13:28:23 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Dec 2020 17:24:26 +0000, Richard Fitzgerald wrote:
> This fixes some minor cases where u32 or unsigned int types were used
> to store big-endian data, and __be32 types used to store both big-endian
> and cpu-endian data. This was producing sparse warnings.
> 
> Most cases resulted from using the same variable to hold the big-endian
> value and its converted cpu-endian value. These can be simply fixed by
> introducing another local variable, or avoiding storing the intermediate
> value back into the original variable.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: wm_adsp: Only use __be32 for big-endian data
      commit: a0b653e89a3afd2a833f23589a83488fac842ddb
[2/2] ASoC: wm_adsp: Use snd_ctl_elem_type_t for control types
      commit: f6212e0ab3ff28d4e2e53a520496a052c241df39

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
