Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC26271EC9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 11:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgIUJTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 05:19:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42601 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726395AbgIUJTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 05:19:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600679943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3qp4k5f2KI+AeGRhJ9jLHzhWwAc1X/UvENG6IrkroPY=;
        b=EGtblSUYCgqiK3rE/cveA0RKMKC0ttWCnGhWRMlUuwLy9NkBbD6dioHIlCiL51REVU6CqC
        fHNBCqGkRqEDPqAx4Y2mIjwIlItxqedeMOifPfhesDRL1zuwSEfbdPDcJ5qYwvx/MLAyyO
        frgQ49Q6ZJyw2OWymn43ji0E6fV2OIU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-Z3Ezu-wYN62Td37Ar0guNA-1; Mon, 21 Sep 2020 05:19:01 -0400
X-MC-Unique: Z3Ezu-wYN62Td37Ar0guNA-1
Received: by mail-ej1-f69.google.com with SMTP id f17so4632664ejq.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 02:19:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3qp4k5f2KI+AeGRhJ9jLHzhWwAc1X/UvENG6IrkroPY=;
        b=OD3qyjFTVLKVwx93v2fbD8whSL5t5bNQ9R+oYqi3YkEljXZYrnHeVjZME4LFk21R6I
         l0JCqWEMdjXOskZLwoBhYl/OQVdoImkAg5qnA1e8l2pZxx/N8AUxl5LjmC5ZbgA8+M0U
         EPXwJIioT+ToXVUY3hi0H0DEZogyj7Guu6JQh3SWDncA6NLzfd8E7vAyBuwZDQO03eSI
         uAV+N9RSIxL2g2B3iG9D9lufGKjcA4kP8IX9hUilF8qsu+X6OCpbXbHe2OHyBS75mLzn
         PdTfGERiExwkHkp9Bfs8miGn4Drp4Zr4ECE3p4eY2QUlEmQ6BXXTgyjlaCTJBhar8bdN
         eFkQ==
X-Gm-Message-State: AOAM5325bF07HC4G6TejHqBJfCoqLLpqJzf6z1YIEyfTgco1XOByqiM/
        MzP9A+17wUcU+FAWXSX7lWnv7C2xjhtsMHSS4LsPk76gk4U+2YeXOTBC31y6rYb9QIQxP9Ml+7L
        NU4j9fc0J0s1poJ6WsMZjEWLh
X-Received: by 2002:a50:a418:: with SMTP id u24mr51947452edb.103.1600679940030;
        Mon, 21 Sep 2020 02:19:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzDKoKGiKQIQpBJlsb/iqwSh7JcFxvu99TdsAlFbT44ZItCwR+Vi3SamuNRx7W9du4vOje0Cg==
X-Received: by 2002:a50:a418:: with SMTP id u24mr51947429edb.103.1600679939783;
        Mon, 21 Sep 2020 02:18:59 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id j15sm8478438ejs.5.2020.09.21.02.18.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 02:18:59 -0700 (PDT)
Subject: Re: [PATCH v2] Introduce support for Systems Management Driver over
 WMI for Dell Systems
To:     "Bharathi, Divya" <Divya.Bharathi@Dell.com>,
        "Limonciello, Mario" <Mario.Limonciello@dell.com>,
        Divya Bharathi <divya27392@gmail.com>,
        "dvhart@infradead.org" <dvhart@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Ksr, Prasanth" <Prasanth.Ksr@dell.com>
References: <20200904142846.5356-1-divya_bharathi@dell.com>
 <aaf3b072-a109-4f69-67dd-bea3dc5fb023@redhat.com>
 <DM6PR19MB2636829402BC67EC1048E15FFA230@DM6PR19MB2636.namprd19.prod.outlook.com>
 <CY4PR19MB12544CE6AFD16E89E688ACCD85200@CY4PR19MB1254.namprd19.prod.outlook.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <0c575811-a578-1b11-7741-f795f0c7265e@redhat.com>
Date:   Mon, 21 Sep 2020 11:18:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CY4PR19MB12544CE6AFD16E89E688ACCD85200@CY4PR19MB1254.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/15/20 6:28 PM, Bharathi, Divya wrote:

<snip>

>>>> +/* kept variable names same as in sysfs file name for sysfs_show
>>>> +macro
>>> definition */
>>>> +struct enumeration_data {
>>>> +	char display_name_language_code[MAX_BUFF];
>>>> +	char attribute_name[MAX_BUFF];
>>>> +	char display_name[MAX_BUFF];
>>>> +	char default_value[MAX_BUFF];
>>>> +	char current_value[MAX_BUFF];
>>>> +	char modifier[MAX_BUFF];
>>>> +	int value_modifier_count;
>>>> +	char value_modifier[MAX_BUFF];
>>>> +	int possible_value_count;
>>>> +	char possible_value[MAX_BUFF];
>>>> +	char type[MAX_BUFF];
>>>> +};
>>>> +
>>>> +static struct enumeration_data *enumeration_data; static int
>>>> +enumeration_instances_count;
>>>
>>> Please store these 2 in the global wmi_priv data.
>>>
>>> Also there is a lot of overlap between structs like struct
>>> enumeration_data, struct integer_data, etc.
>>>
>>> I think it would be good to make a single struct attr_data, which
>>> contains fields for all the supported types.
>>>
>>> I also see a lot of overlapping code between:
>>>
>>> drivers/platform/x86/dell-wmi-enum-attributes.c
>>> drivers/platform/x86/dell-wmi-int-attributes.c
>>> drivers/platform/x86/dell-wmi-string-attributes.c
>>>
>>> I think that folding the data structures together will help with also
>>> unifying that code into a single dell-wmi-std-attributes.c file.
>>>
> 
> Yes, it does seem like lot of code is overlapping but they differ by
> properties that are little unnoticeable.
> 
> If we make single file adding switch cases we may end up in many
> switch cases and if conditions. Because, here only attribute_name,
> display_lang_code, display_lang and modifier are same. Apart from
> these other properties are different either by name or data type.
> 
> Also, one advantage here is if any new type is added in future it will
> be easier to create new sysfs_attr_group according to new type's
> properties
> 
> We will certainly try and minimize some identical looking code
> wherever possible and add inline comments/document the
> differences more clearly in v3 which is incoming shortly.
> 
>>>> +get_instance_id(enumeration);
>>>> +
>>>> +static ssize_t current_value_show(struct kobject *kobj, struct
>>> kobj_attribute *attr, char *buf)
>>>> +{
>>>> +	int instance_id;
>>>> +
>>>> +	if (!capable(CAP_SYS_ADMIN))
>>>> +		return -EPERM;
>>>> +	instance_id = get_enumeration_instance_id(kobj);
>>>
>>> If you unify the integer, string and enum code then this just becomes:
>>> get_std_instance_id(kobj)
>>>
> 
> For each type of attribute GUIDs are different and for each type
> instance IDs start from zero. So if we populate them in single data
> structure then instance IDs may overlap.

Ah, I missed that, because of the switch-case in init_bios_attributes()
I assumed it was only called once and all attributes were enumerated
in a single loop.

I see that init_bios_attributes() gets called once for each of
ENUM, INT, STR and PO now. My mistake, sorry.

So you are right. Since the instance-ids overlap then my idea will not
work and we need to keep separate foo_data arrays per type.

It might still be worth it to unify enum_data, string_data and
integer_data into a single shared struct so that some of the
sysfs getter functions can be shared. I will leave that up to you.

Regards,

Hans

