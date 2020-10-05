Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1C22283DFD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 20:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbgJESI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 14:08:58 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:13996 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726745AbgJESI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 14:08:58 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7b612d0002>; Mon, 05 Oct 2020 11:08:45 -0700
Received: from [10.2.161.39] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 5 Oct
 2020 18:05:20 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     David Hildenbrand <david@redhat.com>
CC:     Michal Hocko <mhocko@suse.com>, <linux-mm@kvack.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Shakeel Butt" <shakeelb@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "John Hubbard" <jhubbard@nvidia.com>,
        David Nellans <dnellans@nvidia.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 00/30] 1GB PUD THP support on x86_64
Date:   Mon, 5 Oct 2020 14:05:17 -0400
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <8850ABA0-0B42-41DB-9ADC-0E2BB1F841D0@nvidia.com>
In-Reply-To: <f84c2b88-9912-d716-e83e-749fbfb6ff30@redhat.com>
References: <20200928175428.4110504-1-zi.yan@sent.com>
 <20200930115505.GT2277@dhcp22.suse.cz>
 <73394A41-16D8-431C-9E48-B14D44F045F8@nvidia.com>
 <20201002073205.GC20872@dhcp22.suse.cz>
 <9a7600e2-044a-50ca-acde-bf647932c751@redhat.com>
 <20201002081023.GA4555@dhcp22.suse.cz>
 <645b35a5-970d-dcfe-2b4a-04ebd4444756@redhat.com>
 <F3606096-EF9F-4F69-89DC-287095B649DC@nvidia.com>
 <f84c2b88-9912-d716-e83e-749fbfb6ff30@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
        boundary="=_MailMate_8F090C96-5C7C-4AEA-8315-719BF2F380AC_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601921325; bh=BcZ2gYOOKBL5HBWyeKOqfcvbcJ6g3mIy5GoFE1IjT00=;
        h=From:To:CC:Subject:Date:X-Mailer:Message-ID:In-Reply-To:
         References:MIME-Version:Content-Type:X-Originating-IP:
         X-ClientProxiedBy;
        b=XjwbTgLgG430D3wfsx5WcyXUHw2l9mOiRNCeDODFV7nBeu59gekg/jcykCvvvPMkf
         BpQgmc3bLB5EthJes3sssMbcC+7HP4rYFKwxeLyj0dm1QR5iupIzCcJbyOgPLTiZls
         uefrxnt+ssZqzhRfpOY9etk2zb8ibrPWNuvuOhUyp1HSfapfMupDxZuTa6wrU1j8R8
         UXmEwaP9u5ttlxMeShQqO+muKaYXSXPbvQE3rT5DRWR4LlAHULPtVsGEJ/Mmfe2y6s
         qIpedAAyvTpJIj0PAwNdZPAmuVjgO/M3B9PHCs9j0DFrKTeWx+ewAy2BnIXaJtxR62
         4eZOKpo1VIkiQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_8F090C96-5C7C-4AEA-8315-719BF2F380AC_=
Content-Type: text/plain; charset="UTF-8"; markup=markdown
Content-Transfer-Encoding: quoted-printable

On 5 Oct 2020, at 13:39, David Hildenbrand wrote:

>>>> consideting that 2MB THP have turned out to be quite a pain but
>>>> situation has settled over time. Maybe our current code base is prep=
ared
>>>> for that much better.
>>
>> I am planning to refactor my code further to reduce the amount of
>> the added code, since PUD THP is very similar to PMD THP. One thing
>> I want to achieve is to enable split_huge_page to split any order of
>> pages to a group of any lower order of pages. A lot of code in this
>> patchset is replicating the same behavior of PMD THP at PUD level.
>> It might be possible to deduplicate most of the code.
>>
>>>>
>>>> Exposing that interface to the userspace is a different story of cou=
rse.
>>>> I do agree that we likely do not want to be very explicit about that=
=2E
>>>> E.g. an interface for address space defragmentation without any more=

>>>> specifics sounds like a useful feature to me. It will be up to the
>>>> kernel to decide which huge pages to use.
>>>
>>> Yes, I think one important feature would be that we don't end up plac=
ing
>>> a gigantic page where only a handful of pages are actually populated
>>> without green light from the application - because that's what some u=
ser
>>> space applications care about (not consuming more memory than intende=
d.
>>> IIUC, this is also what this patch set does). I'm fine with placing
>>> gigantic pages if it really just "defragments" the address space layo=
ut,
>>> without filling unpopulated holes.
>>>
>>> Then, this would be mostly invisible to user space, and we really
>>> wouldn't have to care about any configuration.
>>
>>
>> I agree that the interface should be as simple as no configuration to
>> most users. But I also wonder why we have hugetlbfs to allow users to
>> specify different kinds of page sizes, which seems against the discuss=
ion
>> above. Are we assuming advanced users should always use hugetlbfs inst=
ead
>> of THPs?
>
> Well, with hugetlbfs you get a real control over which pagesizes to use=
=2E
> No mixture, guarantees.
>
> In some environments you might want to control which application gets
> which pagesize. I know of database applications and hypervisors that
> sometimes really want 2MB huge pages instead of 1GB huge pages. And
> sometimes you really want/need 1GB huge pages (e.g., low-latency
> applications, real-time KVM, ...).
>
> Simple example: KVM with postcopy live migration
>
> While 2MB huge pages work reasonably fine, migrating 1GB gigantic pages=

> on demand (via userfaultdfd) is a painfully slow / impractical.


The real control of hugetlbfs comes from the interfaces provided by
the kernel. If kernel provides similar interfaces to control page sizes
of THPs, it should work the same as hugetlbfs. Mixing page sizes usually
comes from system memory fragmentation and hugetlbfs does not have this
mixture because of its special allocation pools not because of the code
itself. If THPs are allocated from the same pools, they would act
the same as hugetlbfs. What am I missing here?

I just do not get why hugetlbfs is so special that it can have pagesize
fine control when normal pages cannot get. The =E2=80=9Cit should be invi=
sible
to userpsace=E2=80=9D argument suddenly does not hold for hugetlbfs.


=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_8F090C96-5C7C-4AEA-8315-719BF2F380AC_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl97YF4PHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKJn0P/RtNaniQSHTt731jX5X5xpYKe9T2/ac92LWS
pfLJIbuzn0qGkzS205msQbGK3IyHFl7cWLUIBI9ebR1KQX6o8lCSWRpChCyOpDWK
G7dL56OfJj0qZUPwTiV6/qm8F2GA0fIF4Eo49bACZn6yBGceayDyI+QiJBqvRqp6
9X1ATNK1IJMQHt5hbOaALraCSRtwP5CAw0zLBV7zNEqI66ljXh4yAI6ae+3I5nel
wPEOV1eMqxVR0tO4VWqwTisLQHgY4OH+7JXdwdR/2X6VL09UQPHmVaBawxwKR6Od
mo/IMsvTVfNZ13PSa2JoY4OCjFuFvfvER/gmwf2m5vk4DtpOehdRjOTieFXnju6C
CPEmgUjsBwMvg7Fhr4t09N8/bqopOA66Sz/OAqTR2ME8DSfpG441gKXXId/6wEUd
hm9zvAthoAn9SiTYCdG48QC22qt4Wo33V1uOTBBD+Tbv64DBOmREZHE6Mi+9jZPR
r0EGhJN2cJgUMxNqKCY/o35gcO3OAkMCKFoyybDFtBeu2BWfjj5r4LtwZOVbR84f
Rs/BJfSsn5YTIDo0SeQE8i0a4dijlTF3pH5rLjwl48fFk46rsSNeqZ7hlCFL7hHL
k6pvhVoClwEc+LnuD5Xo39XOtzzT/3vM4Y1v1eIA9ssmXycDkfKpjQWAGawabB5P
a5CO8NkP
=ygLd
-----END PGP SIGNATURE-----

--=_MailMate_8F090C96-5C7C-4AEA-8315-719BF2F380AC_=--
