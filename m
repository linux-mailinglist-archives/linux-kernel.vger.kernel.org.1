Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9679D2CFBE0
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 17:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbgLEPzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 10:55:23 -0500
Received: from mga01.intel.com ([192.55.52.88]:27973 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727126AbgLEP2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 10:28:44 -0500
IronPort-SDR: 0ddb7lgdrBPLS74HJb3lALgcnQltBkG0ZWEyksYbbOCHk/hHZBAINcL5rZHicI4BdwtSu/xrNR
 a14hqQ9Noxsg==
X-IronPort-AV: E=McAfee;i="6000,8403,9825"; a="191774457"
X-IronPort-AV: E=Sophos;i="5.78,395,1599548400"; 
   d="scan'208";a="191774457"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2020 06:59:54 -0800
IronPort-SDR: 8AWgwzUhEEs3eyeszZBytfK8vf8IHarISd5ixf6hqDSjMJ/oF0NPBiziNSPRVk7Aiic8dOKM2O
 g0oX0LMLnd7g==
X-IronPort-AV: E=Sophos;i="5.78,395,1599548400"; 
   d="scan'208";a="436104267"
Received: from schamb2-mobl2.amr.corp.intel.com (HELO [10.212.89.161]) ([10.212.89.161])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2020 06:59:53 -0800
Subject: Re: [PATCH 5/7] regmap: sdw: use no_pm routines for SoundWire 1.2 MBQ
To:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, sanyog.r.kale@intel.com,
        rander.wang@linux.intel.com, bard.liao@intel.com
References: <20201202204645.23891-1-yung-chuan.liao@linux.intel.com>
 <20201202204645.23891-6-yung-chuan.liao@linux.intel.com>
 <20201205074630.GS8403@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <e4e3d7ea-0825-2c8c-4182-6d1b578200a3@linux.intel.com>
Date:   Sat, 5 Dec 2020 08:52:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201205074630.GS8403@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>   MODULE_DESCRIPTION("Regmap SoundWire MBQ Module");
>> -MODULE_LICENSE("GPL v2");
>> +MODULE_LICENSE("GPL");
> 
> Why do you want to change this ?

We only use MODULE_LICENSE("GPL") for new contributions since 'GPL v2' 
does not bring any information on the license, is equivalent to 'GPL' 
and only exists for 'historical reasons', see

https://www.kernel.org/doc/html/latest/process/license-rules.html


“GPL”	Module is licensed under GPL version 2. This does not express any 
distinction between GPL-2.0-only or GPL-2.0-or-later. The exact license 
information can only be determined via the license information in the 
corresponding source files.

“GPL v2”	Same as “GPL”. It exists for historic reasons.

We should have used 'GPL' in the initial regmap MBQ patch but didn't for 
some reason, this change just realigns with what we intended.

That said, this is unrelated to this no_pm patch so could be in a 
separate one if you preferred it that way.
