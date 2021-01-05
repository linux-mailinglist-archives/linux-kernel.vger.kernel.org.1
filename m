Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 371602EAF23
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 16:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbhAEPo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 10:44:26 -0500
Received: from mga11.intel.com ([192.55.52.93]:14527 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727408AbhAEPoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 10:44:25 -0500
IronPort-SDR: XCxwBew2cgsx7UWj1u/Ff0voOIC4ha5mrgEQB5kFqPawhgzfee6bHdy6C/7Ejkc4xeCrYyKvQ2
 NJpNHCuiXfTg==
X-IronPort-AV: E=McAfee;i="6000,8403,9855"; a="173614252"
X-IronPort-AV: E=Sophos;i="5.78,477,1599548400"; 
   d="scan'208";a="173614252"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 07:42:39 -0800
IronPort-SDR: QWCWi2VymOqSN6LRoxlv4ex9o8a4DKmuJppeSYTQc20/GkcXeWOxjVNE+VLptIdH5kuQJ6H/Cc
 qQ8hcGW/cGsA==
X-IronPort-AV: E=Sophos;i="5.78,477,1599548400"; 
   d="scan'208";a="378909382"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 07:42:35 -0800
Date:   Tue, 5 Jan 2021 17:39:39 +0200 (EET)
From:   Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To:     Arnd Bergmann <arnd@kernel.org>
cc:     Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        sound-open-firmware@alsa-project.org
Subject: Re: [PATCH] ALSA: hda: fix SND_INTEL_DSP_CONFIG dependency
In-Reply-To: <CAK8P3a1FZSfzu3TA6VMhqP+3H5OD3+BhH5W=vVYEkL+ExHqpMQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2101051631320.864696@eliteleevi.tm.intel.com>
References: <20210103135257.3611821-1-arnd@kernel.org> <3c19a5d5-8883-f917-a96a-f51bb188d115@perex.cz> <s5hble491zu.wl-tiwai@suse.de> <CAK8P3a1FZSfzu3TA6VMhqP+3H5OD3+BhH5W=vVYEkL+ExHqpMQ@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

On Tue, 5 Jan 2021, Arnd Bergmann wrote:

> On Mon, Jan 4, 2021 at 4:05 PM Takashi Iwai <tiwai@suse.de> wrote:
> > As I wrote in another post, a part of the problem is that SOF PCI and
> > ACPI drivers call snd_intel_dsp_driver_probe() unconditionally, even
> > if no Intel driver is bound.
> 
> Makes sense. Is there an existing Kconfig that could be used to
> decide whether the drivers use SND_INTEL_DSP_CONFIG or not?

no, unfortunately not. This is selected per platform in 
sound/soc/sof/intel/Kconfig. CONFIG_SND_SOC_SOF_INTEL_PCI is close, but 
there is at least one platform that does not use SND_INTEL_DSP_CONFIG.

> According to sof_pci_ids[], all PCI IDs are Intel specific, but I can't
> tell which ones need the DSP config.

Indeed currently all the ids are Intel ones (and with exception of old 
Merrifield, all use DSP config). But that's just how it is now.

> Could it be part of the device specific driver_data? 

This would certainly be a clean way and allow to remove the Intel-specific 
calls from sof_pci_probe(). As a short-term solution, IS_REACHABLE() 
seems ok as well.

Br, Kai
