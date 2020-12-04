Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8E982CF784
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 00:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730571AbgLDXal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 18:30:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:41462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbgLDXak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 18:30:40 -0500
From:   Mark Brown <broonie@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     alsa-devel@alsa-project.org, Brent Lu <brent.lu@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Yong Zhi <yong.zhi@intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Dharageswari R <dharageswari.r@intel.com>,
        Fred Oh <fred.oh@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Libin Yang <libin.yang@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Naveen Manohar <naveen.m@intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Ben Zhang <benzh@chromium.org>
In-Reply-To: <20201203154010.29464-1-brent.lu@intel.com>
References: <20201203154010.29464-1-brent.lu@intel.com>
Subject: Re: [PATCH v2] ASoC: intel: sof_rt5682: Add support for tgl_rt1011_rt5682
Message-Id: <160712460213.7629.11587898255974280110.b4-ty@kernel.org>
Date:   Fri, 04 Dec 2020 23:30:02 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Dec 2020 23:40:10 +0800, Brent Lu wrote:
> This patch adds the driver data for two rt1011 speaker amplifiers on
> SSP1 and rt5682 on SSP0 for TGL platform. DAI format for rt1011 is
> leveraged from cml_rt1011_rt5682 which is 4-slot tdm with 100fs bclk.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: intel: sof_rt5682: Add support for tgl_rt1011_rt5682
      commit: aa6cc97c0ac31c668afc7027bcf2bdb0fe4610fe

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
