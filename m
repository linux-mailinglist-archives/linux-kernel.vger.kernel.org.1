Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7AA02CFD8C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 19:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgLESho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 13:37:44 -0500
Received: from mga01.intel.com ([192.55.52.88]:30676 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726061AbgLEShl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 13:37:41 -0500
IronPort-SDR: H8BQQ1+mhM7d55BXRhAhDh3aCGd4opVJYhSuKis3CgmU7lMRCMb994vEo6EDJXGCKGgnq0vAy2
 klqdG7tD4mHw==
X-IronPort-AV: E=McAfee;i="6000,8403,9825"; a="191774459"
X-IronPort-AV: E=Sophos;i="5.78,395,1599548400"; 
   d="scan'208";a="191774459"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2020 06:59:56 -0800
IronPort-SDR: RYoMDGFFTE6jxc6pGLX2RQcbEpvcChRMU2DhisSbvvl+p0aMw7PNIZxacFcm8U16RJ6X5brham
 vKsXrkEViP1Q==
X-IronPort-AV: E=Sophos;i="5.78,395,1599548400"; 
   d="scan'208";a="436104270"
Received: from schamb2-mobl2.amr.corp.intel.com (HELO [10.212.89.161]) ([10.212.89.161])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2020 06:59:55 -0800
Subject: Re: [PATCH 1/7] soundwire: bus: use sdw_update_no_pm when
 initializing a device
To:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, sanyog.r.kale@intel.com,
        rander.wang@linux.intel.com, bard.liao@intel.com
References: <20201202204645.23891-1-yung-chuan.liao@linux.intel.com>
 <20201202204645.23891-2-yung-chuan.liao@linux.intel.com>
 <20201205074508.GQ8403@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <1db93c2e-3c87-bc5e-ddeb-56424870b897@linux.intel.com>
Date:   Sat, 5 Dec 2020 08:59:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201205074508.GQ8403@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review Vinod.

On 12/5/20 1:45 AM, Vinod Koul wrote:
> On 03-12-20, 04:46, Bard Liao wrote:
>> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>>
>> When a Slave device is resumed, it may resume the bus and restart the
>> enumeration. During that process, we absolutely don't want to call
>> regular read/write routines which will wait for the resume to
>> complete, otherwise a deadlock occurs.
>>
>> Fixes: 60ee9be25571 ('soundwire: bus: add PM/no-PM versions of read/write functions')
> 
> Change looks okay, but not sure why this is a fix for adding no pm
> version?

when we added the no_pm version, we missed the two cases below where 
sdw_update() was used and that creates a deadlock. To me that's a 
conceptual bug, we didn't fully use the no_pm versions, hence the Fixes tag.

It's ok to remove the tag if you don't think it's useful/relevant, what 
matters is that we agree on the content.

>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
>> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
>> ---
>>   drivers/soundwire/bus.c | 16 ++++++++++++++--
>>   1 file changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
>> index d1e8c3a54976..60c42508c6c6 100644
>> --- a/drivers/soundwire/bus.c
>> +++ b/drivers/soundwire/bus.c
>> @@ -489,6 +489,18 @@ sdw_read_no_pm(struct sdw_slave *slave, u32 addr)
>>   		return buf;
>>   }
>>   
>> +static int sdw_update_no_pm(struct sdw_slave *slave, u32 addr, u8 mask, u8 val)
>> +{
>> +	int tmp;
>> +
>> +	tmp = sdw_read_no_pm(slave, addr);
>> +	if (tmp < 0)
>> +		return tmp;
>> +
>> +	tmp = (tmp & ~mask) | val;
>> +	return sdw_write_no_pm(slave, addr, tmp);
>> +}
>> +
>>   /**
>>    * sdw_nread() - Read "n" contiguous SDW Slave registers
>>    * @slave: SDW Slave
>> @@ -1256,7 +1268,7 @@ static int sdw_initialize_slave(struct sdw_slave *slave)
>>   	val = slave->prop.scp_int1_mask;
>>   
>>   	/* Enable SCP interrupts */
>> -	ret = sdw_update(slave, SDW_SCP_INTMASK1, val, val);
>> +	ret = sdw_update_no_pm(slave, SDW_SCP_INTMASK1, val, val);
>>   	if (ret < 0) {
>>   		dev_err(slave->bus->dev,
>>   			"SDW_SCP_INTMASK1 write failed:%d\n", ret);
>> @@ -1271,7 +1283,7 @@ static int sdw_initialize_slave(struct sdw_slave *slave)
>>   	val = prop->dp0_prop->imp_def_interrupts;
>>   	val |= SDW_DP0_INT_PORT_READY | SDW_DP0_INT_BRA_FAILURE;
>>   
>> -	ret = sdw_update(slave, SDW_DP0_INTMASK, val, val);
>> +	ret = sdw_update_no_pm(slave, SDW_DP0_INTMASK, val, val);
>>   	if (ret < 0)
>>   		dev_err(slave->bus->dev,
>>   			"SDW_DP0_INTMASK read failed:%d\n", ret);
>> -- 
>> 2.17.1
> 
