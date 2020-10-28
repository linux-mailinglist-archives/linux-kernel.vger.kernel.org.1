Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 423EC29E171
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 03:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbgJ1Vtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:49:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26472 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727650AbgJ1VrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:47:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603921633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TZ6vIgYo/mgKiFIRKeZHstPuk+6xO/QjFVc8HYMFCQ0=;
        b=NACSFoyjx5+BCdkMarVkslgEMKmpUAyV/CdlNVZGH30KEmNSubRscEkixJ1RlSE8brCgEx
        QPXVXNPusV5Ct4FTOSWEVty4DgnnQqdH6BHDmUDb9CFQi2tExzW15QZHEi2fNPFWK6FnS7
        UUd44eNzRDp/cv7+Udfpbq8tMqO8vDU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-BqgrheF_PJi1U50sII0YTQ-1; Wed, 28 Oct 2020 07:44:35 -0400
X-MC-Unique: BqgrheF_PJi1U50sII0YTQ-1
Received: by mail-ed1-f69.google.com with SMTP id t7so2028850edt.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 04:44:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TZ6vIgYo/mgKiFIRKeZHstPuk+6xO/QjFVc8HYMFCQ0=;
        b=SbfohMivGsRyJJa32DqF7agruugiaQSMXYKIgNraPjc2TpIRnpRLAnhUMqAad16rxX
         VyATi6czhkTpiSjQqsVw99TvTTStVj9EjXtrEbebIl+hCY4HM7p+RHJAyqnjJwR1VdWZ
         8pakDnZgyi8RysqJhCOmiuSTnJ8BaLOmeL/Zkd7jfSJatCCV3B1XweKYViW8FXTfwdT5
         pNC0tG5ltXZikEPS9ecMec+6sNs0SUnfizd1BAbkhYfAMNsDk/U9bHr3NIBjvG6GE+Nl
         DVy++doeBuxyRTDRU2TVVpQBKeBM/QvrS2TTKZ2aw5i7M0W6ba+jcXdjlz3L74+pJD5b
         /Edw==
X-Gm-Message-State: AOAM533jM2kQX7qObscr0KI17Qc6X3mc55QnbgZarFCENhzE48CeINJq
        IuoGisgNUfkrO1/oURJP9YowQCCBRTyIDYmfoU2+aY8Zvcs0qVSPXIpVsM5NjpyHizvK6OumkPC
        lkMOv+oLkaPuX5fHpACx/94Qf
X-Received: by 2002:a17:906:b084:: with SMTP id x4mr7356520ejy.374.1603885474020;
        Wed, 28 Oct 2020 04:44:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXVjXhf4+8pZEIqcfIBD798pSoyoaqJ2gYQg3IVaefLkAhlwD9Rvrn8Pf8LVXj+k7UAaPcIg==
X-Received: by 2002:a17:906:b084:: with SMTP id x4mr7356503ejy.374.1603885473814;
        Wed, 28 Oct 2020 04:44:33 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-6c10-fbf3-14c4-884c.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:6c10:fbf3:14c4:884c])
        by smtp.gmail.com with ESMTPSA id ss7sm2832579ejb.28.2020.10.28.04.44.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2020 04:44:33 -0700 (PDT)
Subject: Re: [PATCH v3] platform/x86: asus-wmi: Add support for SW_TABLET_MODE
 on UX360
To:     =?UTF-8?Q?Samuel_=c4=8cavoj?= <samuel@cavoj.net>
Cc:     Mark Gross <mgross@linux.intel.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201020220944.1075530-1-samuel@cavoj.net>
 <20201020222914.6k2pkxiirzbefjml@fastboi.localdomain>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <a108d447-8bbe-dcc1-4ca5-1af4015418bd@redhat.com>
Date:   Wed, 28 Oct 2020 12:44:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201020222914.6k2pkxiirzbefjml@fastboi.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/21/20 12:29 AM, Samuel Čavoj wrote:
> Hi,
> 
> naturally I notice this right after I send the patch, but my whitespace
> is wrong. Time to set a pre-commit hook up. I guess that means a v4,
> unless you would fix it on your end? It's just a single line.
> 
> Sorry about all the noise,
> Sam
> 
> On 21.10.2020 00:09, Samuel Čavoj wrote:
>> @@ -375,6 +376,20 @@ static int asus_wmi_input_init(struct asus_wmi *asus)
>>  		}
>>  	}
>>  
>> +	if (asus->driver->quirks->use_lid_flip_devid) {
>> +		result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_LID_FLIP);
>> +        if (result < 0)
> 
> Right ^here.

No worries I will fix this when merging it.

> 
>> +			asus->driver->quirks->use_lid_flip_devid = 0;
>> +		if (result >= 0) {
>> +			input_set_capability(asus->inputdev, EV_SW, SW_TABLET_MODE);
>> +			input_report_switch(asus->inputdev, SW_TABLET_MODE, result);
>> +		} else if (result == -ENODEV) {
>> +			pr_err("This device has lid_flip quirk but got ENODEV checking it. This is a bug.");
>> +		} else {
>> +			pr_err("Error checking for lid-flip: %d\n", result);
>> +		}
>> +	}
> 

>> +	if (asus->driver->quirks->use_lid_flip_devid) {
>> +		result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_LID_FLIP);
>> +        if (result < 0)
>> +			asus->driver->quirks->use_lid_flip_devid = 0;
> 
> I had the idea of doing this, not sure if it is actually a good idea
> though. The idea is that it would prevent querying the device later
> during runtime, if the first get_devstate fails. Also I assume doing a
> input_report_switch without a corresponding input_set_capability is not
> great either, this would prevent that, if for some reason the
> get_devstate fails in the beginning but later fixes itself.
> 
> However, I can also imagine that writing to the quirks structure is
> frowned upon, please tell if that is the case. Thanks.

The quirk_entry structs are not defined const; and they are already written
to in other places (e.g. the wapf module param handling). So this is fine.

Note FWIW, that calling input_report_switch() with a switch which
has not been declared before through input_set_capability() before
is allowed and is simply treated as a no-op. But just skipping the
handling of the event alltogether is a bit cleaner, so your approach is
fine.

Regards,

Hans

