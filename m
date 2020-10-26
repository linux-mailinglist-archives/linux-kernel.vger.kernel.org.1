Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00F4929914E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 16:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1784317AbgJZPlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 11:41:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49231 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1773432AbgJZPlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 11:41:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603726911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XxTRL/KCZQNPaBl6z/BK7HxMO/ugsS28Pfq4Yc2zsNs=;
        b=GblMsFohwZ4chyIQdbAxzkbcqeOtYLh1PhI4lBahZfkVcam39hpf6Akeu8+ffH0F5jIo61
        lpyjOS879+ty4vEdDP84RnrenddT+dVs3VlRDL3b8cTPwvQ29CEQ+ptCbjvDSHq5BqqOO2
        CzclUoXivYrDGHZo17ncNz18bf3rrmY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-4Al0waNiPIGo4L4sgpS99A-1; Mon, 26 Oct 2020 11:41:48 -0400
X-MC-Unique: 4Al0waNiPIGo4L4sgpS99A-1
Received: by mail-ej1-f69.google.com with SMTP id ha4so1395141ejb.9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 08:41:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XxTRL/KCZQNPaBl6z/BK7HxMO/ugsS28Pfq4Yc2zsNs=;
        b=Os63a0xJEcI+CaDveOljyWoMGsw79Pv2ayDyVeyoc6ljMBXLgolBXfWWFYmrFywxis
         nj18nAWu36acRFrAfFnxIwWooMbTErkPjFeBVlojd/UBqWf67BOcUL3p+9U4iJ53HgkX
         JGXE4dKeEcIJMNeZCrpd0JfkaGzHu8+neyLit5S0iLe6W4MD7h2YZfReejGtujqK7k3O
         czclWNu7dlTXJpJL0o0Q58xVoGiKval/ifiX6KLd++exH3MeW0bhG7fLzGebZrzNLk3m
         7lfj8HENahaGuIinbggpcXo2E0o60tcZjEHl8xW9HChie3EoJGltdoXizZyovMb3/9bm
         vdww==
X-Gm-Message-State: AOAM530eNO2mGr6MV+SO1NLHfBmj1qnN7eqYiaPUzw2qP+XPEBvBobER
        ppyzFpcs/Wqkevwdm6t6Q3/4WI6wJQaCJPXpJ91F+5P8/6sBYwLRF6IdO54nmQ49F0bI6ydt5OQ
        5tA99vdmfNcx2r/j1YP2fxGJR
X-Received: by 2002:aa7:c647:: with SMTP id z7mr3542523edr.350.1603726906746;
        Mon, 26 Oct 2020 08:41:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzijRjaL5cxTNnxce+CH5tVZ5Z7zUs0Eo2Y0iQEs1wVNkENTg7loIfaBSfL3fK8YefmAtAilg==
X-Received: by 2002:aa7:c647:: with SMTP id z7mr3542449edr.350.1603726905798;
        Mon, 26 Oct 2020 08:41:45 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id q3sm5421050edv.17.2020.10.26.08.41.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2020 08:41:45 -0700 (PDT)
Subject: Re: [PATCH v6] Introduce support for Systems Management Driver over
 WMI for Dell Systems
To:     "Limonciello, Mario" <Mario.Limonciello@dell.com>,
        Divya Bharathi <divya27392@gmail.com>,
        "dvhart@infradead.org" <dvhart@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "Bharathi, Divya" <Divya.Bharathi@Dell.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        mark gross <mgross@linux.intel.com>,
        "Ksr, Prasanth" <Prasanth.Ksr@dell.com>
References: <20201006082618.209287-1-divya.bharathi@dell.com>
 <101db8e3-70f0-4e85-b4b9-008995939b1a@redhat.com>
 <DM6PR19MB26367BCFE51C45BC00D13F6BFA190@DM6PR19MB2636.namprd19.prod.outlook.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <7f40bc72-83cc-c265-ac46-9543f74d228a@redhat.com>
Date:   Mon, 26 Oct 2020 16:41:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <DM6PR19MB26367BCFE51C45BC00D13F6BFA190@DM6PR19MB2636.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/26/20 4:39 PM, Limonciello, Mario wrote:
>> This was present in previous versions too, but I just noticed this are you
>> sure that using
>> .string.pointer is correct here? That seems wrong since the pointer gets
>> allocated by
>> the Linux ACPI core, so it is not under influence of the AML code?
>>
>> I think you want / need to use ".integer.value" here ?
>>
>> And maybe first do a type check, e.g.:
>>
>> 	if (obj->package.elements[CURRENT_VAL].type != ACPI_TYPE_INTEGER) {
>> 		ret = -EINVAL;
>> 		goto out;
>> 	}
>>
>> Adding this type check will also show if I'm right that you should use
>> .integer.value ...
>>
>> 	ret = snprintf(buf, PAGE_SIZE, "%lld\n", obj-
> 
> We'll need to double check this, but I'm pretty sure the firmware outputs
> everything as a string.

Ok, in that case it should probably be printed as a "%s" though and not interpret
the buffer-address which the kernel allocated for storing the string as an
integer.

And it would still be good to do the type-check for this, but then checking
for a type of ACPI_TYPE_STRING.

Regards,

Hans

