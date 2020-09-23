Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15887275570
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 12:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgIWKTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 06:19:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50314 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726328AbgIWKTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 06:19:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600856379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZfmXFWuGpvjNq6cXHlDm0b2WUaUCEmp6aIcoRmPsQQc=;
        b=BbAmWtNy7CvX6u+ynwAQMPL5vMmhBaplOyAifeskM1P4o4UnajI7C6yrI0rKLrnBvohqS5
        0FBHNNc6GfjCwKyQom7HmQGTnJSds5hHZqjITreMJexx+1LLPe4L/YVyNrbX8I2eZ0nRk+
        DkKSq7GPtCh64lCyXd+foZBXxFgjfDw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-MDL0NGhrMOyvg8siE20C_Q-1; Wed, 23 Sep 2020 06:19:37 -0400
X-MC-Unique: MDL0NGhrMOyvg8siE20C_Q-1
Received: by mail-ed1-f71.google.com with SMTP id d27so6995111edj.21
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 03:19:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZfmXFWuGpvjNq6cXHlDm0b2WUaUCEmp6aIcoRmPsQQc=;
        b=gJ5RyaMlH62TnkyoJL20WMs4oA22ox29lmPNtESeGb7pwjFkiVc5fEF3ZDAZNF7KMO
         alxv09zvWoJHihAc8ENkMpD97vYLx89/Fjuhj9KMPxVPCGKhc6QVIy9X7zNN4ADyN2RK
         e3+LU4W16PcbDKzarezKHaoRQn+e5fumIzooRbRc9YmyFVdjUPLraOWwOAXKhgNI4Z2Y
         GoUjOOUydMJL0XsBo+vven6zoZoieMP884zP8busg0loIASGvxETIky3btCU4is/2y+u
         35a3XM/3DfThVnTnAKoD6Me5sULCw6D/WZRjGMwEAs6RkcCM51NbE6v3GIpMzuPJ2Gs0
         Xgkw==
X-Gm-Message-State: AOAM5310q1jx/8l6W0mrZXb/9GrUWsJp56pZxQ9RYWYxRgZNtguQsqqM
        3bf0ogMkYMLKKPSQuy3e5mbQwh0UzGK+abCUNHTqr0RzUuyaQIEm3uoO1Atgdi4MRaX3NynOikm
        ypd0oLaQgpRF2PNeb2pAiuqgh
X-Received: by 2002:a17:906:9353:: with SMTP id p19mr9413558ejw.403.1600856376402;
        Wed, 23 Sep 2020 03:19:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxPVx89V1eZbL5cxLXVTc+ANFBUKj6JBoKaRNLXiNnkex3L0pvdHrP2XVqk/yRifa5pnN5u4A==
X-Received: by 2002:a17:906:9353:: with SMTP id p19mr9413545ejw.403.1600856376072;
        Wed, 23 Sep 2020 03:19:36 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id cn21sm13784997edb.14.2020.09.23.03.19.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2020 03:19:35 -0700 (PDT)
Subject: Re: [PATCH v3] Introduce support for Systems Management Driver over
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
References: <20200917065550.127400-1-divya_bharathi@dell.com>
 <2795ca15-59b1-8435-14ef-6e0c1d532b22@redhat.com>
 <DM6PR19MB26361E423C4430923850E1DCFA3A0@DM6PR19MB2636.namprd19.prod.outlook.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <15cedffb-a0a3-a52a-fb6c-cdb674dc0972@redhat.com>
Date:   Wed, 23 Sep 2020 12:19:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <DM6PR19MB26361E423C4430923850E1DCFA3A0@DM6PR19MB2636.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/21/20 8:23 PM, Limonciello, Mario wrote:
>>
>>> +
>>> +		"integer"-type specific properties:
>>> +
>>> +		min_value:	A file that can be read to obtain the lower
>>> +		bound value of the <attr>
>>> +
>>> +		max_value:	A file that can be read to obtain the upper
>>> +		bound value of the <attr>
>>> +
>>> +		scalar_increment:	A file that can be read to obtain the
>>> +		resolution of the incremental value this attribute accepts.
>>> +
>>> +		"string"-type specific properties:
>>> +
>>> +		max_length:	A file that can be read to obtain the maximum
>>> +		length value of the <attr>
>>> +
>>> +		min_length:	A file that can be read to obtain the minimum
>>> +		length value of the <attr>
>>> +
>>> +What:		/sys/devices/platform/dell-wmi-sysman/passwords/
>>> +Date:		December 2020
>>> +KernelVersion:	5.10
>>> +Contact:	Divya Bharathi <Divya.Bharathi@Dell.com>,
>>> +		Mario Limonciello <mario.limonciello@dell.com>,
>>> +		Prasanth KSR <prasanth.ksr@dell.com>
>>> +
>>> +		A BIOS Admin password and System Password can be set, reset or
>>> +		cleared using these attributes. An "Admin" password is used for
>>> +		preventing modification to the BIOS settings. A "System" password
>> is
>>> +		required to boot a machine.
>>> +
>>> +		is_password_set:	A file that can be read
>>> +		to obtain flag to see if a password is set on <attr>
>>> +
>>> +		max_password_length:	A file that can be read to obtain the
>>> +		maximum length of the Password
>>> +
>>> +		min_password_length:	A file that can be read to obtain the
>>> +		minimum length of the Password
>>> +
>>> +		current_password: A write only value used for privileged access
>>> +		such as setting attributes when a system or admin password is set
>>> +		or resetting to a new password
>>> +
>>> +		new_password: A write only value that when used in tandem with
>>> +		current_password will reset a system or admin password.
>>> +
>>> +		Note, password management is session specific. If Admin/System
>>> +		password is set, same password must be writen into current_password
>>> +		file (requied for pasword-validation) and must be cleared once the
>>> +		session	is over. For example,
>>> +			echo "password" > current_password
>>> +			echo "disabled" > TouchScreen/current_value
>>> +			echo "" > current_password
>>
>> So I know this was mentioned before already but one concern I have here
>> is that there is a race where other users with write access to say
>> TouchScreen/current_value
>> may change it between the setting and the clearing of the current_password
>> even if
>> they don't have the password.
> 
> I don't think there is much that can be done here other than move to something atomic
> like sending the password as part of the request.

Right, I'm not saying this scheme is bad per se I just wanted to make
sure that this was brought up and discussed.

> echo "foobar123|enabled" | sudo tee /sys/devices/platform/dell-wmi-sysman/
> 
> That isn't really pretty - and worse you can no longer have a process fetching
> authentication from escrow that is different from your "setter" process.

Note you will likely need some form of IPC, say dbus to your escrow process
anyways to ask it to unlock. So you could just change the "unlock" request
to a "set Camera=Enabled" request and have the process which has access
to the authentication token make the changes itself.

>> This is esp. relevant with containers. I'm not aware about all the intrinsics
>> of
>> sysfs and containers, at a minimum we need to check if it is possible to
>> disallow
>> all writes to the attributes when sysfs is mounted inside a container (so
>> outside of the
>> main filesystem namespace).
> 
> Containers by default mount sysfs as read only unless you use the '--privileged'
> flag.
> 
> https://www.redhat.com/sysadmin/privileged-flag-container-engines

Thanks that is good to know and does address most of my concerns. What I was
wondering about is if we can enforce this in the kernel even for --privileged
containers.  I guess another question would be if we can do that, should we?

Regards,

Hans

