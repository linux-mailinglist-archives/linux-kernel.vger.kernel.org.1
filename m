Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4D11AAC0E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 17:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409948AbgDOPka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 11:40:30 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:11419 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404421AbgDOPkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 11:40:18 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e972aa70000>; Wed, 15 Apr 2020 08:39:19 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 15 Apr 2020 08:40:17 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 15 Apr 2020 08:40:17 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 15 Apr
 2020 15:40:10 +0000
Received: from [10.2.166.97] (172.20.13.39) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 15 Apr
 2020 15:40:08 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
CC:     <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Yang Shi" <yang.shi@linux.alibaba.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv3, RESEND 1/8] khugepaged: Add self test
Date:   Wed, 15 Apr 2020 11:39:53 -0400
X-Mailer: MailMate (1.13.1r5682)
Message-ID: <3DDA6828-36E9-4D1E-8F8A-4FA1D913DE89@nvidia.com>
In-Reply-To: <20200413125220.663-2-kirill.shutemov@linux.intel.com>
References: <20200413125220.663-1-kirill.shutemov@linux.intel.com>
 <20200413125220.663-2-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: multipart/signed;
        boundary="=_MailMate_42EA8C53-5C07-4713-8AE9-48A2E3CB7B4A_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1586965159; bh=kFaLyQy3HyGNKUYm9cHXzrk8jR79gRoU63gv86N+0f4=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:X-Mailer:Message-ID:
         In-Reply-To:References:MIME-Version:X-Originating-IP:
         X-ClientProxiedBy:Content-Type;
        b=gxbn1VJ4X/sSGjq1LluwCN/cPxc77Y9MsZYSZ31MKV2CtAPdsO2JZkqbT0EzFPxlu
         H7jjixV40GTeNmOCYtmpJ05IT8kGNqoYhIUDO+CuTehgiP6JUvOOdhmSCUKs0oDh6F
         cGtawSXDtjX/mj5xCfQ4VSe/Zq65LiupjSqyn/XygYzyyimOB1CL1CSBaDKQvQ+626
         VuCMwABp2Hts/DPUABCAZ55/SxnOCwHk1De4lsTrkb2k5wyu2hcD6ohlNMCAU9RwQ8
         FbfLE2er6nN+rrbmWJIhx8zW3gDCj0yZU/KpXracYae9CPVSjE0AzvtPi84nZrVyib
         +7CHmIU1pqVaw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_42EA8C53-5C07-4713-8AE9-48A2E3CB7B4A_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 13 Apr 2020, at 8:52, Kirill A. Shutemov wrote:

> External email: Use caution opening links or attachments
>
>
> The test checks if khugepaged is able to recover huge page where we
> expect to do so. It only covers anon-THP for now.
>
> Currently the test shows few failures. They are going to be addressed b=
y
> the following patches.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Reviewed-by: Zi Yan <ziy@nvidia.com>
Tested-by: Zi Yan <ziy@nvidia.com>

All tests passed with the whole series applied on v5.6 and Linus=E2=80=99=
 tree (commit: 8632e9b5).

Thanks.

=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_42EA8C53-5C07-4713-8AE9-48A2E3CB7B4A_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl6XKskPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKtT0P/A2tZRfIr1ebKpp9pBs/1YPDLxF2cNTxVMTg
fFM3uwYhfaooRFXhjXDZClaZWI3zAws7F/yON8rSdOx7ltFEQimQcFYa9OlfrSeO
/6vSW/3fgpyuudBrtknEIlKYkmj/GgMgxMqLcXWURsdnSI+H1NJLT4bUDWzZTdY7
Vx3cgFjVg6UcTVlVobKyp2thIwCk4hzXTWCNb38/dETCHOMwRTwIXAEi4HQrR/Ow
xg476HoqcVmTihSZ+EIy/y19aY64iaNxCm9KrJw14U89jtkW0AbDFUwNiVGr7Hpd
M2Fv7f12sTMxlLvwCxkhqfh/Xj8p3oa2wGqMRYwtxLchIddu9r5wARDEKIyVpgnJ
c6FFRWBGfNYKaS1SiQTC5x1dcNJv/TyvRb2efXAXGBMJU6BI74sZJregN3UXz6iF
whQojxRZ1ozOpAKhVhBD9gT0JhBwV9KH4m/3pbB/bQ+tE2c+OfOwVoBwi4Nt1BNP
EA56bKtvqBUR0mQv1msfBt7YIp/Vpw0mAcdjDSFVt0YpSPLPwMMKiLFZtL5dCWvR
6vlw1fcO9k8kSsj8xZLxVYPCUAugjeBUDLK1Sqhra1bvjFG23MOmz6O01WOL8ufr
vuU0Lb6QMM5PhVlre8/+ZlxDiHheL23SeyvhojedP/aybvoZwdLhNuqwCgkbE7FL
JjpSuuJO
=Ew/y
-----END PGP SIGNATURE-----

--=_MailMate_42EA8C53-5C07-4713-8AE9-48A2E3CB7B4A_=--
