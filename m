Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E23412F841F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388719AbhAOSU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:20:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:43476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388059AbhAOSUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:20:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4412723A59;
        Fri, 15 Jan 2021 18:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610734776;
        bh=IYih6HK5bywhQPCe8+Ubp9rfmDXcS5Y7rKssma+9IVE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=BOIS6Ji++V0fQAyQSsHFJYaaqiy7HWX1p+ZVER5G37YtaClPJVR1Fk06bS+x+Y6pR
         56dVep3mubKlDlGRJineKYsLuryVFj+ePsFznyx2QYOwkTbXW/D6b+qU0Gl7Q9VTCl
         sZADmEi85HkKNDEvgMQhagcksWfXJmIV97t7hBl6LNTptVj1d7KY7uT9TGHIinzOw8
         vepRKpLkYWGJ8gChzIVjfRcVFRlhpVFdU//qGdF7rdKQR613rxxf/Zx17rliEBgpVa
         hrsdQZ6vTixx2QaCjAIVPJZAdBASQNKRW2arsov734Z+u2qI4tAyJXvyFNQ20rCXY9
         VcvTdSykkwxjA==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org,
        Bard Liao <yung-chuan.liao@linux.intel.com>, vkoul@kernel.org
Cc:     srinivas.kandagatla@linaro.org, jank@cadence.com,
        hui.wang@canonical.com, rander.wang@linux.intel.com,
        vinod.koul@linaro.org, tiwai@suse.de,
        ranjani.sridharan@linux.intel.com, gregkh@linuxfoundation.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com, linux-kernel@vger.kernel.org
In-Reply-To: <20210115061651.9740-1-yung-chuan.liao@linux.intel.com>
References: <20210115061651.9740-1-yung-chuan.liao@linux.intel.com>
Subject: Re: (subset) [PATCH 0/2] ASoC/SoundWire: fix timeout values
Message-Id: <161073473698.12268.1646614149546970077.b4-ty@kernel.org>
Date:   Fri, 15 Jan 2021 18:18:56 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jan 2021 14:16:49 +0800, Bard Liao wrote:
> The timeout for an individual transaction w/ the Cadence IP is the same as
> the entire resume operation for codecs.
> This doesn't make sense, we need to have at least one order of magnitude
> between individual transactions and the entire resume operation.
> 
> Set the timeout on the Cadence side to 500ms and 5s for the codec resume.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: codecs: soundwire: increase resume timeout
      commit: 7ef8c9edc86cff0881b2eb9a3274796258fbd872

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
