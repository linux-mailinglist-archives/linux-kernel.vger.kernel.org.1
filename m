Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACFC026F2C8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 05:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728919AbgIRDB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 23:01:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49843 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727656AbgIRDBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 23:01:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600398090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=08vvKo7W8fzgKzRki0M2Us+rPrn1t1DRF38EQBkZbD0=;
        b=eSJuMCtkXZrmpN/kNUii8n6HvywtgU2Mc98OAyjCXxYknXmKNZjZwkeIighrthjZPghX9Q
        Mi6cWItw3DjUTtIzc882QJCS1pgPkFOJAwNmzV7a+J5iUWAtMZoUqsFbjS8K6N1NFjDGl5
        nc8exgfMFZFRmUH0pHg0+gpAf3x3y/Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-CC16NPrCO_q5BV3RSOZkzw-1; Thu, 17 Sep 2020 23:01:28 -0400
X-MC-Unique: CC16NPrCO_q5BV3RSOZkzw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F283910060C2;
        Fri, 18 Sep 2020 03:01:24 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-13-81.pek2.redhat.com [10.72.13.81])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BA00455766;
        Fri, 18 Sep 2020 03:01:15 +0000 (UTC)
Date:   Fri, 18 Sep 2020 11:01:12 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, james.morse@arm.com,
        tglx@linutronix.de, mingo@redhat.com, bhe@redhat.com,
        corbet@lwn.net, John.P.donnelly@oracle.com,
        prabhakar.pkin@gmail.com, bhsharma@redhat.com, horms@verge.net.au,
        robh+dt@kernel.org, arnd@arndb.de, nsaenzjulienne@suse.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        guohanjun@huawei.com, xiexiuqi@huawei.com, huawei.libin@huawei.com,
        wangkefeng.wang@huawei.com
Subject: Re: [PATCH v12 3/9] x86: kdump: use macro CRASH_ADDR_LOW_MAX in
 functions reserve_crashkernel[_low]()
Message-ID: <20200918030112.GA3356@dhcp-128-65.nay.redhat.com>
References: <20200907134745.25732-1-chenzhou10@huawei.com>
 <20200907134745.25732-4-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907134745.25732-4-chenzhou10@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/20 at 09:47pm, Chen Zhou wrote:
> To make the functions reserve_crashkernel[_low]() as generic,
> replace some hard-coded numbers with macro CRASH_ADDR_LOW_MAX.
> 
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> ---
>  arch/x86/kernel/setup.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index d7fd90c52dae..71a6a6e7ca5b 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -430,7 +430,7 @@ static int __init reserve_crashkernel_low(void)
>  	unsigned long total_low_mem;
>  	int ret;
>  
> -	total_low_mem = memblock_mem_size(1UL << (32 - PAGE_SHIFT));
> +	total_low_mem = memblock_mem_size(CRASH_ADDR_LOW_MAX >> PAGE_SHIFT);

total_low_mem != CRASH_ADDR_LOW_MAX

>  
>  	/* crashkernel=Y,low */
>  	ret = parse_crashkernel_low(boot_command_line, total_low_mem, &low_size, &base);

The param total_low_mem is for dynamically change crash_size according
to system ram size.

Is above change a must for your arm64 patches?

> @@ -451,7 +451,7 @@ static int __init reserve_crashkernel_low(void)
>  			return 0;
>  	}
>  
> -	low_base = memblock_find_in_range(CRASH_ALIGN, 1ULL << 32, low_size, CRASH_ALIGN);
> +	low_base = memblock_find_in_range(CRASH_ALIGN, CRASH_ADDR_LOW_MAX, low_size, CRASH_ALIGN);
>  	if (!low_base) {
>  		pr_err("Cannot reserve %ldMB crashkernel low memory, please try smaller size.\n",
>  		       (unsigned long)(low_size >> 20));
> @@ -504,8 +504,9 @@ static void __init reserve_crashkernel(void)
>  	if (!crash_base) {
>  		/*
>  		 * Set CRASH_ADDR_LOW_MAX upper bound for crash memory,
> -		 * crashkernel=x,high reserves memory over 4G, also allocates
> -		 * 256M extra low memory for DMA buffers and swiotlb.
> +		 * crashkernel=x,high reserves memory over CRASH_ADDR_LOW_MAX,
> +		 * also allocates 256M extra low memory for DMA buffers
> +		 * and swiotlb.
>  		 * But the extra memory is not required for all machines.
>  		 * So try low memory first and fall back to high memory
>  		 * unless "crashkernel=size[KMG],high" is specified.
> @@ -539,7 +540,7 @@ static void __init reserve_crashkernel(void)
>  		return;
>  	}
>  
> -	if (crash_base >= (1ULL << 32) && reserve_crashkernel_low()) {
> +	if (crash_base >= CRASH_ADDR_LOW_MAX && reserve_crashkernel_low()) {
>  		memblock_free(crash_base, crash_size);
>  		return;
>  	}
> -- 
> 2.20.1
> 

