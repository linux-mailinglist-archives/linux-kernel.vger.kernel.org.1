Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71EFF2B086F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 16:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbgKLPbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 10:31:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22331 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728218AbgKLPbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 10:31:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605195062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XHp7Bo10vm0UfwNZa83vSvzkaRjk9257JvNRreDbMPA=;
        b=i8rjBmP0C5zRz7t2g6S6Rlh54z0DHobnsdzqi4eX+B1pbt39811kEnI2Y13hSIF0+UqbM3
        7mLfSldlK1pa2GmpHL+Uj1NdW0hncsEqbSBzJ27xm0rXVhd1uGh62oy5sSUK8d9KgM7z5A
        PtFdw58GYpV1bTIOLMvPPH+gvH67NM8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-Om32hGOyOo2p9mHvnXdOfw-1; Thu, 12 Nov 2020 10:31:00 -0500
X-MC-Unique: Om32hGOyOo2p9mHvnXdOfw-1
Received: by mail-wm1-f70.google.com with SMTP id u123so1870856wmu.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 07:31:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=XHp7Bo10vm0UfwNZa83vSvzkaRjk9257JvNRreDbMPA=;
        b=UAWCFrako7PNOy5dDAmKjSqoQnvgYbVRuaS9j5DwU3jZm3PHBWB+3ZqrGByn6gmkq8
         ZM0M0yR0PqXUkaLUmFMA+tBEk4q44f0eTmBeEjXJNfS9x3W0kcsPs7uIrXHKe10j2iaJ
         HDlrn/s+02EXxS6o4xjv5MhX40ypj/cVKTK7aX2IsqTFxhBsRRNVh9pUGonNRNvLPOK3
         PFpu7NkP4SBBnoadCjzwzyBjbYM/nZGN4o28Bv9GnmIlhQqQigerEmBObON5I9E7XZ1h
         OPWxqvxTbtAskb9vMnxO0VGMEH7Glr/uln3n7BiUbz0xopRUGYLnN6xiFzlRsc1A5GKB
         JRow==
X-Gm-Message-State: AOAM532cFizPQ1PsSWhDTo3AYjuDpEN72c8X7T/OORR7lKP7eesu0F/U
        RNXXY8E1BvUdUMF3Jemv56jCEnmQKWiEH0touOjnVR9WAZWPGn1mv1SmhNkUjmQDBcrwn9nONgi
        j1DdSS5O9peUVcGmondYWdeaN
X-Received: by 2002:adf:f542:: with SMTP id j2mr56190wrp.107.1605195059653;
        Thu, 12 Nov 2020 07:30:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz1OngyKpQAS+Q4bbI3Hywakt2LTSLrDkVsSOy8wiQ/1aW5MGElsPEZVtZPjFlyvRpBGUIsaQ==
X-Received: by 2002:adf:f542:: with SMTP id j2mr56174wrp.107.1605195059474;
        Thu, 12 Nov 2020 07:30:59 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id c129sm7158288wmd.7.2020.11.12.07.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 07:30:58 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 05/17] clocksource/hyperv: use MSR-based access if
 running as root
In-Reply-To: <20201105165814.29233-6-wei.liu@kernel.org>
References: <20201105165814.29233-1-wei.liu@kernel.org>
 <20201105165814.29233-6-wei.liu@kernel.org>
Date:   Thu, 12 Nov 2020 16:30:57 +0100
Message-ID: <87d00iy4lq.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wei Liu <wei.liu@kernel.org> writes:

> Signed-off-by: Wei Liu <wei.liu@kernel.org>

In the missing commit message I'd like to see why we don't use 'TSC
page' clocksource for the root partition. My guess would be that it's
not available and actually we're supposed to use raw TSC value (because
root partitions never migrate) but please spell it out.

> ---
>  drivers/clocksource/hyperv_timer.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
> index ba04cb381cd3..269a691bd2c4 100644
> --- a/drivers/clocksource/hyperv_timer.c
> +++ b/drivers/clocksource/hyperv_timer.c
> @@ -426,6 +426,9 @@ static bool __init hv_init_tsc_clocksource(void)
>  	if (!(ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE))
>  		return false;
>  
> +	if (hv_root_partition)
> +		return false;
> +
>  	hv_read_reference_counter = read_hv_clock_tsc;
>  	phys_addr = virt_to_phys(hv_get_tsc_page());

-- 
Vitaly

