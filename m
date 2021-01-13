Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 116862F46AF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 09:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbhAMIlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 03:41:22 -0500
Received: from mga01.intel.com ([192.55.52.88]:56042 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726634AbhAMIlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 03:41:21 -0500
IronPort-SDR: XNLsjDIDMZ0eVnkJ3oIFo3i5hF7tnrjl7WGxW/XVfRuN6LAjwIbSXbYstgZkRcgXoRhmklvMVi
 TX54H8FdF35A==
X-IronPort-AV: E=McAfee;i="6000,8403,9862"; a="196807315"
X-IronPort-AV: E=Sophos;i="5.79,343,1602572400"; 
   d="scan'208";a="196807315"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2021 00:39:32 -0800
IronPort-SDR: y6c/uPMlHWU9i8L6dyLaduYNUjuU3S2kRoIXIr/sJfBiIbfWdEm4uJVPTAkDrACCwaLPpAaBUv
 FYPYQ0WaOB6A==
X-IronPort-AV: E=Sophos;i="5.79,343,1602572400"; 
   d="scan'208";a="353374255"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2021 00:39:28 -0800
Date:   Wed, 13 Jan 2021 10:36:25 +0200 (EET)
From:   Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
cc:     tiwai@suse.com, pierre-louis.bossart@linux.intel.com,
        lgirdwood@gmail.com, ranjani.sridharan@linux.intel.com,
        kai.vehmanen@linux.intel.com, daniel.baluta@nxp.com,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Marcin Rajwa <marcin.rajwa@linux.intel.com>,
        broonie@kernel.org, Keyon Jie <yang.jie@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        Payal Kshirsagar <payalskshirsagar1234@gmail.com>,
        "moderated list:SOUND - SOUND OPEN FIRMWARE SOF DRIVERS" 
        <sound-open-firmware@alsa-project.org>
Subject: Re: [PATCH v4 3/3] ASoC: SOF: Intel: hda: Avoid checking jack on
 system suspend
In-Reply-To: <20210112181128.1229827-3-kai.heng.feng@canonical.com>
Message-ID: <alpine.DEB.2.22.394.2101130932480.864696@eliteleevi.tm.intel.com>
References: <20210112181128.1229827-1-kai.heng.feng@canonical.com> <20210112181128.1229827-3-kai.heng.feng@canonical.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 13 Jan 2021, Kai-Heng Feng wrote:

> System takes a very long time to suspend after commit 215a22ed31a1
> ("ALSA: hda: Refactor codec PM to use direct-complete optimization"):
[...]
> [  321.262505] snd_hda_codec_realtek ehdaudio0D0: Unable to sync register 0x2b8000. -5
> [  328.426919] snd_hda_codec_realtek ehdaudio0D0: Unable to sync register 0x2b8000. -5
> [  329.490933] ACPI: EC: interrupt blocked
> 
> That commit keeps the codec suspended during the system suspend. However,
> mute/micmute LED will clear codec's direct-complete flag by
> dpm_clear_superiors_direct_complete().

thanks Kai-Heng. This indeed explains why the regression is only seen on 
some systems (those with mute/micmute LED).

> This doesn't play well with SOF driver. When its runtime resume is
> called for system suspend, hda_codec_jack_check() schedules
> jackpoll_work which uses snd_hdac_is_power_on() to check whether codec

The commit explanation is a bit long, but this is indeed the problem. 
jackpoll_work() is common code (also used by snd-hda-intel) and SOF should 
align to snd-hda-intel and not call this directly to check jack status,
and especially not when going to system suspend.

There are a lot of details related to exact conditions when this problem 
triggers, but in the end, this is the main point.
 
> When direct-complete path is taken, snd_hdac_is_power_on() returns true
> and hda_jackpoll_work() is skipped by accident. So this is still not
> correct.

This doesn't really affect correctness of the patch, but I'm not sure if 
"accident" is the best characterization. This just explains why the bug 
was not hit in all cases.

snd_hdac_is_power_on() is called in a few places:
 - hda_jackpoll_work()
 - snd_hda_bus_reset_codecs()
 - snd_hda_update_power_acct()

In first two, the current logic seems appropriate (if runtime-pm is 
disabled, the action guarded by is_power_on() should not be taken). The 
third case seems suspicious and not sure if current is_power_on()
is appropriate.

So it's not quite clear whether hdaudio.h:snd_hdac_is_power_on() is
wrong or not. But that's now a separate discussion to have, and not 
related to this patchset anymore.

> Because devices suspend in reverse order (i.e. child first), it doesn't
> make much sense to resume an already suspended codec from audio
> controller. So avoid the issue by making sure jackpoll isn't used in
> system PM process.

The commit explanation is a bit long, but it is probably useful to have 
the background included. 

For the whole series:

Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>

Br, Kai
