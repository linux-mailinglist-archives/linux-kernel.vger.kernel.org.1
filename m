Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80DA9278991
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 15:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbgIYN3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 09:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728416AbgIYN3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 09:29:47 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0473AC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 06:29:47 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id v12so3306807wmh.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 06:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LKgAHRfN+eHECSVlw1KuISgeU4iNFfAN7rqXC9yOTKI=;
        b=WBrerB/MreAxoJ1QeOKOEEptz/xwVe+hBiEdURpBhtbhPOgTssqLMflehzZzh2OknM
         pOZBvPRMNo+lw/KcCv4VS9lB/0pza9ag0HnsEOwjJcYALJHodkSkk5Hw9wxFPVfqr7I/
         Bw2FrIUdhg6Ij8nAOiVmeqmzo6IHjlcPRRVrQvrFoWtxR7krIabZMJQbe0FOzwj4/9C5
         rmJR9TnDr0LTj9QWnwiSe2gED1K3nfDDkID35p4rX2TXr5wStq+rCrVuwfOdwv4SDjPE
         wkSt8cWJnCBc2OTXUwsVyWJZkhFv6WFQQ3KE8w/riJ6nA7ZWZkxItSG7wVvXtUzxJKEX
         i9Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LKgAHRfN+eHECSVlw1KuISgeU4iNFfAN7rqXC9yOTKI=;
        b=pgTiMf+RMP8X3BY0SievAgGHTvuflP1nEraCj32b8o7MYGphjehW1RBMm/DulrpeF6
         1RH0Io85VGhFio49laM58LWtiMQBVK2u9BKh4VtsW5l6P3BGVc0aP1IncTkIO/rfRunU
         Utg/r1ldVbQThmyCOghzk9EiHip/UGG43LSgZWabunCS5c4zstaUqFuoCKkch1myH8hS
         Zrvoq59xG85zG040x2nqSfQj26cusUAJWSRs60+iQ393zSS96JmAe9yxJZK4M+telnEr
         5H2SQpQ/VdXxM8UgfCZSM8I39I8JfqzSww2Fo/x8rnLT19bvsc8K3iZEr8NWoh/ElGjO
         VHVg==
X-Gm-Message-State: AOAM532fzivzCgD5Nt0YWnk6FdCmu2vt1jWHJORXFFn/x9nbKGOv5CxW
        EFq9fsnpE5DO68JZbPBHd7K9jVf3nRcLog==
X-Google-Smtp-Source: ABdhPJwjuweijitPqDCHIBWQ+ugr+ah1WtJ/rc1QqofU+wJnhxzqbtWf4gDvVL6M/7/PUmcO+OtDdQ==
X-Received: by 2002:a7b:cb07:: with SMTP id u7mr3059602wmj.57.1601040585233;
        Fri, 25 Sep 2020 06:29:45 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id e13sm2980466wre.60.2020.09.25.06.29.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Sep 2020 06:29:44 -0700 (PDT)
Subject: Re: [PATCH 1/2] regmap: add support to regmap_field_bulk_alloc/free
 apis
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, srivasam@codeaurora.org,
        lgirdwood@gmail.com, gregkh@linuxfoundation.org, rafael@kernel.org,
        tiwai@suse.com, rohitkr@codeaurora.org,
        linux-kernel@vger.kernel.org
References: <20200925092804.23536-1-srinivas.kandagatla@linaro.org>
 <20200925092804.23536-2-srinivas.kandagatla@linaro.org>
 <eb7af426-ab00-b444-e578-cf3c4b329c95@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <6c13fb62-1a45-0a28-4be7-f09e2eac2287@linaro.org>
Date:   Fri, 25 Sep 2020 14:29:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <eb7af426-ab00-b444-e578-cf3c4b329c95@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Pierre,

On 25/09/2020 14:12, Pierre-Louis Bossart wrote:
> 
> 
> On 9/25/20 4:28 AM, Srinivas Kandagatla wrote:
>> Usage of regmap_field_alloc becomes much overhead when number of fields
>> exceed more than 3.
>> QCOM LPASS driver has extensively converted to use regmap_fileds.
> 
> Multiple typos scattered in this patch: fileds -> fields?
> 
thanks for checking this, I will fix that in next spin!

--srini
>>
>> Using new bluk api to allocate fields makes it much more cleaner code 
>> to read!
> 
> bulk api?
> 
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> Tested-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
>> ---
>>   drivers/base/regmap/regmap.c | 100 +++++++++++++++++++++++++++++++++++
>>   include/linux/regmap.h       |  11 ++++
>>   2 files changed, 111 insertions(+)
>>
>> diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
>> index aec3f26bf711..271740a163ad 100644
>> --- a/drivers/base/regmap/regmap.c
>> +++ b/drivers/base/regmap/regmap.c
>> @@ -1270,6 +1270,106 @@ struct regmap_field 
>> *devm_regmap_field_alloc(struct device *dev,
>>   }
>>   EXPORT_SYMBOL_GPL(devm_regmap_field_alloc);
>> +
>> +/**
>> + * regmap_field_bulk_alloc() - Allocate and initialise a bulk 
>> register field.
>> + *
>> + * @regmap: regmap bank in which this register field is located.
>> + * @rm_field: regmap register fileds with in the bank.
>> + * @reg_field: Register fields with in the bank.
>> + * @num_fields: Number of register fileds.
>> + *
>> + * The return value will be an -ENOMEM on error or zero for success.
>> + * Newly allocated regmap_fields should be freed by calling
>> + * regmap_field_bulk_free()
>> + */
>> +int regmap_field_bulk_alloc(struct regmap *regmap,
>> +                struct regmap_field **rm_field,
>> +                struct reg_field *reg_field,
>> +                int num_fields)
>> +{
>> +    struct regmap_field *rf;
>> +    int i;
>> +
>> +    rf = kcalloc(num_fields, sizeof(*rf), GFP_KERNEL);
>> +    if (!rf)
>> +        return -ENOMEM;
>> +
>> +    for (i = 0; i < num_fields; i++) {
>> +        regmap_field_init(&rf[i], regmap, reg_field[i]);
>> +        rm_field[i] = &rf[i];
>> +    }
>> +
>> +    return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(regmap_field_bulk_alloc);
>> +
>> +/**
>> + * devm_regmap_field_bulk_alloc() - Allocate and initialise a bulk 
>> register
>> + * fields.
>> + *
>> + * @dev: Device that will be interacted with
>> + * @regmap: regmap bank in which this register field is located.
>> + * @rm_field: regmap register fileds with in the bank.
>> + * @reg_field: Register fields with in the bank.
> 
> within?
> 
>> + * @num_fields: Number of register fileds.
>> + *
>> + * The return value will be an -ENOMEM on error or zero for success.
>> + * Newly allocated regmap_fields will be automatically freed by the
>> + * device management code.
>> + */
>> +int devm_regmap_field_bulk_alloc(struct device *dev,
>> +                 struct regmap *regmap,
>> +                 struct regmap_field **rm_field,
>> +                 struct reg_field *reg_field,
>> +                 int num_fields)
>> +{
>> +    struct regmap_field *rf;
>> +    int i;
>> +
>> +    rf = devm_kcalloc(dev, num_fields, sizeof(*rf), GFP_KERNEL);
>> +    if (!rf)
>> +        return -ENOMEM;
>> +
>> +    for (i = 0; i < num_fields; i++) {
>> +        regmap_field_init(&rf[i], regmap, reg_field[i]);
>> +        rm_field[i] = &rf[i];
>> +    }
>> +
>> +    return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(devm_regmap_field_bulk_alloc);
>> +
>> +/**
>> + * regmap_field_bulk_free() - Free register field allocated using
>> + *                       regmap_field_bulk_alloc.
>> + *
>> + * @field: regmap fields which should be freed.
>> + */
>> +void regmap_field_bulk_free(struct regmap_field *field)
>> +{
>> +    kfree(field);
>> +}
>> +EXPORT_SYMBOL_GPL(regmap_field_bulk_free);
>> +
>> +/**
>> + * devm_regmap_field_bulk_free() - Free a bulk register field 
>> allocated using
>> + *                            devm_regmap_field_bulk_alloc.
>> + *
>> + * @dev: Device that will be interacted with
>> + * @field: regmap field which should be freed.
>> + *
>> + * Free register field allocated using 
>> devm_regmap_field_bulk_alloc(). Usually
>> + * drivers need not call this function, as the memory allocated via devm
>> + * will be freed as per device-driver life-cyle.
>> + */
>> +void devm_regmap_field_bulk_free(struct device *dev,
>> +                 struct regmap_field *field)
>> +{
>> +    devm_kfree(dev, field);
>> +}
>> +EXPORT_SYMBOL_GPL(devm_regmap_field_bulk_free);
>> +
>>   /**
>>    * devm_regmap_field_free() - Free a register field allocated using
>>    *                            devm_regmap_field_alloc.
>> diff --git a/include/linux/regmap.h b/include/linux/regmap.h
>> index 0c49d59168b5..a35ec0a0d6e0 100644
>> --- a/include/linux/regmap.h
>> +++ b/include/linux/regmap.h
>> @@ -1189,6 +1189,17 @@ struct regmap_field 
>> *devm_regmap_field_alloc(struct device *dev,
>>           struct regmap *regmap, struct reg_field reg_field);
>>   void devm_regmap_field_free(struct device *dev,    struct 
>> regmap_field *field);
>> +int regmap_field_bulk_alloc(struct regmap *regmap,
>> +                 struct regmap_field **rm_field,
>> +                 struct reg_field *reg_field,
>> +                 int num_fields);
>> +void regmap_field_bulk_free(struct regmap_field *field);
>> +int devm_regmap_field_bulk_alloc(struct device *dev, struct regmap 
>> *regmap,
>> +                 struct regmap_field **field,
>> +                 struct reg_field *reg_field, int num_fields);
>> +void devm_regmap_field_bulk_free(struct device *dev,
>> +                 struct regmap_field *field);
>> +
>>   int regmap_field_read(struct regmap_field *field, unsigned int *val);
>>   int regmap_field_update_bits_base(struct regmap_field *field,
>>                     unsigned int mask, unsigned int val,
>>
