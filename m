Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7679C283A6D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 17:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgJEPeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 11:34:19 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:12708 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727146AbgJEPeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 11:34:11 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7b3cbb0001>; Mon, 05 Oct 2020 08:33:15 -0700
Received: from [10.2.161.39] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 5 Oct
 2020 15:34:05 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     David Hildenbrand <david@redhat.com>, Roman Gushchin <guro@fb.com>
CC:     Michal Hocko <mhocko@suse.com>, <linux-mm@kvack.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Rik van Riel <riel@surriel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Mike Kravetz" <mike.kravetz@oracle.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "John Hubbard" <jhubbard@nvidia.com>,
        David Nellans <dnellans@nvidia.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 00/30] 1GB PUD THP support on x86_64
Date:   Mon, 5 Oct 2020 11:34:02 -0400
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <021D3552-4C75-4B82-BDE5-AFA6E0315051@nvidia.com>
In-Reply-To: <9a7600e2-044a-50ca-acde-bf647932c751@redhat.com>
References: <20200928175428.4110504-1-zi.yan@sent.com>
 <20200930115505.GT2277@dhcp22.suse.cz>
 <73394A41-16D8-431C-9E48-B14D44F045F8@nvidia.com>
 <20201002073205.GC20872@dhcp22.suse.cz>
 <9a7600e2-044a-50ca-acde-bf647932c751@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
        boundary="=_MailMate_CB2033C2-8117-4BDB-80EB-32CE4307F2DF_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601911995; bh=qrftAgQVD/EzCC4R77V5PF2fGyxxv3FP2bn6MURc4qQ=;
        h=From:To:CC:Subject:Date:X-Mailer:Message-ID:In-Reply-To:
         References:MIME-Version:Content-Type:X-Originating-IP:
         X-ClientProxiedBy;
        b=TVIIgN0C8SohqhJ6ZOhUs7rcHeGFu4PVYUn64nhS+O1oaHwXZzJi6ilmLjq4YowjE
         0YGnp1WobEmE+SmpHAbyXbHrXXphTtkq7CmWJqe+Wc6pSLLrXWz8hbXIPUHBXAB9Ya
         4wt5peElV2zf1ka5VUEDZfvFZIXykT1H7IEpXdhI6HTZkU5T2apFjws0ly2ne2mzHG
         4hnCFrTAosMid1HlboaW1lMWFxSxDi2py2vmhcNAuMcnzwmyWJy2IfD+cayMy2wi/2
         CsDCxadljpbMS+GvEL445UkzIFxAqtEBBRMsxPYETnyVxgK1aPt9z0vERZ+ZGi7kAA
         zAnvZJ4Ez1fZQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_CB2033C2-8117-4BDB-80EB-32CE4307F2DF_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 2 Oct 2020, at 3:50, David Hildenbrand wrote:

>>>> - huge page sizes controllable by the userspace?
>>>
>>> It might be good to allow advanced users to choose the page sizes, so=
 they
>>> have better control of their applications.
>>
>> Could you elaborate more? Those advanced users can use hugetlb, right?=

>> They get a very good control over page size and pool preallocation etc=
=2E
>> So they can get what they need - assuming there is enough memory.
>>
>
> I am still not convinced that 1G THP (TGP :) ) are really what we want
> to support. I can understand that there are some use cases that might
> benefit from it, especially:
>
> "I want a lot of memory, give me memory in any granularity you have, I
> absolutely don't care - but of course, more TGP might be good for
> performance." Say, you want a 5GB region, but only have a single 1GB
> hugepage lying around. hugetlbfs allocation will fail.
>
>
> But then, do we really want to optimize for such (very special?) use
> cases via " 58 files changed, 2396 insertions(+), 460 deletions(-)" ?

I am planning to further refactor my code to reduce the size and make
it more general to support any size of THPs. As Matthew=E2=80=99s patchse=
t[1]
is removing kernel=E2=80=99s THP size assumption, it might be a good time=
 to
make THP support more general.

>
> I think gigantic pages are a sparse resource. Only selected application=
s
> *really* depend on them and benefit from them. Let these special
> applications handle it explicitly.
>
> Can we have a summary of use cases that would really benefit from this
> change?

For large machine learning applications, 1GB pages give good performance =
boost[2].
NVIDIA DGX A100 box now has 1TB memory, which means 1GB pages are not
that sparse in GPU-equipped infrastructure[3].

In addition, @Roman Gushchin should be able to provide a more concrete
story from his side.


[1] https://lore.kernel.org/linux-mm/20200908195539.25896-1-willy@infrade=
ad.org/
[2] http://learningsys.org/neurips19/assets/papers/18_CameraReadySubmissi=
on_MLSys_NeurIPS_2019.pdf
[3] https://www.nvidia.com/content/dam/en-zz/Solutions/Data-Center/nvidia=
-dgx-a100-datasheet.pdf

=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_CB2033C2-8117-4BDB-80EB-32CE4307F2DF_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl97POoPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKUWUP/2iZhl7ezUaDgRc+j+lqT7NpBCUZkK0NBn2T
hjQRrzPp5DjejW3Bmv3WUm9wuZD2NID4UE0KswpmqYLJEp5kkFrscL01GCwYFxcD
d1o+jgnD9xQMgx/E92sPpyO27rq1370M785T3ytV9KFQ2Thwngt1jn9RbSbwExc5
8SasCDzLyuHow0i5KGk7MtDkU4+UgF3vWHwELKFePUhe+MXRX73/kRjRWXUKcKZO
jgXUo7FqxOPvBsvgOumkc/Ych7YUzUqeVAZ/jNsDbbaP9RBP+WVVeVIG1GV1YqP5
Dj67yKwfilslxHrj6SkKB2h82s/b5f2vreov88q8Y8Y+I6wfpyMOP+SdL2/bWXja
0ttqa3wxp+d680YxLzZvLZYYv5z+SMo4W2EUtqK1igl67qJ3ZuHnKHb+a9SVJYJJ
D+2PhVLQc4xGJ2dhMqgeTCaFql28OenoKC+QIvxSdf0fa8rOa+apT2l1H9ITIFXq
c55Cz8pLY0XLDeF7hqwQPNT/7xAkBXYxWLqv9ViOHHa4BQjTdqFG85d7IvJsZOVn
4evzocWd3ArrvQrJCJGNd7JW0p9SOFQRB7vtOE6Zea+M+vfFx0saQtfv7NC2gLvH
dtXZ0K+6JtNvINAmD7PgTzhiAoVWS579ce83sh9y1trpX/APW+4H2vCZhLPNPot7
Ti3y9wSW
=1T4B
-----END PGP SIGNATURE-----

--=_MailMate_CB2033C2-8117-4BDB-80EB-32CE4307F2DF_=--
