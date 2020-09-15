Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1134D26A3FB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 13:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgIOLQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 07:16:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52314 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726169AbgIOLLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 07:11:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600168262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tiWWA5WPIJE1R4aNQnzFviD2WfhvbCKqrfBZuXGN+7s=;
        b=RRzfh5+IvGmEk78OEvlkp+Pg60w8e8osrPzu8u6R0J7zy+vPdA/Du4mVyhex+XKi/GDdU+
        Fi9jpyHnhTlF7vTR3BNkqQ7hp38etQTYkgBWV3he+3DWAvN/zCXk8owNktsCW6hMvu0Wgy
        JeIri+sYCk7iLRSvzFwrl5kjNPAJw08=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-4W44YhAOMy65-ACyjhHSWw-1; Tue, 15 Sep 2020 07:02:12 -0400
X-MC-Unique: 4W44YhAOMy65-ACyjhHSWw-1
Received: by mail-wr1-f72.google.com with SMTP id g6so1093501wrv.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 04:02:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=tiWWA5WPIJE1R4aNQnzFviD2WfhvbCKqrfBZuXGN+7s=;
        b=ggbW++S2fwtz+e135W/OTBiKo1bJ5aGHf6UZ6e+s0j5ysnTUYs7Rc1r+WWpRJWz0FN
         gQZjAx3grbwWffDZg4qgkoIn6kBiP3u1XLg1NG1bJS5ZPnjqF7+GniGaWQpsAzy5o4Lk
         /L/QZ5edRsVvyq7UsbAalLPEXOy/RKYJID2XLbr5tmuXBdPt+yxdK73d3cwIlZk3PFc8
         QoJdhTEhCgLIOqhmXEPdsGnQDrLdSeDqBz5RBuTMuSF+qpvThMPRPjPXI4tXZYp4ms1Z
         rxJ32psBHMEYQQQtJn07uilA1TUH7eKm90pz7LlTedanhlJf+qD+NrH4DW6mAG3+b5DI
         ncHw==
X-Gm-Message-State: AOAM532BSh1ImGcJ8mcX/MBEF9kXq6tdu4r2n3jS5D7F7urXlRcvC5y9
        Vr0668vCEGhBoXzJVOq5P+z2W+zJFyR0FX1Iam8WbpTX+2hRF3OCoNryinu7CYu2yQ4Nlmaw2kj
        DT6W2PwqxWZt8XMpWAw4YxRMk
X-Received: by 2002:adf:f24d:: with SMTP id b13mr20494596wrp.316.1600167731102;
        Tue, 15 Sep 2020 04:02:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxlb3plOi5NIG6+FaUC+KmbrIuYLV1hdg3p4P3m7Jsr5kxBr0w1XwcAmImBMjoeZWSiZxGoww==
X-Received: by 2002:adf:f24d:: with SMTP id b13mr20494569wrp.316.1600167730881;
        Tue, 15 Sep 2020 04:02:10 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id m23sm8009179wmi.19.2020.09.15.04.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 04:02:10 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nudasnev@microsoft.com>,
        Lillian Grassin-Drake <ligrassi@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer\:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH RFC v1 08/18] x86/hyperv: handling hypercall page setup for root
In-Reply-To: <20200915103710.cqmdvzh5lys4wsqo@liuwe-devbox-debian-v2>
References: <20200914112802.80611-1-wei.liu@kernel.org> <20200914112802.80611-9-wei.liu@kernel.org> <87v9gfjpoi.fsf@vitty.brq.redhat.com> <20200915103710.cqmdvzh5lys4wsqo@liuwe-devbox-debian-v2>
Date:   Tue, 15 Sep 2020 13:02:08 +0200
Message-ID: <87pn6njob3.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wei Liu <wei.liu@kernel.org> writes:

> On Tue, Sep 15, 2020 at 12:32:29PM +0200, Vitaly Kuznetsov wrote:
>> Wei Liu <wei.liu@kernel.org> writes:
>> 
>> > When Linux is running as the root partition, the hypercall page will
>> > have already been setup by Hyper-V. Copy the content over to the
>> > allocated page.
>> 
>> And we can't setup a new hypercall page by writing something different
>> to HV_X64_MSR_HYPERCALL, right?
>> 
>
> My understanding is that we can't, but Sunil can maybe correct me.
>
>> >
>> > The suspend, resume and cleanup paths remain untouched because they are
>> > not supported in this setup yet.
>> >
>> > Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
>> > Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
>> > Signed-off-by: Nuno Das Neves <nudasnev@microsoft.com>
>> > Co-Developed-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
>> > Co-Developed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
>> > Co-Developed-by: Nuno Das Neves <nudasnev@microsoft.com>
>> > Signed-off-by: Wei Liu <wei.liu@kernel.org>
>> > ---
>> >  arch/x86/hyperv/hv_init.c | 26 ++++++++++++++++++++++++--
>> >  1 file changed, 24 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
>> > index 0eec1ed32023..26233aebc86c 100644
>> > --- a/arch/x86/hyperv/hv_init.c
>> > +++ b/arch/x86/hyperv/hv_init.c
>> > @@ -25,6 +25,7 @@
>> >  #include <linux/cpuhotplug.h>
>> >  #include <linux/syscore_ops.h>
>> >  #include <clocksource/hyperv_timer.h>
>> > +#include <linux/highmem.h>
>> >  
>> >  /* Is Linux running as the root partition? */
>> >  bool hv_root_partition;
>> > @@ -448,8 +449,29 @@ void __init hyperv_init(void)
>> >  
>> >  	rdmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
>> >  	hypercall_msr.enable = 1;
>> > -	hypercall_msr.guest_physical_address = vmalloc_to_pfn(hv_hypercall_pg);
>> > -	wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
>> > +
>> > +	if (hv_root_partition) {
>> > +		struct page *pg;
>> > +		void *src, *dst;
>> > +
>> > +		/*
>> > +		 * Order is important here. We must enable the hypercall page
>> > +		 * so it is populated with code, then copy the code to an
>> > +		 * executable page.
>> > +		 */
>> > +		wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
>> > +
>> > +		pg = vmalloc_to_page(hv_hypercall_pg);
>> > +		dst = kmap(pg);
>> > +		src = memremap(hypercall_msr.guest_physical_address << PAGE_SHIFT, PAGE_SIZE,
>> > +				MEMREMAP_WB);
>> 
>> memremap() can fail...
>
> And we don't care here, if it fails, we would rather it panic or oops.
>
> I was relying on the fact that copying from / to a NULL pointer will
> cause the kernel to crash. But of course it wouldn't hurt to explicitly
> panic here.
>
>> 
>> > +		memcpy(dst, src, PAGE_SIZE);
>> > +		memunmap(src);
>> > +		kunmap(pg);
>> > +	} else {
>> > +		hypercall_msr.guest_physical_address = vmalloc_to_pfn(hv_hypercall_pg);
>> > +		wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
>> > +	}
>> 
>> Why can't we do wrmsrl() for both cases here?
>> 
>
> Because the hypercall page has already been set up when Linux is the
> root.

But you already do wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64)
in 'if (hv_root_partition)' case above, that's why I asked.

>
> I could've tried writing to the MSR again, but because the behaviour
> here is not documented and subject to change so I didn't bother trying.
>
> Wei.
>
>> >  
>> >  	/*
>> >  	 * Ignore any errors in setting up stimer clockevents
>> 
>> -- 
>> Vitaly
>> 
>

-- 
Vitaly

