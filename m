Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32D862B0835
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 16:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbgKLPO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 10:14:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26797 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728218AbgKLPO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 10:14:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605194067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fWIN7/Nq/yeoyKpiKidMDeDSC6wVzNUm+jANJbo9SZs=;
        b=gTt9EwWQSy+HBxxGZGYdpYohCxrfy+kqggJoBVmczwqsyLXf2WemCwAg6+gsd8OsCJAkur
        jgNbXiQxfD4e3QxKAImU5kh0GRF1vETCRJ+FsRJMgDuicqS3bLNxQLnDyDipYVX8gZmNkd
        iVhc7rgWeByvBW6j3qN2A4eL2w0AHfk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-FeZUXl2zPBKEJQsSqnbjmA-1; Thu, 12 Nov 2020 10:14:26 -0500
X-MC-Unique: FeZUXl2zPBKEJQsSqnbjmA-1
Received: by mail-wr1-f72.google.com with SMTP id r15so2057022wrn.15
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 07:14:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=fWIN7/Nq/yeoyKpiKidMDeDSC6wVzNUm+jANJbo9SZs=;
        b=Yo48Z9DneWkeZP0OFA3win1A0+ZccqEOKRts0sBy1H5G0BPOP+Y63rUVvGhaMkcepz
         6jt9ygkJBzCxO6NogzSr3ksMI06yvaTVkNqmnIUxLWw8PMGe/YKfhR39awRuL1iJJsgd
         1qecyK39QvPmrzTStYDxXa+cW2q0du9Oxoh+//YJF53nwi4Hds7AHgAVd4l+MLD4LMVd
         htCwdzsfysf2PGW39rmVv1+ONYBVWYZVxz8uAGnQqmxksEZkSlonM7/DSg6MKMzVgxqR
         GBLoECFW10WmcSLLT4b7rdQebyJpAOsR/BfoMH8FFaGWHGqRYWbEiyvJRcJtt16/TrCK
         VXoQ==
X-Gm-Message-State: AOAM530pkwjcEiBNV3mLbr0DvAdktyGQ/hil6rIkOdpOqO46nfsgfbsL
        gxtfDwNMKYuIXzFFy43v3kgoD9C3JA0Jhy+8R2FcnFIr2fv+Uuz7M7Bz6gbhSpM3bA8XjXEk88m
        LJB2exMPAWjf/6UebU/MmjEbR
X-Received: by 2002:adf:c547:: with SMTP id s7mr6967wrf.222.1605194064954;
        Thu, 12 Nov 2020 07:14:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzCi+qMEnYo3Z4at9GKUxuCuJdHsy/Kwa2RjJxcMb5RiR3KRPrzSMM5oNvlfzZNkCS6x5Cx5g==
X-Received: by 2002:adf:c547:: with SMTP id s7mr6912wrf.222.1605194064609;
        Thu, 12 Nov 2020 07:14:24 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id f8sm7541222wrt.88.2020.11.12.07.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 07:14:24 -0800 (PST)
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
        Arnd Bergmann <arnd@arndb.de>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v2 01/17] asm-generic/hyperv: change
 HV_CPU_POWER_MANAGEMENT to HV_CPU_MANAGEMENT
In-Reply-To: <20201105165814.29233-2-wei.liu@kernel.org>
References: <20201105165814.29233-1-wei.liu@kernel.org>
 <20201105165814.29233-2-wei.liu@kernel.org>
Date:   Thu, 12 Nov 2020 16:14:22 +0100
Message-ID: <87mtzmy5dd.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wei Liu <wei.liu@kernel.org> writes:

> This makes the name match Hyper-V TLFS.
>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
>  include/asm-generic/hyperv-tlfs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
> index e73a11850055..e6903589a82a 100644
> --- a/include/asm-generic/hyperv-tlfs.h
> +++ b/include/asm-generic/hyperv-tlfs.h
> @@ -88,7 +88,7 @@
>  #define HV_CONNECT_PORT				BIT(7)
>  #define HV_ACCESS_STATS				BIT(8)
>  #define HV_DEBUGGING				BIT(11)
> -#define HV_CPU_POWER_MANAGEMENT			BIT(12)
> +#define HV_CPU_MANAGEMENT			BIT(12)
>  
>  
>  /*

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

