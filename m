Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7741E283F66
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 21:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbgJETOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 15:14:52 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:11061 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgJETOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 15:14:51 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7b70400007>; Mon, 05 Oct 2020 12:13:04 -0700
Received: from [10.2.161.39] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 5 Oct
 2020 19:12:58 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>, <linux-mm@kvack.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Rik van Riel <riel@surriel.com>,
        "Roman Gushchin" <guro@fb.com>, Shakeel Butt <shakeelb@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Nellans <dnellans@nvidia.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 00/30] 1GB PUD THP support on x86_64
Date:   Mon, 5 Oct 2020 15:12:55 -0400
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <302C73F4-27BF-459C-8D78-5CBAF812E5CB@nvidia.com>
In-Reply-To: <20201005155553.GM20115@casper.infradead.org>
References: <20200928175428.4110504-1-zi.yan@sent.com>
 <20200930115505.GT2277@dhcp22.suse.cz>
 <73394A41-16D8-431C-9E48-B14D44F045F8@nvidia.com>
 <20201002073205.GC20872@dhcp22.suse.cz>
 <9a7600e2-044a-50ca-acde-bf647932c751@redhat.com>
 <20201002081023.GA4555@dhcp22.suse.cz>
 <645b35a5-970d-dcfe-2b4a-04ebd4444756@redhat.com>
 <F3606096-EF9F-4F69-89DC-287095B649DC@nvidia.com>
 <20201005155553.GM20115@casper.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
        boundary="=_MailMate_D38E8686-9AFF-4F08-B99D-7F1EB625309E_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601925184; bh=dOZceyI6yUqUSD8fFfUASGjqEJz9c9JEVYKaeZrka8w=;
        h=From:To:CC:Subject:Date:X-Mailer:Message-ID:In-Reply-To:
         References:MIME-Version:Content-Type:X-Originating-IP:
         X-ClientProxiedBy;
        b=mWsYqujQ7uipfpcWpTVH2C72IlExNieHn6qL73Pg0je7Ctxo8oWE6S+vqMdRaUk9T
         h40K2BcQKXhXTl5C/6zVt0m1TRHxUgGcyVLjM8G4sT+yesmNpUCw2ezNeT8wOovFEL
         VRLBHYQwMtsLWGnaRKVw2n+8nIZyj9r+Zk293+/6zifgsWo8nnv0G15PmYEvcCi0Bk
         sbl9r81NegzEOh9vuGSujL2S8WOxdvqo5/ddDl5/qSj1r+p6nLuI+p2IC7XxuvfvFh
         SX9iaFUflR1OpOizFsoLKk91kiyPyLzPzFzR5ybckkN+qT81jPIjOt1HgHK4kB21WE
         27HshDIv8zh/A==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_D38E8686-9AFF-4F08-B99D-7F1EB625309E_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 5 Oct 2020, at 11:55, Matthew Wilcox wrote:

> On Mon, Oct 05, 2020 at 11:03:56AM -0400, Zi Yan wrote:
>> On 2 Oct 2020, at 4:30, David Hildenbrand wrote:
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
>> I agree that the interface should be as simple as no configuration to
>> most users. But I also wonder why we have hugetlbfs to allow users to
>> specify different kinds of page sizes, which seems against the discuss=
ion
>> above. Are we assuming advanced users should always use hugetlbfs inst=
ead
>> of THPs?
>
> Evolution doesn't always produce the best outcomes ;-)
>
> A perennial mistake we've made is "Oh, this is a strange & new & weird
> feature that most applications will never care about, let's put it in
> hugetlbfs where nobody will notice and we don't have to think about it
> in the core VM"
>
> And then what was initially strange & new & weird gradually becomes
> something that most applications just want to have happen automatically=
,
> and telling them all to go use hugetlbfs becomes untenable, so we move
> the feature into the core VM.
>
> It is absurd that my phone is attempting to manage a million 4kB pages.=

> I think even trying to manage a quarter-million 16kB pages is too much
> work, and really it would be happier managing 65,000 64kB pages.
>
> Extend that into the future a decade or two, and we'll be expecting
> that it manages memory in megabyte sized units and uses PMD and PUD
> mappings by default.  PTE mappings will still be used, but very much
> on a "Oh you have a tiny file, OK, we'll fragment a megabyte page into
> smaller pages to not waste too much memory when mapping it" basis.  So,=

> yeah, PUD sized mappings have problems today, but we should be writing
> software now so a Pixel 15 in a decade can boot a kernel built five
> years from now and have PUD mappings Just Work without requiring the
> future userspace programmer to "use hugetlbfs".

I agree.

>
> One of the longer-term todo items is to support variable sized THPs for=

> anonymous memory, just like I've done for the pagecache.  With that in
> place, I think scaling up from PMD sized pages to PUD sized pages start=
s
> to look more natural.  Itanium and PA-RISC (two architectures that will=

> never be found in phones...) support 1MB, 4MB, 16MB, 64MB and upwards.
> The RiscV spec you pointed me at the other day confines itself to addin=
g
> support for 16, 64 & 256kB today, but does note that 8MB, 32MB and 128M=
B
> sizes would be possible additions in the future.

Just to understand the todo items clearly. With your pagecache patchset,
kernel should be able to understand variable sized THPs no matter they
are anonymous or not, right? For anonymous memory, we need kernel policie=
s
to decide what THP sizes to use at allocation, what to do when under
memory pressure, and so on. In terms of implementation, THP split functio=
n
needs to support from any order to any lower order. Anything I am missing=
 here?

>
> But, back to today, what to do with this patchset?  Even on my 16GB
> laptop, let alone my 4GB phone, I'm uncertain that allocating a 1GB
> page is ever the right decision to make.  But my laptop runs a "mixed"
> workload, and if you could convince me that Firefox would run 10% faste=
r
> by using a 1GB page as its in-memory cache, well, I'd be sold.
>
> I do like having the kernel figure out what's in the best interests of =
the
> system as a whole.  Apps don't have enough information, and while they
> can provide hints, they're often wrong.  So, let's say an app maps 8GB
> of anonymous memory.  As the app accesses it, we should probably start
> by allocating 4kB pages to back that memory.  As time goes on and that
> memory continues to be accessed and more memory is accessed, it makes
> sense to keep track of that, replacing the existing 4kB pages with, say=
,
> 16-64kB pages and allocating newly accessed memory with larger pages.
> Eventually that should grow to 2MB allocations and PMD mappings.
> And then continue on, all the way to 1GB pages.
>
> We also need to be able to figure out that it's not being effective
> any more.  One of the issues with tracing accessed/dirty at the 1GB lev=
el
> is that writing an entire 1GB page is going to take 0.25 seconds on a x=
4
> gen3 PCIe link.  I know swapping sucks, but that's extreme.  So to use
> 1GB pages effectively today, we need to fragment them before choosing t=
o
> swap them out (*)  Maybe that's the point where we can start to say "OK=
,
> this sized mapping might not be effective any more".  On the other hand=
,
> that might not work for some situations.  Imagine, eg, a matrix multipl=
y
> (everybody's favourite worst-case scenario).  C =3D A * B where each of=
 A,
> B and C is too large to fit in DRAM.  There are going to be points of t=
he
> calculation where each element of A is going to be walked sequentially,=

> and so it'd be nice to use larger PTEs to map it, but then we need to
> destroy that almost immediately to allow other things to use the memory=
=2E
>
>
> I think I'm leaning towards not merging this patchset yet.  I'm in
> agreement with the goals (allowing systems to use PUD-sized pages
> automatically), but I think we need to improve the infrastructure to
> make it work well automatically.  Does that make sense?

I agree that this patchset should not be merged in the current form.
I think PUD THP support is a part of variable sized THP support, but
current form of the patchset does not have the =E2=80=9Cvariable sized TH=
P=E2=80=9D
spirit yet and is more like a special PUD case support. I guess some
changes to existing THP code to make PUD THP less a special case would
make the whole patchset more acceptable?

Can you elaborate more on the infrastructure part? Thanks.

>
> (*) It would be nice if hardware provided a way to track D/A on a sub-P=
TE
> level when using PMD/PUD sized mappings.  I don't know of any that does=

> that today.

I agree it would be a nice hardware feature, but it also has a high cost.=

Each TLB would support this with 1024 bits, which is about 16 TLB entry s=
ize,
assuming each entry takes 8B space. Now it becomes why not having a bigge=
r
TLB. ;)



=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_D38E8686-9AFF-4F08-B99D-7F1EB625309E_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl97cDcPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKq+QP/jjMIScWlmj70Cb3XRipyiAEuPH+Xo+EJizT
Fe/zmBNncrzJGzL+c6fIvgEbAmZbXOyyO27FjUDGqReyM9SfK0+9kJEA89sgcKCc
Vds3EmCA6rntCJgZqGoHziPcMVTYP5k/AIvukU1IVPZP22SMX5rSfNbz2L0oYNey
9ikL2uEfuomLgIWPS8vvWON32psH4pySm8LfKvRervQK6ToBPC8OsJ/z/NkW934f
R4NfhjZ3Twiw851zhGhRbU2a7TUr6oMAEVNRa5CnLH8iIEzIALO1eXtvOE/gQRrS
ejIU2qJDfnr24RXZxhtrSFPYXIWkpYQnST9hyywtsr50OpG3LXoQPcZQ55yFvO1d
MWKcoy2DSFckHu5otzxLIObZJ6JsKNS65nFgPV/opExAShwKm3bmGynLH8zdIwum
pUjEI+/859Fs4R4egknF5CC5v4fX0/i6Gld3wTT4uZXR5kBldzxtO9qeyA7xWTIL
vE5SyRVXjza3Hb19H/DCxy/MAHihL1Gz99G0l7n16R74uYqI7VkmTH948CCxSjiq
yhOcN0u1DCulKLSVz+KVQ7U5GIcayLpYrOT1VlsoHsQvR/Xo+B9EEnGlV/PclleR
4IBXBrL1tb4y/ZMXj1gt9lHLeWG7fdp6KHgtp0ImGMQeSB1UyEoEpqPVkB93fag6
WMMMWKjo
=5Ftw
-----END PGP SIGNATURE-----

--=_MailMate_D38E8686-9AFF-4F08-B99D-7F1EB625309E_=--
