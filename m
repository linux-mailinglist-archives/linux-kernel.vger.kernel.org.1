Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFA692B5138
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 20:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730452AbgKPTdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 14:33:00 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:10445 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727153AbgKPTdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 14:33:00 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fb2d3f50003>; Mon, 16 Nov 2020 11:33:09 -0800
Received: from [10.2.160.29] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 16 Nov
 2020 19:32:50 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Alex Shi <alex.shi@linux.alibaba.com>
CC:     <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] docs/vm: remove unused 3 items explanation for
 /proc/vmstat
Date:   Mon, 16 Nov 2020 14:32:47 -0500
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <CF852878-79B6-405C-B019-339DD1D1A2AD@nvidia.com>
In-Reply-To: <1605520282-51993-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1605520282-51993-1-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
        boundary="=_MailMate_40AB2DDD-2E93-4922-81FA-0CD2586ABFF5_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605555189; bh=C7XOS6W3qGRTk11X8JPOzveM6gK4JnBqNgAuviLKCEU=;
        h=From:To:CC:Subject:Date:X-Mailer:Message-ID:In-Reply-To:
         References:MIME-Version:Content-Type:X-Originating-IP:
         X-ClientProxiedBy;
        b=SzjB59dF9pi0FAfxdaBiZAqZ7+PmnVIWqXlAjAlq1bLo8eqI0FWCi2sFpwM+e293k
         /Ok9Peetdzz7BPxLcMAxPE7tW9NQ0BWW06JRb9gp1GYPOMEpNihvD52Jxn8Dm2vtAI
         1OPd0ujpi/lfQZMF65m/wdpAeZg25yl7gkcaTy6JKjXOuyyQNRRfSMhpttUE8zACY3
         e5nR+UgIdwzvuzT/2N7Wk2CjCsAOkESjV2tmIBNxlbhXRicgXEAuP/n2GzzsvqPfZU
         nIKBGjCnln5QO0Vay9pcL2yVagbu+e2Ubo7aNvRl0mBfVING4+nTg110deNYT3NrpM
         l50/ZggC0aVtg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_40AB2DDD-2E93-4922-81FA-0CD2586ABFF5_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 16 Nov 2020, at 4:51, Alex Shi wrote:

> Commit 5647bc293ab1 ("mm: compaction: Move migration fail/success
> stats to migrate.c"), removed 3 items in /proc/vmstat. but the docs
> still has their explanation. let's remove them.
>
> "compact_blocks_moved",
> "compact_pages_moved",
> "compact_pagemigrate_failed",
>
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Yang Shi <yang.shi@linux.alibaba.com>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  Documentation/admin-guide/mm/transhuge.rst | 15 ---------------
>  1 file changed, 15 deletions(-)
>

LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>.

=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_40AB2DDD-2E93-4922-81FA-0CD2586ABFF5_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl+y098PHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqK1TAQAJi2bBBxR9xM10J+N425mzRAgIPAdoWlO3Y3
07KyFpbD4Y4O1QLyqoxI+HxOXYNp6HgzatEBlJql7//zzJMpVFrHVbpamCJpLQhu
yqAoztXZZHgqZssL2c2tdGHRifWrPrDTkmoBDIwFeuHldb9UPlSXpbPxYDm+RolZ
OellXlKgoSPo0hvR+DGpH7iYvOaGrOzkPbSo8ZIrDuCFLDwShV8BbfTOFI2E+IIH
CQnc52sJ04JpUKOD6QKrAXTfyW2BrInrDASBPWOTAd8dt1Q4FTGlxF6Er2j1VWGC
v9PxS3n8s8AGNLP8s0tUqykmZLJpbfJ30mhoZVFosyA3L09gzsE9QWqoaIRHeafn
8RaorbOHVWSyUwuQWmr2cM1hYdmAEB2nB9Qv/nyZKsazrbm3M6+Zd0MmrNPawPDu
KZLAbYqgn1riLQJduad/6tEEkP7AEpPTyhV+Avy2q8XhHBqoeORhSGrohhwFZOEo
brzuIrhAD+mddpaXohlqEODXGub9al7waKbfYHChIV7Zsb+22s68D0ErlvVucOP+
JuWzOLSBPE7ENpmokenXr9Gz7pq+FSeiAoatgVCfXA/0dc1KdS55SMsCJ7y8/cBS
VMdYlzSlbwjHZN6EFi9e+dIKvpTUc587RZEnF8sjHMvhnV0pv52NuYtAnZPZfnBv
893BHDd2
=+DZh
-----END PGP SIGNATURE-----

--=_MailMate_40AB2DDD-2E93-4922-81FA-0CD2586ABFF5_=--
