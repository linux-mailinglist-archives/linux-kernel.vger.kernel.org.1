Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52E33293817
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 11:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392914AbgJTJeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 05:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392907AbgJTJen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 05:34:43 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7563BC061755
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 02:34:43 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id d24so1272883ljg.10
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 02:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version;
        bh=Yy0e2KzQZjsdApoOL3xxTvEy01p/cHiTbfoFKLpzkLw=;
        b=r0Gowq4KsjQc1Kw06cn0h4mKLRbV0fdyq8nSJ80Jcg3DxwL/+DhAQN69mv4fS6QDO1
         GkdKwaMJcst0zYVXCq5AamRhDNnBtN+DtxlaDu4pLEDSUSZMcHzMfaXLplcJnhQAMTRu
         jnVUTJIxs49m2hXQ0Qn2nmOPyeVSxmiYfn/J2DZAPJIB1MInzADoWOyaax+Ytl7rvblF
         zMJCcj2ol7CAl+w6Pi6hGN6MSKpDrLOrPXWPs0BBN/xQaMKry2kjt7P0aIUTfzcbdbmh
         zxvHWh4rw0GpsymQJJdcSiCGO/gmB25vfFqjxzAxHwexVEbfXjYY3DCYQmUjrVfmeYX1
         hruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version;
        bh=Yy0e2KzQZjsdApoOL3xxTvEy01p/cHiTbfoFKLpzkLw=;
        b=HF/1CDZMnSe9bZ286UyJfMmZBENkI7mrv6kmeqNJotBMF1PCI0U+vRTyw5nn9oL/B/
         p2LO0JiCQF0Zt/MxKirvQRbOqbUD9q5InUrqUjb3rawBLFaRt9VD3q0/rjPQIfseFtIw
         aItY7GFgdWr66nAkFWKLBVHZv6ZOADkr9eromXbxfaEVkMXFfGJpkAX5wujsbJIrzCV3
         NClaLOHaa5S9eO5OfLOZ8thY1QBKgKBJXLK7rwJ/a8OtBCy/HEervHtexn1rkr200uVW
         +t2Bt1umOxIEC7vUwyxua1CUt0AMUDS7PfOa5gc/SwzGP19vpw/3iizFsDo2bXHGzM60
         IDIQ==
X-Gm-Message-State: AOAM531x1k4CnprYf7EaY/v+QKxX26gIQoMU2lB40cOOnJhI/EXU3+pJ
        13AmIVt5UHzjivp3FyvgBvg=
X-Google-Smtp-Source: ABdhPJwegxqVKeKQ0SqpNnibIq8OtPU7i8FiHpkO+sBsKsGhxrJf7yoyOoA3O2/TeVLH2bdzMCrsaw==
X-Received: by 2002:a2e:3004:: with SMTP id w4mr789169ljw.35.1603186481995;
        Tue, 20 Oct 2020 02:34:41 -0700 (PDT)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id l8sm212200lfk.203.2020.10.20.02.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 02:34:41 -0700 (PDT)
Date:   Tue, 20 Oct 2020 12:34:30 +0300
From:   Pekka Paalanen <ppaalanen@gmail.com>
To:     Mugilraj Dhavachelvan <dmugil2000@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Karol Herbst <karolherbst@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        nouveau@lists.freedesktop.org
Subject: Re: [PATCH] x86/mm/kmmio: correctly handle kzalloc return
Message-ID: <20201020123430.44968cb4@eldfell>
In-Reply-To: <20201020084345.96823-1-dmugil2000@gmail.com>
References: <20201020084345.96823-1-dmugil2000@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/kNxw96BEn+M0PYEUFx6pYAH"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/kNxw96BEn+M0PYEUFx6pYAH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 20 Oct 2020 14:13:44 +0530
Mugilraj Dhavachelvan <dmugil2000@gmail.com> wrote:

> Replacing return value -1 to error code
>=20
> Signed-off-by: Mugilraj Dhavachelvan <dmugil2000@gmail.com>
> ---
>  arch/x86/mm/kmmio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/x86/mm/kmmio.c b/arch/x86/mm/kmmio.c
> index be020a7bc414..15430520c232 100644
> --- a/arch/x86/mm/kmmio.c
> +++ b/arch/x86/mm/kmmio.c
> @@ -386,7 +386,7 @@ static int add_kmmio_fault_page(unsigned long addr)
> =20
>  	f =3D kzalloc(sizeof(*f), GFP_ATOMIC);
>  	if (!f)
> -		return -1;
> +		return -ENOMEN;
> =20
>  	f->count =3D 1;
>  	f->addr =3D addr;

Hi,

did you even build-test this?

Why did you write this patch? What does it achieve?


Thanks,
pq

--Sig_/kNxw96BEn+M0PYEUFx6pYAH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAl+OryYACgkQI1/ltBGq
qqeYBA//XVRjP/OgzYv+hLE7Dv4qtIQH3SuKcWS9kLcK2mVxoo12wErFrVjY+hfu
03qjkW2k9JU6WfwlusYHHpkgW4lb1ucUeev5uZPBn8mi5mRGp79GgLDdkqUe9bZi
dSyNNiZDYfSKDgM9E3F5wYZmEUBj83l0dIh6FTPGdO4KKW0X1tc+/FTqByGBpuH7
tuawXLtBGIi3HG1l/VmWwVQ/X2TlqPP3EmJntjjBXvKOV/53xAZ8Z+2e2Ce/EAK3
l+UozLCLKxEH1NmSurV4aeb/6PiZiEsitUzqiitjUQjPdnUvwWk1zUfUbBkl6zwU
5Vdjub2eKGE2vx79eBq/mIXN9btzH7Bzd8bZPu/BDfyKO3DD1W9dOKH/o3BiXlbD
K7fkW8o7oDf9jSIEUmm3hQNA3XkVrfWunDQ0oQPHHn2O06YD+8CCz97zlVmBBNK3
l7JoXB3/kIBAlCSXXWSvL7AkoHJdJp+dMuK1IQycwSs3OAPBt/SiDutSjMq0veKn
/mT2mxh0pkm7FN9hupj0G9N5+EmafdksuyWXLGSAk1Z5WTMG711xB+rMeb+E7DAd
uQGZkFcq4j6RW1dQY4Z86mzlKDovCxL4KwMBJS0lR4Df9gBct23eQ9Z6LK34RTw1
e0qDXwXqkpXJ44SttdB8bOm0bIpzL/CsK/wZmkTMA085/8zhTKc=
=yGB5
-----END PGP SIGNATURE-----

--Sig_/kNxw96BEn+M0PYEUFx6pYAH--
