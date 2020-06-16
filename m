Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBAB21FBD14
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 19:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731236AbgFPRdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jun 2020 13:33:44 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:10124 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729113AbgFPRdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 13:33:43 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ee902140001>; Tue, 16 Jun 2020 10:32:04 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 16 Jun 2020 10:33:42 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 16 Jun 2020 10:33:42 -0700
Received: from [10.2.166.236] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 16 Jun
 2020 17:33:41 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Yang Shi <yang.shi@linux.alibaba.com>
CC:     <kirill.shutemov@linux.intel.com>, <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: thp: remove debug_cow switch
Date:   Tue, 16 Jun 2020 13:33:38 -0400
X-Mailer: MailMate (1.13.1r5690)
Message-ID: <33C9F202-A610-4C9F-87E9-C50DF77C4329@nvidia.com>
In-Reply-To: <1592270980-116062-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1592270980-116062-1-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: multipart/signed;
        boundary="=_MailMate_4F23ADB1-404C-40E3-99A6-9E39630448E4_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1592328724; bh=b0XgSPW4uLM1dRrzgrkyFKmnV5pSJjQs4+MeUEM2ySE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:X-Mailer:Message-ID:
         In-Reply-To:References:MIME-Version:X-Originating-IP:
         X-ClientProxiedBy:Content-Type;
        b=iQzJIz1pDDQX0QpaS+ueJXvwseZo92er7YsIOpxB6+7xXowFxDeIANjiOt4Iueuob
         BL9q7TLyVq66UY0q/FbzhFeKaeA9AJuqHOekt2z/sOR388t6b95i0sv6+GBYJKTT0b
         D/wGfXXxb9jESI3ukvGh3gRQ0hrmTU/6VPs3eCtZjAP24vD1xy/yBYCES5j0ZW4+IW
         Xgk/USsV5H4ePyq6xYTRFDGbeWePLTKu064QZ6GXbHx6j3sQllC265RZ1pItcOewZ+
         y1hNBAa56f01cO1Yp2dADWNQMFIv/Op9lVErzLqGIZHxdFqVYtaAbml12Lu6U7KYTu
         HaFt+Ud3WL2/g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_4F23ADB1-404C-40E3-99A6-9E39630448E4_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 15 Jun 2020, at 21:29, Yang Shi wrote:

> Since commit 3917c80280c93a7123f1a3a6dcdb10a3ea19737d ("thp: change CoW=

> semantics for anon-THP"), the CoW page fault of THP has been rewritten,=

> debug_cow is not used anymore.  So, just remove it.
>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> ---

Makes sense to me.

Reviewed-by: Zi Yan <ziy@nvidia.com>

=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_4F23ADB1-404C-40E3-99A6-9E39630448E4_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl7pAnIPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKuTsQAKbBpdVpN6PpJrFS7avuVDzH6zcuyz/P2xwV
2w9J2/5MyDJmmObha2qUux2cXAZXWln/v52BsXJYGO2EGV8aeYAj1Py4OxNp2eZ6
GtKVvq1H0HpQogebLB4WLRx+U2QMJNU70wxPNdrCb0yYUmODs4yQR8k9zj0S26uB
UIOkb3sW8W725cXjuJ482tVlxyLD+FnE3FWNs2RGRMgOaqv18aQT8x+FsuCpZnRr
QvIKKBU92j5H7/Q9cLhzNzY1hiG69HfuFzEoSZbXw5Jc2Y4/isU1yQXJIHgbQ8Om
A/lSqPpfaoGdO3MY/6AKSUqvKsVE87Nwbl5SsG3nN7BxHHTJQO4orLptw+pSo9SK
9B1QYJOWgkAXml7RA/bABvwdr4abjQJ5ImAfh4tulIKJlCL92Efd8LdYtvegnG5s
Gs8Twck/JMvzAoP1f2sWYy8jcGJhUKLCzu8VAIUn9gXKm/eAEUUZ+6ue6D9qnWdE
SRR8TtM1Eo8lFL1lPTrUYyHVMP5p5N4iX63SpFVJRB30eBbKPujGwWfU6+MdB4pV
6ou9G3FJfBnwUND9J/W/pk7WudW2nV9iIWhFjfTKJz4xbR/xbyCWvEWu13c6VHkA
WEe3aklnxZPoumt1WyMXe+9UBZoYgUziwXcKx8UqiIZwQlpLTDa3BYpUnlXzl5Xi
u1b1MXbY
=NxHz
-----END PGP SIGNATURE-----

--=_MailMate_4F23ADB1-404C-40E3-99A6-9E39630448E4_=--
