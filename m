Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 826CA288415
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 09:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732453AbgJIH63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 03:58:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48622 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732086AbgJIH62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 03:58:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602230307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iVtewP7s5qyHI/1d+VGBxPQ+aBPBWOMB6+eMQ61/Xu8=;
        b=IvY0znSrBq02uNqKjuc7gZe/ILz6IHKSGq8FfaQrF8O0m8n6YxCRhvEVfdJ7KwrCHOCYTS
        6Mkmg4GyL3uuiWzoyHdjVjnEmC2Wq9LcJdVaTL48W5MXlziQun7VqHk1vxkYNF1D5EBpjG
        QBn2qlXPg/GIeD3OAtUwxDtz1cz9szM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-WOYqiplkOJy9GOj2XVl-YA-1; Fri, 09 Oct 2020 03:58:25 -0400
X-MC-Unique: WOYqiplkOJy9GOj2XVl-YA-1
Received: by mail-ej1-f72.google.com with SMTP id x22so3269333ejs.17
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 00:58:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iVtewP7s5qyHI/1d+VGBxPQ+aBPBWOMB6+eMQ61/Xu8=;
        b=Qi25c8xHdrUhx25SgkVQSUTizdPcgWQytwoVNmVIJ8MT/0dJ1H7VfAhKb44s4X45cJ
         jvXt2mm+Ge1rxYYoi3V3hO4gXFSa82CgfdrXpgUsCil6t9I9+Gv5PnCN+IHKMImQmCXa
         RGS2eX8JkeEuoXsLqw84u/5Jn5Fd2F1V1F3hB0JIJOXSDRKqWPWeQgvVsxpftpM93+L0
         tO+gqbCKQBWnQB88LU43QGzu7vzHFy0WaTiCV/NJR6cgUyYe4vcg26caUDlNzaUmP0kk
         pTgBWesnC8PkyC9Rr414CEY0zNdIys7F1bam11a4gz3NHDAvDxhjvseqie2ww18yTZ8B
         XazQ==
X-Gm-Message-State: AOAM530snufGCjrx9K+3P3lwXbaGr84qnEZRvdddPWjtx2KN/c1yCfuJ
        avOPjye7KxixNj8haw70maQYkAbsAm3RynjXHyqxdHHh0xClRBYhvw5tNlSh30kJcMp+eDdqX8f
        z7VAiIUadJMvyFBApLnC6wGft
X-Received: by 2002:a50:c199:: with SMTP id m25mr12731674edf.207.1602230303973;
        Fri, 09 Oct 2020 00:58:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyGLLbe5PJGZf0JdhylEg7DAfHZXgLhwZN0l/qVt+kqh4CIT9fmTssJbfbdyLss4r7lfP7SGA==
X-Received: by 2002:a50:c199:: with SMTP id m25mr12731664edf.207.1602230303717;
        Fri, 09 Oct 2020 00:58:23 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id c17sm5876578ejb.15.2020.10.09.00.58.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2020 00:58:22 -0700 (PDT)
Subject: Re: [PATCH v5] Introduce support for Systems Management Driver over
 WMI for Dell Systems
To:     "Bharathi, Divya" <Divya.Bharathi@Dell.com>,
        Divya Bharathi <divya27392@gmail.com>,
        "dvhart@infradead.org" <dvhart@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        mark gross <mgross@linux.intel.com>,
        "Limonciello, Mario" <Mario.Limonciello@dell.com>,
        "Ksr, Prasanth" <Prasanth.Ksr@dell.com>
References: <20200929025521.59573-1-divya.bharathi@dell.com>
 <7015e6d5-3c1e-e07e-572f-d5d47a9b0191@redhat.com>
 <CY4PR19MB125486920AE0C6CA105B973A850D0@CY4PR19MB1254.namprd19.prod.outlook.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <a7cc8b62-c87a-2253-de7a-7b463589ee4c@redhat.com>
Date:   Fri, 9 Oct 2020 09:58:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CY4PR19MB125486920AE0C6CA105B973A850D0@CY4PR19MB1254.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI,

On 10/6/20 10:46 AM, Bharathi, Divya wrote:
> Sorry for another mail on same patch. I missed to add one response on
> previous comments

No problem.

> <snip>
> 
>>> +/**
>>> + * init_bios_attributes() - Initialize all attributes for a type
>>> + * @attr_type: The attribute type to initialize
>>> + * @guid: The WMI GUID associated with this type to initialize
>>> + *
>>> + * Initialiaze all 4 types of attributes enumeration, integer, string and
>> password object.
>>> + * Populates each attrbute typ's respective properties under sysfs files
>>> + **/
>>> +static int init_bios_attributes(int attr_type, const char *guid)
>>> +{
>>> +	struct kobject *attr_name_kobj; //individual attribute names
>>> +	union acpi_object *obj = NULL;
>>> +	union acpi_object *elements;
>>> +	struct kset *tmp_set;
>>> +
>>> +	/* instance_id needs to be reset for each type GUID
>>> +	 * also, instance IDs are unique within GUID but not across
>>> +	 */
>>> +	int instance_id = 0;
>>> +	int retval = 0;
>>> +
>>> +	retval = alloc_attributes_data(attr_type);
>>> +	if (retval)
>>> +		return retval;
>>> +	/* need to use specific instance_id and guid combination to get right
>> data */
>>> +	obj = get_wmiobj_pointer(instance_id, guid);
>>> +	if (!obj)
>>> +		return -ENODEV;
>>> +	elements = obj->package.elements;
>>> +
>>> +	mutex_lock(&wmi_priv.mutex);
>>> +	while (elements) {
>>> +		/* sanity checking */
>>> +		if (strlen(elements[ATTR_NAME].string.pointer) == 0) {
>>> +			pr_debug("empty attribute found\n");
>>> +			goto nextobj;
>>> +		}
>>> +		if (attr_type == PO)
>>> +			tmp_set = wmi_priv.authentication_dir_kset;
>>> +		else
>>> +			tmp_set = wmi_priv.main_dir_kset;
>>> +
>>> +		if (kset_find_obj(tmp_set,
>> elements[ATTR_NAME].string.pointer)) {
>>> +			pr_debug("duplicate attribute name found - %s\n",
>>> +				elements[ATTR_NAME].string.pointer);
>>> +			goto nextobj;
>>> +		}
>>> +
>>> +		/* build attribute */
>>> +		attr_name_kobj = kzalloc(sizeof(*attr_name_kobj),
>> GFP_KERNEL);
>>> +		if (!attr_name_kobj)
>>> +			goto err_attr_init;
>>> +
>>> +		attr_name_kobj->kset = tmp_set;
>>> +
>>> +		retval = kobject_init_and_add(attr_name_kobj,
>> &attr_name_ktype, NULL, "%s",
>>> +
>> 	elements[ATTR_NAME].string.pointer);
>>> +		if (retval) {
>>> +			kobject_put(attr_name_kobj);
>>> +			goto err_attr_init;
>>> +		}
>>> +
>>> +		/* enumerate all of this attribute */
>>> +		switch (attr_type) {
>>> +		case ENUM:
>>> +			retval = populate_enum_data(elements, instance_id,
>> attr_name_kobj);
>>> +			break;
>>> +		case INT:
>>> +			retval = populate_int_data(elements, instance_id,
>> attr_name_kobj);
>>> +			break;
>>> +		case STR:
>>> +			retval = populate_str_data(elements, instance_id,
>> attr_name_kobj);
>>> +			break;
>>> +		case PO:
>>> +			retval = populate_po_data(elements, instance_id,
>> attr_name_kobj);
>>> +			break;
>>> +		default:
>>> +			break;
>>> +		}
>>
>> The show functions don't take the mutex and can be called as soon as
>> kobject_init_and_add() is called, so it would be better to first populate the
>> data for the current instance_id and only then call kobject_init_and_add()
>>
> 
> Populate functions called here for each type of attribute uses
> attribute_koject which helps in attribute group cleanup.

Good point, and we do allocate the data before creating the kobjects,
so if a user manages to hit the race (which almost certainly would have
to be done intentionally) then the read would just result in an empty
string (rather then say a null pointer dereference oops).

So lets just keep this as is.

Regards,

Hans

