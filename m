Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C67C32838DF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 17:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbgJEPEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 11:04:06 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:19771 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbgJEPEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 11:04:04 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7b35d60001>; Mon, 05 Oct 2020 08:03:50 -0700
Received: from [10.2.161.39] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 5 Oct
 2020 15:03:58 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>
CC:     <linux-mm@kvack.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Rik van Riel <riel@surriel.com>,
        "Roman Gushchin" <guro@fb.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "John Hubbard" <jhubbard@nvidia.com>,
        David Nellans <dnellans@nvidia.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 00/30] 1GB PUD THP support on x86_64
Date:   Mon, 5 Oct 2020 11:03:56 -0400
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <F3606096-EF9F-4F69-89DC-287095B649DC@nvidia.com>
In-Reply-To: <645b35a5-970d-dcfe-2b4a-04ebd4444756@redhat.com>
References: <20200928175428.4110504-1-zi.yan@sent.com>
 <20200930115505.GT2277@dhcp22.suse.cz>
 <73394A41-16D8-431C-9E48-B14D44F045F8@nvidia.com>
 <20201002073205.GC20872@dhcp22.suse.cz>
 <9a7600e2-044a-50ca-acde-bf647932c751@redhat.com>
 <20201002081023.GA4555@dhcp22.suse.cz>
 <645b35a5-970d-dcfe-2b4a-04ebd4444756@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
        boundary="=_MailMate_B3260F79-3BA8-4E15-9EE5-B16DB43C668F_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601910231; bh=5crz1Q0dxpCTBJz/oRfrTGpbH1gGQtLtgtCQWMEJvJU=;
        h=From:To:CC:Subject:Date:X-Mailer:Message-ID:In-Reply-To:
         References:MIME-Version:Content-Type:X-Originating-IP:
         X-ClientProxiedBy;
        b=UrzxVmVOJAHB34/9lv/tKgjEP1FI66QoqTndl6qg8dz0igpaI46gLyt3Eiwx8TGQV
         W98r4RUeo7vw5tbHM3MmF35+3bat9cepsG1Ru7Qs9tyACVOb5edSuGcPZbxOjrmdqg
         0IO9y7xe709gFV0q/8hKIheozjKqCYNRV66yfSLFokKV8Q/EF6hwRdlx03pPgKdRl8
         xRGs0mStQPs4TV+3V/GFxR/PPUNQhc9Qex5TrzQDXvRVWbDgVNOxXujy9P8S+SPg8r
         YXfgQDf38ek+sxe1iyJbIC7tfzicKyuXCsO1d6BCCs1FW5PjhA5cSTrzRk+sFuLNHj
         avRuAhVQfT5OQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_B3260F79-3BA8-4E15-9EE5-B16DB43C668F_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 2 Oct 2020, at 4:30, David Hildenbrand wrote:

> On 02.10.20 10:10, Michal Hocko wrote:
>> On Fri 02-10-20 09:50:02, David Hildenbrand wrote:
>>>>>> - huge page sizes controllable by the userspace?
>>>>>
>>>>> It might be good to allow advanced users to choose the page sizes, =
so they
>>>>> have better control of their applications.
>>>>
>>>> Could you elaborate more? Those advanced users can use hugetlb, righ=
t?
>>>> They get a very good control over page size and pool preallocation e=
tc.
>>>> So they can get what they need - assuming there is enough memory.
>>>>
>>>
>>> I am still not convinced that 1G THP (TGP :) ) are really what we wan=
t
>>> to support. I can understand that there are some use cases that might=

>>> benefit from it, especially:
>>
>> Well, I would say that internal support for larger huge pages (e.g. 1G=
B)
>> that can transparently split under memory pressure is a useful
>> funtionality. I cannot really judge how complex that would be
>
> Right, but that's then something different than serving (scarce,
> unmovable) gigantic pages from CMA / reserved hugetlbfs pool. Nothing
> wrong about *real* THP support, meaning, e.g., grouping consecutive
> pages and converting them back and forth on demand. (E.g., 1GB ->
> multiple 2MB -> multiple single pages), for example, when having to
> migrate such a gigantic page. But that's very different from our
> existing gigantic page code as far as I can tell.

Serving 1GB PUD THPs from CMA is a compromise, since we do not want to
bump MAX_ORDER to 20 to enable 1GB page allocation in buddy allocator,
which needs section size increase. In addition, unmoveable pages cannot
be allocated in CMA, so allocating 1GB pages has much higher chance from
it than from ZONE_NORMAL.


>> consideting that 2MB THP have turned out to be quite a pain but
>> situation has settled over time. Maybe our current code base is prepar=
ed
>> for that much better.

I am planning to refactor my code further to reduce the amount of
the added code, since PUD THP is very similar to PMD THP. One thing
I want to achieve is to enable split_huge_page to split any order of
pages to a group of any lower order of pages. A lot of code in this
patchset is replicating the same behavior of PMD THP at PUD level.
It might be possible to deduplicate most of the code.

>>
>> Exposing that interface to the userspace is a different story of cours=
e.
>> I do agree that we likely do not want to be very explicit about that.
>> E.g. an interface for address space defragmentation without any more
>> specifics sounds like a useful feature to me. It will be up to the
>> kernel to decide which huge pages to use.
>
> Yes, I think one important feature would be that we don't end up placin=
g
> a gigantic page where only a handful of pages are actually populated
> without green light from the application - because that's what some use=
r
> space applications care about (not consuming more memory than intended.=

> IIUC, this is also what this patch set does). I'm fine with placing
> gigantic pages if it really just "defragments" the address space layout=
,
> without filling unpopulated holes.
>
> Then, this would be mostly invisible to user space, and we really
> wouldn't have to care about any configuration.


I agree that the interface should be as simple as no configuration to
most users. But I also wonder why we have hugetlbfs to allow users to
specify different kinds of page sizes, which seems against the discussion=

above. Are we assuming advanced users should always use hugetlbfs instead=

of THPs?


=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_B3260F79-3BA8-4E15-9EE5-B16DB43C668F_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl97NdwPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKrHsP/27TL1+4zqJTR/MAy0+TeHZddIh85sxdignb
h1jgHEpgdspXEasqqL6+zbME14+15Ed+mpmmy/me0jKdKNxm7yueDD5ZXAjMKoGV
3kqfH5fZIAGXACKRUiM+PWBluA8VpHhzsuM9/pZLM/mDdaW7wAdnu/xq5ghNwI5V
bHPxFh+IS1ymw3QFQwKawHLqK8ngiZJ9cMY7pLcywMOeKUf1VHHaduZcHXpwW/LW
fJIhNlkj29W07Os9OOHO5+/DJhSmjqvsrUzPE1nwxGPNCEN5O317MTa1iQRFowZS
keB5vsZgjla60RPgd6mSJxIYcYnAM+NZwRSCc8oSKBNvPhFuzbm8dEVB2z5dbrBf
I631kzY2NABM3ywunMHM6H5R1VCdUJ3c3v9C8SMqdgaN4rjb+QHjBu6or5g7+eIf
EB3nwYpsyI3SD0Zyf/ubJBr58+Lsa+V/mNquf1NkuqeKU4NCtlOYRKYUbecUEuDz
9mLrNWCODyygVYGC6ev1kPVKaLQajRDkOxXHButJ+7sAg3oiVkx6joa1wLKUbZ2d
ZpXMYVr2so4dk1ffGOOsUUWruRnwfVMmqsVs5GA0rf6j1jIFONvfriqXjeGdoNxd
TzmyzSUrl7q6Shq3LQOq8HpPmErSW6HL0tEVmRejSplvkJSUzk+S/2gi4rI5ZG+Q
cmVUTOu5
=ci6s
-----END PGP SIGNATURE-----

--=_MailMate_B3260F79-3BA8-4E15-9EE5-B16DB43C668F_=--
