Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D62E929C27D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 18:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1820632AbgJ0Rgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 13:36:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28736 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1760830AbgJ0Ogk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 10:36:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603809398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ug8vzX663gR3NE8oqRQHPCaGbnO8Nn0snBXYCYT+1IE=;
        b=XvG2s/bh2ihGIYPx9GN3/NGJPFDM/j5OyNtodP13bhLiz1rb4RzrZTG0ODga0vVhFPtxf6
        g07fUvXJNvPNUCVWuXpNh3Ont83XjRzvvR73rS3LthAEaK9VrAC2BHuvWfpKigr5Xysre8
        Dvp+cd7rfYFqXAR87SFclzqSVs7Q6XA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-abSmJRqgOg2Q3rPhpTLizw-1; Tue, 27 Oct 2020 10:36:36 -0400
X-MC-Unique: abSmJRqgOg2Q3rPhpTLizw-1
Received: by mail-ed1-f71.google.com with SMTP id b16so773798edn.6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 07:36:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ug8vzX663gR3NE8oqRQHPCaGbnO8Nn0snBXYCYT+1IE=;
        b=nYL6fuDIkhSegAHaeratufmbfbVB5K8TBpDWX4JMt8fx4xt2bb7NCLr4d4VA9O4qvN
         hA4SI/5MReCxAffd80Zzq7Z/n5xnRI5fLV85qoTkO6fhlBhVjh4f74+4xgbK2FZDXGb1
         FEJahYVd4pZpWzgQxsXC5IAy7kDzFSOWHpHYEFdGrETbhHdqA3zHFlEiTLB6/mnRjhyc
         NeHu0lS0mQe+8dpHjqCv0/nXJSsgvZimfgln5jxgddVV9VcNL5gBqwKIS/ppBnjmMqpr
         RXq5xR68JjgLnGD2XWtWnePF+0bb4AXY4SBcenV63CpapZmqbyVEPewihjbw+ASC6Eqh
         IIYg==
X-Gm-Message-State: AOAM5339fYtXMlIPonqSxVglCvBHsUi2/Smz3Oza6dijKb6lfy53npLi
        VvfhHvwCEJUDEwLi86ZSd+nfhgKMNteq/V87HGd5tDGG3glxZQOmaFyCfaC2TuOhVCCUJlP+Kc4
        ZTeA9yLZjFbrHwoIFpYbt5Y7G
X-Received: by 2002:aa7:c815:: with SMTP id a21mr2531640edt.166.1603809395207;
        Tue, 27 Oct 2020 07:36:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyaYi64qtz7uB4mxOVc/QA3cIK6821annqrLaJPpuMj3ZGZl0sXWYqOFXnLYNdfauqIPbwfnw==
X-Received: by 2002:aa7:c815:: with SMTP id a21mr2531620edt.166.1603809395007;
        Tue, 27 Oct 2020 07:36:35 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id dm8sm1121656edb.57.2020.10.27.07.36.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 07:36:34 -0700 (PDT)
Subject: Re: [PATCH] Revert "platform/x86: wmi: Destroy on cleanup rather than
 unregister"
To:     Yongxin Liu <yongxin.liu@windriver.com>, andy@infradead.org,
        dvhart@infradead.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mario.limonciello@dell.com
References: <20191115052710.46880-1-yongxin.liu@windriver.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <ee964f27-e038-931d-803a-dbcb9e0566dd@redhat.com>
Date:   Tue, 27 Oct 2020 15:36:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20191115052710.46880-1-yongxin.liu@windriver.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Quick self intro: I have take over drivers/platform/x86
maintainership from Andy; and I'm working my way through
the backlog of old patches in patchwork:
https://patchwork.kernel.org/project/platform-driver-x86/list/

On 11/15/19 6:27 AM, Yongxin Liu wrote:
> This reverts commit 7b11e8989618581bc0226ad313264cdc05d48d86.
> 
> Consider the following hardware setting.
> 
> |-PNP0C14:00
> |  |-- device #1
> |-PNP0C14:01
> |  |-- device #2
> 
> When unloading wmi driver module, device #2 will be first unregistered.
> But device_destroy() using MKDEV(0, 0) will locate PNP0C14:00 first
> and unregister it. This is incorrect. Should use device_unregister() to
> unregister the real parent device.
> 
> Signed-off-by: Yongxin Liu <yongxin.liu@windriver.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up there once I've pushed my local branch there,
which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans

> ---
>  drivers/platform/x86/wmi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> index 59e9aa0f9643..e16f660aa117 100644
> --- a/drivers/platform/x86/wmi.c
> +++ b/drivers/platform/x86/wmi.c
> @@ -1347,7 +1347,7 @@ static int acpi_wmi_remove(struct platform_device *device)
>  	acpi_remove_address_space_handler(acpi_device->handle,
>  				ACPI_ADR_SPACE_EC, &acpi_wmi_ec_space_handler);
>  	wmi_free_devices(acpi_device);
> -	device_destroy(&wmi_bus_class, MKDEV(0, 0));
> +	device_unregister((struct device *)dev_get_drvdata(&device->dev));
>  
>  	return 0;
>  }
> @@ -1401,7 +1401,7 @@ static int acpi_wmi_probe(struct platform_device *device)
>  	return 0;
>  
>  err_remove_busdev:
> -	device_destroy(&wmi_bus_class, MKDEV(0, 0));
> +	device_unregister(wmi_bus_dev);
>  
>  err_remove_notify_handler:
>  	acpi_remove_notify_handler(acpi_device->handle, ACPI_DEVICE_NOTIFY,
> 

