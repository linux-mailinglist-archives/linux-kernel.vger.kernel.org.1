Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACFF28E394
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 17:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbgJNPwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 11:52:25 -0400
Received: from mga12.intel.com ([192.55.52.136]:45706 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726439AbgJNPwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 11:52:24 -0400
IronPort-SDR: 8RoVHTW5hsv+qHtvEL3sth9Rc6VugU/nRVmyyioK+UWI61bPJHnwkuIsiutfG0dtC6KWb/czOO
 1cj5TKEmLQ3g==
X-IronPort-AV: E=McAfee;i="6000,8403,9773"; a="145441500"
X-IronPort-AV: E=Sophos;i="5.77,375,1596524400"; 
   d="scan'208";a="145441500"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2020 08:52:23 -0700
IronPort-SDR: TiMpkT6Vr5KRL2Rb3SJMqROFDgAygZNDRfFesudJonJg+mkNpycV56Meh+jvgxEaCQptmnDMvZ
 i/WjTR7QwHJA==
X-IronPort-AV: E=Sophos;i="5.77,375,1596524400"; 
   d="scan'208";a="357411121"
Received: from mbhutani-mobl.amr.corp.intel.com (HELO [10.212.4.214]) ([10.212.4.214])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2020 08:52:22 -0700
Subject: Re: [PATCH 0/3] ASoC: sof: cleanup Kconfig files
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     alsa-devel@alsa-project.org,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        sound-open-firmware@alsa-project.org, Takashi Iwai <tiwai@suse.de>,
        Mark Brown <broonie@kernel.org>
References: <20201014025633.4879-1-rdunlap@infradead.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <86a0251d-3d0d-bff8-a591-22d184c40fc7@linux.intel.com>
Date:   Wed, 14 Oct 2020 09:37:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201014025633.4879-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/13/20 9:56 PM, Randy Dunlap wrote:
> Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> Cc: Daniel Baluta <daniel.baluta@nxp.com>
> Cc: sound-open-firmware@alsa-project.org
> Cc: alsa-devel@alsa-project.org
> 
> Some general editing of sound/soc/sof/ Kconfig files:

Thanks Randy!

That looks all good to me, but I see you didn't CC: Mark Brown and 
Takashi Iwai so not sure if Mark can apply this directly. Might need to 
resend the series?

I also can take this series in the SOF tree and combine it with other 
changes I am making to Kconfigs to remove hard-coded exclusions, that 
would mean less churn on the same files.
>   [PATCH 1/3] ASoC: sof: imx: fix Kconfig punctuation
>   [PATCH 2/3] ASoC: sof: intel: fix Kconfig punctuation and wording
>   [PATCH 3/3] ASoC: sof: Kconfig: fix Kconfig punctuation and wording
> 
>   sound/soc/sof/Kconfig       |   42 +++++++++++------------
>   sound/soc/sof/imx/Kconfig   |   10 ++---
>   sound/soc/sof/intel/Kconfig |   62 +++++++++++++++++-----------------
>   3 files changed, 57 insertions(+), 57 deletions(-)
> 
