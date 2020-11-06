Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D51B52A9E6F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 21:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbgKFUF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 15:05:59 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:7025 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728313AbgKFUF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 15:05:58 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa5aca40000>; Fri, 06 Nov 2020 12:05:56 -0800
Received: from [10.2.172.112] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 6 Nov
 2020 20:05:57 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Yang Shi <shy828301@gmail.com>
CC:     <mhocko@suse.com>, <songliubraving@fb.com>, <mgorman@suse.de>,
        <jack@suse.cz>, <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] mm: migrate: clean up migrate_prep{_local}
Date:   Fri, 6 Nov 2020 15:05:54 -0500
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <AFF11692-A120-4BA2-9707-079F37B462A6@nvidia.com>
In-Reply-To: <20201103130334.13468-5-shy828301@gmail.com>
References: <20201103130334.13468-1-shy828301@gmail.com>
 <20201103130334.13468-5-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
        boundary="=_MailMate_627BF5E2-A770-4222-BE7B-7416578843FE_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604693156; bh=UwJKjrs0rWAJPVQAol3MpRv9KEwS4zvFE70qz0g/yAM=;
        h=From:To:CC:Subject:Date:X-Mailer:Message-ID:In-Reply-To:
         References:MIME-Version:Content-Type:X-Originating-IP:
         X-ClientProxiedBy;
        b=JfoG/Ub5AwxEi79X6YGUgqXgcpGBTh09tzWc0s9WgI9er9h5aUcn+eyLiwRsvETRB
         5ViacpriScZfho9/ptDg8yL1J4EBJ52EoPQM1upgzRE2ihzETTbfXO5JIbF+FccPDV
         9NEqSbb/6kC2wnA/ygU9tJFERZFzkd0JEI7Fnql/V82aEzhOz0j+5flH9QcY8N94Am
         PwCwr7m4+GZU/8fjs7iZp46AWImoKpjS6pDmvWoG4M65lH5jvZeslW7Yepc+w80Elj
         i2p+5Ui5cKsVHL5/tKuwrdY8kGShv7lOhG6pD2azqtk9cc7H23/zaso6er4Umvt/Bl
         7H7/YLWx/7R0g==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_627BF5E2-A770-4222-BE7B-7416578843FE_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 3 Nov 2020, at 8:03, Yang Shi wrote:

> The migrate_prep{_local} never fails, so it is pointless to have return=

> value and check the return value.
>
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
>  include/linux/migrate.h | 4 ++--
>  mm/mempolicy.c          | 8 ++------
>  mm/migrate.c            | 8 ++------
>  3 files changed, 6 insertions(+), 14 deletions(-)
>

LGTM. Thanks. Reviewed-by: Zi Yan <ziy@nvidia.com>


=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_627BF5E2-A770-4222-BE7B-7416578843FE_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl+lrKIPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqK7c8P/3pnWRya6pnhnyoziSVErqcRCKPIDo68dMTw
tNps1x3kpJA2xVZcHwzcloFj/3ektFsJv3p/WttOChJT00voWjGVP2/cTDiP7QfD
5hHg66/jFDDBvehWBD54ELFsPlENb8zmNr8dwF9wknLZwN7EvpCccRcR9C2uOHYQ
5u++18mzmJs2xvVtUwbosIcC/WZgooFNfX+v/GN3eQ+WKQGNmlYlQ5I+FZbLycAs
MUjIKC+Au942pYspHMiLhpK3ARPCDb6UcFuiLSGEpehrWZ4kzeLdxXRL6/wth/Xd
/ZB5CGdqVgMFPoU5qX9UUpseOua+tw/ggCNVOyrE/RxYlb2nNPS4s3tNcJYFt+cO
2+MbaLxfxJjejVoDg/Nxbc8bBwGyYcq8xklg4RXMhuo8v2AGDE9+gC0LIHWtuObz
ZpG8GYtQk7XtBjLZmkKFRY9WXok+p7GlVJ+2W3S8VxolRjK9WONE1+5Vc7HDhesV
v7KXV1MNj4f1Owq/c05kczXSoGpKPHH/riNt+z+mEmESPXnhNFgOJVGUjpBuyHUD
kS/QVysf6a9eu1ni9vvYpk//D+yItcSEUDgMCh1ACopUXl8JIUtpgqQFdnqB5cOk
iGfWS5VZ5nmz+JWmCOlWl6kLJEQ29MeeDakt+3YYadxepvKWH0cppTVye7/LLtAe
nppDQwih
=IKpN
-----END PGP SIGNATURE-----

--=_MailMate_627BF5E2-A770-4222-BE7B-7416578843FE_=--
