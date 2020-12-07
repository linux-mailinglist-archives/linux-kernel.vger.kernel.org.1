Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3459A2D1870
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 19:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726459AbgLGSXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 13:23:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45064 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726102AbgLGSXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 13:23:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607365314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9sdDUmxzObkvlmtgXKPhQxtpEVX8JbdclTJVfFITbFQ=;
        b=KSCCZVzuiSnQdYHVsbxa7OSvyWD/O9GyiTAxEeh3YI3nayOj+sA9OInRtCv/NNiGtLjMxC
        msRpWo5QMMeizWuoC/R8Kjbyylz5jLHShOgdvSDqyqtG+n63or6x8OJQ9Mac1dZj14knA3
        q0ZohvSNza5kyhNKee+dmnN1S03x65k=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-HzzdBzWLNWSyBfoyUQ96QA-1; Mon, 07 Dec 2020 13:21:52 -0500
X-MC-Unique: HzzdBzWLNWSyBfoyUQ96QA-1
Received: by mail-ej1-f71.google.com with SMTP id ny19so3333881ejb.10
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 10:21:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9sdDUmxzObkvlmtgXKPhQxtpEVX8JbdclTJVfFITbFQ=;
        b=C1t76XVawARKMgQmrgXNcwNcN6jPBpbwFO0whbn+9+C6dEcvg1H83FCqkw83+ykt8w
         w+juZjG/VjIAz1hSFY8V7izsYb3H4TVpx8ssxEj0ZJZ+L7aaAaUCNqW16mlUfKllHQ0R
         RGiKs7kSVSO09tW/3t59u9GEfdg4a14zsilGeahX81+OgKh2EeRE9ptlu7LFHPcosoyx
         3u30bQo9xqwpvXBH1l++bbEtHSULcDhIpHVNJfE8ZsUtban6bVCqAxwtnH2Dyrz+UbzD
         dXalD1Lb5Or4LWvzYpZo0y9/EbivOZZDc3PGs0oIfsvvdFukXedMeJKAcGdRzXLWNP70
         LSaQ==
X-Gm-Message-State: AOAM53342LgMNDZLKQSwoJpvMgq1sgUrSTUEz27YN3mUZjh/U7XCcrCm
        Vu3QvHgEXp1+DUcJg3u3EztHNpOnL9U2PVBbYoIj6XjGI1D4bK8rsxaPtyw5Ev/RYsWvYIVpd/S
        4ABK/baXP5kslwbo1xignF9lA
X-Received: by 2002:a17:906:4bd2:: with SMTP id x18mr19721833ejv.464.1607365311272;
        Mon, 07 Dec 2020 10:21:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJysF62b/9EGmsRFN0aGkV9U90I0qPEfB39SdKUggYcDeLV+AkT7k5X5iH/EBJ9lML6lAu1cSg==
X-Received: by 2002:a17:906:4bd2:: with SMTP id x18mr19721820ejv.464.1607365311099;
        Mon, 07 Dec 2020 10:21:51 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id u5sm14291209edp.5.2020.12.07.10.21.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Dec 2020 10:21:50 -0800 (PST)
Subject: Re: [PATCH] ACPI: scan: Fix up _DEP-related terminology with
 supplier/consumer
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
References: <6314382.p3e4rEhblS@kreacher>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <054cc790-bebb-9c84-e14c-16b9460d1636@redhat.com>
Date:   Mon, 7 Dec 2020 19:21:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <6314382.p3e4rEhblS@kreacher>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/7/20 6:46 PM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The ACPI namespace scanning code uses the terms master/slave when
> populating the list of _DEP dependencies, but that use has no
> external exposures and is not mandated by nor associated with any
> external specifications.
> 
> Change the language used through-out to supplier/consumer.
> 
> No functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/acpi/scan.c |   12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> Index: linux-pm/drivers/acpi/scan.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/scan.c
> +++ linux-pm/drivers/acpi/scan.c
> @@ -51,8 +51,8 @@ static u64 spcr_uart_addr;
>  
>  struct acpi_dep_data {
>  	struct list_head node;
> -	acpi_handle master;
> -	acpi_handle slave;
> +	acpi_handle supplier;
> +	acpi_handle consumer;
>  };
>  
>  void acpi_scan_lock_acquire(void)
> @@ -1881,8 +1881,8 @@ static void acpi_device_dep_initialize(s
>  		if (!dep)
>  			return;
>  
> -		dep->master = dep_devices.handles[i];
> -		dep->slave  = adev->handle;
> +		dep->supplier = dep_devices.handles[i];
> +		dep->consumer  = adev->handle;
>  		adev->dep_unmet++;
>  
>  		mutex_lock(&acpi_dep_list_lock);
> @@ -2058,8 +2058,8 @@ void acpi_walk_dep_device_list(acpi_hand
>  
>  	mutex_lock(&acpi_dep_list_lock);
>  	list_for_each_entry_safe(dep, tmp, &acpi_dep_list, node) {
> -		if (dep->master == handle) {
> -			acpi_bus_get_device(dep->slave, &adev);
> +		if (dep->supplier == handle) {
> +			acpi_bus_get_device(dep->consumer, &adev);
>  			if (!adev)
>  				continue;
>  
> 
> 
> 

