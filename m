Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F12B2759C8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 16:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgIWOTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 10:19:15 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:11796 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgIWOTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 10:19:15 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f6b59040000>; Wed, 23 Sep 2020 07:17:40 -0700
Received: from [10.2.170.77] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 23 Sep
 2020 14:19:13 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     yuleixzhang <yulei.kernel@gmail.com>
CC:     <akpm@linux-foundation.org>, <willy@infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernellwp@gmail.com>,
        yuleixzhang <yuleixzhang@tencent.com>
Subject: Re: [PATCH] mm:cleanup mincore_huge_pmd
Date:   Wed, 23 Sep 2020 10:19:11 -0400
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <DBD8D854-5433-447A-8300-95EA548E8FED@nvidia.com>
In-Reply-To: <20200922083423.15074-1-yuleixzhang@tencent.com>
References: <20200922083423.15074-1-yuleixzhang@tencent.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
        boundary="=_MailMate_4B888942-31FB-4553-AB65-5A3459D41413_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600870660; bh=u1QlrfBhQ9gwmZfKAcl3pNfsZW+FM7SJ4tkd1B42Qr8=;
        h=From:To:CC:Subject:Date:X-Mailer:Message-ID:In-Reply-To:
         References:MIME-Version:Content-Type:X-Originating-IP:
         X-ClientProxiedBy;
        b=E8XvIvVavrOh8rBs/kjD7b6RonIeBYz97oZorgE5+l8bZQ5HR1gfqRfIlMXCW+T1B
         qxwT+r6n6Xts7nD6mh0MdxY3X7wLHNL5VbqsfvlPjho0Yj4+K0BkN5R8Tug/tTSkN/
         PIsfbGM6NOQAJ5sq+jk5WAQykuKrQcbB3auESBjlLOvBLxqrvUxxH4Vk5kG+DhDfhu
         RdRBuNXfKxkqr7q5lFaCiXP0KWlf0eyLstFWZINBY9lEIKScRVHpWsyw6rSp/tVgJ+
         Si5DWBRrgYL+31DrRP7kAWvwkerLZ3Qwq494V2ohrhkquze4UY4PKlnJyxtrcMgawo
         a1vZ16w+X4NKg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_4B888942-31FB-4553-AB65-5A3459D41413_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 22 Sep 2020, at 4:34, yuleixzhang wrote:

> As mincore_huge_pmd() was dropped, remove the declaration from
> the head file huge_mm.h.
>
> Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>
> ---
>  include/linux/huge_mm.h | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 8a8bc46a2432..0365aa97f8e7 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -38,9 +38,6 @@ extern int zap_huge_pmd(struct mmu_gather *tlb,
>  extern int zap_huge_pud(struct mmu_gather *tlb,
>  			struct vm_area_struct *vma,
>  			pud_t *pud, unsigned long addr);
> -extern int mincore_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
> -			unsigned long addr, unsigned long end,
> -			unsigned char *vec);
>  extern bool move_huge_pmd(struct vm_area_struct *vma, unsigned long ol=
d_addr,
>  			 unsigned long new_addr,
>  			 pmd_t *old_pmd, pmd_t *new_pmd);
> -- =

> 2.17.1

LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

Thanks.

=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_4B888942-31FB-4553-AB65-5A3459D41413_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl9rWV8PHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqK98EQAKwUmbHAjQNPX344emKgApyBzwSTbGQaFqU9
lXKpPg7XzDvHbQnWR3uwS/sYZa0ZF0HFhug2fXdi2RPBcUoxg/OCEaAT0/oxFFAW
HCvwtfETPlbn6+rC45mV7uh2RHov1N7dZqKFOVqP7v77Kp0/Hro4yziI7mY3IDw7
ehySmKVTjRJs+cEnrtoE6FPkM+9HCsozPmaV9s2XmhBBrjGEB5EM5fi+i3N1Lpef
RKzZfbufnHF3bowjkPNcytZKs736PTK3iCISjbEfR5y+I6DthXk3Kersp+ZJhXkn
rm9/FpmOlKefqAAiDaVf6HBreSDsH0EqyaWF/GCYbozKalfUYPTbZ9MFYLu333l1
gXTBLNWgIxmvW6b2HC/0W6BkZWyCHFh8/pKMU5Eb871o+d2AIedYvBplIYSAAf7s
0cIiHY5qJP+x5glESgQVt6pvYxyV6m9FFAHSOg3JiaKawcgnorUMHXlrYgf2KDHc
a+tIapGFJJagitPE5XDEoLb/c2cnBWXKqF1aagcLJ8+elzljyoS/COqBjSnBkc/d
Bh7uRRNYa91VnP8eGpe3MKvbUKSrAuZLHE8E88/A8zwb5Kf3oGXGK8pV8POHBayQ
w+Eugacd/q3KbZO70G+/8wZyT2rsAudxqqkEkTd7IblImTDuR74xCgOX8jspnjzk
qSYO7af6
=8xFt
-----END PGP SIGNATURE-----

--=_MailMate_4B888942-31FB-4553-AB65-5A3459D41413_=--
