Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD1A31F7A69
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jun 2020 17:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgFLPKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jun 2020 11:10:50 -0400
Received: from mga09.intel.com ([134.134.136.24]:16934 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726257AbgFLPKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 11:10:50 -0400
IronPort-SDR: Bh87+QvBG22iqaFnyMb0n8l/G6Gat79QB7B61pkC4GcNpup2xy8m3QjaM5h/Ua5PDe0gA3k91k
 bSNXNC/VHM9g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2020 08:10:49 -0700
IronPort-SDR: 4JkrYmtVboNNLbg7cW9Y+q1f7vsTRdAMJ04hamINWV9k6cd5qkRCTTwAchhXdS1BfCUaJTaJy9
 zmnTBKNCk9KA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,503,1583222400"; 
   d="scan'208";a="315152617"
Received: from rrhill-mobl1.amr.corp.intel.com (HELO [10.254.71.222]) ([10.254.71.222])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Jun 2020 08:10:47 -0700
Subject: Re: [Sound-open-firmware] [PATCH v3] ASoC: SOF: Intel: hda: Clear
 RIRB status before reading WP
To:     Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Keyon Jie <yang.jie@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Zhu Yingjiang <yingjiang.zhu@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Brent Lu <brent.lu@intel.com>, linux-kernel@vger.kernel.org,
        sound-open-firmware@alsa-project.org
References: <1591959048-15813-1-git-send-email-brent.lu@intel.com>
 <s5h5zbwczuk.wl-tiwai@suse.de>
 <alpine.DEB.2.22.394.2006121522440.3186@eliteleevi.tm.intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <8530e0d0-de78-3f60-a849-99ef4f577ae0@linux.intel.com>
Date:   Fri, 12 Jun 2020 09:45:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2006121522440.3186@eliteleevi.tm.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/12/20 7:24 AM, Kai Vehmanen wrote:
> Hey Brent,
> 
> On Fri, 12 Jun 2020, Takashi Iwai wrote:
> 
>> On Fri, 12 Jun 2020 12:50:48 +0200, Brent Lu wrote:
>>>
>>> Port commit 6d011d5057ff ("ALSA: hda: Clear RIRB status before reading
>>> WP") from legacy HDA driver to fix the get response timeout issue.
>>> Current SOF driver does not suffer from this issue because sync write
>>> is enabled in hda_init. The issue will come back if the sync write is
>>> disabled for some reason.
>>>
>>> Signed-off-by: Brent Lu <brent.lu@intel.com>
>>
>> Reviewed-by: Takashi Iwai <tiwai@suse.de>
> 
> thanks, looks good now:
> 
> Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>

CI results initiated by Kai don't show any regression and change looks 
good so:

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Thanks Brent!
