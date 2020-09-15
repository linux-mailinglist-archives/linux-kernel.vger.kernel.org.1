Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6C226A2D0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 12:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgIOKKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 06:10:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60120 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726130AbgIOKKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 06:10:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600164611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PW2WSdBrk/XXLs9riC9q1EjPQLc8T5twwn4fVAgRI5I=;
        b=iqZs7V6Lqh8xMh1sbahLc64QzY3TPXqlYVzw8ucaAl35ktdDNRs0peEuFrowgYCo7FfhAm
        3Y4ugTxBu8xFYVTdUGUPeFanyUbv/t3DtHfRfn04AKdPbmpP+BYpZZHIFFV5JlHG1xqmwy
        xpvuOrj+zCJU8MlP0iOLlZKCOcGwrcg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-0pbAvN3JMb-abQ-xoggubQ-1; Tue, 15 Sep 2020 06:10:08 -0400
X-MC-Unique: 0pbAvN3JMb-abQ-xoggubQ-1
Received: by mail-wr1-f70.google.com with SMTP id n15so1021872wrv.23
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 03:10:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=PW2WSdBrk/XXLs9riC9q1EjPQLc8T5twwn4fVAgRI5I=;
        b=BpFwcOWb7wT4C1YTEj/z2zIDeWPWZz6khvLO2vEYU7F3I0tsTFkj9nyNwYoD3UQKNJ
         SVPGzNOZY0ZDLp6KT8/0Ggr6r20gj8HvPIxezbgidO12EMzmwK4XlASZnwvQTLIQQPUU
         9qH1Whog3v2J2h7PVqXlbIvmMP3PmNlKGmvyt5z9za8gsm/uO4vi0ZmYAQcgXvyzwVbh
         w+plP5KMgz+/8N6f5Zxorc62Ew9L+G4PenlIEw1fZO20TxroBTZNR6XKNQ76Yh27lIoF
         rO6YVP8B5CJk+X8If+SjN3iXhOCcJG+RG2tsVqBBwLgjymPWGiRzft2a9hMu9JVMPNlK
         U6YQ==
X-Gm-Message-State: AOAM532DOnRdfWKwRgxJz4FD2H/GNynb9Ose60s1M2GK258hwXSUXjHm
        6uDHLBvNs13NvBHGuNmKHDdul/0FUD/FcB8GG1GF5FC7M6QaIqhk6TfD72U8dhpBJnc/KSV/eT+
        Ae5yPyNlGtPKQ+/qumyJ+mrij
X-Received: by 2002:a1c:7d55:: with SMTP id y82mr3913451wmc.100.1600164607059;
        Tue, 15 Sep 2020 03:10:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw+J82Jd8EMAaV6jdVfRPYNTBzK7waYWJIWEbGPmCe6Da0iBTQvQbeRjA+xD8ipa/CdBYDyPQ==
X-Received: by 2002:a1c:7d55:: with SMTP id y82mr3913430wmc.100.1600164606872;
        Tue, 15 Sep 2020 03:10:06 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id m2sm16387178wrq.25.2020.09.15.03.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 03:10:06 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nudasnev@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH RFC v1 05/18] clocksource/hyperv: use MSR-based access if running as root
In-Reply-To: <20200914112802.80611-6-wei.liu@kernel.org>
References: <20200914112802.80611-1-wei.liu@kernel.org> <20200914112802.80611-6-wei.liu@kernel.org>
Date:   Tue, 15 Sep 2020 12:10:04 +0200
Message-ID: <874knzl5ab.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wei Liu <wei.liu@kernel.org> writes:

> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
>  drivers/clocksource/hyperv_timer.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
> index 09aa44cb8a91..fe96082ce85e 100644
> --- a/drivers/clocksource/hyperv_timer.c
> +++ b/drivers/clocksource/hyperv_timer.c
> @@ -426,6 +426,9 @@ static bool __init hv_init_tsc_clocksource(void)
>  	if (!(ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE))
>  		return false;
>  
> +	if (hv_root_partition)
> +		return false;
> +

Out of pure curiosity,

TSC page clocksource seems to be available to the root partition (as
HV_MSR_REFERENCE_TSC_AVAILABLE is set), why don't we use it? (I
understand that with TSC scaling support in modern CPUs even migration
is a no-issue and we can use raw TSC but this all seems to be
independent from root/non-root partition question).

>  	hv_read_reference_counter = read_hv_clock_tsc;
>  	phys_addr = virt_to_phys(hv_get_tsc_page());

-- 
Vitaly

