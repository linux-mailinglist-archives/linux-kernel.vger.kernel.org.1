Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE5912EF5CB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 17:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbhAHQdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 11:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728119AbhAHQc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 11:32:59 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B46C0612EA
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 08:32:19 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id g24so6853760qtq.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 08:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=70i3PwMzLW9UUW/bJTFqRoHPC2G8GebnbTNeoxXJgHQ=;
        b=qgj0yyfHFOIxaVJnDLTOkk92GN1WcMmMDZxX9b3wVNCX5z9wrjamMKlxqhdjsc9kts
         3ev5Czb0Wp2Xbhk5xeRkL6/9jo1C3Iyrw1Ae6n+wfjBI9OPERGe7AI6rOXdlOihw0TIU
         M43l9ww/XTfbkqyTG1eklbXslr/EHVUvQRrABG1cngAFuSssKbhA48e3duA83d3OQ55h
         Vmsfw75yhWXxv0xoGxbm7v2ccz2lDhwSm6SrXhIgfGX6DO3Nb7PXnfXtfyWtiHrFveka
         HdPVdGQkpj7NM2C/F7msmaKq1jeYwVsljJBJgJB2G2AH1iVjQuMbdLc4z7KDjv+EegTA
         jL2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=70i3PwMzLW9UUW/bJTFqRoHPC2G8GebnbTNeoxXJgHQ=;
        b=FZbO5ltCGCtzhnT4R2/bJbK9bSXOOCORbslrDjN7sY3y68BAm+w4OEcodGXhHz3w9I
         KIdYtLOwl9EzSVA6PQoHYALgGfr9Ag231P591lAEfX8F6uUlsNa+5o0o4RY/eYLBnd3z
         WQKGWqGLGRtaNB9V0BFnDBHgf84peinZs/JLMBA+SotzsrMNF/NkHrjm9dCDxuGOA9u1
         /9vSNa/bf1HUQ8MDQbQrOu21UbeUlApc35gvxdFxKS+Q4gxWSUyZongKgacBM76Jj0rt
         e4Y34s/3hbzwfaVGlR8arQQV9S+EPu14raQ73zqBSm+OIW5WFvgJ/CZnYM+4UyK3jV2Y
         8bGw==
X-Gm-Message-State: AOAM531s/xa7MJIu4UpaBk7cS5vLb7+kNbN6xsvCdW5XyCobgL0VdFya
        OcMANooIRjIuNUQYl2+1FLEQqg==
X-Google-Smtp-Source: ABdhPJz+ZPlhEC6GjKWjchDvSZmlGcAZzgjZ/F89ihfjZHe1W8WWTed75uDIhlDfHIJRhEk0bnC0Yw==
X-Received: by 2002:ac8:51d8:: with SMTP id d24mr4139712qtn.73.1610123538577;
        Fri, 08 Jan 2021 08:32:18 -0800 (PST)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id r15sm4931575qke.55.2021.01.08.08.32.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jan 2021 08:32:17 -0800 (PST)
Subject: Re: [PATCH v4 37/37] firmware: arm_scmi: add dynamic scmi devices
 creation
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
References: <20210106201610.26538-1-cristian.marussi@arm.com>
 <20210106201610.26538-38-cristian.marussi@arm.com>
 <50434a02-0fe0-50f3-1529-51ab8a0cc1f3@linaro.org>
 <20210108144257.GD9138@e120937-lin>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <9d08fb9f-44e0-7f1d-9568-ebb499c91434@linaro.org>
Date:   Fri, 8 Jan 2021 11:32:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210108144257.GD9138@e120937-lin>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/8/21 9:42 AM, Cristian Marussi wrote:
> On Thu, Jan 07, 2021 at 09:28:07AM -0500, Thara Gopinath wrote:
>> Hi Christian,
>>
>> On 1/6/21 3:16 PM, Cristian Marussi wrote:
>>> Having added the support for SCMI protocols as modules in order to let
>>> vendors extend the SCMI core with their own additions it seems odd to
>>> then force SCMI drivers built on top to use a static device table to
>>> declare their devices since this way any new SCMI drivers addition
>>> would need the core SCMI device table to be updated too.
>>>
>>> Remove the static core device table and let SCMI drivers to simply declare
>>> which device/protocol pair they need at initialization time: the core will
>>> then take care to generate such devices dynamically during platform
>>> initialization or at module loading time, as long as the requested
>>> underlying protocol is defined in the DT.
>>>
>>> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
>>> ---
>> 	
>> [snip]
>>
>>> -static inline void
>>> -scmi_create_protocol_devices(struct device_node *np, struct scmi_info *info,
>>> -			     int prot_id)
>>> +	for (; rdev; rdev = rdev->next)
>>> +		scmi_create_protocol_device(np, info, prot_id,
>>> +					    rdev->id_table->name);
>>> +}
>>> +
>>> +/**
>>> + * scmi_request_protocol_device  - Helper to request a device
>>> + *
>>> + * @id_table: A protocol/name pair descriptor for the device to be created.
>>> + *
>>> + * This helper let an SCMI driver request specific devices identified by the
>>> + * @id_table to be created for each active SCMI instance.
>>> + *
>>> + * The requested device name MUST NOT be already existent for any protocol;
>>> + * at first the freshly requested @id_table is annotated in the IDR table
>>> + * @scmi_requested_devices, then a matching device is created for each already
>>> + * active SCMI instance. (if any)
>>> + *
>>> + * This way the requested device is created straight-away for all the already
>>> + * initialized(probed) SCMI instances (handles) but it remains instead pending
>>> + * for creation if the requesting SCMI driver is loaded before some instance
>>> + * and related transports was available: when such late SCMI instance is probed
>>> + * it will take care to scan the list of pending requested devices and create
>>> + * those on its own (see @scmi_create_protocol_devices and its enclosing loop)
>>> + *
>>> + * Return: 0 on Success
>>> + */
>>> +int scmi_request_protocol_device(const struct scmi_device_id *id_table)
>>>    {
>>> -	int loop, cnt;
>>> +	int ret = 0;
>>> +	unsigned int id = 0;
>>> +	struct scmi_requested_dev *rdev, *proto_rdev = NULL;
>>> +	struct scmi_info *info;
>>> -	for (loop = 0; loop < ARRAY_SIZE(devnames); loop++) {
>>> -		if (devnames[loop].protocol_id != prot_id)
>>> -			continue;
>>> +	pr_debug("Requesting SCMI device (%s) for protocol %x\n",
>>> +		 id_table->name, id_table->protocol_id);
>>> -		for (cnt = 0; cnt < ARRAY_SIZE(devnames[loop].names); cnt++) {
>>> -			const char *name = devnames[loop].names[cnt];
>>> +	/*
>>> +	 * Search for the matching protocol rdev list and then search
>>> +	 * of any existent equally named device...fails if any duplicate found.
>>> +	 */
>>> +	mutex_lock(&scmi_requested_devices_mutex);
>>> +	idr_for_each_entry(&scmi_requested_devices, rdev, id) {
>>> +		if (rdev->id_table->protocol_id == id_table->protocol_id)
>>> +			proto_rdev = rdev;
>>> +		for (; rdev; rdev = rdev->next) {
>>> +			if (!strcmp(rdev->id_table->name, id_table->name)) {
>>> +				pr_err("Ignoring duplicate request [%d] %s\n",
>>> +				       rdev->id_table->protocol_id,
>>> +				       rdev->id_table->name);
>>> +				ret = -EINVAL;
>>> +				goto out;
>>> +			}
>> 	Shouldn't there be proto_rdev = rdev here as well ?
>>
> 
> No, because each IDR entry points to one or more linked rdev descriptors
> for the same protocol: while scanning each list in the IDR table I'm
> searching for the proto_rdev representing the head of that protocol list
> (if any already exist) and also scan all the lists fully to check for
> duplicates, in such a case we give up.
> The IDR map containing list resembles a lot a Linux hash implementation
> but I decided not to use it because it seemed cumbersome to use an
> hash given most of the time each IDR entry will contain just one single
> element and this lookup happens really very infrequently (just at driver
> loading time)

I agree that using hash might be overkill here.
I still think you need proto_rdev = rdev so that proto_rdev points to 
the last element and not the head. Else later on, below when you do
	proto_rdev->next = rdev;
you will lose devices.

Basically in the current implementation if there are more than two 
devices for a protocol, you will end up losing devices since you are 
adding the new device as the second device always.

I think like you mentioned this should be a klist instead of a custom 
linked list. And idr can keep track of head of each list.

> 
>>> +		}
>>> +	}
>>> +
>>> +	/*
>>> +	 * No duplicate found for requested id_table, so let's create a new
>>> +	 * requested device entry for this new valid request.
>>> +	 */
>>> +	rdev = kzalloc(sizeof(*rdev), GFP_KERNEL);
>>> +	if (!rdev) {
>>> +		ret = -ENOMEM;
>>> +		goto out;
>>> +	}
>>> +	rdev->id_table = id_table;
>>> +
>>> +	/*
>>> +	 * Append the new requested device table descriptor to the head of the
>>> +	 * related protocol chain, eventually creating such chain if not already
>>> +	 * there.
>>> +	 */
>>> +	if (!proto_rdev) {
>>> +		ret = idr_alloc(&scmi_requested_devices, (void *)rdev,
>>> +				rdev->id_table->protocol_id,
>>> +				rdev->id_table->protocol_id + 1, GFP_KERNEL);
>>> +		if (ret != rdev->id_table->protocol_id) {
>>> +			pr_err("Failed to save SCMI device - ret:%d\n", ret);
>>> +			kfree(rdev);
>>> +			ret = -EINVAL;
>>> +			goto out;
>>> +		}
>>> +		ret = 0;
>>> +	} else {
>>> +		proto_rdev->next = rdev;
>>> +	}
>>> +
>>> +	/*
>>> +	 * Now effectively create and initialize the requested device for every
>>> +	 * already initialized SCMI instance which has registered the requested
>>> +	 * protocol as a valid active one: i.e. defined in DT and supported by
>>> +	 * current platform FW.
>>> +	 */
>>> +	mutex_lock(&scmi_list_mutex);
>>> +	list_for_each_entry(info, &scmi_list, node) {
>>> +		struct device_node *child;
>>> +
>>> +		child = idr_find(&info->active_protocols,
>>> +				 id_table->protocol_id);
>>> +		if (child) {
>>> +			struct scmi_device *sdev;
>>> +
>>> +			sdev = scmi_get_protocol_device(child, info,
>>> +							id_table->protocol_id,
>>> +							id_table->name);
>>> +			/* Set handle if not already set (device existed) */
>>> +			if (sdev && !sdev->handle)
>>> +				sdev->handle = scmi_handle_get_from_info(info);
>>> +		} else {
>>> +			dev_err(info->dev,
>>> +				"Failed. SCMI protocol %d not active.\n",
>>> +				id_table->protocol_id);
>>> +		}
>>> +	}
>>> +	mutex_unlock(&scmi_list_mutex);
>>> +
>>> +out:
>>> +	mutex_unlock(&scmi_requested_devices_mutex);
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +/**
>>> + * scmi_unrequest_protocol_device  - Helper to unrequest a device
>>> + *
>>> + * @id_table: A protocol/name pair descriptor for the device to be unrequested.
>>> + *
>>> + * An helper to let an SCMI driver release its request about devices; note that
>>> + * devices are created and initialized once the first SCMI driver request them
>>> + * but they destroyed only on SCMI core unloading/unbinding.
>>> + *
>>> + * The current SCMI transport layer uses such devices as internal references and
>>> + * as such they could be shared as same transport between multiple drivers so
>>> + * that cannot be safely destroyed till the whole SCMI stack is removed.
>>> + * (unless adding further burden of refcounting.)
>>> + */
>>> +void scmi_unrequest_protocol_device(const struct scmi_device_id *id_table)
>>> +{
>>> +	struct scmi_requested_dev *victim, *prev, *head;
>>> +
>>> +	pr_debug("Unrequesting SCMI device (%s) for protocol %x\n",
>>> +		 id_table->name, id_table->protocol_id);
>>> -			if (name)
>>> -				scmi_create_protocol_device(np, info, prot_id,
>>> -							    name);
>>> +	head = idr_find(&scmi_requested_devices, id_table->protocol_id);
>>> +	if (!head)
>>> +		return;
>>> +
>>> +	/*
>>> +	 * Scan the protocol list of requested device name searching
>>> +	 * for the victim.
>>> +	 */
>>> +	victim = head;
>>> +	for (prev = victim; victim; prev = victim, victim = victim->next)
>>
>> 	The initial assignment for the for loop is wrong. With this when you break
>> prev will be equal to victim. You want prev to be the one pointing to the
>> victim. Or am I missing something?
>>
> 
> Yes prev is the one preceding the victim, if any, but if it was the head
> I'll remove the head and not use at all the prev really.
> I think is right as it is, it is the naming that is misleading, because
> yes in the initial assignment prev = victim BUT victim = head, so if I bail
> out immediately I'm really removing the head.
> It would be clearer like
> 
>           prev = victim = head;
>           for (; victim; prev = victim, victim = victim->next)
> 	 ...
> 
> But it's better that I review this whole loop in deep to simplify it; I
> avoided using klist because seemed easier enough to handle a singly
> linked list which most of the time is one element deep, buut maybe I
> should just stick with well known and proven kists.

Yes you are right. No bug here. Like I mentioned above, klists are 
something to consider here.

> 
> Thanks
> 
> Cristian
> 
>>
>> -- 
>> Warm Regards
>> Thara

-- 
Warm Regards
Thara
