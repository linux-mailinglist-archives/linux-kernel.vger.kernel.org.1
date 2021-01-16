Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE7E62F8D55
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 13:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbhAPMiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 07:38:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36319 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726018AbhAPMiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 07:38:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610800591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p/hW3UDH3Mt+qMjiOhDxhyq+alcWmdFGAsYWy1szuU8=;
        b=X788SEL45I53pAZDHkq185e2cwJ/oItmKlZuS7irF1G0xk04Rmk1CzUtb2RItjRATM8Ft3
        JqBAPHn8rTzkche1HqLKK5KpLz/ULUrlgKoTk2i7ck8SzIuCi1zBP/RZjhz9cGcyLSs3fF
        acI5TvJBVJE916nj4GxBRDl+Y4OxY9g=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-twNNAl2iPJ2dln-L7WuR4g-1; Sat, 16 Jan 2021 07:36:30 -0500
X-MC-Unique: twNNAl2iPJ2dln-L7WuR4g-1
Received: by mail-ed1-f72.google.com with SMTP id f19so5284974edq.20
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jan 2021 04:36:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p/hW3UDH3Mt+qMjiOhDxhyq+alcWmdFGAsYWy1szuU8=;
        b=OwwEhpKq90H602SS6u4JVNTAbHIVhDllogtxEbp+4bj9Yai2cm8nlnmsI4wJaPwHgC
         Wp5x6wMEx9djC/TX71wIN8nlgC82QdQxi7/ca69ZqzJmCiyfDUR6ReOjWzxZ07Q08ed8
         Cki/EnMi5F1/vyzhhh/QdBit9AcBgxb6BfA6K3IzfEl9sqXMxTXI0E3s4NwGXkD885jN
         JDF3kdSIpMKJYAOtQrn3a38PpsW70wv/bv9bovM5Ttg8FNZSWlunTRaFK9SisK5TF1Iv
         TC3Q4Acguy7dSjKzVYYpu8/Id3FLoGD3Gi5lGWSKo+DAIoUTEl74tgn1A+2EFHa5AqvE
         lFqQ==
X-Gm-Message-State: AOAM531ZU9O/BADWNwQAdYseb59VrXrzPrBa7VVYS5Dvj3KbJxp67fiL
        ZmBXxNP0opHaoSRix4WqIHasWjTS7K53eXHhSkw3nFsFGZZCfkrWoTv5IaTA84EYNdyjYLoRv1C
        J/Urlg/HRRRJUfaBo93JCdaY8
X-Received: by 2002:aa7:cd44:: with SMTP id v4mr13245289edw.156.1610800588968;
        Sat, 16 Jan 2021 04:36:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy6sfd3skgtXMX3K0NcltTHfd1eDkWSBYRb5dIgmFvrNR1iPf56gxLl6J4bo+5TtlNTkGD6JQ==
X-Received: by 2002:aa7:cd44:: with SMTP id v4mr13245283edw.156.1610800588844;
        Sat, 16 Jan 2021 04:36:28 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id s4sm830187ejc.14.2021.01.16.04.36.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Jan 2021 04:36:28 -0800 (PST)
Subject: Re: [PATCH v1 2/2] ACPI: scan: Adjust white space in
 acpi_device_add()
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <3494203.VBaj39JGmp@kreacher> <8659794.ROA1lt5W1e@kreacher>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <42424760-6c02-7480-e38a-f1d66b447742@redhat.com>
Date:   Sat, 16 Jan 2021 13:36:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <8659794.ROA1lt5W1e@kreacher>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/14/21 7:47 PM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Add empty lines in some places in acpi_device_add() to help
> readability and drop leading spaces before the labels in there.
> 
> No functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/acpi/scan.c |    9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> Index: linux-pm/drivers/acpi/scan.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/scan.c
> +++ linux-pm/drivers/acpi/scan.c
> @@ -692,10 +692,12 @@ int acpi_device_add(struct acpi_device *
>  
>  	if (device->wakeup.flags.valid)
>  		list_add_tail(&device->wakeup_list, &acpi_wakeup_device_list);
> +
>  	mutex_unlock(&acpi_device_lock);
>  
>  	if (device->parent)
>  		device->dev.parent = &device->parent->dev;
> +
>  	device->dev.bus = &acpi_bus_type;
>  	device->dev.release = release;
>  	result = device_add(&device->dev);
> @@ -711,16 +713,19 @@ int acpi_device_add(struct acpi_device *
>  
>  	return 0;
>  
> - err:
> +err:
>  	mutex_lock(&acpi_device_lock);
> +
>  	if (device->parent)
>  		list_del(&device->node);
> +
>  	list_del(&device->wakeup_list);
>  
> - err_unlock:
> +err_unlock:
>  	mutex_unlock(&acpi_device_lock);
>  
>  	acpi_detach_data(device->handle, acpi_scan_drop_device);
> +
>  	return result;
>  }
>  
> 
> 
> 

