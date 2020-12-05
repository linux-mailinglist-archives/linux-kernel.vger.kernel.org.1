Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA6E2CFC7E
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 19:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730343AbgLEST7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 13:19:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44172 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728343AbgLESE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 13:04:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607191375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ngbQFaYupjBC+H+tboAOi4kI6aZEZIqf728BmBL002o=;
        b=It3CLJ5wQw7T6iQ0EhF/stbl6MWLxpbmkzQCUIkaEYRFYbYwWxXUp+pQp08FMillnIFCEp
        Rmdt2eWoVnUwjk/9TcRgSsW4c48aWsw2iPa5F0xjwUTqg1+WV6PmRpR0Anp3/XiQEZizx8
        NYHuIKMqXBeIpeOjp//k8X/H7oM3vg8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-I3jGSrvnOmyQQlb5WY3qzQ-1; Sat, 05 Dec 2020 10:34:48 -0500
X-MC-Unique: I3jGSrvnOmyQQlb5WY3qzQ-1
Received: by mail-ed1-f69.google.com with SMTP id u18so3655047edy.5
        for <linux-kernel@vger.kernel.org>; Sat, 05 Dec 2020 07:34:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ngbQFaYupjBC+H+tboAOi4kI6aZEZIqf728BmBL002o=;
        b=EW5k4vjxVXf68NcoDrt/K8OgG3m52HmFfWIyv/3jG9DWlr+Uwjae0C6V+lGfDY+SRd
         k425iMtOUTcniOHpVaP1OSV3iHaZASObKdhNre55M0MT7WQqwd+76y6wjtVtT8PqP1d5
         A/64u0isNiIRlC2c6Tj1ohY7E6jRrJGwq2vwuIY+H76ZKbIndIUcq5EbDnps2xq3T3+w
         UBE7/aP6XVitwwi6gkHx8Iet6TeQ85rQt39RQRaB9yk7vNH4S4krXGkNCcuGanXglTt4
         O9CPnjGWekr8vt6XnCkdLcfvn2coxNa5y5WtKjkS6gfeJJevA6uev/WaS7KAAmxYc2V7
         hVMA==
X-Gm-Message-State: AOAM5326vlNMYFdR/lZQwiuTuEPIrNNdBUTVcVNjZlIIBe0qMhlW8S7t
        FukesnhdqKyKRBdIicx5zSeAW8oyPUu7jrNjyew7KFx5DI1hprI6aaUCU6KYq+WyjWJbeQXHkXQ
        AoQvyjU2KU9psC/BA/bZZwzte
X-Received: by 2002:a05:6402:8cc:: with SMTP id d12mr12372033edz.0.1607182487237;
        Sat, 05 Dec 2020 07:34:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwYPmjObSWDGzOcfnFCRrago04hStbb9gkJSWAB21feYry+hxhfXvJ/UUwB6qTP3ITLvN7nEA==
X-Received: by 2002:a05:6402:8cc:: with SMTP id d12mr12372021edz.0.1607182487069;
        Sat, 05 Dec 2020 07:34:47 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id p91sm5921160edp.9.2020.12.05.07.34.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Dec 2020 07:34:46 -0800 (PST)
Subject: Re: [PATCH] ACPI: scan: Add PNP0D80 to the _DEP exceptions list
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        David Box <david.e.box@linux.intel.com>
References: <3849919.JfvvSOo2yN@kreacher>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <52a2b98c-6bf3-760b-eca9-93cf05fb4877@redhat.com>
Date:   Sat, 5 Dec 2020 16:34:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <3849919.JfvvSOo2yN@kreacher>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/5/20 4:29 PM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The PNP0D80 ("Windows-compatible System Power Management Controller")
> device ID is used for identifying the special device object providing
> the LPI (Low-power S0 Idle) _DSM interface [1].  That device object
> does not supply any operation regions, but it appears in _DEP lists
> for other devices in the ACPI tables on some systems to enforce
> specific enumeration ordering that does not matter in Linux.
> 
> For this reason, _DEP list entries pointing to the device object whose
> _CID returns PNP0D80 need not be taken into account as real operation
> region dependencies, so add that device ID to the list of device IDs
> for which the matching _DEP list entries should be ignored.
> 
> Accordingly, update the function used for matching device IDs in that
> list to allow it to check _CID as well as _HID and rename it to
> acpi_info_matches_ids().
> 
> Link: https://www.uefi.org/sites/default/files/resources/Intel_ACPI_Low_Power_S0_Idle.pdf # [1]
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thank you for doing this, I contemplated doing the exact same
thing but never got around to it.

One small review remark inline:

> ---
>  drivers/acpi/scan.c |   27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
> 
> Index: linux-pm/drivers/acpi/scan.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/scan.c
> +++ linux-pm/drivers/acpi/scan.c
> @@ -719,25 +719,40 @@ int acpi_device_add(struct acpi_device *
>  /* --------------------------------------------------------------------------
>                                   Device Enumeration
>     -------------------------------------------------------------------------- */
> -static bool acpi_info_matches_hids(struct acpi_device_info *info,
> -				   const char * const hids[])
> +static bool acpi_info_matches_ids(struct acpi_device_info *info,
> +				  const char * const ids[])
>  {
> +	struct acpi_pnp_device_id_list *cid_list = NULL;
>  	int i;
>  
>  	if (!(info->valid & ACPI_VALID_HID))
>  		return false;
>  
> -	for (i = 0; hids[i]; i++) {
> -		if (!strcmp(info->hardware_id.string, hids[i]))
> +	if (info->valid & ACPI_VALID_CID)
> +		cid_list = &info->compatible_id_list;
> +
> +	for (i = 0; ids[i]; i++) {
> +		int j;
> +
> +		if (!strcmp(info->hardware_id.string, ids[i]))
>  			return true;
> +
> +		if (!cid_list)
> +			continue;
> +
> +		for (j = 0; j < cid_list->count; j++) {
> +			if (!strcmp(cid_list->ids[j].string, ids[i]))
> +				return true;
> +		}
>  	}
>  
>  	return false;
>  }
>  
>  /* List of HIDs for which we ignore matching ACPI devices, when checking _DEP lists. */
> -static const char * const acpi_ignore_dep_hids[] = {
> +static const char * const acpi_ignore_dep_ids[] = {
>  	"INT3396", /* Windows System Power Management Controller */

I think this one can be dropped now, I checked my acpidump / dsdt.dsl
collection and 45/45 DSDTs declaring a _HID of INT3396 also added a _CID of
PNP0D80 to this.

Regards,

Hans


> +	"PNP0D80", /* Windows-compatible System Power Management Controller */
>  	NULL
>  };
>  
> @@ -1857,7 +1872,7 @@ static void acpi_device_dep_initialize(s
>  			continue;
>  		}
>  
> -		skip = acpi_info_matches_hids(info, acpi_ignore_dep_hids);
> +		skip = acpi_info_matches_ids(info, acpi_ignore_dep_ids);
>  		kfree(info);
>  
>  		if (skip)
> 
> 
> 

