Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4742A9912
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 17:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgKFQHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 11:07:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbgKFQHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 11:07:20 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE3FC0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 08:07:20 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id s14so1488819qkg.11
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 08:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WJnI/SYPYAielaIfnGZAZL8QkgwPBos547PDjdyfv5s=;
        b=EQVqsYo7w7ewip2Ujdl1KiYAuehAgsBEHK2DG38TFQzla/7Zt25aWFvNSFpJPSSHJ/
         FkJ6izGYTZDd2uLFmbnD5CeT/0hLKp/c9MORdvTC/74iPTyBU9zp5APa4P2GOCTYMkbp
         Agk7JezDubCiQZvZE7m/Pzm45DuBIRJGw9sBi5y/rZY2q2gKX/6wDneAcPRdK2ctkpN5
         Xvpsh2Rt8Leag0e41VBIAu8mXNZanHY3nB3Y/ZbY6awfh5xsiYgGCIF3SbI02P3LpDyP
         iz4zO8abBYYA/r4QpYenq+8SF8utVghwWY5HhAgSianBgCj33OmVmqymY985ZUacCl/3
         cXVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WJnI/SYPYAielaIfnGZAZL8QkgwPBos547PDjdyfv5s=;
        b=dRaN79afQP1e9WO6jBrTH+dTerj+SOI28MgFmundzheBlCLNFqEQ2oBUZFVZAiFzO4
         3+HCMwg4hevulbAhm7QebY9NEyCMS26Cm6EW2iUJpAmuZP0EpnHDfTt7JuOzWnpiPHN9
         5P15ShbQZapARQz9ECEu6eKpp4L2L+vqccvtf9qOZBk+fs/pM0qxlV+FDlUUfgHvmqEX
         qjH40yeuNQ7jnfcYa4/oQX/mjnpB1+mjF42AmLWLstQ0ORjJ/QszL3kKKXzahPHIfgmu
         FNhYCS2OMfRUyVHqw+LViJg3NBQC941xELZrQUHBkqgP84EJFZMJbk5rLzyvinbsYLqn
         ZHOA==
X-Gm-Message-State: AOAM53042mS3HZrY0MS8T2lkvuE2plVUCNWby4hKGNCZ89SZRcPf+X1k
        UZCp7AHLgEWJork1PYbe1GL3sg==
X-Google-Smtp-Source: ABdhPJzhJaXoh4g+SVHm9yyh5uCEVL9MPYlcYh97JUPsT5gIjrRv7pGw9NAqKwJ4QBQvAbrzcrBsEA==
X-Received: by 2002:a37:6584:: with SMTP id z126mr2094666qkb.187.1604678839335;
        Fri, 06 Nov 2020 08:07:19 -0800 (PST)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id z6sm749172qtw.36.2020.11.06.08.07.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2020 08:07:18 -0800 (PST)
Subject: Re: [PATCH v2 3/8] firmware: arm_scmi: introduce new protocol
 operations support
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
References: <20201028202914.43662-1-cristian.marussi@arm.com>
 <20201028202914.43662-4-cristian.marussi@arm.com>
 <2b09a607-6470-ad41-fd19-6a7a248237c5@linaro.org>
 <20201104180808.GC24640@e120937-lin>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <3c77ccfb-edc7-e36f-2a7f-8751bd8aee96@linaro.org>
Date:   Fri, 6 Nov 2020 11:07:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201104180808.GC24640@e120937-lin>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/4/20 1:08 PM, Cristian Marussi wrote:
> Hi,
> 
> On Wed, Nov 04, 2020 at 11:16:31AM -0500, Thara Gopinath wrote:
>> Hi Cristian,
>>
>> On 10/28/20 4:29 PM, Cristian Marussi wrote:
>>> Expose a new generic get/put protocols API based on protocol handles;
>>> provide also a devres managed version also for notifications.
>>
>> minor nit.. Maybe yous should reword this! Kind of confusing to understand!
>>
>> Also, if it was me, I will separate the notifications and get/put hooks
>> into two separate patches. Not an issue though if you want to keep it
>> in the same patch.
> 
> You're right I have to reword the commit message, and I'll review the
> possibility of a further split, even though many parts of this series
> are tightly bound together given the kind of changes so sometimes to
> avoid breaking bisectability I had to push painfully long patches (like
> 6/8 :< )...but maybe I've got it wrong and this is not the case here.
> 
>>
>>> All SCMI drivers still keep using the old handle based interface.
>>>
>>> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
>>> ---
>>>    drivers/firmware/arm_scmi/driver.c | 126 +++++++++++++++++++++++++++++
>>>    drivers/firmware/arm_scmi/notify.c | 123 ++++++++++++++++++++++++++++
>>>    include/linux/scmi_protocol.h      |  34 +++++++-
>>>    3 files changed, 282 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
>>> index 8ca04acb6abb..4d86aafbf465 100644
>>> --- a/drivers/firmware/arm_scmi/driver.c
>>> +++ b/drivers/firmware/arm_scmi/driver.c
>>> @@ -15,6 +15,7 @@
>>>     */
>>>    #include <linux/bitmap.h>
>>> +#include <linux/device.h>
>>>    #include <linux/export.h>
>>>    #include <linux/idr.h>
>>>    #include <linux/io.h>
>>> @@ -728,6 +729,38 @@ void scmi_release_protocol(struct scmi_handle *handle, u8 protocol_id)
>>>    	mutex_unlock(&info->protocols_mtx);
>>>    }
>>> +/**
>>> + * scmi_get_protocol_operations  - Get protocol operations
>>> + * @handle: A reference to the SCMI platform instance.
>>> + * @protocol_id: The protocol being requested.
>>> + * @ph: A pointer reference used to pass back the associated protocol handle.
>>> + *
>>> + * Get hold of a protocol accounting for its usage, eventually triggering its
>>> + * initialization, and returning the protocol specific operations and related
>>> + * protocol handle which will be used as first argument in most of the protocols
>>> + * operations methods.
>>> + *
>>> + * Return: A reference to the requested protocol operations or error.
>>> + *	   Must be checked for errors by caller.
>>> + */
>>> +static const void __must_check *
>>> +scmi_get_protocol_operations(struct scmi_handle *handle, u8 protocol_id,
>>> +			     struct scmi_protocol_handle **ph)
>>> +{
>>> +	struct scmi_protocol_instance *pi;
>>> +
>>> +	if (!ph)
>>> +		return ERR_PTR(-EINVAL);
>>> +
>>> +	pi = scmi_get_protocol_instance(handle, protocol_id);
>>> +	if (IS_ERR(pi))
>>> +		return pi;
>>> +
>>> +	*ph = &pi->ph;
>>> +
>>> +	return pi->proto->ops;
>>> +}
>>> +
>>>    void scmi_setup_protocol_implemented(const struct scmi_handle *handle,
>>>    				     u8 *prot_imp)
>>>    {
>>> @@ -751,6 +784,95 @@ scmi_is_protocol_implemented(const struct scmi_handle *handle, u8 prot_id)
>>>    	return false;
>>>    }
>>> +struct scmi_protocol_devres {
>>> +	struct scmi_handle *handle;
>>> +	u8 protocol_id;
>>> +};
>>> +
>>> +static void scmi_devm_release_protocol(struct device *dev, void *res)
>>> +{
>>> +	struct scmi_protocol_devres *dres = res;
>>> +
>>> +	scmi_release_protocol(dres->handle, dres->protocol_id);
>>> +}
>>> +
>>> +/**
>>> + * scmi_devm_get_protocol_ops  - Devres managed get protocol operations
>>> + * @sdev: A reference to an scmi_device whose embedded struct device is to
>>> + *	  be used for devres accounting.
>>> + * @protocol_id: The protocol being requested.
>>> + * @ph: A pointer reference used to pass back the associated protocol handle.
>>> + *
>>> + * Get hold of a protocol accounting for its usage, eventually triggering its
>>> + * initialization, and returning the protocol specific operations and related
>>> + * protocol handle which will be used as first argument in most of the
>>> + * protocols operations methods.
>>> + * Being a devres based managed method, protocol hold will be automatically
>>> + * released, and possibly de-initialized on last user, once the SCMI driver
>>> + * owning the scmi_device is unbound from it.
>>> + *
>>> + * Return: A reference to the requested protocol operations or error.
>>> + *	   Must be checked for errors by caller.
>>> + */
>>> +static const void __must_check *
>>> +scmi_devm_get_protocol_ops(struct scmi_device *sdev, u8 protocol_id,
>>> +			   struct scmi_protocol_handle **ph)
>>> +{
>>> +	struct scmi_protocol_instance *pi;
>>> +	struct scmi_protocol_devres *dres;
>>> +	struct scmi_handle *handle = sdev->handle;
>>> +
>>> +	if (!ph)
>>> +		return ERR_PTR(-EINVAL);
>>> +
>>> +	dres = devres_alloc(scmi_devm_release_protocol,
>>> +			    sizeof(*dres), GFP_KERNEL);
>>> +	if (!dres)
>>> +		return ERR_PTR(-ENOMEM);
>>> +
>>> +	pi = scmi_get_protocol_instance(handle, protocol_id);
>>> +	if (IS_ERR(pi)) {
>>> +		devres_free(dres);
>>> +		return pi;
>>> +	}
>>> +
>>> +	dres->handle = handle;
>>> +	dres->protocol_id = protocol_id;
>>> +	devres_add(&sdev->dev, dres);
>>> +
>>> +	*ph = &pi->ph;
>>> +
>>> +	return pi->proto->ops;
>>> +}
>>> +
>>> +static int scmi_devm_protocol_match(struct device *dev, void *res, void *data)
>>> +{
>>> +	struct scmi_protocol_devres *dres = res;
>>> +
>>> +	if (WARN_ON(!dres || !data))
>>> +		return 0;
>>> +
>>> +	return dres->protocol_id == *((u8 *)data);
>>> +}
>>> +
>>> +/**
>>> + * scmi_devm_put_protocol_ops  - Devres managed put protocol operations
>>> + * @sdev: A reference to an scmi_device whose embedded struct device is to
>>> + *	  be used for devres accounting.
>>> + * @protocol_id: The protocol being requested.
>>> + *
>>> + * Explicitly release a protocol hold previously obtained calling the above
>>> + * @scmi_devm_get_protocol_ops.
>>> + */
>>> +static void scmi_devm_put_protocol_ops(struct scmi_device *sdev, u8 protocol_id)
>>> +{
>>> +	int ret;
>>> +
>>> +	ret = devres_release(&sdev->dev, scmi_devm_release_protocol,
>>> +			     scmi_devm_protocol_match, &protocol_id);
>>> +	WARN_ON(ret);
>>> +}
>>> +
>>>    /**
>>>     * scmi_handle_get() - Get the SCMI handle for a device
>>>     *
>>> @@ -1004,6 +1126,10 @@ static int scmi_probe(struct platform_device *pdev)
>>>    	handle = &info->handle;
>>>    	handle->dev = info->dev;
>>>    	handle->version = &info->version;
>>> +	handle->devm_get_ops = scmi_devm_get_protocol_ops;
>>> +	handle->devm_put_ops = scmi_devm_put_protocol_ops;
>>> +	handle->get_ops = scmi_get_protocol_operations;
>>> +	handle->put_ops = scmi_release_protocol;
>>
>> Why do you need a dev_res version and a non dev_res version? I checked
>> patch 6 where you convert the drivers to use these hooks and all of them
>> are using the dev res apis.
>>
> 
> Yes indeed, I wanted to drop the non devm_ version, but I was not sure
> if for completeness I should have instead not provided...So I left it
> to have it discussed on the list...I was hoping to be told to remove
> those non devres :D
> 
> Also because in fact any current or future SCMI driver (that are the only
> possible users of this interface) will certainly have an scmi_dev to use
> with devm_() methods.
> 
> Probably the same is true for notify_ops, I could stick with the new
> devres managed versions.

I think you should drop it, unless any one else has issues not having it.

-- 
Warm Regards
Thara
