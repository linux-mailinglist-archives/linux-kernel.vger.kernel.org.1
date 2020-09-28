Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1884327B665
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 22:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbgI1UfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 16:35:01 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:5031 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbgI1UfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 16:35:01 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7248900000>; Mon, 28 Sep 2020 13:33:20 -0700
Received: from [10.2.161.19] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 28 Sep
 2020 20:34:57 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     <linux-mm@kvack.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        William Kucharski <william.kucharski@oracle.com>,
        "Andrea Arcangeli" <aarcange@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "David Nellans" <dnellans@nvidia.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 03/30] mm: thp: use single linked list for THP page
 table page deposit.
Date:   Mon, 28 Sep 2020 16:34:55 -0400
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <13ABC58F-F1FD-45CF-A1D4-132BEE120CED@nvidia.com>
In-Reply-To: <20200928193428.GB30994@casper.infradead.org>
References: <20200928175428.4110504-1-zi.yan@sent.com>
 <20200928175428.4110504-4-zi.yan@sent.com>
 <20200928193428.GB30994@casper.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
        boundary="=_MailMate_83ECF82A-1505-4C55-ABCA-DBCDD06046C5_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601325200; bh=D2V6H3YxgUz1ManjZAWAmwkYbEARtMvgkOEk16ytmJg=;
        h=From:To:CC:Subject:Date:X-Mailer:Message-ID:In-Reply-To:
         References:MIME-Version:Content-Type:X-Originating-IP:
         X-ClientProxiedBy;
        b=gYV3+K0uvAs5wgpZFmhWIDm1LAkrsgg6oLLJJ6wnnKn7a4Szpdv1FJk29mid7/DDk
         TOGA5L5xGWQbHqNGT6uY4NOy/Xe0IScYNK1G6NqRPvWsD6NMtzXPQ4s3DyRNJ+xxxp
         3ynVfeH/gTtDRM9rsaLxmtCg+wbb98EV7Y6EE8BtdZ8vAaGxkE97w+R63JPXKD4Q8n
         2+sDYpGbJBAOtIADp3D+INJUuylF4XnMLMJa2qONkHBiEb3PkxH0LF8sIG1IrZlrZI
         hqpp1mZb+igcjqQ2Qy6PWfgvtkzgTUc7iOgalkPX17o5/KtqWrDf/HcrgfKzSkna/U
         K7wIB7BVgyrtA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_83ECF82A-1505-4C55-ABCA-DBCDD06046C5_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 28 Sep 2020, at 15:34, Matthew Wilcox wrote:

> On Mon, Sep 28, 2020 at 01:54:01PM -0400, Zi Yan wrote:
>>  		struct {	/* Page table pages */
>> -			unsigned long _pt_pad_1;	/* compound_head */
>> -			pgtable_t pmd_huge_pte; /* protected by page->ptl */
>> +			struct llist_head deposit_head; /* pgtable deposit list head */
>> +			struct llist_node deposit_node; /* pgtable deposit list node */
>
> If you're going to use two pointers anyway, you might as well use a
> list_head.  But I don't think you need to; you could either use a union=

> of these or you could use the page_address() of the page to store as
> much information as you like!

This is intended for depositing pgtable pages hierarchically. PUD THP
pgtable page deposit uses it. For a PUD THP, we need to deposit 1 PMD
pgtable page and 512 PTE pgtable pages, totally 513 pages.

One way is to deposit all of them on a list, but when we split the PUD
THP, we need to pull them all out and use one for PMD pgtable page
and deposit the rest 512 PTE pgtable pages to PMD page=E2=80=99s pmd_huge=
_pte.
But this mixes PMD pgtable pages and PTE pgtable pages in one list,
which can be error prone and also requires extra pgtable page deposit
operations during page split.

This approach, at the high level, makes a pgtable page=E2=80=99s deposit_=
head
point to a list of lower level pgtable pages, which are linked using
deposit_node. For example, we link all 512 PTE pgtable pages using
deposit_node and use PMD pgtable page=E2=80=99s deposit_head to point to =
the
PTE page list. In addition, when we deposit the PMD pgtable page,
we just point a struct_llist_head to the PMD pgtable page=E2=80=99s depos=
it_node.
When it comes to PUD THP split, we can simply withdraw and use the PMD
pgtable page without additional operations, since PTE pgtable pages
have already been deposited at the beginning.

Let me know if it makes sense to you. I will add the paragraphs above
to the commit message. Swapping patch 4 and 5 might also make the change
easier to understand since patch 5 use this patch.


=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_83ECF82A-1505-4C55-ABCA-DBCDD06046C5_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl9ySO8PHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKoGkQAKV82OEF77appH1OFz2MqoDmHo6e199Rh095
hRkKAt0xYOrrFTBgGfMXZAkLhGwvZzb97FMSU2kyt7uNF+T2TraDn+KCMnEinIQq
h+bVxoSww3grUsyadTnJuTLuug95/Uv0zvIaTuAeZSPTIYvh3C5B91KRoStuL5c8
BNBzaMUjZfvCWMTOizgf4rihSn5y1f1jMaw5nWSkt24eXlV4nE5Tk2xnynwKAWOW
V2EcJkiL+DTLjgbcP037XuB79Fe7kyHKkV2JEiDa7xSbJSG9Vw0agKXETvJkKExJ
K7wRUqKMOt9NQFnQJX0gSHVhhdYVR+GiVHtgCxHttz/ZpmBfOfdPgGirOg+8fC/h
AtWeGQOA1Gfe0E6Lo4o4ovqAZFBzuWl/8fXbkuZSd94ZBaGD5A0SC/rH48h6JSpP
FKGK2tuIg6RRp2IZxz3Qph0U6q/orwV+xOqioZMRhtPpe5OTLXCsicmd40BVu5hI
M2pgupc2GJitBZ2iWtCGvjYv+wjvMp42Vy9b4pgYfMOE8eu5V9D6HIjg8YfZQC0U
FmaJOTbhFXqjSSC4whxSQ6WdvoEHqKxbSn3jiRuI8NLqy5jMF6u3UN5rmVQeUuo1
AyEaGfhYuV/gw8q3OUCNuTVmQXHKfnYBSp+K5dThyKTQwwIPqDxbLwH+kUBmgEgf
UMJ4/Frr
=VR4d
-----END PGP SIGNATURE-----

--=_MailMate_83ECF82A-1505-4C55-ABCA-DBCDD06046C5_=--
