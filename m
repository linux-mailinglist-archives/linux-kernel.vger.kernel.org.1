Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B54BA2D136B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 15:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbgLGOS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 09:18:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46084 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727201AbgLGOSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 09:18:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607350619;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s53RZYILsGtwM83jxx1xgqBZlFTvrwRxd01Lxzro7PM=;
        b=hkkBDe0AFrrPx2NK7E4Q+ymENtv6QGWUrjADhOSaT2erPXQ5BZk6ceyvBgjZm+0PUp53cX
        WiW4MBcEsLz1e5Q8W8H+8600jQa/s4dwLERID6Q9qmqLwMn0VpSdlFdGXrWsEO6rf9/9mL
        G1Jw/HLpDe8qtHnyZAVPgV1jszu/ZfE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-95R0JqmcMRaFVBIV0K3pvQ-1; Mon, 07 Dec 2020 09:16:57 -0500
X-MC-Unique: 95R0JqmcMRaFVBIV0K3pvQ-1
Received: by mail-ed1-f69.google.com with SMTP id ca7so5875003edb.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 06:16:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s53RZYILsGtwM83jxx1xgqBZlFTvrwRxd01Lxzro7PM=;
        b=Amzpf4vA7O8MLTPw4GocqvS+wgkVoOfu+32KtzQ2jSLPdbx0ULT4AOazivQcbzSlq6
         0YmYyR7Of35HfY/Ydv53TThJJ3JbeS6Mp0STlaxjn6WwbEgCMjHO+yr8LnyvnXOjSFcm
         ex7gMgJG8cWBTzEkX4OsROsrszBPwjeCQFnE01am0YNeXM5hqzyyuzlV8LScu0Psd3qz
         38KkPDylOyTZy+S/AJN9S+Tv/3+Zc8YQ36hpoP19p66jFlLseCgkHvqTZ8sOHI60F7fO
         KKaQcWBslFwDKZyKt36UQkuqVED1NQpk71nS6KJ8FkBPxQr3BYu4j0eHyIPvFKzNkREz
         3QZg==
X-Gm-Message-State: AOAM530hOsLFZopa3bfTBmyDbstfZRyq+qNfVZ9nxQ3m2Aifx9JJv2cU
        O1dgLKWiGvj5mQOLvVPAjDwMpZZ0uatQJT+rRXu+JOl2+tNOg1Na4yG60qrenA9JVBwc3Bzuw3A
        kCZLzx0ZyjaJrCRsZKBDy2j49ibdkAornOqeToC9pHNTjR+mWe9u3FvvdtbVYeOzsj/e0Zhbr1u
        j+
X-Received: by 2002:a17:906:b143:: with SMTP id bt3mr19227278ejb.318.1607350616440;
        Mon, 07 Dec 2020 06:16:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzuQwbVhuYI/1XHG55Js/DNsfUhgSclENPUQ9U+GNFJ8u84Voy3So1uMAHP/3H5mVOpNV0AUw==
X-Received: by 2002:a17:906:b143:: with SMTP id bt3mr19227252ejb.318.1607350616149;
        Mon, 07 Dec 2020 06:16:56 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id f18sm13423408edt.60.2020.12.07.06.16.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Dec 2020 06:16:55 -0800 (PST)
Subject: Re: [PATCH 1/3] platform/x86: ISST: Check for unaligned mmio address
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        mgross@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201204015746.1168941-1-srinivas.pandruvada@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <535e4198-4244-2650-b1d4-4d81262c3198@redhat.com>
Date:   Mon, 7 Dec 2020 15:16:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201204015746.1168941-1-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/4/20 2:57 AM, Srinivas Pandruvada wrote:
> The address should be aligned to 4 byte boundary. So send an error for
> unaligned address.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Thank you for your patch-series.

One thing which still seems to be missing after this series is a check for
attempting to read/write the hole between the 2 ranges. Can you please
provide a follow-up patch adding such a check?

###

I've applied the series to my review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans


> ---
>  drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c b/drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c
> index aa17fd7817f8..e7e9808a1aed 100644
> --- a/drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c
> +++ b/drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c
> @@ -42,6 +42,9 @@ static long isst_if_mmio_rd_wr(u8 *cmd_ptr, int *write_only, int resume)
>  	if (io_reg->reg < 0x04 || io_reg->reg > 0xD0)
>  		return -EINVAL;
>  
> +	if (io_reg->reg % 4)
> +		return -EINVAL;
> +
>  	if (io_reg->read_write && !capable(CAP_SYS_ADMIN))
>  		return -EPERM;
>  
> 

