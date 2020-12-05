Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EED12CFBE1
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 17:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbgLEQAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 11:00:05 -0500
Received: from mga01.intel.com ([192.55.52.88]:27984 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727347AbgLEP3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 10:29:14 -0500
IronPort-SDR: CLjanD/QTRewvRikLdxG42ELpyXJjae2BrVHSVHqULuuKL4EO212pwFZPHds5z/OB2M5PDpPOC
 uJBPwrIEYstQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9825"; a="191774455"
X-IronPort-AV: E=Sophos;i="5.78,395,1599548400"; 
   d="scan'208";a="191774455"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2020 06:59:52 -0800
IronPort-SDR: +vl+HACmjCKcAtpEM37NXeuK0wfxYW7gV4L1SEvyX/90iJeWmUPkwGbEPU4HvxhF+3xikZUCgi
 GC/J6Jf/Vm+A==
X-IronPort-AV: E=Sophos;i="5.78,395,1599548400"; 
   d="scan'208";a="436104261"
Received: from schamb2-mobl2.amr.corp.intel.com (HELO [10.212.89.161]) ([10.212.89.161])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2020 06:59:51 -0800
Subject: Re: [PATCH 4/7] soundwire/regmap: use _no_pm functions in
 regmap_read/write
To:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, sanyog.r.kale@intel.com,
        rander.wang@linux.intel.com, bard.liao@intel.com
References: <20201202204645.23891-1-yung-chuan.liao@linux.intel.com>
 <20201202204645.23891-5-yung-chuan.liao@linux.intel.com>
 <20201205074554.GR8403@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <f72fc1d5-f904-2247-17ef-d01a9fcf0b97@linux.intel.com>
Date:   Sat, 5 Dec 2020 08:43:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201205074554.GR8403@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> -static int sdw_write_no_pm(struct sdw_slave *slave, u32 addr, u8 value)
>> +int sdw_write_no_pm(struct sdw_slave *slave, u32 addr, u8 value)
>>   {
>>   	return sdw_nwrite_no_pm(slave, addr, 1, &value);
>>   }
>> +EXPORT_SYMBOL(sdw_write_no_pm);
> 
> Why not export this is patch 1..?

yes, good point. I guess Bard and I were debugging in parallel and 
missed this. thanks for pointing it out.
