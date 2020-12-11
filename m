Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6C42D8129
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 22:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392522AbgLKVbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 16:31:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35884 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405984AbgLKVak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 16:30:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607722152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9Rl5EtIOs03CVOerY2+wVTiaDIkcXc+bBp/8wnzmHJM=;
        b=IycrZ4/EYEc7YY66bAlajurt3dR6GhiO5Z61TV9F7gY+2f7Atl1Y1QN0rmB+24OJ4ymlhE
        FLk+ka3D6Z294+XMj5V7inKPiQjVzlDDIu5Ym750j7mdg+RsbpVuHjcRN5NVDb5r6aBKZ6
        +JUzKJoAwgZwnSFCnpmQTK0jzDAmJLY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-517-C4916xAUNLCMdkFPMfApqg-1; Fri, 11 Dec 2020 16:29:11 -0500
X-MC-Unique: C4916xAUNLCMdkFPMfApqg-1
Received: by mail-wr1-f69.google.com with SMTP id o17so3807172wra.8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 13:29:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=9Rl5EtIOs03CVOerY2+wVTiaDIkcXc+bBp/8wnzmHJM=;
        b=AF4jAUQFxSRglnvzbZe0Eu7+XwAcxus6N4EZqVItU3sBxUthXSATEgDZ3FAkALTbKm
         jlpbSRF4/KJqyOD34vIlOP2HttOTooAE+3eUwnq7XDO8Ubw++ADsIeuwHW3oEU9IyapL
         Hy+ma1xqXXslqpqanY8cVfJo7qaj7xL6yLsWeHFmH3ryoje8/IXxjUWonyqv621vtIeO
         qLTmNzTu6m4cwVNj+4efFbTXiLb0A9glIWcoKJcR4yLtfkLmTTqTyzg1skw0mVPoeJj3
         QNXgTO2RNKbB0S3vXD62esWUNyd0OSyDWkVdSYBIjzfiP2I+njKlHpR8gPl90BaA5WEE
         1apw==
X-Gm-Message-State: AOAM5337CQfkS/8B0AchaA6i0tG0crl8f5/zdTK/lyTG8A0Y9Esr+ZCl
        petRaLPprX8Io3iH0AQWYP/JNfe203bOK3aOpC4aarYGgsK6dJ2O/JbrLvvQBYxTpfOL9uCVuO6
        Bik6qtenXmBsOzksOwjMeKJ6f
X-Received: by 2002:adf:9cca:: with SMTP id h10mr8782006wre.77.1607722149875;
        Fri, 11 Dec 2020 13:29:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxML2UPeLq19wEtUIxrniwOw/YoaYTaWXyKEajEcsSnhW1AWwjmA+tfkw1FaXOISFtnfmZ+hQ==
X-Received: by 2002:adf:9cca:: with SMTP id h10mr8781992wre.77.1607722149677;
        Fri, 11 Dec 2020 13:29:09 -0800 (PST)
Received: from [192.168.3.114] (p4ff23c7c.dip0.t-ipconnect.de. [79.242.60.124])
        by smtp.gmail.com with ESMTPSA id n189sm15862735wmf.20.2020.12.11.13.29.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Dec 2020 13:29:09 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3 5/6] mm/gup: migrate pinned pages out of movable zone
Date:   Fri, 11 Dec 2020 22:29:08 +0100
Message-Id: <10F682D5-0654-4C42-9989-F999D4434295@redhat.com>
References: <CA+CK2bC6u4wnHX53ZhfPtQBLTDbD3t4V9Zuhj=HwD3gEyL4Puw@mail.gmail.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, mike.kravetz@oracle.com,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
In-Reply-To: <CA+CK2bC6u4wnHX53ZhfPtQBLTDbD3t4V9Zuhj=HwD3gEyL4Puw@mail.gmail.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
X-Mailer: iPhone Mail (18B92)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Am 11.12.2020 um 22:09 schrieb Pavel Tatashin <pasha.tatashin@soleen.com>:=

>=20
> =EF=BB=BFOn Fri, Dec 11, 2020 at 3:46 PM Jason Gunthorpe <jgg@ziepe.ca> wr=
ote:
>>=20
>>> On Fri, Dec 11, 2020 at 03:40:57PM -0500, Pavel Tatashin wrote:
>>> On Fri, Dec 11, 2020 at 3:23 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>>>>=20
>>>> On Fri, Dec 11, 2020 at 03:21:39PM -0500, Pavel Tatashin wrote:
>>>>> @@ -1593,7 +1592,7 @@ static long check_and_migrate_cma_pages(struct m=
m_struct *mm,
>>>>>                              }
>>>>>=20
>>>>>                              if (!isolate_lru_page(head)) {
>>>>> -                                     list_add_tail(&head->lru, &cma_p=
age_list);
>>>>> +                                     list_add_tail(&head->lru, &movab=
le_page_list);
>>>>>                                      mod_node_page_state(page_pgdat(he=
ad),
>>>>>                                                          NR_ISOLATED_A=
NON +
>>>>>                                                          page_is_file_=
lru(head),
>>>>> @@ -1605,7 +1604,7 @@ static long check_and_migrate_cma_pages(struct m=
m_struct *mm,
>>>>>              i +=3D step;
>>>>>      }
>>>>>=20
>>>>> -     if (!list_empty(&cma_page_list)) {
>>>>> +     if (!list_empty(&movable_page_list)) {
>>>>=20
>>>> You didn't answer my earlier question, is it OK that ZONE_MOVABLE
>>>> pages leak out here if ioslate_lru_page() fails but the
>>>> moval_page_list is empty?
>>>>=20
>>>> I think the answer is no, right?
>>> In my opinion it is OK. We are doing our best to not pin movable
>>> pages, but if isolate_lru_page() fails because pages are currently
>>> locked by someone else, we will end up long-term pinning them.
>>> See comment in this patch:
>>> +        * 1. Pinned pages: (long-term) pinning of movable pages is avoi=
ded
>>> +        *    when pages are pinned and faulted, but it is still possibl=
e that
>>> +        *    address space already has pages in ZONE_MOVABLE at the tim=
e when
>>> +        *    pages are pinned (i.e. user has touches that memory before=

>>> +        *    pinning). In such case we try to migrate them to a differe=
nt zone,
>>> +        *    but if migration fails the pages can still end-up pinned i=
n
>>> +        *    ZONE_MOVABLE. In such case, memory offlining might retry a=
 long
>>> +        *    time and will only succeed once user application unpins pa=
ges.
>>=20
>> It is not "retry a long time" it is "might never complete" because
>> userspace will hold the DMA pin indefinitely.
>>=20
>> Confused what the point of all this is then ??
>>=20
>> I thought to goal here is to make memory unplug reliable, if you leave
>> a hole like this then any hostile userspace can block it forever.
>=20
> You are right, I used a wording from the previous comment, and it
> should be made clear that pin may be forever. Without these patches it
> is guaranteed that hot-remove will fail if there are pinned pages as
> ZONE_MOVABLE is actually the first to be searched. Now, it will fail
> only due to exceptions listed in ZONE_MOVABLE comment:
>=20
> 1. pin + migration/isolation failure

Not sure what that really means. We have short-term pinnings (although we mi=
ght have a better term for =E2=80=9Epinning=E2=80=9C here) for example, when=
 a process dies (IIRC). There is a period where pages cannot get migrated an=
d offlining code has to retry (which might take a while). This still applies=
 after your change - are you referring to that?

> 2. memblock allocation due to limited amount of space for kernelcore
> 3. memory holes
> 4. hwpoison
> 5. Unmovable PG_offline pages (? need to study why this is a scenario).

Virtio-mem is the primary user in this context.

> Do you think we should unconditionally unpin pages, and return error
> when isolation/migration fails?

I=E2=80=98m not sure what you mean here. Who=E2=80=99s supposed to unpin whi=
ch pages?

>=20
> Pasha
>=20
>>=20
>> Jason
>=20

