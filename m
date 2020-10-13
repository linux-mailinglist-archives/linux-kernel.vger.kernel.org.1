Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB21528D546
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 22:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732597AbgJMURf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 16:17:35 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:57268 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbgJMURe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 16:17:34 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20201013201722euoutp01eda78eaa6c6352dcab4cbe442dbab8a5~9pp6m1Awh0211902119euoutp012;
        Tue, 13 Oct 2020 20:17:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20201013201722euoutp01eda78eaa6c6352dcab4cbe442dbab8a5~9pp6m1Awh0211902119euoutp012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1602620242;
        bh=yuAK5blgz4+yQDehqFk6XN6ct7zGXDrK7MuXG5faAXU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ra0uGmp38jDbv4z06WV21xvwLRoWDzx4kAehpuXWzCiK4zDdhebulrQxFLJ+1Nb1v
         f4OoZcwntclZ0CEtGxbU1ii1wvDkBe7uJMMJJ/6zBzjYeX4o4g6vO7xTIhjme1G1wo
         YITtfz5sDW7g3AcDWfBFCLo1HSiaP+yShGKsjdNY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201013201716eucas1p20e7a97987a17545380dba9bfa96d15ea~9pp06TXeA2390923909eucas1p2b;
        Tue, 13 Oct 2020 20:17:16 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 8E.30.06456.C4B068F5; Tue, 13
        Oct 2020 21:17:16 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20201013201715eucas1p266a9a553002a9e72e604f92c50a0f950~9ppz7Wkaz2185321853eucas1p2g;
        Tue, 13 Oct 2020 20:17:15 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201013201715eusmtrp17a90f80d8882650a429264532ab05db9~9ppz6l7ij3121531215eusmtrp1R;
        Tue, 13 Oct 2020 20:17:15 +0000 (GMT)
X-AuditID: cbfec7f2-7efff70000001938-24-5f860b4c4400
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 98.3A.06314.B4B068F5; Tue, 13
        Oct 2020 21:17:15 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20201013201715eusmtip14b91fbe337393aaa3615178d7ed6a725~9ppzxNoSQ2133321333eusmtip1K;
        Tue, 13 Oct 2020 20:17:15 +0000 (GMT)
From:   Lukasz Stelmach <l.stelmach@samsung.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vivek Goyal <vgoyal@redhat.com>,
        Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>
Subject: Re: [PATCH v2 2/2] x86: kexec_file: print appropriate variable
Date:   Tue, 13 Oct 2020 22:17:01 +0200
In-Reply-To: <20200430163142.27282-3-l.stelmach@samsung.com>
        (=?utf-8?Q?=22=C5=81ukasz?= Stelmach"'s message of "Thu, 30 Apr 2020
        18:31:42 +0200")
Message-ID: <dleftj4kmx98zm.fsf%l.stelmach@samsung.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg="pgp-sha256";
        protocol="application/pgp-signature"
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHeXcuO65Wp2X4ZGEyLKjIsuuRLpQVHaIionvmWu2kopuyqWkf
        ylVbOryU5kILW1Fqy9naRJfVGvuQlqVmpJGClV281cgLaqvIdRb07fc+z/P/v//n5aUwiZYM
        puJVKZxaJU+UkiK85sl486Jtk/SyJZkloUx9u4Ngrg88I5gh62+S8ZTlIMZ4L4jpcpYLGFt3
        G8G8qrtKMrfaXwqYVpdJwPx8PI4zdlsRxrS9dZJM7/cGnBmzdhPrp7KjujycrSytRKzNnE2y
        nW0PSfZbU5OQfee246z95mnW43xNskO2ELbh3DCxU3RQtEbBJcancerF646I4noq05MLZ6Z7
        XWexTOSaYUABFNDLwax1Ej6W0BUIbniPGJBogocR1Hq7CP4whCC3bZT8p3Be0ZF8oxzB4+wR
        jD98QdD3M09oQBRF0uFgsez3CQLpRdCiv4T7GKNzcah4dsDH0+ktYPHqhT7G6bmQ/dzy1zSA
        NiJ4f63ibyYxvQoceq3AxzPoSKju6RLy9WnwtPij31QJxc0DyCcG+jYFOne/kI+6CUasZn/s
        6dBXX+2vz4bGwhzcFxTo01BYsJLX5iCouTqG8zOrobPph1+7ATru3xLy81Pgzddp/L1ToKDm
        MsaXxZCll/DTYVCV/9DvEgy5fRWIZxa6tdUC/q3yEZQbf6ELKLTkv3VK/lunZMIWo+fD3brF
        fHkhlF3vx3heC1VVHtyECDMK4lI1ylhOE6HiToRr5EpNqio2/FiS0oYmPmPj7/pBBxppPepG
        NIWkk8VZVp1MQsjTNBlKNwqbcPpgvdOCgnFVkoqTBoqjXjTGSMQKecZJTp0kU6cmcho3mkXh
        0iDxshu9hyV0rDyFS+C4ZE79ryugAoIzEQTGGZJCDAc9sqKt2jmW6OOKjVErAufNjHxwcTje
        dSbUbnxxb3eZR1e5uci8PXSw1PLeFEJ93uMdO9Sly33UE51Sd35pgVZWP1TbcurLvoS1jTuS
        P0jTOyyJ47JLjsjPpmrXxuibvbctpYoa03lKcezd3l2mBU3wKe4sE3N85yqPFNfEySMWYGqN
        /A/mYBctlAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJIsWRmVeSWpSXmKPExsVy+t/xu7re3G3xBpO3Klgcv76D1WLhm1Os
        Fp83/GOzeL+sh9Fi2kZxi/v7ljNZbHp8jdXi8q45bBZLr19ksrh0YAGTxZ/9P1ksNm+aymxx
        7dY+NouXH0+wWPzY8JjVgd/je2sfi8eaeWsYPTat6mTzuHNtD5vHu3Pn2D0eHNrM4rF5Sb3H
        +31X2Tw+b5LzONHyhTWAK0rPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/O
        JiU1J7MstUjfLkEv48WaioLJkhW/DzQzNzAeEO1i5OSQEDCR2De7la2LkYtDSGApo8SbW0tZ
        uhg5gBJSEivnpkPUCEv8udYFVfOUUeLHib+MIDVsAnoSa9dGgNSICOhKXGibwgJiMws0sEic
        O68GYgsLuEus/d3GDmILCVhL/N0+lRnEZhFQleg8sxZsJqfANEaJpRv2sYIkeAXMJXa0NTKB
        2KIClhJbXtxnh4gLSpyc+QRqQbbE19XPmScwCsxCkpqFJDUL6DxmAU2J9bv0IcLaEssWvmaG
        sG0l1q17z7KAkXUVo0hqaXFuem6xoV5xYm5xaV66XnJ+7iZGYFRvO/Zz8w7GSxuDDzEKcDAq
        8fB2bGiNF2JNLCuuzD3EqAI05tGG1RcYpVjy8vNSlUR4nc6ejhPiTUmsrEotyo8vKs1JLT7E
        aAr06ERmKdHkfGAiyiuJNzQ1NLewNDQ3Njc2s1AS5+0QOBgjJJCeWJKanZpakFoE08fEwSnV
        wBjxaIrdhq2v1K/oz7X+a5b0x33vr+71kxblCfnqJsyLdTy3T+xlvtqMn0d2+XnGe58N/pXO
        WffiUGK5U0Hw6ZMTdEyP1y6KfLr/e4L74lWim+8cXRy6/LjH/PDDPnfa1MLEPX0SE1bf2bKz
        rvFxwKMLsnPeZy+Tez3h5/FbvR8U577YEc196VeEEktxRqKhFnNRcSIAG58I3AwDAAA=
X-CMS-MailID: 20201013201715eucas1p266a9a553002a9e72e604f92c50a0f950
X-Msg-Generator: CA
X-RootMTR: 20201013201715eucas1p266a9a553002a9e72e604f92c50a0f950
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201013201715eucas1p266a9a553002a9e72e604f92c50a0f950
References: <20200430163142.27282-3-l.stelmach@samsung.com>
        <CGME20201013201715eucas1p266a9a553002a9e72e604f92c50a0f950@eucas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

It was <2020-04-30 czw 18:31>, when =C5=81ukasz Stelmach wrote:
> The value of kbuf->memsz may be different than kbuf->bufsz after calling
> kexec_add_buffer(). Hence both values should be logged.
>
> Fixes: ec2b9bfaac44e ("kexec_file: Change kexec_add_buffer to take kexec_=
buf as argument.")
> Fixes: 27f48d3e633be ("kexec-bzImage64: support for loading bzImage using=
 64bit entry")
> Fixes: dd5f726076cc7 ("kexec: support for kexec on panic using new system=
 call")
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> Signed-off-by: =C5=81ukasz Stelmach <l.stelmach@samsung.com>
> ---
>  arch/x86/kernel/crash.c           | 2 +-
>  arch/x86/kernel/kexec-bzimage64.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index fd87b59452a3..d408e5b536fa 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -420,7 +420,7 @@ int crash_load_segments(struct kimage *image)
>  	}
>  	image->arch.elf_load_addr =3D kbuf.mem;
>  	pr_debug("Loaded ELF headers at 0x%lx bufsz=3D0x%lx memsz=3D0x%lx\n",
> -		 image->arch.elf_load_addr, kbuf.bufsz, kbuf.bufsz);
> +		 image->arch.elf_load_addr, kbuf.bufsz, kbuf.memsz);
>=20=20
>  	return ret;
>  }
> diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bz=
image64.c
> index db6578d45157..420393c58a73 100644
> --- a/arch/x86/kernel/kexec-bzimage64.c
> +++ b/arch/x86/kernel/kexec-bzimage64.c
> @@ -434,7 +434,7 @@ static void *bzImage64_load(struct kimage *image, cha=
r *kernel,
>  		goto out_free_params;
>  	bootparam_load_addr =3D kbuf.mem;
>  	pr_debug("Loaded boot_param, command line and misc at 0x%lx bufsz=3D0x%=
lx memsz=3D0x%lx\n",
> -		 bootparam_load_addr, kbuf.bufsz, kbuf.bufsz);
> +		 bootparam_load_addr, kbuf.bufsz, kbuf.memsz);
>=20=20
>  	/* Load kernel */
>  	kbuf.buffer =3D kernel + kern16_size;
> @@ -464,7 +464,7 @@ static void *bzImage64_load(struct kimage *image, cha=
r *kernel,
>  		initrd_load_addr =3D kbuf.mem;
>=20=20
>  		pr_debug("Loaded initrd at 0x%lx bufsz=3D0x%lx memsz=3D0x%lx\n",
> -				initrd_load_addr, initrd_len, initrd_len);
> +				initrd_load_addr, kbuf.bufsz, kbuf.memsz);
>=20=20
>  		setup_initrd(params, initrd_load_addr, initrd_len);
>  	}

Ping? Any chance this patch follows its arm64 counterpart into mainline?

Kind regards,
=2D-=20
=C5=81ukasz Stelmach
Samsung R&D Institute Poland
Samsung Electronics

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXpuyqjq9kGEVr9UQsK4enJilgBAFAl+GCz0ACgkQsK4enJil
gBA+sQgAknuxR62NM6MA3eZXzg2/NIAoN5/D82mBJCWrm5Y6yYd1pR/oV9unxk1E
p2h3xP81UUjabhiqW12zCD5Jiq2YgQCeiMWnd+0LBTuXaqXBH4jJjm0882oREBnZ
jxWa4k+hBIh6QDgQG5UTIZoKiUMQk0l6USSN4nNSSL3c/qs1K0nM1tM1fIWR/4O+
iLNeEdr/vKoKdj4ahrsQzmxx/dtUw0p2IyON6TGKmn+7/sEuRvrw0EaJovqepEMQ
tBsSqfuzKHqsI4dirHdgIZ5/EtbfxwiTc844wQ9GVudga0aAXf8cWu+a3HwyA8kj
PpOzdEklx9WQa4iiHejbvYk385ta3Q==
=qbAv
-----END PGP SIGNATURE-----
--=-=-=--
