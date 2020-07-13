Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29B30218DC0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 19:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730721AbgGHRAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 13:00:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:36922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbgGHRAg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 13:00:36 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F65E206F6;
        Wed,  8 Jul 2020 17:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594227635;
        bh=WnhCZojewPXcv0n/TF3e1xmOynWedsPS6pPm82CttRE=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=QEA/Dt9v66OvDEiw6aCk1h7ffkzZKT14hMmC3MEoWl0mslZPF9v8sdeX3fTPNhOJK
         0P7YmGnSzR6nrdNCgGAiHrGKQWh+VRqPB+6eVwFk+DcEQghVXm3hk6RJc9bqqwidD4
         KlE6kJdXCt1mFrffP8vGx6UNe0Msgz0PG+P33jsQ=
Date:   Wed, 08 Jul 2020 18:00:30 +0100
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, tiwai@suse.de,
        "open list:REGISTER MAP ABSTRACTION" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
In-Reply-To: <20200707202628.113142-1-pierre-louis.bossart@linux.intel.com>
References: <20200707202628.113142-1-pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] regmap: add missing dependency on SoundWire
Message-Id: <159422762554.28767.13186222307552952374.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jul 2020 15:26:28 -0500, Pierre-Louis Bossart wrote:
> CONFIG_REGMAP is not selected when no other serial bus is supported.
> It's largely academic since CONFIG_I2C is usually selected e.g. by
> DRM, but still this can break randconfig so let's be explicit.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: add missing dependency on SoundWire
      commit: 443a34ba68e8a627c15f9987b11cfa01f3e1ba0a

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
