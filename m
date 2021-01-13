Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C664C2F4E99
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 16:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbhAMP2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 10:28:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:60886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbhAMP2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 10:28:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 360F9233EA;
        Wed, 13 Jan 2021 15:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610551642;
        bh=vxd/kqSo8bN8c/zk/ku4UDlXJMGZVRAHdZAV8MksMrE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=RNF09ngmseI9UabNoK5Vo4YTXrl8bOw2HXJhQ4ZYMb5ecL6c8XfI88+cB96dahPOq
         cH7MNioULHXyycATFBQzr/Y9PMNna4r1+OEq9uiyQN1KleHubpBAKgqj9plbRDC6C5
         lcMI1SDA67xZvCEqsxB0BWVLG693n/tqDMsL9igXqTeP0vkMFCVfDoY8GfIZ7zOzdy
         zxPpmDRkE7HMHbg426eQp9IUSsH7oK6zT13QXTnULG7hN2T9V1E2vkgNf1oYsk77Tl
         CNAOVgEW1dZxvX5qvJCiLVR0/xPF8co0R+nae5+9KtgRzF2+2Qn7q16sj2STyAPziR
         hEXS4ngRJ0qDg==
From:   Mark Brown <broonie@kernel.org>
To:     pierre-louis.bossart@linux.intel.com,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        kai.vehmanen@linux.intel.com, daniel.baluta@nxp.com,
        tiwai@suse.com, ranjani.sridharan@linux.intel.com,
        lgirdwood@gmail.com
Cc:     Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        "moderated list:SOUND - SOUND OPEN FIRMWARE SOF DRIVERS" 
        <sound-open-firmware@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>,
        Rander Wang <rander.wang@intel.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        Payal Kshirsagar <payalskshirsagar1234@gmail.com>
In-Reply-To: <20210112181128.1229827-1-kai.heng.feng@canonical.com>
References: <20210112181128.1229827-1-kai.heng.feng@canonical.com>
Subject: Re: [PATCH v4 1/3] ASoC: SOF: Intel: hda: Resume codec to do jack detection
Message-Id: <161055160366.21623.4212588433578007556.b4-ty@kernel.org>
Date:   Wed, 13 Jan 2021 15:26:43 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jan 2021 02:11:23 +0800, Kai-Heng Feng wrote:
> Instead of queueing jackpoll_work, runtime resume the codec to let it
> use different jack detection methods based on jackpoll_interval.
> 
> This partially matches SOF driver's behavior with commit a6e7d0a4bdb0
> ("ALSA: hda: fix jack detection with Realtek codecs when in D3"), the
> difference is SOF unconditionally resumes the codec.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: SOF: Intel: hda: Resume codec to do jack detection
      commit: bcd7059abc19e6ec5b2260dff6a008fb99c4eef9
[2/3] ASoC: SOF: Intel: hda: Modify existing helper to disable WAKEEN
      commit: 31ba0c0776027896553bd8477baff7c8b5d95699
[3/3] ASoC: SOF: Intel: hda: Avoid checking jack on system suspend
      commit: ef4d764c99f792b725d4754a3628830f094f5c58

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
