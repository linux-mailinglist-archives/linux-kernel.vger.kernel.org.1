Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7A12EAAEB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 13:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730406AbhAEMaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 07:30:35 -0500
Received: from mga06.intel.com ([134.134.136.31]:61562 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728748AbhAEMab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 07:30:31 -0500
IronPort-SDR: 6gVfW9dDPwV8naYPN2hqhZfXbuPpuNvGkUThigIzs+tyxSDR8Q0/RhQEwiSP0GQxV51HP3LDwZ
 hGCS54KHVbAg==
X-IronPort-AV: E=McAfee;i="6000,8403,9854"; a="238648483"
X-IronPort-AV: E=Sophos;i="5.78,476,1599548400"; 
   d="scan'208";a="238648483"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 04:28:44 -0800
IronPort-SDR: oV0oLDcpmc1m6hLknczWLIBVxARy3d03mwwTfWBlVhQoOM/I6mJq083EN/khUPNLvtl4oJx7Te
 lk5+boiVwd/w==
X-IronPort-AV: E=Sophos;i="5.78,476,1599548400"; 
   d="scan'208";a="378851997"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 04:28:40 -0800
Date:   Tue, 5 Jan 2021 14:25:43 +0200 (EET)
From:   Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
cc:     pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        daniel.baluta@nxp.com, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Keyon Jie <yang.jie@linux.intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Marcin Rajwa <marcin.rajwa@linux.intel.com>,
        Payal Kshirsagar <payalskshirsagar1234@gmail.com>,
        "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" 
        <sound-open-firmware@alsa-project.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] ASoC: SOF: Intel: hda: Avoid checking jack on
 system suspend
In-Reply-To: <20210104140853.228448-3-kai.heng.feng@canonical.com>
Message-ID: <alpine.DEB.2.22.394.2101051354300.864696@eliteleevi.tm.intel.com>
References: <20210104140853.228448-1-kai.heng.feng@canonical.com> <20210104140853.228448-3-kai.heng.feng@canonical.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

On Mon, 4 Jan 2021, Kai-Heng Feng wrote:

> System takes a very long time to suspend after commit 215a22ed31a1
> ("ALSA: hda: Refactor codec PM to use direct-complete optimization"):
> [   90.065964] PM: suspend entry (s2idle)

the patch itself looks good, but can you explain a bit more in what 
conditions you hit the delay?

I tried to reproduce the delay on multiple systems (with tip of 
tiwai/master), but with no luck. I can see hda_jackpoll_work() called, but 
at this point runtime pm has been disabled already (via 
__device_suspend()) and snd_hdac_is_power_on() will return true even when 
pm_runtime_suspended() is true as well (which is expected as runtime-pm is 
disabled at this point for system suspend). End result is codec is not 
powered up in hda_jackpoll_work() and suspend is not delayed.

The patch still seems correct. You would hit the problem you describe if 
jackpoll_interval was set to a non-zero value (not the case on most 
systems supported by SOF, but still a possibility). I'm still curious how 
you hit the problem. At minimum, we are missing a scenario in our testing.

Br, Kai
