Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF7A280246
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 17:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732598AbgJAPOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 11:14:23 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:13625 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732368AbgJAPOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 11:14:22 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f75f2410000>; Thu, 01 Oct 2020 08:14:09 -0700
Received: from [10.2.161.39] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 1 Oct
 2020 15:14:16 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Michal Hocko <mhocko@suse.com>
CC:     <linux-mm@kvack.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        William Kucharski <william.kucharski@oracle.com>,
        "Andrea Arcangeli" <aarcange@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "David Nellans" <dnellans@nvidia.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 00/30] 1GB PUD THP support on x86_64
Date:   Thu, 1 Oct 2020 11:14:14 -0400
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <73394A41-16D8-431C-9E48-B14D44F045F8@nvidia.com>
In-Reply-To: <20200930115505.GT2277@dhcp22.suse.cz>
References: <20200928175428.4110504-1-zi.yan@sent.com>
 <20200930115505.GT2277@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
        boundary="=_MailMate_4911C37C-2287-4A21-975B-AB019A841C25_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601565249; bh=w71nksGlHguYUsCotx0z4gQN1upgSO+zA+9EekCz0EU=;
        h=From:To:CC:Subject:Date:X-Mailer:Message-ID:In-Reply-To:
         References:MIME-Version:Content-Type:X-Originating-IP:
         X-ClientProxiedBy;
        b=MeSyPqKHIPuH0Vh/7qZFdQWmouEB+ZlTEXqtX5oSBfdJammGc2OCbXIpVQf1VBioi
         fa4ObFwx971nK51CpOdHRvIC8mRxA/mtZphc9kzQKi33q9Pp8//iFcUraEJLdg2g5u
         wYCZjy+IDn60qG3fWQtLWyc4O7ydgxQb6mFWISJ/lRzU90LvKzIj89yN9EHhw2OkAr
         dHaF9GQN0Bwk3869hLij4xs3Ytci0cXXSLB6ArfKo9NZADO3eFMDD08Jn5sN4l04N/
         Inae2j90DYZIJb8wZsW+fQRgnAzmJnVvsAHO6+6YI4vmTlF7oPOKZqCWJwVK4X2Fu3
         lJunM/5ph8Mcg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_4911C37C-2287-4A21-975B-AB019A841C25_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 30 Sep 2020, at 7:55, Michal Hocko wrote:

> On Mon 28-09-20 13:53:58, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> Hi all,
>>
>> This patchset adds support for 1GB PUD THP on x86_64. It is on top of
>> v5.9-rc5-mmots-2020-09-18-21-23. It is also available at:
>> https://github.com/x-y-z/linux-1gb-thp/tree/1gb_thp_v5.9-rc5-mmots-202=
0-09-18-21-23
>>
>> Other than PUD THP, we had some discussion on generating THPs and cont=
iguous
>> physical memory via a synchronous system call [0]. I am planning to se=
nd out a
>> separate patchset on it later, since I feel that it can be done indepe=
ndently of
>> PUD THP support.
>
> While the technical challenges for the kernel implementation can be
> discussed before the user API is decided I believe we cannot simply add=

> something now and then decide about a proper interface. I have raised
> few basic questions we should should find answers for before the any
> interface is added. Let me copy them here for easier reference
Sure. Thank you for doing this.

For this new interface, I think it should generate THPs out of populated
memory regions synchronously. It would be complement to khugepaged, which=

generate THPs asynchronously on the background.

> - THP allocation time - #PF and/or madvise context
I am not sure this is relevant, since the new interface is supposed to
operate on populated memory regions. For THP allocation, madvise and
the options from /sys/kernel/mm/transparent_hugepage/defrag should give
enough choices to users.

> - lazy/sync instantiation

I would say the new interface only does sync instantiation. madvise has
provided the lazy instantiation option by adding MADV_HUGEPAGE to populat=
ed
memory regions and letting khugepaged generate THPs from them.

> - huge page sizes controllable by the userspace?

It might be good to allow advanced users to choose the page sizes, so the=
y
have better control of their applications. For normal users, we can provi=
de
best-effort service. Different options can be provided for these two case=
s.
The new interface might want to inform user how many THPs are generated
after the call for them to decide what to do with the memory region.

> - aggressiveness - how hard to try

The new interface would try as hard as it can, since I assume users reall=
y
want THPs when they use this interface.

> - internal fragmentation - allow to create THPs on sparsely or unpopula=
ted
>   ranges

The new interface would only operate on populated memory regions. MAP_POP=
ULATE
like option can be added if necessary.


> - do we need some sort of access control or privilege check as some THP=
s
>   would be a really scarce (like those that require pre-reservation).

It seems too much to me. I suppose if we provide page size options to use=
rs
when generating THPs, users apps could coordinate themselves. BTW, do we =
have
access control for hugetlb pages? If yes, we could borrow their method.


=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_4911C37C-2287-4A21-975B-AB019A841C25_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl918kYPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKd7YP/3uDCyGVqQmubnazt7xDgvEnQDbeT/2JuiCn
/Ak5skrOeFDm9onIB66bI+gS3ErpAj4IGOqYKYmZ5eU4fkUU+6WFZCpIQebc51gQ
vai0pg8gI2XgjzmWuUNGLbjR8yBGfE8WEos0386ZZiTdW8acl7Fs3wEJJa4CUXSi
25i0/u9KLBvvSqGYNxFZzqoYRy+ta+pnQLtBU60zs/8vJESCnRBJRf4EbsjD0OZC
hoQQ9Olg8BGAUlP7/K7ueo5L/efg+vvvFyqKRLWIH0rC4SKQV8SWjIKprLIcqVGg
zbRR5yCnMPhTcqq1aOKI7tyObbUVnVLYREuJIO7vb9rZs/5SchXs1XzayJjhXfuE
xe6XYQK9QH5cr3d3uA8hYBonbgefqrSENpjUDwzGVuktzJi9sh5F6iZYX8rsHs0x
Lbnq/IjLf62iZjqhf6ueIDcdjzTw9tzmaPbU9H5Ykvr1iVnnYS/U2wiDl48i0oXu
xTXNXlWKn2uDZZiXetrPl1tlAQcmvxlQTCZBOkyW8CYIm0Qjvye0V4hjJ6qhomlQ
LTgonRlhpQ3NwzC/eIsTiYKiyE4jKG1kp/yhbiZmQW+MP6q2V+4jKYzniwPFtn/9
3QcqnjKdZOpV/EJZgmRSezX+pHKc8Fk4Z4VBeFZsvAuNcBX3PGsFKPgdQO0w247Y
x/+DifLK
=6UQJ
-----END PGP SIGNATURE-----

--=_MailMate_4911C37C-2287-4A21-975B-AB019A841C25_=--
