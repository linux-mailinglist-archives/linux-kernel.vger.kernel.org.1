Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9F922E9EAF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 21:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbhADUMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 15:12:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41988 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727952AbhADUMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 15:12:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609791072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uf7YcQ6j4//fvt+DAqWWp4t8Vqx45+iboex03SWw704=;
        b=VVzQHwomINqndeVWIrDsG/0JWHHefKt6P13Weoug9Ph4lEgGsGeANBqjfa/qE+07UtgaLx
        Cqn/jZgY2EqlQQEuunSka+T5EN0QDQXCPd1myL8vpFHUoyPkcN+2rWkp5mC48+M4pCcAnT
        uUzpf74VrSWGFVe2b06kV2oxfaDQHaY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-fEFEYU35MASc6d604caeZw-1; Mon, 04 Jan 2021 15:11:11 -0500
X-MC-Unique: fEFEYU35MASc6d604caeZw-1
Received: by mail-wr1-f72.google.com with SMTP id 88so13689482wrc.17
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 12:11:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=Uf7YcQ6j4//fvt+DAqWWp4t8Vqx45+iboex03SWw704=;
        b=j7k2ESGwkwk3AxZa2W/aK4aUHtLvgousar7nRhIUms3Uyfjw+Ccjf4w5iGK5XlHpjb
         9DgocQYPt4gGULjv9Jk8fopJS5SS51cvF4Np40/2Xvz8p1xYW/McjHFGSgXT7bSLOXiN
         wF4gI5laH3kvb00eK/ssL6ePrVXICZG527H4q2aozALa0Vy2ynY94w+zzONFuSXfx/lC
         HfIzWaNVTQoy720Is6dQoItHP52uYmhbWA9pzELz0Rv78dqeGeYfMVB15/17HuO9NAWI
         JiKlx1l2oe4dFRl6+6Ca1Zl/WzSCBsAgiZ6L/vgG30ErSYPLTSLoQXF9QQhLZJ4GWAHR
         a+xg==
X-Gm-Message-State: AOAM533f3gILm5oMNRhFqaZjE3zbjwHyQVWivLpY/8NXnJDIhx0aPCRD
        1jkkl++de+nB4qMwpqotPdO0iBHL5PxgO3lmm630c67ZNpYLjLfXIhmH6eEnyZz0WAg15Fp602j
        ug4eowudDEnSOR4o9hzB+5tOs
X-Received: by 2002:adf:dcc5:: with SMTP id x5mr80661630wrm.167.1609791069110;
        Mon, 04 Jan 2021 12:11:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzkdFEzyOlA3Y8Eyk0/ltCkVecx3CgLuE1hJOwodBehjEmZXochwhSLXoNLGXuGRBsrbBGEYg==
X-Received: by 2002:adf:dcc5:: with SMTP id x5mr80661617wrm.167.1609791068978;
        Mon, 04 Jan 2021 12:11:08 -0800 (PST)
Received: from [192.168.3.108] (p5b0c69d7.dip0.t-ipconnect.de. [91.12.105.215])
        by smtp.gmail.com with ESMTPSA id 138sm731389wma.41.2021.01.04.12.11.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jan 2021 12:11:08 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC v2 PATCH 4/4] mm: pre zero out free pages to speed up page allocation for __GFP_ZERO
Date:   Mon, 4 Jan 2021 21:11:07 +0100
Message-Id: <43576DAD-8A3B-4691-8808-90C5FDCF03B7@redhat.com>
References: <a5ba7bdf-8510-d0a0-9c22-ec1b81019982@intel.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Liang Li <liliangleo@didiglobal.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
In-Reply-To: <a5ba7bdf-8510-d0a0-9c22-ec1b81019982@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
X-Mailer: iPhone Mail (18C66)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Am 04.01.2021 um 20:52 schrieb Dave Hansen <dave.hansen@intel.com>:
>=20
> =EF=BB=BFOn 1/4/21 11:27 AM, Matthew Wilcox wrote:
>>> On Mon, Jan 04, 2021 at 11:19:13AM -0800, Dave Hansen wrote:
>>> On 12/21/20 8:30 AM, Liang Li wrote:
>>>> --- a/include/linux/page-flags.h
>>>> +++ b/include/linux/page-flags.h
>>>> @@ -137,6 +137,9 @@ enum pageflags {
>>>> #endif
>>>> #ifdef CONFIG_64BIT
>>>>    PG_arch_2,
>>>> +#endif
>>>> +#ifdef CONFIG_PREZERO_PAGE
>>>> +    PG_zero,
>>>> #endif
>>>>    __NR_PAGEFLAGS,
>>>=20
>>> I don't think this is worth a generic page->flags bit.
>>>=20
>>> There's a ton of space in 'struct page' for pages that are in the
>>> allocator.  Can't we use some of that space?
>>=20
>> I was going to object to that too, but I think the entire approach is
>> flawed and needs to be thrown out.  It just nukes the caches in extremely=

>> subtle and hard to measure ways, lowering overall system performance.
>=20
> Yeah, it certainly can't be the default, but it *is* useful for thing
> where we know that there are no cache benefits to zeroing close to where
> the memory is allocated.
>=20
> The trick is opting into it somehow, either in a process or a VMA.
>=20

The patch set is mostly trying to optimize starting a new process. So proces=
s/vma doesn=E2=80=98t really work.

I still wonder if using tmpfs/shmem cannot somehow be used to cover the orig=
inal use case of starting a new vm fast (or rebooting an existing one involv=
ing restarting the process).=

