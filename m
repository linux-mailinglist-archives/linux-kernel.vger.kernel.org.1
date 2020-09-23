Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37E6D275A97
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 16:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgIWOrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 10:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgIWOrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 10:47:18 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF7FC0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 07:47:17 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z4so337252wrr.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 07:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RNjkhiM1FCbGUrDGCeRB32FSp0tmCPTFU6QyULJjsI8=;
        b=iGP4diqgXbxiGsiWrdpTwYspUMIcOmfdUmidyf4ku7VMe48ulyc+YL+37JWHz4kxbU
         PMAffnzWV95HJs4W47VoVMgjtsFPZzzfW33AbaLc/als7NQCyGqwo8O6vZqzWKvPabKI
         tJLmn+nQTX3hiRqDEuz3tSDkAYLriOx8rmm6WLP7e9DIb2DSCNED74LLJcPJjgML5O3t
         B4d5/yAadXKSeaPeC6iYePpX2t/AXN+tOFJhqXjT3blBFoKUyWP8Hh3I+GMdfRReQeuC
         vlfO7UADXEb4rcP1S0S5RNLx909I2z2yJ+cJBI2dWi8BtJ28eIOpIJLeYsBwVrDKl75U
         MLaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RNjkhiM1FCbGUrDGCeRB32FSp0tmCPTFU6QyULJjsI8=;
        b=Q1p/s8D19eTQWU3TKc2Gsjx8oEp+12N0tNQG7BDujT/7iLyUcSOUXQ4MCBa7dp+HDY
         B1hrbINfT+zJ7eXE5FLMA+8ApN26NpvdSsAhunTWZ4Az+shtp9iT7DaauACH4Arm+MnQ
         zg+IIHyL4c8q1WfxNTp6Vq4UWtHdguVSCfovAx/iRrVGXMZ9pPNNgNkKZ+vKGiPJCfmM
         DZJSUa737Lhcrrc5G6PJzUG9CmfCAi83QUt1k2BSmPnvYlpet9NUATG/LWjqEdis9fvL
         v2nSQk/8ZCF/sDljRdGbpEGbZuGJ84sUKxczj+pulStqqdAM9nXnMNBRqPe6/jl8ZkLo
         sqAg==
X-Gm-Message-State: AOAM530oEYrkzM7EDcmohcgd3cHRyVOjADMPzD81YQlakbG8UD9GEvH2
        3VtIuavDU+zR9eh6riwYzMjIIf9VZ1CFYg==
X-Google-Smtp-Source: ABdhPJyaTECKp7w3xVuhksXZYgacwP9oq2RNCnqcyI1givi2XEsKHV5iuf1zT2L5+9eKhfaWDgWktg==
X-Received: by 2002:a5d:444e:: with SMTP id x14mr1198240wrr.235.1600872436091;
        Wed, 23 Sep 2020 07:47:16 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id s17sm35870wrr.40.2020.09.23.07.47.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Sep 2020 07:47:15 -0700 (PDT)
Subject: Re: [PATCH v2] nvmem: core: fix possibly memleak when use
 nvmem_cell_info_to_nvmem_cell()
To:     Vadym Kochan <vadym.kochan@plvision.eu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20200923135343.16565-1-vadym.kochan@plvision.eu>
 <7a072204-a4b8-e5ef-9ce2-4db176f70366@linaro.org>
 <20200923141334.GA16798@plvision.eu>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <1f65dc6a-50f3-d4e5-f1ce-7a68fddde287@linaro.org>
Date:   Wed, 23 Sep 2020 15:47:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200923141334.GA16798@plvision.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/09/2020 15:13, Vadym Kochan wrote:
> On Wed, Sep 23, 2020 at 03:10:36PM +0100, Srinivas Kandagatla wrote:
>>
>>
>> On 23/09/2020 14:53, Vadym Kochan wrote:
>>> Fix missing 'kfree_const(cell->name)' when call to
>>> nvmem_cell_info_to_nvmem_cell() in several places:
>>>
>>>        * after nvmem_cell_info_to_nvmem_cell() failed during
>>>          nvmem_add_cells()
>>>
>>>        * during nvmem_device_cell_{read,write}. This is fixed by simply
>>>          re-using info->name instead of duplicating it:
>>>
>>>              cell->name = info->name
>>>
>>> Because cell->name is not used except for error message printing in case
>>> of un-aligned access, the new __nvmem_cell_info_to_nvmem_cell() helper
>>> was introduced.
>>>
>>> Fixes: e2a5402ec7c6 ("nvmem: Add nvmem_device based consumer apis.")
>>> Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
>>> ---
>>> v2:
>>>       * remove not needed 'kfree_const(cell->name)' after nvmem_cell_info_to_nvmem_cell()
>>>         failed.
>>>
>>>    drivers/nvmem/core.c | 35 ++++++++++++++++++++++++++---------
>>>    1 file changed, 26 insertions(+), 9 deletions(-)
>>
>>
>>
>> Really :-)
>>
> But what about nvmem_device_cell_{read,write} case ?
> In my understanding the cell is allocated on the stack but kstrdup() is
You are right!

That is the second issue where the caller outside would fail after 
successful call to nvmem_cell_info_to_nvmem_cell() .

Probably we cam free it in failure cases!
something like:

------------------------>cut<---------------------------
diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 6cd3edb2eaf6..fb1e756adcee 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -383,6 +383,7 @@ static int nvmem_cell_info_to_nvmem_cell(struct 
nvmem_device *nvmem,
                 dev_err(&nvmem->dev,
                         "cell %s unaligned to nvmem stride %d\n",
                         cell->name, nvmem->stride);
+               kfree_const(cell->name);
                 return -EINVAL;
         }

@@ -1465,8 +1466,10 @@ ssize_t nvmem_device_cell_read(struct 
nvmem_device *nvmem,
                 return rc;

         rc = __nvmem_cell_read(nvmem, &cell, buf, &len);
-       if (rc)
+       if (rc) {
+               kfree_const(cell->name);
                 return rc;
+       }

         return len;
  }
@@ -1494,7 +1497,11 @@ int nvmem_device_cell_write(struct nvmem_device 
*nvmem,
         if (rc)
                 return rc;

-       return nvmem_cell_write(&cell, buf, cell.bytes);
+       rc = nvmem_cell_write(&cell, buf, cell.bytes);
+       if (rc)
+               kfree_const(cell->name);
+
+       return rc;
  }
  EXPORT_SYMBOL_GPL(nvmem_device_cell_write);
  ------------------------>cut<---------------------------

--srini

> not freed in the end, or I missed something ?
> 
>>
>> Below change should just fix this the reported issue!
>> ------------------------>cut<---------------------------
>>
>> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
>> index 6cd3edb2eaf6..9fb9112fe75d 100644
>> --- a/drivers/nvmem/core.c
>> +++ b/drivers/nvmem/core.c
>> @@ -383,6 +383,7 @@ static int nvmem_cell_info_to_nvmem_cell(struct
>> nvmem_device *nvmem,
>>                  dev_err(&nvmem->dev,
>>                          "cell %s unaligned to nvmem stride %d\n",
>>                          cell->name, nvmem->stride);
>> +               kfree_const(cell->name);
>>                  return -EINVAL;
>>          }
>>
>> ------------------------>cut<---------------------------
>>
>> I don't see a point in the way your patch try to fix this!!
>>
>>
>> --srini
>>
>>>
>>> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
>>> index 6cd3edb2eaf6..e6d1bc414faf 100644
>>> --- a/drivers/nvmem/core.c
>>> +++ b/drivers/nvmem/core.c
>>> @@ -361,16 +361,15 @@ static void nvmem_cell_add(struct nvmem_cell *cell)
>>>    	blocking_notifier_call_chain(&nvmem_notifier, NVMEM_CELL_ADD, cell);
>>>    }
>>> -static int nvmem_cell_info_to_nvmem_cell(struct nvmem_device *nvmem,
>>> -				   const struct nvmem_cell_info *info,
>>> -				   struct nvmem_cell *cell)
>>> +static int
>>> +__nvmem_cell_info_to_nvmem_cell(struct nvmem_device *nvmem,
>>> +				const struct nvmem_cell_info *info,
>>> +				struct nvmem_cell *cell)
>>>    {
>>>    	cell->nvmem = nvmem;
>>>    	cell->offset = info->offset;
>>>    	cell->bytes = info->bytes;
>>> -	cell->name = kstrdup_const(info->name, GFP_KERNEL);
>>> -	if (!cell->name)
>>> -		return -ENOMEM;
>>> +	cell->name = info->name;
>>>    	cell->bit_offset = info->bit_offset;
>>>    	cell->nbits = info->nbits;
>>> @@ -382,13 +381,31 @@ static int nvmem_cell_info_to_nvmem_cell(struct nvmem_device *nvmem,
>>>    	if (!IS_ALIGNED(cell->offset, nvmem->stride)) {
>>>    		dev_err(&nvmem->dev,
>>>    			"cell %s unaligned to nvmem stride %d\n",
>>> -			cell->name, nvmem->stride);
>>> +			cell->name ?: "<unknown>", nvmem->stride);
>>>    		return -EINVAL;
>>>    	}
>>>    	return 0;
>>>    }
>>> +static int
>>> +nvmem_cell_info_to_nvmem_cell(struct nvmem_device *nvmem,
>>> +			      const struct nvmem_cell_info *info,
>>> +			      struct nvmem_cell *cell)
>>> +{
>>> +	int err;
>>> +
>>> +	err = __nvmem_cell_info_to_nvmem_cell(nvmem, info, cell);
>>> +	if (err)
>>> +		return err;
>>> +
>>> +	cell->name = kstrdup_const(info->name, GFP_KERNEL);
>>> +	if (!cell->name)
>>> +		return -ENOMEM;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>>    /**
>>>     * nvmem_add_cells() - Add cell information to an nvmem device
>>>     *
>>> @@ -1460,7 +1477,7 @@ ssize_t nvmem_device_cell_read(struct nvmem_device *nvmem,
>>>    	if (!nvmem)
>>>    		return -EINVAL;
>>> -	rc = nvmem_cell_info_to_nvmem_cell(nvmem, info, &cell);
>>> +	rc = __nvmem_cell_info_to_nvmem_cell(nvmem, info, &cell);
>>>    	if (rc)
>>>    		return rc;
>>> @@ -1490,7 +1507,7 @@ int nvmem_device_cell_write(struct nvmem_device *nvmem,
>>>    	if (!nvmem)
>>>    		return -EINVAL;
>>> -	rc = nvmem_cell_info_to_nvmem_cell(nvmem, info, &cell);
>>> +	rc = __nvmem_cell_info_to_nvmem_cell(nvmem, info, &cell);
>>>    	if (rc)
>>>    		return rc;
>>>
