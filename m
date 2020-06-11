Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9BDE1F6EDA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jun 2020 22:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgFKUhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jun 2020 16:37:01 -0400
Received: from mga05.intel.com ([192.55.52.43]:30161 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbgFKUhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 16:37:01 -0400
IronPort-SDR: PXV7M5sLYG8V5PksoWwDKYbcxT3ryHKibXqu5a8YBqazzYMD08Zp/sRZoGXgQQjF1FaXOQ8pyE
 pxir9525G3gw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2020 13:37:00 -0700
IronPort-SDR: pepvTIbg9SIlqOWtoQ4OtOupzy32cfxyZsYPgMKHnzW0Mdk4DZZjFbx+yJ6d345eaUwBBgSk2T
 cxGwt5K3WxoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,501,1583222400"; 
   d="scan'208";a="260628282"
Received: from mgesquiv-mobl.amr.corp.intel.com (HELO [10.254.106.112]) ([10.254.106.112])
  by orsmga007.jf.intel.com with ESMTP; 11 Jun 2020 13:36:59 -0700
Subject: Re: [PATCH] ASoC: SOF: Intel: hda: unsolicited RIRB response
To:     Takashi Iwai <tiwai@suse.de>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Cc:     "Lu, Brent" <brent.lu@intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "authored:2/16=12%,added_lines:21/248=8%,removed_lines:5/84=6%,),Liam"
         Girdwood DRIVERS ")" <lgirdwood@gmail.com>,
        "commit_signer:6/16=38%,authored:6/16=38%,added_lines:123/248=50% 
        ,removed_lines:36/84=43%,Kai" Vehmanen DRIVERS ")" 
        <kai.vehmanen@linux.intel.com>,
        "Daniel Baluta DRIVERS )" <daniel.baluta@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        Zhu Yingjiang <yingjiang.zhu@linux.intel.com>,
        Keyon Jie <yang.jie@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        "sound-open-firmware@alsa-project.orgDRIVERS" 
        <sound-open-firmware@alsa-project.orgDRIVERS>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1591883073-17190-1-git-send-email-brent.lu@intel.com>
 <b7e0b822a9deea506acaa40e0e31cc9f488bb446.camel@linux.intel.com>
 <DM6PR11MB4316108BCF449D52E49C7E4297800@DM6PR11MB4316.namprd11.prod.outlook.com>
 <s5h5zbxeb5t.wl-tiwai@suse.de>
 <ccccab4d074878cd8fc3b3c4313025e54f78b65a.camel@linux.intel.com>
 <s5hzh99cqc0.wl-tiwai@suse.de>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <b7e98ae0-ea42-bced-1c0f-caa73e798908@linux.intel.com>
Date:   Thu, 11 Jun 2020 15:36:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <s5hzh99cqc0.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>> I added debug messages to print the RIRBWP register and realize
>>>> that
>>>> response could come between the read of RIRBWP in the
>>>> snd_hdac_bus_update_rirb() function and the interrupt clear in the
>>>> hda_dsp_stream_interrupt() function. The response is not handled
>>>> but
>>>> the interrupt is already cleared. It will cause timeout unless more
>>>> responses coming to RIRB.
>>>
>>> Now I noticed that the legacy driver already addressed it recently
>>> via
>>> commit 6d011d5057ff
>>>      ALSA: hda: Clear RIRB status before reading WP
>>>
>>> We should have checked SOF at the same time, too...
>>
>> Thanks, Takashi. But the legacy driver but doesnt remove the loop. The
>> loop added in the SOF driver was based on the legacy driver and
>> specifically to handle missed stream interrupts. Is there any harm in
>> keeping the loop?
> 
> A loop there might be safer to keep, indeed.  That's basically for a
> difference kind of race, and it can still happen theoretically.
> 
> Though, SOF is with the threaded interrupt, and it's interesting how
> the behavior differs.  I can imagine that, if a thread irq is running
> while a new IRQ is re-triggered, the hard irq handler won't queue it
> again.  But I might be wrong here, need some checks.

IIRC we added this loop before merging all interrupt handling in one 
thread, somehow the MSI mode never worked reliably without this change, 
so maybe we don't need this loop any longer.

I'd really prefer it if we didn't tie the RIRB handing change to this 
loop change, removing the loop should only be done with *a lot of testing*.

