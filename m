Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34F082967B3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 01:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S373456AbgJVXnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 19:43:05 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:11057 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S373448AbgJVXmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 19:42:49 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f9218c90001>; Thu, 22 Oct 2020 16:42:01 -0700
Received: from [10.2.173.3] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 22 Oct
 2020 23:42:48 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Roman Gushchin <guro@fb.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        <saberlily.xia@hisilicon.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <kernel-team@fb.com>
Subject: Re: [PATCH v1 0/2] mm: cma: introduce a non-blocking version of
 cma_release()
Date:   Thu, 22 Oct 2020 19:42:45 -0400
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <F8551A10-E254-44FC-B28E-9E7F8AC14B57@nvidia.com>
In-Reply-To: <20201022225308.2927890-1-guro@fb.com>
References: <20201022225308.2927890-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
        boundary="=_MailMate_60AFCD9D-6CCF-4FC6-8444-6B791A110E49_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603410121; bh=BQ1JtoBLX9iPDNRiHWm88Fv3CTmOF38m/ARKNeF1qhc=;
        h=From:To:CC:Subject:Date:X-Mailer:Message-ID:In-Reply-To:
         References:MIME-Version:Content-Type:X-Originating-IP:
         X-ClientProxiedBy;
        b=SZeICWpuZP8ssL95rNG0RAfL+IvAfU1lU+TXYjhwBvCkxJGXY2jLvBk+QzlAeFVpL
         rehN7YSvM0IUIVCtUITidllzkSMuZJeMZwo/ucDfquOGPrxKTatvCW9Tg+UYGEYMFS
         KqBVZPscUfQWjxifxmGA52v/EUK40sNI/uagmU2VukFY4l5jiqk4j+g2hku4yM6wAm
         7dZRCeSmBv96fctLa6XXDmRhwOTf8lcacE7VWRDpFQad1R7vWtpNKEd940w7qzbGa9
         p09dgH4X8E4Qj57Oup1uAu/drt9NWDic5m2VS9MqAwLgHhjDhEyIpZjULCqmw7TBW7
         scRMl28O82Eug==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_60AFCD9D-6CCF-4FC6-8444-6B791A110E49_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 22 Oct 2020, at 18:53, Roman Gushchin wrote:

> This small patchset introduces a non-blocking version of cma_release()
> and simplifies the code in hugetlbfs, where previously we had to
> temporarily drop hugetlb_lock around the cma_release() call.
>
> It should help Zi Yan on his work on 1 GB THPs: splitting a gigantic
> THP under a memory pressure requires a cma_release() call. If it's

Thanks for the patch. But during 1GB THP split, we only clear
the bitmaps without releasing the pages. Also in cma_release_nowait(),
the first page in the allocated CMA region is reused to store
struct cma_clear_bitmap_work, but the same method cannot be used
during THP split, since the first page is still in-use. We might
need to allocate some new memory for struct cma_clear_bitmap_work,
which might not be successful under memory pressure. Any suggestion
on where to store struct cma_clear_bitmap_work when I only want to
clear bitmap without releasing the pages?

Thanks.

=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_60AFCD9D-6CCF-4FC6-8444-6B791A110E49_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl+SGPUPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKKwwP/3PFE+jf79qDZDHPvFsnYevRicOlgcouKKF/
EEoMbvdcy9pL+zjLeb0Bd61SpwHumiX4kimgQmkY5ZU2VybJODexj1YJtNeM45oR
eJ9iyzRhEczyPYhk0IBX8/tu/0wRLCoBtCMEmRuXPPQ5EptZEo9//s/kee1T6R9C
2YlVd3e1znXjnUtTjgE4lo/jj0dlos4Uf4j9HuiGyjB6z0HekIKgpGoKp3TJXgdW
H3dRu9bG/mkfk1/AeXl3JKV6BFXZTkE+pM9Qyz2MpATphcXoJ/84ZkA9CJWNVrsE
ktc9TnuntzSvml8sePdzsFdVoNq7mxuGJCrjoXgyyimRbUkrr2EFWBYDw0OQJyR6
oowEhXYpLYI1wiftdLUW+EyfUFyTTuEIE9/J0neb3qXzln3lYgsNYi08kCgM7Tha
p4JJKqOK05HhDxmnpdingU8p/BHNGKPW8c17dm2e+Ec7pVfc2dnXx4cJ1zpkUQTh
fXRMbZic8VeUslb+OyZ0aFsm6uvUHvApBoH58l36mmmtZb+0518xwb1EtUXy4Tlf
ZGGLscqkvBtgZALS3XaO/UHiQoe97kQ23QY+2QRFJWpDs4xDIXG/tTHqDkBu1QCY
PSm708gUgSftlhkErVNhHMBIRTe/uI94w+wUX+8u0HrrnlXn2NogbV5IEk76vQfA
OrGx4Qtt
=91mg
-----END PGP SIGNATURE-----

--=_MailMate_60AFCD9D-6CCF-4FC6-8444-6B791A110E49_=--
