Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA35A2A0ED1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 20:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbgJ3Tmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 15:42:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:35774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727357AbgJ3Tlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 15:41:35 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE76820739;
        Fri, 30 Oct 2020 19:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604086894;
        bh=6APAouS5gTipcXWfVkIabBDcftgnh4LjNXjLSb8L+3Q=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=EiRFCM8k8ht84bI9je+gxuuqS1xxj9UReHpl8DG7oDaMD9NFD9ryzM+koPnR1JAwt
         SWA+uenTovAUvAka7GgmBntTLIZvYAqKDbmIHVWnq+cgfMJ90b512IV9duTXkNCWLR
         AAiG2waZw5dXLwpc04+lk2nQY6FrCNH8YncVdmGI=
Date:   Fri, 30 Oct 2020 19:41:27 +0000
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org, Brent Lu <brent.lu@intel.com>
Cc:     Jason Yan <yanaijie@huawei.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Fred Oh <fred.oh@linux.intel.com>,
        Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Yong Zhi <yong.zhi@intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Rander Wang <rander.wang@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
In-Reply-To: <20201030170559.20370-1-brent.lu@intel.com>
References: <20201030170559.20370-1-brent.lu@intel.com>
Subject: Re: [PATCH v2 0/2] Add rt1015 support to CML boards
Message-Id: <160408688150.11950.1006967503782392855.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 Oct 2020 01:05:57 +0800, Brent Lu wrote:
> First patch adds tdm 4-slot 100fs DAI setting to avoid jitter of using
> 64fs on CML boards. Second patch is a DMI quirk for HP Dooly.
> 
> Changes since v1:
> -Add comment on Dooly's DMI quirk
> 
> Brent Lu (2):
>   ASoC: intel: sof_rt5682: Add support for cml_rt1015_rt5682
>   ASoC: intel: sof_rt5682: Add quirk for Dooly
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: intel: sof_rt5682: Add support for cml_rt1015_rt5682
      commit: 35249a5684fd01377bb40e20b8a604774cb073d8
[2/2] ASoC: intel: sof_rt5682: Add quirk for Dooly
      commit: bdd088ce5bfd32b95ab1bd90b49405e7c1f1fff5

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
