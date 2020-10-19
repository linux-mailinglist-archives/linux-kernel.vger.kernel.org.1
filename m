Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22FD0292DCC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 20:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730845AbgJSSwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 14:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727681AbgJSSwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 14:52:34 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F775C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 11:52:32 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id m22so675957ots.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 11:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wwPRXAaMYxjFqM/YIzNWQCJWcq2FDVHsw8/2EBq/9VU=;
        b=QXyH1Uoh0HaPVS3ogACUfZSrONjtnanEi7sYkrOLGnRqNeDWL0KFCnPyRn4EDO091X
         gCFc2qpmlsYMAORzxra1AkYBosy1H29fHnn3M3o1wgkDOYQ58pTQ4sZg+aiqsI4YxZru
         Rt085B2812Ju/Od92PjjFINlzvZn7chwiyltU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wwPRXAaMYxjFqM/YIzNWQCJWcq2FDVHsw8/2EBq/9VU=;
        b=LeaYYu1KlfH9aspQ3j/ZuXaLMl+CtPZ7CbHv8UpLajwI8qrWEkQccWTQlyxOV3NFBc
         T2u8TBnjgcNCp9Urg4L8501TMD/Hf/43nuTVGPnkYhl0Dycv4/ucSHuoan8Iaj2XtSea
         +ZwBSkXm/gOwdALGe1s2Gey3J6luaShd6RwcMBI158V61K8VEpqcz53s8a8E24w26TxP
         lw0C/dtSH9i9Uy5UukBmiKZuLSbuKvvgPqV61nwOU+Z1G+b0eC7VwPrPkwABseIaeRPa
         5W4nArnrutTJoKIPsDLifOwIpo9YtfRx2MApY41qgZbPuE34X24MLemffDxaj/HABYHH
         Mnrg==
X-Gm-Message-State: AOAM5334dzsflgNrjAVoGpeWMiNOXpwpLGkF+SGiDERgTDj0IlTC3zrx
        pBVUInEMw455qT14Leoh0eH2Bg==
X-Google-Smtp-Source: ABdhPJzdSd2LvaOxu/5mKLj3tQrTLEdoRYuVpFdhu/ztrTOVEnY3w1zEPrR9+Jpu4jkJD8gDRtkUJA==
X-Received: by 2002:a05:6830:19d9:: with SMTP id p25mr997145otp.135.1603133551820;
        Mon, 19 Oct 2020 11:52:31 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id x15sm201142oor.33.2020.10.19.11.52.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2020 11:52:31 -0700 (PDT)
Subject: Re: [PATCH v3] kcov, usbip: collect coverage from vhci_rx_loop
To:     Andrey Konovalov <andreyknvl@google.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        Nazime Hande Harputluoglu <handeharput@gmail.com>,
        Nazime Hande Harputluoglu <handeharputlu@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <e626ad10573bdc561c6f00667a31c87ee7725044.1603127827.git.andreyknvl@google.com>
 <ca9c83b0-364a-6a26-4539-e38373a455aa@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <2ee45dd7-0735-fcbb-545c-352d9c5d8689@linuxfoundation.org>
Date:   Mon, 19 Oct 2020 12:52:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <ca9c83b0-364a-6a26-4539-e38373a455aa@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/20 12:49 PM, Shuah Khan wrote:
> On 10/19/20 11:20 AM, Andrey Konovalov wrote:
>> From: Nazime Hande Harputluoglu <handeharputlu@google.com>
>>
>> Add kcov_remote_start()/kcov_remote_stop() annotations to the
>> vhci_rx_loop() function, which is responsible for parsing USB/IP packets
>> coming into USB/IP client.
>>
>> Since vhci_rx_loop() threads are spawned per vhci_hcd device instance, 
>> the
>> common kcov handle is used for kcov_remote_start()/stop() annotations
>> (see Documentation/dev-tools/kcov.rst for details). As the result kcov
>> can now be used to collect coverage from vhci_rx_loop() threads.
>>
>> Signed-off-by: Nazime Hande Harputluoglu <handeharputlu@google.com>
>> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>> ---
>>
>> Changes v2->v3:
>> - Fix build without KCOV enabled.
>>
>> ---
>>   drivers/usb/usbip/usbip_common.h | 4 ++++
>>   drivers/usb/usbip/vhci_rx.c      | 7 +++++++
>>   drivers/usb/usbip/vhci_sysfs.c   | 4 ++++
>>   3 files changed, 15 insertions(+)
>>
>> diff --git a/drivers/usb/usbip/usbip_common.h 
>> b/drivers/usb/usbip/usbip_common.h
>> index 8be857a4fa13..0906182011d6 100644
>> --- a/drivers/usb/usbip/usbip_common.h
>> +++ b/drivers/usb/usbip/usbip_common.h
>> @@ -277,6 +277,10 @@ struct usbip_device {
>>           void (*reset)(struct usbip_device *);
>>           void (*unusable)(struct usbip_device *);
>>       } eh_ops;
>> +
>> +#ifdef CONFIG_KCOV
>> +    u64 kcov_handle;
>> +#endif
>>   };
>>   #define kthread_get_run(threadfn, data, namefmt, ...)               \
>> diff --git a/drivers/usb/usbip/vhci_rx.c b/drivers/usb/usbip/vhci_rx.c
>> index 266024cbb64f..68ec0aa64f69 100644
>> --- a/drivers/usb/usbip/vhci_rx.c
>> +++ b/drivers/usb/usbip/vhci_rx.c
>> @@ -3,6 +3,7 @@
>>    * Copyright (C) 2003-2008 Takahiro Hirofuchi
>>    */
>> +#include <linux/kcov.h>
>>   #include <linux/kthread.h>
>>   #include <linux/slab.h>
>> @@ -261,7 +262,13 @@ int vhci_rx_loop(void *data)
>>           if (usbip_event_happened(ud))
>>               break;
>> +#ifdef CONFIG_KCOV
>> +        kcov_remote_start_common(ud->kcov_handle);
>> +#endif
>>           vhci_rx_pdu(ud);
>> +#ifdef CONFIG_KCOV
>> +        kcov_remote_stop();
>> +#endif
>>       }
> 
> Let's move these into usbip_common.h as inline functions along
> the line of
> 
> #ifdef CONFIG_KCOV
> usbip_kcov_remote_start_common(ud)
> {
>    kcov_remote_start_common(ud->kcov_handle);
> }
> 
> usbip_kcov_remote_stop_common(ud)
> {
>    kcov_remote_stop_common(ud->kcov_handle);
> }
> #else
> stubs that do nothing
> #endif
> 
>>       return 0;
>> diff --git a/drivers/usb/usbip/vhci_sysfs.c 
>> b/drivers/usb/usbip/vhci_sysfs.c
>> index be37aec250c2..e167b8a445ad 100644
>> --- a/drivers/usb/usbip/vhci_sysfs.c
>> +++ b/drivers/usb/usbip/vhci_sysfs.c
>> @@ -4,6 +4,7 @@
>>    * Copyright (C) 2015-2016 Nobuo Iwata
>>    */
>> +#include <linux/kcov.h>
>>   #include <linux/kthread.h>
>>   #include <linux/file.h>
>>   #include <linux/net.h>
>> @@ -383,6 +384,9 @@ static ssize_t attach_store(struct device *dev, 
>> struct device_attribute *attr,
>>       vdev->ud.sockfd     = sockfd;
>>       vdev->ud.tcp_socket = socket;
>>       vdev->ud.status     = VDEV_ST_NOTASSIGNED;
>> +#ifdef CONFIG_KCOV
>> +    vdev->ud.kcov_handle = kcov_common_handle();
>> +#endif
> 
> 
> Same here add a usbip_kcov_handle_init(ud)
> 

btw - I am seeing bounces on handeharputlu@google.com address.

thanks,
-- Shuah
