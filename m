Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 602402A0968
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 16:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgJ3PSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 11:18:11 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:16533 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgJ3PSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 11:18:10 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f9c2ebd0000>; Fri, 30 Oct 2020 08:18:21 -0700
Received: from [10.2.173.19] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 30 Oct
 2020 15:18:09 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        Rik van Riel <riel@surriel.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/compaction: count pages and stop correctly during page
 isolation.
Date:   Fri, 30 Oct 2020 11:18:07 -0400
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <7C9FAF14-075D-4E29-B5F5-ADF15E687C3A@nvidia.com>
In-Reply-To: <16bdfad8-05f9-6ecf-0db6-c2dcf8e60309@suse.cz>
References: <20201029200435.3386066-1-zi.yan@sent.com>
 <16bdfad8-05f9-6ecf-0db6-c2dcf8e60309@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
        boundary="=_MailMate_12CC4A4F-A68B-42A0-802B-75C263460CC2_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604071101; bh=IZcvHFrEo6j+XKYW2oDy7BzNNWblNOa44181hJqkZ6U=;
        h=From:To:CC:Subject:Date:X-Mailer:Message-ID:In-Reply-To:
         References:MIME-Version:Content-Type:X-Originating-IP:
         X-ClientProxiedBy;
        b=LO/3QOVvOhkD4eDacszYN71WOrEqnXGsmcscKgrUErVo0wG+YiQjq/kok1ysmBQg6
         +xYkhNP8WOa3GIYfCJixuimii24psf9Jjqa0TujqJuZ/hRhkW6Nc8fOgDI+530knrX
         ng5YDc7hovyOpGf/nK7WeSiJTXceNmkVdoKwN3YApwuqIV2VXJuCjMwq6GxlTQIsue
         IfdIQV8hUTO+aF6fEeDMEWK3eQPQDX9JlNVrYhKtGAXM3ukEIEI9Pszt1k2UOvIVpb
         kzkL4/QTQZq2TBNkxj2EwWB4GPJybWKXv/6F4e7Gnqa8bnE4MX0CekX0CsC8IZa+U2
         KIn9L8giNN2Tw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_12CC4A4F-A68B-42A0-802B-75C263460CC2_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 30 Oct 2020, at 10:50, Vlastimil Babka wrote:

> On 10/29/20 9:04 PM, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> In isolate_migratepages_block, when cc->alloc_contig is true, we are
>> able to isolate compound pages, nr_migratepages and nr_isolated did no=
t
>> count compound pages correctly, causing us to isolate more pages than =
we
>> thought. Use thp_nr_pages to count pages. Otherwise, we might be trapp=
ed
>> in too_many_isolated while loop, since the actual isolated pages can g=
o
>> up to COMPACT_CLUSTER_MAX*512=3D16384, where COMPACT_CLUSTER_MAX is 32=
,
>> since we stop isolation after cc->nr_migratepages reaches to
>> COMPACT_CLUSTER_MAX.
>
> I wonder if a better fix would be to adjust the too_many_isolated() che=
ck so that if we have non-zero cc->nr_migratepages, we bail out from furt=
her isolation and migrate what we have immediately, instead of looping.

I just tested your fix and it works too. The difference is that with
your fix alloc_contig_range will fail quickly without killing the user
application mlocking THPs in the CMA region (for more context, please
see my other email to Andrew explaining how to reproduce in userspace),
whereas my fix will oom the user application and make alloc_contig_range
successful at the end.

Anyway, I will add your fix below and send v2:

diff --git a/mm/compaction.c b/mm/compaction.c
index ee1f8439369e..8fa11637ccfd 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -817,6 +817,9 @@ isolate_migratepages_block(struct compact_control *cc=
, unsigned long low_pfn,
         * delay for some time until fewer pages are isolated
         */
        while (unlikely(too_many_isolated(pgdat))) {
+               /* stop isolation if there are still pages not migrated *=
/
+               if (cc->nr_migratepages)
+                       return 0;
                /* async migration should just abort */
                if (cc->mode =3D=3D MIGRATE_ASYNC)
                        return 0;

>
> Because I can also imagine a hypothetical situation where multiple thre=
ads in parallel cause too_many_isolated() to be true, and will all loop t=
here forever. The proposed fix should prevent such situation as well, AFA=
ICT.

Yes. oom01 from ltp tests the multi-threaded situation and my fix works t=
here too.


=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_12CC4A4F-A68B-42A0-802B-75C263460CC2_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl+cLq8PHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqK9D4QAKVpUdtG4B1p2K3qHffqsBxttPCXRVSU1e+N
9gSoxWs6/Q04FCkTMlOBwn34j9ZspH2pq/WngqKj8P//9UC/8z5WTnL6LU6E4NRY
btvjWlMA4xMeGgobB7N/1xYSg4Ejqw/m4Wh2sBBUHejZKfsRZBR4QLzAIwoTgqOb
5my/z7pSkrnczuw2cTCao+qJiJwpUZOXn47p8ymLqw8b70A3NDqh0iksbLM4uXsO
d+HG7u2P6JyqZIMeMKkFCMKT5ptXKx+cNY77nNUN15kktJ6gbTgSumzqU8fEyyIY
pnmMnHevwLWZzBX6pxGj9P8zVvqtq0w4FugYg3nDKCpnAKbqSxElshtwjql1fWq3
2u0w6QbOXIhGK57RlMzrhO3bhHYQ9tahboz/ln/wDqhDOjlrw5sCzg5HyZQAzR7G
PWPMHhXoCELIXre+LTtvOqpDLaGWBBeF4QjvgAkBBtF+0m4pM1relpGxjOPzcomG
t+zM25Ga1aTTqXEy/WrEf3SgkjZu14rP43go2W00qXAvGXkwtNF9sFbd7balvjyb
SreVTDZwjlT+QKh4pT7M9kfyZscPhIta/6HF/ZN5DLqfue1pY7tPm7kkSobZMs2J
7WtWT8gORb9C1kCsk9nPf2GlpPiyuMuG3hKSPiFD9GHRR9KTg0ly54FNFDSN8REY
QRose3Fq
=0VtA
-----END PGP SIGNATURE-----

--=_MailMate_12CC4A4F-A68B-42A0-802B-75C263460CC2_=--
