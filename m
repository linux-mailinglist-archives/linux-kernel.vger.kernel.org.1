Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCE42CA5D5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 15:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389163AbgLAOh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 09:37:29 -0500
Received: from mga06.intel.com ([134.134.136.31]:21747 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388620AbgLAOh3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 09:37:29 -0500
IronPort-SDR: 16zeXfjaTNi6TEs5Lo0/uJuSt0Ga41zo2NIcwxxtAIpgQwEq4crjRgnwR6DYemPlQMlA++Jhod
 VEsR1VEoiIlg==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="234438754"
X-IronPort-AV: E=Sophos;i="5.78,384,1599548400"; 
   d="scan'208";a="234438754"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 06:35:46 -0800
IronPort-SDR: temaf+ahoFTQk7464VYz82vE8GVBgjV5ccgi9dSbQLc1h7rh1xDUBG0uhQf8X/7p2X4lElG6cW
 PdR5CiHYfF3w==
X-IronPort-AV: E=Sophos;i="5.78,384,1599548400"; 
   d="scan'208";a="364762445"
Received: from griver2-mobl.amr.corp.intel.com (HELO [10.213.191.92]) ([10.213.191.92])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 06:35:44 -0800
Subject: Re: [PATCH v2 0/5] regmap/SoundWire/ASoC: Add SoundWire SDCA support
To:     Vinod Koul <vkoul@kernel.org>, "Liao, Bard" <bard.liao@intel.com>
Cc:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "tiwai@suse.de" <tiwai@suse.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ranjani.sridharan@linux.intel.com" 
        <ranjani.sridharan@linux.intel.com>,
        "hui.wang@canonical.com" <hui.wang@canonical.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "jank@cadence.com" <jank@cadence.com>,
        "Kale, Sanyog R" <sanyog.r.kale@intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        "rander.wang@linux.intel.com" <rander.wang@linux.intel.com>
References: <20201130144020.19757-1-yung-chuan.liao@linux.intel.com>
 <DM6PR11MB4074311B4E0B70F24383E754FFF40@DM6PR11MB4074.namprd11.prod.outlook.com>
 <20201201041138.GY8403@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <e9478e45-2a24-05f9-eb56-5905d54ab6a4@linux.intel.com>
Date:   Tue, 1 Dec 2020 08:35:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201201041138.GY8403@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/30/20 10:11 PM, Vinod Koul wrote:
> On 01-12-20, 02:42, Liao, Bard wrote:
> 
>> Hi Vinod/Mark,
>>
>> Could we take this series into Vinod's tree with Mark's Acked-by?
>> It failed to build on Mark's tree.
> 
> I see Mark has already applied 1-3 ..

Sorry, I thought Mark had reversed the entire series.

Vinod, would you mind providing a tag for Mark then? The following 
commit is needed to compile:

b7cab9be7c161 ('soundwire: SDCA: detect sdca_cascade interrupt')

Thank you Sir!
