Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E52592AD192
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 09:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbgKJIqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 03:46:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgKJIp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 03:45:59 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B8CC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 00:45:59 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id e21so9552624pgr.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 00:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=G12SAfGo9zxDhW2sfOaoLT7Ktw6spyrLizVoU+CQKHg=;
        b=gSn+R8PvB0P75cPhWXK+AsCwd1kW9Tg0e7bVX8Adq5UK5mqsZ/vFjOW+uF4KBrQuTa
         zC3NG8kF2qe106t3HxD3K+16SQ41jWl2CcbDYzg2g64RRjTNKDpATn4oEexEuWLnNiZB
         wCoZdjyFdjKvKEqxx7z+MgDSO763uFB305vnamPJ1Wm1mZZzcwpMf+faPFMtRIMWJHkW
         0V1g4n0bpfbW6BHapxmZFJZfz1Qo8zxafu0RbuS+yD8xLX+ZfKpOqQZDTUoI9vvufVjW
         LePiITZ5+cPkb0/mVZ9QLJr6afGgijF0L8M52WvfTTz1IwZvzZlv1Mmg9cEsgNaG7Eak
         kiFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=G12SAfGo9zxDhW2sfOaoLT7Ktw6spyrLizVoU+CQKHg=;
        b=c/0pZaD44/s5wkcGLDJGWvQQfyBNrDpw1mzJE1b27bb9x5sNw8gLF9s9KUTe+UK5l7
         tO2eRpsyUEDleM4AlKrRmF7kJAxbTfBWrZ8N1E1jPLH9SXiaUTEdWC8JhVoP9jL4VP+/
         Jc5bnH3GFBAjla8ZD/EfUde21l3ORWTtt1hE6gcpg8FzG5gTOUCaVMt0QY+l+Dk5fHAU
         ib1YJJpfBSbkpUWLVonXYuDv1iW/cf6+WM2yRtzqvYVVgCHC1Va8l1l//1tLOksbsvrd
         qVpM5IR3rq0crda/KxY200UXAhK+Hk63wiypGnDCO5B/bibGCQ7ad4Pe263b5UM707Bz
         cWmg==
X-Gm-Message-State: AOAM530T7VZp8qlsAB0yUzngOg15yOx+Yj922TheTr65dJIEHblosg6N
        LxqVQ/YDbeh2qcwiKRA9uCE=
X-Google-Smtp-Source: ABdhPJx3np16kym1rMkDTZ30+yq2VJ/D3E5goHBnPjVIZz1lnC6ahLzpM+leXGVqEKHqMwYhBOGxrQ==
X-Received: by 2002:a17:90b:b12:: with SMTP id bf18mr3642616pjb.205.1604997959304;
        Tue, 10 Nov 2020 00:45:59 -0800 (PST)
Received: from localhost (27-32-36-31.tpgi.com.au. [27.32.36.31])
        by smtp.gmail.com with ESMTPSA id c9sm13577108pfc.197.2020.11.10.00.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 00:45:58 -0800 (PST)
Date:   Tue, 10 Nov 2020 18:45:53 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 1/3] powerpc/64s: Replace RFI by RFI_TO_KERNEL and
 remove RFI
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <7719261b0a0d2787772339484c33eb809723bca7.1604854583.git.christophe.leroy@csgroup.eu>
In-Reply-To: <7719261b0a0d2787772339484c33eb809723bca7.1604854583.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1604997906.z9qht3tf9f.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christophe Leroy's message of November 9, 2020 2:57 am:
> In head_64.S, we have two places using RFI to return to
> kernel. Use RFI_TO_KERNEL instead.
>=20
> They are the two only places using RFI on book3s/64, so
> the RFI macro can go away.

Looks good to me.

Acked-by: Nicholas Piggin <npiggin@gmail.com>

>=20
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/include/asm/ppc_asm.h | 1 -
>  arch/powerpc/kernel/head_64.S      | 9 +++++++--
>  2 files changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/as=
m/ppc_asm.h
> index 511786f0e40d..bedf3eb52ebc 100644
> --- a/arch/powerpc/include/asm/ppc_asm.h
> +++ b/arch/powerpc/include/asm/ppc_asm.h
> @@ -495,7 +495,6 @@ END_FTR_SECTION_NESTED(CPU_FTR_CELL_TB_BUG, CPU_FTR_C=
ELL_TB_BUG, 96)
>  #endif
> =20
>  #ifdef CONFIG_PPC_BOOK3S_64
> -#define RFI		rfid
>  #define MTMSRD(r)	mtmsrd	r
>  #define MTMSR_EERI(reg)	mtmsrd	reg,1
>  #else
> diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.=
S
> index 1510b2a56669..ecf9a88988ff 100644
> --- a/arch/powerpc/kernel/head_64.S
> +++ b/arch/powerpc/kernel/head_64.S
> @@ -41,6 +41,11 @@
>  #include <asm/ppc-opcode.h>
>  #include <asm/export.h>
>  #include <asm/feature-fixups.h>
> +#ifdef CONFIG_PPC_BOOK3S
> +#include <asm/exception-64s.h>
> +#else
> +#include <asm/exception-64e.h>
> +#endif
> =20
>  /* The physical memory is laid out such that the secondary processor
>   * spin code sits at 0x0000...0x00ff. On server, the vectors follow
> @@ -829,7 +834,7 @@ __secondary_start:
> =20
>  	mtspr	SPRN_SRR0,r3
>  	mtspr	SPRN_SRR1,r4
> -	RFI
> +	RFI_TO_KERNEL
>  	b	.	/* prevent speculative execution */
> =20
>  /*=20
> @@ -966,7 +971,7 @@ start_here_multiplatform:
>  	ld	r4,PACAKMSR(r13)
>  	mtspr	SPRN_SRR0,r3
>  	mtspr	SPRN_SRR1,r4
> -	RFI
> +	RFI_TO_KERNEL
>  	b	.	/* prevent speculative execution */
> =20
>  	/* This is where all platforms converge execution */
> --=20
> 2.25.0
>=20
>=20
