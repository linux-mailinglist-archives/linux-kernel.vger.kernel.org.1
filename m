Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 203272FDC30
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 23:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbhATV70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 16:59:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53363 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388956AbhATVzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 16:55:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611179615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qkj5MTn4PqAHlxRkP6Nm9pU0Bj533hacC35Vuu/cJN4=;
        b=BNnh+kRuLhHwo+qV+Dg08h346hWm8UeR6pHb3z6YWptboVwiZLUuYJutc7wLSUhyRUy8+6
        4OfGc9tnV4X1E5M1KIS9rVyxjiSWmxf1ljByhBt4hBCdXFlms8H2dQ/TZxLwclJglujv4l
        Po0N6iTmNrc0DMN9/WZ+1+mWj4Ytl8c=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-FThySIhmOPaQXBAe_-qfog-1; Wed, 20 Jan 2021 16:53:33 -0500
X-MC-Unique: FThySIhmOPaQXBAe_-qfog-1
Received: by mail-ed1-f70.google.com with SMTP id e25so43841edq.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 13:53:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Qkj5MTn4PqAHlxRkP6Nm9pU0Bj533hacC35Vuu/cJN4=;
        b=HWIPuxuOxoWjL244mF63Mc4w0hpw+8qJnDVnpz2R8HimM8bLhUaNVv0PKGDaYXkLze
         ejqgFWqThDb5qhEihsPNzn8RBwP1lbiJYnBXhY6AQAXZHvjxDWsIgugPe2XxM5bcp3I5
         dymvZX0iZGeHWqDi2G8zXmhP1hcAdY+aFCOpExddL2T3nrGL2FwY10vUDDQkQNJ37MP2
         qPcnI01HqCPyOJ+wP1Vqa6nb2z0Kg0nXS8vWbtqqH6+ceuyjupglu1rKb4R7c9dcIlmR
         WWZM5nFkhEJzjSs6vJKujX/ecvyxg1/shaEK2HaRUxzZB9WLRJf1yY7aLTM05ADk1QnA
         qcVA==
X-Gm-Message-State: AOAM531ttZXjyyBtPJBczkChyOvB1BKIEsPHNFnzmZ8jAKgwXXXm/KoF
        qV/3r0s+Uv+sim3hsV3bxRl/vsm8/EJY2AlyfzI0nsDKuRBitU80oDzJ953noQnfvwv/8AtB/T0
        z7pC7bqwTW3w5hCKYXtyzjLSOTafAbZxnt35g5pUx5VkkA8VmS9JlUS3aILoOGsTR6RCyy8rD+X
        lD
X-Received: by 2002:a17:907:96a2:: with SMTP id hd34mr7649441ejc.494.1611179611876;
        Wed, 20 Jan 2021 13:53:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzI3lxgxiq/yVQUuFKTdqZdIG+IDBHyajT8lNqTn0fRfhXoFS1SjkyS+YoPp+jyqVVTfDye6w==
X-Received: by 2002:a17:907:96a2:: with SMTP id hd34mr7649432ejc.494.1611179611693;
        Wed, 20 Jan 2021 13:53:31 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id j18sm1410893ejv.18.2021.01.20.13.53.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 13:53:30 -0800 (PST)
Subject: Re: [PATCH] ACPI: scan: Rearrange code related to
 acpi_get_device_data()
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <3445520.6OZ3MRzmT7@kreacher>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <d6dcb0cc-ff6a-3b71-55a2-d965cd8a290c@redhat.com>
Date:   Wed, 20 Jan 2021 22:53:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <3445520.6OZ3MRzmT7@kreacher>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/18/21 8:25 PM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> There are two callers of acpi_get_device_data(), acpi_bus_get_device()
> and acpi_bus_get_acpi_device(), but only one of them takes the int
> return value into account.  Moreover, the latter knows that it passes
> a valid return pointer to acpi_get_device_data() and it properly
> clears that pointer upfront, so it doesn't need acpi_get_device_data()
> to do that.
> 
> For this reason, rearrange acpi_get_device_data() to return a strct
> acpi_device pointer instead of an int and adapt its callers to that.
> 
> While at it, rename acpi_get_device_data() to handle_to_device(),
> because the old name does not really reflect the functionality
> provided by that function.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Nice cleanup, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
> 
> On top of https://patchwork.kernel.org/project/linux-acpi/patch/20210115215752.389656-1-hdegoede@redhat.com/
> 
> ---
>  drivers/acpi/scan.c |   35 +++++++++++++++++------------------
>  1 file changed, 17 insertions(+), 18 deletions(-)
> 
> Index: linux-pm/drivers/acpi/scan.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/scan.c
> +++ linux-pm/drivers/acpi/scan.c
> @@ -578,29 +578,31 @@ static void acpi_scan_drop_device(acpi_h
>  	mutex_unlock(&acpi_device_del_lock);
>  }
>  
> -static int acpi_get_device_data(acpi_handle handle, struct acpi_device **device,
> -				void (*callback)(void *))
> +static struct acpi_device *handle_to_device(acpi_handle handle,
> +					    void (*callback)(void *))
>  {
> +	struct acpi_device *adev = NULL;
>  	acpi_status status;
>  
> -	if (!device)
> -		return -EINVAL;
> -
> -	*device = NULL;
> -
>  	status = acpi_get_data_full(handle, acpi_scan_drop_device,
> -				    (void **)device, callback);
> -	if (ACPI_FAILURE(status) || !*device) {
> -		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "No context for object [%p]\n",
> -				  handle));
> -		return -ENODEV;
> +				    (void **)&adev, callback);
> +	if (ACPI_FAILURE(status) || !adev) {
> +		acpi_handle_debug(handle, "No context!\n");
> +		return NULL;
>  	}
> -	return 0;
> +	return adev;
>  }
>  
>  int acpi_bus_get_device(acpi_handle handle, struct acpi_device **device)
>  {
> -	return acpi_get_device_data(handle, device, NULL);
> +	if (!device)
> +		return -EINVAL;
> +
> +	*device = handle_to_device(handle, NULL);
> +	if (!*device)
> +		return -ENODEV;
> +
> +	return 0;
>  }
>  EXPORT_SYMBOL(acpi_bus_get_device);
>  
> @@ -612,10 +614,7 @@ static void get_acpi_device(void *dev)
>  
>  struct acpi_device *acpi_bus_get_acpi_device(acpi_handle handle)
>  {
> -	struct acpi_device *adev = NULL;
> -
> -	acpi_get_device_data(handle, &adev, get_acpi_device);
> -	return adev;
> +	return handle_to_device(handle, get_acpi_device);
>  }
>  
>  void acpi_bus_put_acpi_device(struct acpi_device *adev)
> 
> 
> 

