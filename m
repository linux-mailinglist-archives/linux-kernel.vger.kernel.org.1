Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 033F12B1B26
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 13:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgKMM2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 07:28:53 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:3026 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726526AbgKMM2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 07:28:52 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0ADCCDZY006699;
        Fri, 13 Nov 2020 13:28:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=D6ax8bSplNDzhM9Q/b1J1XsUBFnRNHgE12ab49u37NM=;
 b=lwxDyFW5K7nvaCVd/bA66jOyjMFsL9ndoIo+sABl27xxhNdIGSNuyaR1eQual+r9FDhw
 eWZR5YVRik8rfwRFZ6OgVvI6tL49rH+FBl6ZPlrHz9TnlLA2zX6zfHytG1w42NlgHIf5
 otr19n+7MsVWy4LPFq7HHpzoVEkK/mOlBWU4bOLxbWKRoLjchvS59ZPZS71NWdtkiWvR
 44uPnKdGiJ6Wjz6+XLFZ6eC0o5noACLqy/k2Nsvxjqw1vB284A1dxesstX1LjdA9COUe
 GbP2rLeBOsOM2/1yHsoKze/2LNy1myD3y41riZ9cop72ATss8AGIvdbD7H66vu56TEnC Fg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34nhkdc854-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Nov 2020 13:28:41 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C072E10002A;
        Fri, 13 Nov 2020 13:28:40 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AEA2F254667;
        Fri, 13 Nov 2020 13:28:40 +0100 (CET)
Received: from lmecxl0995.lme.st.com (10.75.127.45) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 13 Nov
 2020 13:28:39 +0100
Subject: Re: [PATCH 1/1] mfd: stmfx: fix dev_err_probe call in stmfx_chip_init
To:     Lee Jones <lee.jones@linaro.org>
CC:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20201110080400.7207-1-amelie.delaunay@st.com>
 <20201113100919.GC3718728@dell>
From:   Amelie DELAUNAY <amelie.delaunay@st.com>
Message-ID: <33150808-aace-b5cd-baeb-f5192373e6ee@st.com>
Date:   Fri, 13 Nov 2020 13:28:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201113100919.GC3718728@dell>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG3NODE1.st.com (10.75.127.7) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-13_10:2020-11-13,2020-11-13 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/20 11:09 AM, Lee Jones wrote:
> On Tue, 10 Nov 2020, Amelie Delaunay wrote:
> 
>> ret may be 0 so, dev_err_probe should be called only when ret is an error
>> code.
>>
>> Fixes: 41c9c06c491a ("mfd: stmfx: Simplify with dev_err_probe()")
>> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
>> ---
>>   drivers/mfd/stmfx.c | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mfd/stmfx.c b/drivers/mfd/stmfx.c
>> index 5e680bfdf5c9..360fb4646688 100644
>> --- a/drivers/mfd/stmfx.c
>> +++ b/drivers/mfd/stmfx.c
>> @@ -329,12 +329,11 @@ static int stmfx_chip_init(struct i2c_client *client)
>>   
>>   	stmfx->vdd = devm_regulator_get_optional(&client->dev, "vdd");
>>   	ret = PTR_ERR_OR_ZERO(stmfx->vdd);
>> -	if (ret == -ENODEV) {
>> +	if (ret == -ENODEV)
>>   		stmfx->vdd = NULL;
>> -	} else {
>> +	else if (ret)
>>   		return dev_err_probe(&client->dev, ret,
>>   				     "Failed to get VDD regulator\n");
>> -	}
> 
> Probably nicer to keep all of the error handing in one area, like:
> 
> 	if (ret) {
> 		if (ret == -ENODEV)
> 			stmfx->vdd = NULL;
> 		else
> 			return dev_err_probe(&client->dev, ret,
> 					     "Failed to get VDD regulator\n");
> 	}
> 
> I'll let you make the call though.
> 

Thanks for the review. I agree. Fixed in v2.

Regards,
Amelie
