Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B95B72BC977
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 22:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgKVVGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 16:06:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727584AbgKVVGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 16:06:08 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE233C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 13:06:07 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id b63so12966514pfg.12
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 13:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=sELl9jm+1JhWzTbZGX2WRwQ+Gq8BTW7JoGJRRHBodJ4=;
        b=u2IM1kaEWNmz/FaispQsolexnVrc8c2oVds347XHVuGpw5aYh+d8++3zTVDK4jcQef
         lERFp19ufsdzzHrTGS0TPC94vgAtpirv6ly6qbhf8r/07f83ZEONqKK2wtwhYKkpenMI
         bCwfmZlao9wPwoe1zdNKCqRRE6bMI9WnRkGTHbzzmyUxDEpo34Uh7DINt/7LEbInoVLH
         IsCxY/ocdgod7+HZvm4L6HTYgLNEoBYRSb/c16uqSpmLiL/zzdyqgG8NjNJ4Xz6h0SxY
         wzdsgFyTI0Cj9O9/oeXzSW4YWdXscWofUKWkghXgGKeMPD9t/ou8wDnaIUJ4NYdoojdr
         7ObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=sELl9jm+1JhWzTbZGX2WRwQ+Gq8BTW7JoGJRRHBodJ4=;
        b=I3G0Mv+UVPcjP6Y29W4XcmVBw5EelPFOL3VSnLmr3RJYIf6PXaQSiqRX5JbTjm/47g
         CUqqHShJ8KdQCSfE4Zm+gdf4DTaI6GAcPn8fSMGumoOwhQuDJGvKojDvIbS7fV8Wq3ld
         n5oOGTi5/iu00+6jUANUskkGgnss4Ug79CqJUbl8bGC9tx3sRzatAbqc8vHu0OQeTf5N
         k6ZYAIMfzJvs1HX9tt9VL/9mG2kqWvC4O7vIzq75rl+UfYAs7KfGsEbl64RdbO3YdcYJ
         v2mwGIf5kL/mT3PlGiY7Gx0AWn26wEL6wOFtE+JPRPF0/RC78CDPcXfMiFUXzHd7z4lm
         4KTw==
X-Gm-Message-State: AOAM530LMPWgAgLOaFenQ6T9KP18FZ30DZ/f2Ge3m6CoUF2l325idGLj
        Wb2DX9BOM5jlnxX4aBnExIquPw==
X-Google-Smtp-Source: ABdhPJzG87ibSQtVjM4+L/IIku561bu7bxDOU3R58AbMhHVxG/6X89gI1e+EsO+dpU3Nl8IbOweuWA==
X-Received: by 2002:a17:90a:c90b:: with SMTP id v11mr13388482pjt.181.1606079167343;
        Sun, 22 Nov 2020 13:06:07 -0800 (PST)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id y5sm10174277pfc.165.2020.11.22.13.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 13:06:06 -0800 (PST)
Date:   Sun, 22 Nov 2020 13:06:05 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
cc:     linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, sthemmin@microsoft.com
Subject: Re: Pinning ZONE_MOVABLE pages
In-Reply-To: <CA+CK2bBffHBxjmb9jmSKacm0fJMinyt3Nhk8Nx6iudcQSj80_w@mail.gmail.com>
Message-ID: <alpine.DEB.2.23.453.2011221300100.2830030@chino.kir.corp.google.com>
References: <CA+CK2bBffHBxjmb9jmSKacm0fJMinyt3Nhk8Nx6iudcQSj80_w@mail.gmail.com>
User-Agent: Alpine 2.23 (DEB 453 2020-06-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Nov 2020, Pavel Tatashin wrote:

> Recently, I encountered a hang that is happening during memory hot
> remove operation. It turns out that the hang is caused by pinned user
> pages in ZONE_MOVABLE.
> 
> Kernel expects that all pages in ZONE_MOVABLE can be migrated, but
> this is not the case if a user applications such as through dpdk
> libraries pinned them via vfio dma map. Kernel keeps trying to
> hot-remove them, but refcnt never gets to zero, so we are looping
> until the hardware watchdog kicks in.
> 
> We cannot do dma unmaps before hot-remove, because hot-remove is a
> slow operation, and we have thousands for network flows handled by
> dpdk that we just cannot suspend for the duration of hot-remove
> operation.
> 
> The solution is for dpdk to allocate pages from a zone below
> ZONE_MOVAVLE, i.e. ZONE_NORMAL/ZONE_HIGHMEM, but this is not possible.
> There is no user interface that we have that allows applications to
> select what zone the memory should come from.
> 
> I've spoken with Stephen Hemminger, and he said that DPDK is moving in
> the direction of using transparent huge pages instead of HugeTLBs,
> which means that we need to allow at least anonymous, and anonymous
> transparent huge pages to come from non-movable zones on demand.
> 

I'd like to know more about this use case, ZONE_MOVABLE is typically a 
great way to optimize for thp availability because, absent memory pinning, 
this memory can always be defragmented.  So the idea is that DPDK will now 
allocate all of its thp from ZONE_NORMAL or only a small subset?  Seems 
like an invitation for oom kill if the sizing of ZONE_NORMAL is 
insufficient.

> Here is what I am proposing:
> 1. Add a new flag that is passed through pin_user_pages_* down to
> fault handlers, and allow the fault handler to allocate from a
> non-movable zone.
> 
> Sample function stacks through which this info needs to be passed is this:
> 
> pin_user_pages_remote(gup_flags)
>  __get_user_pages_remote(gup_flags)
>   __gup_longterm_locked(gup_flags)
>    __get_user_pages_locked(gup_flags)
>     __get_user_pages(gup_flags)
>      faultin_page(gup_flags)
>       Convert gup_flags into fault_flags
>       handle_mm_fault(fault_flags)
> 
> From handle_mm_fault(), the stack diverges into various faults,
> examples include:
> 
> Transparent Huge Page
> handle_mm_fault(fault_flags)
> __handle_mm_fault(fault_flags)
> Create: struct vm_fault vmf, use fault_flags to specify correct gfp_mask
> create_huge_pmd(vmf);
> do_huge_pmd_anonymous_page(vmf);
> mm_get_huge_zero_page(vma->vm_mm); -> flag is lost, so flag from
> vmf.gfp_mask should be passed as well.
> 
> There are several other similar paths in a transparent huge page, also
> there is a named path where allocation is based on filesystems, and
> the flag should be honored there as well, but it does not have to be
> added at the same time.
> 
> Regular Pages
> handle_mm_fault(fault_flags)
> __handle_mm_fault(fault_flags)
> Create: struct vm_fault vmf, use fault_flags to specify correct gfp_mask
> handle_pte_fault(vmf)
> do_anonymous_page(vmf);
> page = alloc_zeroed_user_highpage_movable(vma, vmf->address); ->
> replace change this call according to gfp_mask.
> 

This would likely be useful for AMD SEV as well, which requires guest 
pages to be pinned because the encryption algorithm depends on the host 
physical address.  This ensures that plaintext memory for two pages don't 
result in the same ciphertext.
