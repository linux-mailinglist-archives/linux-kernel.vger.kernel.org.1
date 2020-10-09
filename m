Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D63F2883DB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 09:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732265AbgJIHq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 03:46:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31503 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732025AbgJIHq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 03:46:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602229617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NaHtpFDh78DMWI0+4c2kug15EzHu5hi7MLxFg0PhrNY=;
        b=PJnsjzzdXAa1N8X32LSgi32ncuuD0phxs14sLUgUrgSpshSI0jIwtfj1YGmDgyskQcIuq5
        KfZJ/BEDR5kDRW4RA4vOwimXxHPlZ/cv4eEATOOff/yzingPKzZ3Pr7/ruhqp2DvyCMb98
        Baif0aqAzRGSeppPFqPo2z+PNTc407E=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-a6-l5_FOPNyHaHzCdc_Y4w-1; Fri, 09 Oct 2020 03:46:56 -0400
X-MC-Unique: a6-l5_FOPNyHaHzCdc_Y4w-1
Received: by mail-ed1-f72.google.com with SMTP id h6so169624edt.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 00:46:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NaHtpFDh78DMWI0+4c2kug15EzHu5hi7MLxFg0PhrNY=;
        b=cjpEYxvcuCfWrtPyCM+1IsfDV0urm3c0pycFSYMZbJ5pr3+0tsW2riI3Qd46AdkyZt
         Rt0RiE4d/Cg+G4KH7KzutTQxkivHVkw5IW3jU71GecoqLQL1BIsRq26ddrhLBMt+qNtz
         I9wdvM+gMhz2aaLMfoiCee7tcP+fBvZGzHVMDjeGLYL+9pAWK5r/+db6GG+Zi0x6OOrk
         L2KcPXSA8plvSvF5dTU7HIAqaplN8qvnDGzQgLPC6XiR12/s+bnhoB7NXl0/938FJFy/
         4t+CRAMgGm5n6x6dltbbB+AX0wF1RE3vN5S3tCN6NvvfbE67bCcOHq3m+pCVgrtuDgwE
         T8eQ==
X-Gm-Message-State: AOAM531ngexyeb1HYDng9VJDK+Zy7q/OBSd9FgEE9ozsOJRXjn+8G/6h
        EVKipDWca/lYrkPEEq21FZDPeC7wPZS0RFXIhX417e6w4NOfL+Te2kF3rIyHgMMfl90UlYbUcFc
        OalbXr4dfpj0dyMZL4cRINzEk
X-Received: by 2002:a17:906:7a0f:: with SMTP id d15mr13276533ejo.533.1602229614603;
        Fri, 09 Oct 2020 00:46:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxPP6E5WFz7ADARHQt7U8BbNAjGw1U1zCs3ShXJj1v38i2Y8t/seuC24V6nfoj20xIA9DKsbA==
X-Received: by 2002:a17:906:7a0f:: with SMTP id d15mr13276514ejo.533.1602229614368;
        Fri, 09 Oct 2020 00:46:54 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id k18sm5837615ejh.50.2020.10.09.00.46.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2020 00:46:53 -0700 (PDT)
Subject: Re: [PATCH v5] Introduce support for Systems Management Driver over
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
References: <20200929025521.59573-1-divya.bharathi@dell.com>
 <7015e6d5-3c1e-e07e-572f-d5d47a9b0191@redhat.com>
 <DM6PR19MB26368CC7E63EB64C380C9F63FA300@DM6PR19MB2636.namprd19.prod.outlook.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <0c4a8f66-5261-5cf0-0cd4-6991d7406854@redhat.com>
Date:   Fri, 9 Oct 2020 09:46:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <DM6PR19MB26368CC7E63EB64C380C9F63FA300@DM6PR19MB2636.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/1/20 9:37 PM, Limonciello, Mario wrote:
>>> +
>>> +	if (!capable(CAP_SYS_ADMIN))
>>> +		return -EPERM;
>>
>> Sorry for not addressing this during earlier reviews, but why is this
>> check here. Is read-only access to the settings by normal users
>> considered harmful ?
>>
> 
> The best answer I can give is that this is exposing data to a user that
> previously they would have needed either physical access or root access
> to see.  And even if they had physical access they may have needed a
> BIOS admin password to get "into" setup.  Exposing it directly to everyone
> subverts the previous access limitations to the data.
> 
> Some of the settings are certainly more sensitive than others, so I don't
> feel it's appropriate for the kernel to perform this arbitration.

I see, IMHO it would be better to just set the file permissions for
current_value to 600 then, then it will be much clearer to users
why they are getting -EPERM. This is e.g. also done for some of
the more sensitive DMI strings like e.g. serial-numbers:

[hans@x1 ~]$ ls -l /sys/class/dmi/id/board_serial
-r-------- 1 root root 4096 Oct  9 09:36 /sys/class/dmi/id/board_serial

You can do this by changing:

__ATTR_RW(current_value);

to:

__ATTR_RW_MODE(current_value, 0600);

>>> +static int validate_enumeration_input(int instance_id, const char *buf)
>>> +{
>>> +	char *options, *tmp, *p;
>>> +	int ret = -EINVAL;
>>> +
>>> +	options = tmp =
>> kstrdup(wmi_priv.enumeration_data[instance_id].possible_values,
>>> +				 GFP_KERNEL);
>>> +	if (!options)
>>> +		return -ENOMEM;
>>> +
>>> +	while ((p = strsep(&options, ";")) != NULL) {
>>> +		if (!*p)
>>> +			continue;
>>> +		if (!strncasecmp(p, buf, strlen(p))) {
>>
>> So using strncasecmp here is usually done to get rid of the '\n' but it
>> is a bit finicky and as such you got it wrong here, of say "Enabled"
>> is a valid value and the user passes "EnabledFooBar" then this
>> will get accepted because the first 7 chars match. Since you
>> are already dealing with the \n in the caller you can just drop the
>> "n" part of the strncasecmp to fix this.
>>
>> Also are you sure you want a strcasecmp here ? That makes the compare
>> case-insensitive. So IOW that means that enabled and ENABLED are also
>> acceptable.
> 
> That's correct, the firmware will interpret ENABLED and enabled as the same
> thing.  It will also do further validation of the input.

Ok, strcasecmp it is then.

Regards,

Hans

