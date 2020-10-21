Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60F6E295186
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 19:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503499AbgJURab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 13:30:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40675 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2503481AbgJURab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 13:30:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603301429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xK14QpL3GKUFjkKdFe713G5PD83aAbMCe1sf9+K+cAY=;
        b=QHMQlF4aiUGKCjCTbx2aXsQ25qn7uaCpu8E9OHpjthE3YnLFlAqAwcW+2dOeFGCIHrx8rH
        S4Vnrp8YzB2oZr4cBsp1d620BrcztjXXXoEc18d85e3zT1GHJcWDgbkdYUhtoUn0ZrFO2y
        fQ6/n/a0GD3eXGrcZ4AvhXVCU5vll2U=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-gJIZswkmMJyU9LG23CgfxA-1; Wed, 21 Oct 2020 13:30:28 -0400
X-MC-Unique: gJIZswkmMJyU9LG23CgfxA-1
Received: by mail-ej1-f69.google.com with SMTP id k23so2088441ejx.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 10:30:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:mime-version:subject
         :from:in-reply-to:cc:date:message-id:references:to;
        bh=xK14QpL3GKUFjkKdFe713G5PD83aAbMCe1sf9+K+cAY=;
        b=mk2APZ/rahDOthMhwz0XnkXCH9N0m9wgcMVLNxGRKJhka7X154HXJjSm23kDYdg59T
         mRaP7snfoa91laC18LTgVAVscKez2zCm/27BAFibC4FDmhRZo096HtUojj8kwHdMd9G4
         SEEI10k7MOqriAL6j7/yr5/VbJn/J7Ewi4tfAVLaL38jQxFHowZn6PlYQneqU6UKPqSK
         L+RpYQiZ4E77U+BO1LZmvpsEsX775MQ6bxogKH3hrI3BF6vE3zT/SrK2Al+/Pcy4mCoY
         Gy5yCB9nj5TtKRkV/iPCnqrH7VIoj0MHcynLB38gVfeqNHbGyiizaEr5yR82V7DvuPB5
         kJtw==
X-Gm-Message-State: AOAM532UAW4cEdm2aCyyE1e13yx4qd4GIXdqBywTPP7c2l4si/OzHw5E
        iT0voTe6kliEGCEhmJxGtBqfmsEP7IH0JvVTWOgl5hwrVaJwed7ISSJBTZBgsyktD7XKnLkHJDF
        BZjLfiFzoiv7/rgwNP/KJ6e4o
X-Received: by 2002:a17:907:2677:: with SMTP id ci23mr4533765ejc.270.1603301426536;
        Wed, 21 Oct 2020 10:30:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyobCl+n+APRhXGQt2eHe0a4Q2vF6QNKErLZWR3alp3ZaOvMbaPB4TyHk35mQfTA2Ucqh8G6g==
X-Received: by 2002:a17:907:2677:: with SMTP id ci23mr4533750ejc.270.1603301426337;
        Wed, 21 Oct 2020 10:30:26 -0700 (PDT)
Received: from [192.168.3.114] (p5b0c6a39.dip0.t-ipconnect.de. [91.12.106.57])
        by smtp.gmail.com with ESMTPSA id f26sm2604346ejx.23.2020.10.21.10.30.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2020 10:30:25 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (1.0)
Subject: Re: cgroup and FALLOC_FL_PUNCH_HOLE: WARNING: CPU: 13 PID: 2438 at mm/page_counter.c:57 page_counter_uncharge+0x4b/0x5
From:   David Hildenbrand <david@redhat.com>
In-Reply-To: <be1e53c3-262c-e6f5-d68b-ab41c40d11ac@oracle.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Privoznik <mprivozn@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Tejun Heo <tj@kernel.org>
Date:   Wed, 21 Oct 2020 19:30:23 +0200
Message-Id: <FF106FE1-E3DD-4A9B-B844-B04D0C26C403@redhat.com>
References: <be1e53c3-262c-e6f5-d68b-ab41c40d11ac@oracle.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
X-Mailer: iPhone Mail (18A393)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Am 21.10.2020 um 18:58 schrieb Mike Kravetz <mike.kravetz@oracle.com>:
> =EF=BB=BF
>>=20
>>> On 21.10.20 15:11, David Hildenbrand wrote:
>>> On 21.10.20 14:57, Michal Privoznik wrote:
>>>> On 10/21/20 5:35 AM, Mike Kravetz wrote:
>>>>> On 10/20/20 6:38 AM, David Hildenbrand wrote:
>>>>> It would be good if Mina (at least) would look these over.  Would also=

>>>>> be interesting to know if these fixes address the bug seen with the qe=
mu
>>>>> use case.
>>>>> I'm still doing more testing and code inspection to look for other iss=
ues.
> ...
> ...
>>>> I've applied, rebuilt and tested, but unfortunately I still hit the pro=
blem:
>>>> [ 6472.719047] ------------[ cut here ]------------
>>>> [ 6472.719052] WARNING: CPU: 6 PID: 11773 at mm/page_counter.c:57
> ...
> ...
>>> Agreed, same over here. :(
>>=20
>> I *think* the following on top makes it fly
>>=20
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 67fc6383995b..5cf7f6a6c1a6 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -656,6 +656,9 @@ static long region_del(struct resv_map *resv, long
>> f, long t)
>>=20
>>                        del +=3D t - f;
>>=20
>> +                       hugetlb_cgroup_uncharge_file_region(
>> +                               resv, rg, t - f);
>> +
>>                        /* New entry for end of split region */
>>                        nrg->from =3D t;
>>                        nrg->to =3D rg->to;
>> @@ -667,9 +670,6 @@ static long region_del(struct resv_map *resv, long
>> f, long t)
>>                        /* Original entry is trimmed */
>>                        rg->to =3D f;
>>=20
>> -                       hugetlb_cgroup_uncharge_file_region(
>> -                               resv, rg, nrg->to - nrg->from);
>> -
>>                        list_add(&nrg->link, &rg->link);
>>                        nrg =3D NULL;
>>                        break;
>=20
> Thanks, yes that certainly does look like a bug in that code.
>=20
> Does that resolve the issue with quemu?

I was not able to reproduce, so I guess we found all issues!

Thanks!

>=20
> I want to do a little more testing/research before sending a patch later
> today.
> --=20
> Mike Kravetz

