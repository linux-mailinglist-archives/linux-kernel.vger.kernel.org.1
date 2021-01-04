Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDB02E97EE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 16:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbhADPBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 10:01:01 -0500
Received: from mail1.perex.cz ([77.48.224.245]:59796 "EHLO mail1.perex.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727042AbhADPBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 10:01:00 -0500
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 7CE2DA004B;
        Mon,  4 Jan 2021 16:00:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 7CE2DA004B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1609772418; bh=NBYgMHbbqmHovG+sVQDGeTFC7J2tgqVlSOKHqgUroAs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=4NVnHObBmMnXi9kIdZofTZIMaTWjRKdmxFDLrtTisQNP++VxeOZfx/477BTKV8sEL
         uiHGnI5Bz9KUiUkxpvxDznI6ke+Vq5/PHun4AGzEh1tPgkk9UIqUcY+EA39BFN/aTF
         WW8t/tazFj8FRS4LhysOWKNVjtC6RUcMRYdRJmN0=
Received: from p1gen2.localdomain (unknown [192.168.100.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Mon,  4 Jan 2021 16:00:06 +0100 (CET)
Subject: Re: [PATCH] ALSA: hda: fix SND_INTEL_DSP_CONFIG dependency
To:     Arnd Bergmann <arnd@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        sound-open-firmware@alsa-project.org
References: <20210103135257.3611821-1-arnd@kernel.org>
From:   Jaroslav Kysela <perex@perex.cz>
Message-ID: <3c19a5d5-8883-f917-a96a-f51bb188d115@perex.cz>
Date:   Mon, 4 Jan 2021 16:00:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210103135257.3611821-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne 03. 01. 21 v 14:52 Arnd Bergmann napsal(a):
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The sof-pci-dev driver fails to link when built into the kernel
> and CONFIG_SND_INTEL_DSP_CONFIG is set to =m:
> 
> arm-linux-gnueabi-ld: sound/soc/sof/sof-pci-dev.o: in function `sof_pci_probe':
> sof-pci-dev.c:(.text+0x1c): undefined reference to `snd_intel_dsp_driver_probe'
> 
> All other drivers using this interface already use a 'select
> SND_INTEL_DSP_CONFIG' statement to force the it to be present, so it
> seems reasonable to do the same here.
> 
> The stub implementation in the header makes the problem harder to find,
> as it avoids the link error when SND_INTEL_DSP_CONFIG is completely
> disabled, without any obvious upsides. Remove these stubs to make it
> clearer that the driver is in fact needed here.
> 
> Fixes: 82d9d54a6c0e ("ALSA: hda: add Intel DSP configuration / probe code")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/sound/intel-dsp-config.h | 17 -----------------
>  sound/soc/sof/Kconfig            |  2 ++
>  2 files changed, 2 insertions(+), 17 deletions(-)
> 
> diff --git a/include/sound/intel-dsp-config.h b/include/sound/intel-dsp-config.h
> index d4609077c258..94667e870029 100644
> --- a/include/sound/intel-dsp-config.h
> +++ b/include/sound/intel-dsp-config.h
> @@ -18,24 +18,7 @@ enum {
>  	SND_INTEL_DSP_DRIVER_LAST = SND_INTEL_DSP_DRIVER_SOF
>  };
>  
> -#if IS_ENABLED(CONFIG_SND_INTEL_DSP_CONFIG)

The SOF drivers selects the DSP config code only when required (for specific
platforms - see sound/soc/sof/intel/Kconfig).

It seems that the above if should be modified as:

#if IS_BUILDIN(CONFIG_SND_INTEL_DSP_CONFIG) || (defined(MODULE) &&
IS_MODULE(CONFIG_SND_INTEL_DSP_CONFIG))

So the buildin drivers which do not require the DSP config probe can be
compiled without this dependency.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
