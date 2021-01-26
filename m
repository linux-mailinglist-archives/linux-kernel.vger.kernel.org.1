Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 338C0303BBE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 12:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405255AbhAZLfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 06:35:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391841AbhAZKR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 05:17:26 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87FE7C061756
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 02:16:46 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id my11so1131375pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 02:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=sR1f6/9qxbOzaGUBvKshvPIEd27XjEPY6YY4xmBmtPw=;
        b=hByZTPn+kC7e4UW2FPK/AIyIGf9W594vufpomYmL3zBVkQjdrkkQGpHS3xs7297uF8
         VOZuXvTyW9sl55CPyhKIIMU+riCrnYcmolSmzO7a2ks0VOAD5PMXwyn75ZqZWJt9qd0f
         fgvVhIgSOjxP+3wo55hLn6DBp6ZeyaybNzl7PQFEyHP/ZCCm93jKAiAbAkNLYGghQIag
         TqE5huzf5DEhD5ui8CJ2NJPiTNuT1oUOjfl4UoGUE2sZnIoHd8lmUCLKDEPX+0+H/MCW
         Qi7nLK7V9o/vLa4YcxC1L1QBFwSMvu3lrbd/9irKOurZORXuC/OvuF5VuOJIx4D6xK8Q
         DINw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=sR1f6/9qxbOzaGUBvKshvPIEd27XjEPY6YY4xmBmtPw=;
        b=aJQnU/43i21QoPInYRSEl2dFEUMG/HuLDSRZc55FygTzGIaHtmYbizPazt3NAjB7dW
         5mvLeAKya6+05wBWyxOnND8lwJbmLviQEi00XlmbVHlajGgfnb2ZU2zSCDKH7M55maIT
         3vK5ZMDcL3kJ6eQskPpQ8w3/JxgCckHZcvBgdAVvg1+ymZhEnFlT2t6jw81nrPXU3ODf
         dP3rlWfrgbIpd/CPoVU6Ao+iSNkFxqoKZiCZ1RfFE3lLsW+2+Tf67YRzlQ2vRECOHPtC
         XbXxWm2Z4QEqbbtyh0jUqu0FdxsPvH3ieWQjRE7v8LLdvuhsb2zShtvgekfsGV63E/rH
         MivQ==
X-Gm-Message-State: AOAM5332CsFzwgKyBn8Uvjg6NmItelvxwHLVQ+sLFKfrwaMVX1M/imUf
        e+4ECkVcYka3JWdlaULPmOkmjDGlzAY=
X-Google-Smtp-Source: ABdhPJwg+JTjblgrrhG9vFEfUG1cblX6qFxLOGQzgNLdQMrgRvDnqGJyI0cCwhxPL54X1bAz2FR0zA==
X-Received: by 2002:a17:902:9a4a:b029:dc:435c:70ad with SMTP id x10-20020a1709029a4ab02900dc435c70admr5154709plv.77.1611656206142;
        Tue, 26 Jan 2021 02:16:46 -0800 (PST)
Received: from localhost (192.156.221.203.dial.dynamic.acc50-nort-cbr.comindico.com.au. [203.221.156.192])
        by smtp.gmail.com with ESMTPSA id d2sm1840594pjd.29.2021.01.26.02.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 02:16:45 -0800 (PST)
Date:   Tue, 26 Jan 2021 20:16:39 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v4 20/23] powerpc/syscall: Do not check unsupported scv
 vector on PPC32
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>, msuchanek@suse.de,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1611585031.git.christophe.leroy@csgroup.eu>
        <f02af988a86f7e83b6492df7c4fa1b53bcd1919b.1611585031.git.christophe.leroy@csgroup.eu>
In-Reply-To: <f02af988a86f7e83b6492df7c4fa1b53bcd1919b.1611585031.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1611656145.efq1cxcpts.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christophe Leroy's message of January 26, 2021 12:48 am:
> Only PPC64 has scv. No need to check the 0x7ff0 trap on PPC32.
>=20
> And ignore the scv parameter in syscall_exit_prepare (Save 14 cycles
> 346 =3D> 332 cycles)
>=20
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/kernel/entry_32.S | 1 -
>  arch/powerpc/kernel/syscall.c  | 7 +++++--
>  2 files changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_3=
2.S
> index 9922a04650f7..6ae9c7bcb06c 100644
> --- a/arch/powerpc/kernel/entry_32.S
> +++ b/arch/powerpc/kernel/entry_32.S
> @@ -343,7 +343,6 @@ transfer_to_syscall:
> =20
>  ret_from_syscall:
>  	addi    r4,r1,STACK_FRAME_OVERHEAD
> -	li	r5,0
>  	bl	syscall_exit_prepare
>  #if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
>  	/* If the process has its own DBCR0 value, load it up.  The internal
> diff --git a/arch/powerpc/kernel/syscall.c b/arch/powerpc/kernel/syscall.=
c
> index 476909b11051..30f8a397a522 100644
> --- a/arch/powerpc/kernel/syscall.c
> +++ b/arch/powerpc/kernel/syscall.c
> @@ -86,7 +86,7 @@ notrace long system_call_exception(long r3, long r4, lo=
ng r5,
>  	local_irq_enable();
> =20
>  	if (unlikely(current_thread_info()->flags & _TIF_SYSCALL_DOTRACE)) {
> -		if (unlikely(regs->trap =3D=3D 0x7ff0)) {
> +		if (IS_ENABLED(CONFIG_PPC64) && unlikely(regs->trap =3D=3D 0x7ff0)) {
>  			/* Unsupported scv vector */
>  			_exception(SIGILL, regs, ILL_ILLOPC, regs->nip);
>  			return regs->gpr[3];
> @@ -109,7 +109,7 @@ notrace long system_call_exception(long r3, long r4, =
long r5,
>  		r8 =3D regs->gpr[8];
> =20
>  	} else if (unlikely(r0 >=3D NR_syscalls)) {
> -		if (unlikely(regs->trap =3D=3D 0x7ff0)) {
> +		if (IS_ENABLED(CONFIG_PPC64) && unlikely(regs->trap =3D=3D 0x7ff0)) {

Perhaps this could be hidden behind a function like trap_is_scv()?

trap_is_unsupported_scv() ?

Thanks,
Nick
