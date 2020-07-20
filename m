Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1D9B2254CD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 02:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgGTABF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jul 2020 20:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbgGTABE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 20:01:04 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D39C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 17:01:04 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d1so7856849plr.8
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 17:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:references:in-reply-to:mime-version:message-id
         :content-transfer-encoding;
        bh=j+6d8B6fz5yyIangtZ6PT96gM568UJuQn4eeODSijdw=;
        b=BNLEcxEfISxGxjXwECU/O1uYawmXKSgkzlV2TRBDr3VAUSfB8YyBUcTZ7VAh/bElat
         +cTkjAMOQ8gOU1m12hvwyQlqXgBoBv558EKLYam65JWxX985wq4SD7iHxmBsx6fGZ8/1
         TIuLKgUJIy7xlKmpFBf3NKXi5MasSDCKP6ef/vCY7siYPIiF6TrY6BHjmSmNGzseVeKF
         PtBVsQ4jA2eLJUyX9RVTOAnx6UYFlChJGC4hBHqoInG9dmFH9BH4qfBI6Z+L6F3aXhif
         rkY+zUXCf95wHokiNTDuZ/fbsED5hdWH3cElSB0OOZq+mgFeMsrwukKOq9EAiyPTaVoT
         l9mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=j+6d8B6fz5yyIangtZ6PT96gM568UJuQn4eeODSijdw=;
        b=XVn0dFdeKHHSEukM5nkKLH8xp31uw+Su+jlxeGg/3uEaFNsatSpaFgF9fB4dh3m3nY
         S2V/pQYC0PkS/T3q1PbB+yd70yUW0N83PuTe89UFcWf5mRmqW4fqmw5/op+qALVV8Ji0
         3DGQUeAhTERbdeImLu5L9Bg3qRsu3Bw3c5lOFV3F0x3i5CdMjN74dyMQzLd1b+2KkDWP
         8n5gLGq56PQQMS+qAsLvbWRw6k+Sf3ICcwazt7M1b0q+OL08RkrtwmgSLY5LZdg9JPXy
         mU7UDxTKOX2hOa3nJCyeVdH4mYYfEOF/svgUEcfvSVt1kkap84BuDrphhfiBkOW+nRE1
         XFgA==
X-Gm-Message-State: AOAM533XmpYDWDGa/gjhuvX1gUvTO1sG8VchEmXbs/xgqBcvm39HDGin
        o8UbI5tdP6VZc3tLztDqFos=
X-Google-Smtp-Source: ABdhPJxiIede1+eHQDhINnVQE4tU64jEVTzCbsr0iLeAMn66rXLjWBmqPQMr6vLQjDrOdi0sTshSPg==
X-Received: by 2002:a17:90a:ce02:: with SMTP id f2mr22081649pju.159.1595203264023;
        Sun, 19 Jul 2020 17:01:04 -0700 (PDT)
Received: from localhost (110-174-173-27.tpgi.com.au. [110.174.173.27])
        by smtp.gmail.com with ESMTPSA id a16sm13559886pgj.27.2020.07.19.17.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 17:01:03 -0700 (PDT)
Date:   Mon, 20 Jul 2020 10:00:57 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3 1/3] powerpc/powernv/idle: Replace CPU features checks
 with PVR checks
To:     benh@kernel.crashing.org, ego@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mikey@neuling.org, mpe@ellerman.id.au, paulus@samba.org,
        pratik.r.sampat@gmail.com,
        Pratik Rajesh Sampat <psampat@linux.ibm.com>,
        svaidy@linux.ibm.com
References: <20200717185306.60607-1-psampat@linux.ibm.com>
        <20200717185306.60607-2-psampat@linux.ibm.com>
In-Reply-To: <20200717185306.60607-2-psampat@linux.ibm.com>
MIME-Version: 1.0
Message-Id: <1595203067.oropk0x5c8.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Pratik Rajesh Sampat's message of July 18, 2020 4:53 am:
> As the idle framework's architecture is incomplete, hence instead of
> checking for just the processor type advertised in the device tree CPU
> features; check for the Processor Version Register (PVR) so that finer
> granularity can be leveraged while making processor checks.
>=20
> Signed-off-by: Pratik Rajesh Sampat <psampat@linux.ibm.com>
> ---
>  arch/powerpc/platforms/powernv/idle.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platfor=
ms/powernv/idle.c
> index 2dd467383a88..f62904f70fc6 100644
> --- a/arch/powerpc/platforms/powernv/idle.c
> +++ b/arch/powerpc/platforms/powernv/idle.c
> @@ -92,7 +92,7 @@ static int pnv_save_sprs_for_deep_states(void)
>  		if (rc !=3D 0)
>  			return rc;
> =20
> -		if (cpu_has_feature(CPU_FTR_ARCH_300)) {
> +		if (pvr_version_is(PVR_POWER9)) {
>  			rc =3D opal_slw_set_reg(pir, P9_STOP_SPR_MSR, msr_val);
>  			if (rc)
>  				return rc;
> @@ -116,7 +116,7 @@ static int pnv_save_sprs_for_deep_states(void)
>  				return rc;
> =20
>  			/* Only p8 needs to set extra HID regiters */
> -			if (!cpu_has_feature(CPU_FTR_ARCH_300)) {
> +			if (!pvr_version_is(PVR_POWER9)) {
> =20
>  				rc =3D opal_slw_set_reg(pir, SPRN_HID1, hid1_val);
>  				if (rc !=3D 0)

What I think you should do is keep using CPU_FTR_ARCH_300 for this stuff=20
which is written for power9 and we know is running on power9, because=20
that's a faster test (static branch and does not have to read PVR. And
then...

> @@ -1205,7 +1205,7 @@ static void __init pnv_probe_idle_states(void)
>  		return;
>  	}
> =20
> -	if (cpu_has_feature(CPU_FTR_ARCH_300))
> +	if (pvr_version_is(PVR_POWER9))
>  		pnv_power9_idle_init();
> =20
>  	for (i =3D 0; i < nr_pnv_idle_states; i++)

Here is where you would put the version check. Once we have code that=20
can also handle P10 (either by testing CPU_FTR_ARCH_31, or by adding
an entirely new power10 idle function), then you can add the P10 version
check here.

Thanks,
Nick

