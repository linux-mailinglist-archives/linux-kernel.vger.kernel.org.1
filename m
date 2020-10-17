Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB52291094
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 09:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437511AbgJQHjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 03:39:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43757 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2437504AbgJQHjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 03:39:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602920385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nlE7mWs+OHbEhLBW5Ti9CXDUCrj0uRPZ3Ruggfy/J74=;
        b=DiJv4nfH+zahr5JMOPatKC8w8Gz1t9Jh/MejtMqkBPy516PvXbwXJ50uVORnDcpN/X2SVH
        lXwYqdmZTAlcuRg2+iKu5oU+G2gGID8ttNrQP9HCgFR3fPA88UuhV7ZN/wuvkFiYI5CFi3
        bwrKfb+qIzE0H7XYYO55r3fnZEpCbdA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-nPDBdNqlPMCD5V0IH_25zg-1; Sat, 17 Oct 2020 03:39:41 -0400
X-MC-Unique: nPDBdNqlPMCD5V0IH_25zg-1
Received: by mail-ej1-f72.google.com with SMTP id x22so2748407ejs.17
        for <linux-kernel@vger.kernel.org>; Sat, 17 Oct 2020 00:39:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=nlE7mWs+OHbEhLBW5Ti9CXDUCrj0uRPZ3Ruggfy/J74=;
        b=tma9uPjutdw7JcKKlOuqv+XX7e+2IFaDQMzQDeV44dhfWTX70DZISfCVkA+K30wEA2
         BoCBJIrMxSqiSz8+9fsa+yG0AsddG4PwWoeQuO9IJc100qu2xoJIgfzozzUPs5HHWNbP
         6lIInLkdLeGxuqzf39Myk0/HXjaw1pHtFDw3/53bdDlLi6nQa6qh5VSBzKwJb085jpoL
         A/VzTrq6adtrq9o4mk2B44pFpeIUOF+T0MtbUxTVKKZTnIaaR2uleiD43GWsFy+8MBHI
         Og+5LbARCK+dpqxICGCbcdVAV2bjZpo3eQi4ycvNhTfcy8nOtmSKHly9eaLhQ4pETdYc
         z41g==
X-Gm-Message-State: AOAM530D0kKIdnvi11y7/xJK53d/LvB5BF+qQ7EIXzNI7s32971Caeah
        6P6Ibhu2ajEdmf60isXEUHYB+D0CpsjrJKRAF7Gi0K2ir/YCu/EvDsDJeTXNfa3Pd+YAoYdZXxS
        h2BVE6LCfAy+OerTVweFdn6wJ
X-Received: by 2002:aa7:dc16:: with SMTP id b22mr8068523edu.252.1602920379910;
        Sat, 17 Oct 2020 00:39:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzuZ1/FCI19jeTpRP2oGQpZx/HslqeOvnC2jgnpgIVRX1a6ZmQPIKyyDNb7ut4Lh1R/3tQAQA==
X-Received: by 2002:aa7:dc16:: with SMTP id b22mr8068509edu.252.1602920379651;
        Sat, 17 Oct 2020 00:39:39 -0700 (PDT)
Received: from [192.168.3.114] (p4ff239ab.dip0.t-ipconnect.de. [79.242.57.171])
        by smtp.gmail.com with ESMTPSA id vr3sm4406332ejb.124.2020.10.17.00.39.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Oct 2020 00:39:39 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v1 05/29] virtio-mem: generalize check for added memory
Date:   Sat, 17 Oct 2020 09:39:38 +0200
Message-Id: <2E12AC3C-872A-4B30-8FD7-12420FA1D14E@redhat.com>
References: <20201016223811.GJ44269@L-31X9LVDL-1304.local>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, virtualization@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
In-Reply-To: <20201016223811.GJ44269@L-31X9LVDL-1304.local>
To:     Wei Yang <richard.weiyang@linux.alibaba.com>
X-Mailer: iPhone Mail (18A393)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Am 17.10.2020 um 00:38 schrieb Wei Yang <richard.weiyang@linux.alibaba.com=
>:
>=20
> =EF=BB=BFOn Fri, Oct 16, 2020 at 12:32:50PM +0200, David Hildenbrand wrote=
:
>>>>> Ok, I seems to understand the logic now.
>>>>>=20
>>>>> But how we prevent ONLINE_PARTIAL memory block get offlined? There are=
 three
>>>>> calls in virtio_mem_set_fake_offline(), while all of them adjust page'=
s flag.
>>>>> How they hold reference to struct page?
>>>>=20
>>>> Sorry, I should have given you the right pointer. (similar to my other
>>>> reply)
>>>>=20
>>>> We hold a reference either via
>>>>=20
>>>> 1. alloc_contig_range()
>>>=20
>>> I am not familiar with this one, need to spend some time to look into.
>>=20
>> Each individual page will have a pagecount of 1.
>>=20
>>>=20
>>>> 2. memmap init code, when not calling generic_online_page().
>>>=20
>>> I may miss some code here. Before online pages, memmaps are allocated in=

>>> section_activate(). They are supposed to be zero-ed. (I don't get the ex=
act
>>> code line.) I am not sure when we grab a refcount here.
>>=20
>> Best to refer to __init_single_page() -> init_page_count().
>>=20
>> Each page that wasn't onlined via generic_online_page() has a refcount
>> of 1 and looks like allocated.
>>=20
>=20
> Thanks, I see the logic.
>=20
>    online_pages()
>        move_pfn_range_to_zone()  --- 1)
>    online_pages_range()      --- 2)
>=20
> At 1), __init_single_page() would set page count to 1. At 2),
> generic_online_page() would clear page count, while the call back would no=
t.
>=20
> Then I am trying to search the place where un-zero page count prevent offl=
ine.
> scan_movable_pages() would fail, since this is a PageOffline() and has 1 p=
age
> count.
>=20
> So the GUARD we prevent offline partial-onlined pages is
>=20
>    (PageOffline && page_count)
>=20
> And your commit aa218795cb5fd583c94f
>=20
> mm: Allow to offline unmovable PageOffline() pages via MEM_GOING_OFFLINE
>=20
> is introduced to handle this case.
>=20
> That's pretty clear now.
>=20

I=E2=80=98m happy to see that I am no longer the only person that understand=
s all this magic :)

Thanks for having a look / reviewing!

>> --=20
>> Thanks,
>>=20
>> David / dhildenb
>=20
> --=20
> Wei Yang
> Help you, Help me
>=20

