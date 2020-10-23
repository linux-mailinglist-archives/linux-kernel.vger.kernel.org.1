Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF96296834
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 02:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374189AbgJWA6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 20:58:14 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:2257 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2901407AbgJWA6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 20:58:14 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f922a990000>; Thu, 22 Oct 2020 17:58:01 -0700
Received: from [10.2.173.3] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 23 Oct
 2020 00:58:12 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Roman Gushchin <guro@fb.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        <saberlily.xia@hisilicon.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <kernel-team@fb.com>
Subject: Re: [PATCH v1 0/2] mm: cma: introduce a non-blocking version of
 cma_release()
Date:   Thu, 22 Oct 2020 20:58:10 -0400
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <09C785FF-8FEA-4178-9172-4E41C173E82A@nvidia.com>
In-Reply-To: <20201023004739.GH300658@carbon.dhcp.thefacebook.com>
References: <20201022225308.2927890-1-guro@fb.com>
 <F8551A10-E254-44FC-B28E-9E7F8AC14B57@nvidia.com>
 <20201023004739.GH300658@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
        boundary="=_MailMate_3F54904D-4ACE-4B66-8101-E086CACBEC8E_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603414681; bh=nM0eKBYIq5L+uXKx3FvXdPIBvrvzPf2aMSTaYXzWw50=;
        h=From:To:CC:Subject:Date:X-Mailer:Message-ID:In-Reply-To:
         References:MIME-Version:Content-Type:X-Originating-IP:
         X-ClientProxiedBy;
        b=lyQxg1wFlUJQj24dQSxzv2IleqbLOMTF+6CRcVQvaB/btkfT3YxOQqwO85Yf9rP9A
         HavNoUvlKAITcwO371fz639ZvJerbfT04/l0BTMTy2Gr8mFkZ5yzlVuryqMUoaaXF7
         E49vmyvsegd0H7dfLoIxza+nio+ru5GZeOVT2c7EYfVQ3kg93SYOZSauV28nZP66WA
         t2WL0ZYvB8TEH/XUvezHiVNB6mos3+rnOTXH9ucXN/eAjMWtocRjRhOPCVPBWWsgQr
         xE3B2bH+voB00QzivYxUvq3PsUSihKX3S8KNGQNrApDWPhqL17FJPeoYdl+EqAeRMY
         C92vubK01XzYA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_3F54904D-4ACE-4B66-8101-E086CACBEC8E_=
Content-Type: text/plain; charset="UTF-8"; markup=markdown
Content-Transfer-Encoding: quoted-printable

On 22 Oct 2020, at 20:47, Roman Gushchin wrote:

> On Thu, Oct 22, 2020 at 07:42:45PM -0400, Zi Yan wrote:
>> On 22 Oct 2020, at 18:53, Roman Gushchin wrote:
>>
>>> This small patchset introduces a non-blocking version of cma_release(=
)
>>> and simplifies the code in hugetlbfs, where previously we had to
>>> temporarily drop hugetlb_lock around the cma_release() call.
>>>
>>> It should help Zi Yan on his work on 1 GB THPs: splitting a gigantic
>>> THP under a memory pressure requires a cma_release() call. If it's
>>
>> Thanks for the patch. But during 1GB THP split, we only clear
>> the bitmaps without releasing the pages. Also in cma_release_nowait(),=

>> the first page in the allocated CMA region is reused to store
>> struct cma_clear_bitmap_work, but the same method cannot be used
>> during THP split, since the first page is still in-use. We might
>> need to allocate some new memory for struct cma_clear_bitmap_work,
>> which might not be successful under memory pressure. Any suggestion
>> on where to store struct cma_clear_bitmap_work when I only want to
>> clear bitmap without releasing the pages?
>
> It means we can't use cma_release() there either, because it does clear=

> individual pages. We need to clear the cma bitmap without touching page=
s.
>
> Can you handle an error there?
>
> If so, we can introduce something like int cma_schedule_bitmap_clearanc=
e(),
> which will allocate a work structure and will be able to return -ENOMEM=

> in the unlikely case of error.
>
> Will it work for you?

Yes, it works. Thanks.

=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_3F54904D-4ACE-4B66-8101-E086CACBEC8E_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl+SKqIPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKzN4QAJBztkS2oOkDx2OKEHvJfKlo14kSjvTDXEHq
rRYgOQBjk0cXqhT0DeLJ0KvitmEZUWWR/bhlQ4yWUWDOvfc+X/LM3PuEOmlc2djR
LJOoaS1wrDrltyT7apFmNW4n/PP/TGL3IFxcZy3VA96t9NKZtkNrTfZPpZhMQYVf
Gn9yCELGkYPpm7D5TTIr9xt23jT+dtVrakAdXa7DCuzCKuHEInjo3RlNThO7xNzK
wse9HEugSfTPyXRpAxf7WgtNjKfWzsDN5m9k7e8owE8TZfv9qM3uH8zlYuJMDdGi
ey7uanT9B9vC93HkeEf73fcKG3sjY3v37xGTVjl2P04cZkMgLUawtaUE1Cw2runz
DTHNz/sp8R56ci5sbdG3XW6vr7uukStYS9dV0mN9wgW46Ga4uHGXvaPX7INTrBCA
K+0V+nCnLJaxoyffa1OEoZLzl6wlV6m71QrsIBYdA0ILvrrGqeU9AQvCboMwrYSL
7WG4aVPP291dimOrOwbJmjRkKuuJqdHIfBz5NQw8sG3sHsAFoM121RBmxouOuc5K
3UtzARDa/Msqby+urLcyuFe7SjDABCAjmFIO/tc/biF1NdTyD/90lbQ+2g8Okgkt
8gB3VJdzIFNyAl7CMaKTKimUQnciCDZKjaEGoJEy24Eu+7f34VnixoWyMQXW+tSW
HY3tMKFE
=mmUM
-----END PGP SIGNATURE-----

--=_MailMate_3F54904D-4ACE-4B66-8101-E086CACBEC8E_=--
