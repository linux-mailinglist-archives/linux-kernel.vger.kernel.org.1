Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 288C22688CE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 11:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgINJxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 05:53:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39050 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726239AbgINJx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 05:53:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600077204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Oj17EjhcdC1dLgIQUMv6H6xqafNT2mozvuM9vDiQWQY=;
        b=McZJLOBy1636eCH9payScMIU79poE+5dX7Nw/Hxk7Zm7Ke/uThXD9jLDOBryudVrqoxMeG
        Q3OzloufBC1I+WUu1XGqiFiKgrQW65FIdYG+IGX4MHIccq9zItdGx1sTYSz6uRDmv+YwYd
        xTxg0QjHrLk3TA23Yc7ZImYnxMNmWSg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-fIQBCe_jO7aQp0m5_gqdOg-1; Mon, 14 Sep 2020 05:53:20 -0400
X-MC-Unique: fIQBCe_jO7aQp0m5_gqdOg-1
Received: by mail-ed1-f70.google.com with SMTP id bm14so9122726edb.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 02:53:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Oj17EjhcdC1dLgIQUMv6H6xqafNT2mozvuM9vDiQWQY=;
        b=TYikaDYvfDKpiRj0o/2uPs2RElINggPA4bh0pcYtnT7Z0PF/GfmeOfYIgQrjNDCzvA
         XdEGGNXqIIFd4RDjDJBoY/wTmvSfP3ngk20VQHerRJhQaN4fUd/XjY+mXybYZugqyY7I
         3ldWpDeQMzmTyT63LcFUJHtsQN03Dgj2rdnU92ldw6OKsqst5Ng5XL+P66pysoQx6cw0
         wssE5j3hJiv0R61MJTay0XoBxya3anQz09NrMTq9mFTOgyJaL1uAZKydr42G79eXnjTj
         MtPyfmXFsfid4DOq+kUKqNZTh13lRlH5AD18hg++hSrEcAfQkIq/PcAUAxtVY7/62LAU
         Es0A==
X-Gm-Message-State: AOAM532ev9TqLf1Rtz34ak6vBE9rYgSSdloKt2SBj2BnargPIqTTjEuJ
        NfG+pBHe7SDetbMUDQ4t0D34EgQmyWJBsnK1PE8a0xuJqWoIV7PknbFQAMLKbceu0ETfzJ1KI9F
        klOsBHQ2ScPUwDLJ2eyOkp3c5
X-Received: by 2002:a17:906:17c6:: with SMTP id u6mr14097487eje.95.1600077199080;
        Mon, 14 Sep 2020 02:53:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwT5iEZUZ5nIK9bwAsDT0My596j/tVJnOiLMNEBAQYJwhIl66Elc9Dk5L+kF1YWBqKOeeATMQ==
X-Received: by 2002:a17:906:17c6:: with SMTP id u6mr14097472eje.95.1600077198900;
        Mon, 14 Sep 2020 02:53:18 -0700 (PDT)
Received: from x1.localdomain ([78.108.130.193])
        by smtp.gmail.com with ESMTPSA id a18sm7326291ejy.71.2020.09.14.02.53.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 02:53:18 -0700 (PDT)
Subject: Re: [PATCH] Introduce support for Systems Management Driver over WMI
 for Dell Systems
To:     "Limonciello, Mario" <Mario.Limonciello@dell.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Divya Bharathi <divya27392@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        "Bharathi, Divya" <Divya.Bharathi@Dell.com>,
        "Ksr, Prasanth" <Prasanth.Ksr@dell.com>
References: <20200730143122.10237-1-divya_bharathi@dell.com>
 <9b0e8473-1582-eb02-70f4-0f25d09c720c@redhat.com>
 <CAHp75Vfxgf4ttL931M08WqiWVELtZQotHvikDbmrTGkOyd=ZtQ@mail.gmail.com>
 <DM6PR19MB2636225813D7359A210D8DCCFA2C0@DM6PR19MB2636.namprd19.prod.outlook.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <71aebcf6-ecc5-72ce-e230-8bd25a294de8@redhat.com>
Date:   Mon, 14 Sep 2020 11:53:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <DM6PR19MB2636225813D7359A210D8DCCFA2C0@DM6PR19MB2636.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/3/20 4:27 PM, Limonciello, Mario wrote:

<snip>

>>>> +     /* look up if user set a password for the requests */
>>>> +     current_password = get_current_password("Admin");
>>>> +     if (!current_password)
>>>> +             return -ENODEV;
>>>
>>> Can we instead of passing "Admin" and "System" to this function
>>> just have 2 separate get_current_admin_password and
>> get_current_system_password
>>> helpers and then drop the error handling ?
> 
> The error handling for -ENODEV is actually important in case a WMI driver
> was unbound.

I see and checking for that is good, but then please make it
explicit, rather then hiding it like this. As is the code suggests
to someone reading the code that the problem is a missing password not
the driver being unbound.

As I mentioned before, since the code clearly assume that
only 1 instance of each WMI GUID is present, it should move to
storing all its data into a shared global struct. Protected
by a single shared global mutex.

And then functions exposed through sysfs attributes can do:

	mutex_lock(&dell_wmi_bios_attr_mutex);

	if (!dell_wmi_bios_attr_data.bios_attr_wdev ||
	    !dell_wmi_bios_attr_data.password_attr_wdev) {
		mutex_unlock(&call_mutex);
		return -ENODEV;
	}

And the password data can simply be directly read from
dell_wmi_bios_attr_data without needing a helper for it at all.

>>>> +
>>>> +     /* password is set */
>>>> +     if (strlen(current_password) > 0)
>>>> +             security_area_size = (sizeof(u32) * 2) +
>> strlen(current_password) +
>>>> +                                     strlen(current_password) % 2;
>>>> +     /* password not set */
>>>> +     else
>>>> +             security_area_size = sizeof(u32) * 2;
>>>
>>> Since you are using more then 1 line here please use {} around the state-
>> ments,
>>> also please put the /* password not set */ after the else:
>>>
>>>                  ...
>>>          } else { /* password not set */
>>>                  ...
>>>
>>>> +     string_area_size = (strlen(a_name) + strlen(a_value))*2;
>>>> +     buffer_size = security_area_size + string_area_size + sizeof(u16) *
>> 2;
>>>> +
>>>> +     buffer = kzalloc(buffer_size, GFP_KERNEL);
>>
>> Actually above looks like home grown kasprintf() implementation.
> 
> I don't think so, sprintf isn't used at all here.  It's a calculation to determine
> the size of the buffer to use.

Ack, this is different because it concats a UTF16 string together with some
other data into the new buf.

Regards,

Hans

