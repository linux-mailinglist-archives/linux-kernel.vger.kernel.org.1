Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D383B303D1C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 13:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731132AbhAZMiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 07:38:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391934AbhAZKT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 05:19:28 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB82CC061573
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 02:18:48 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id n10so11178021pgl.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 02:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=bY0+m4945nWumwbU1TQ36SLdrna7sXMlUaFEMn9azHM=;
        b=otcVSaDkyuN1IFfRVEUqE8c2bayHgbWl4fMLIM9/NfgujwypOXpNCcVfJqbv3XPmZ3
         m3T5caX+X2PFVmGS2PuAM3DSxmuqsEC/qtdlFRNyvNLgA2erWkj02+d+0ZXfH7NVvlXC
         vqRzjdUDLgbJtG4ELaHWDai/2D7gTuh3zm1QMuO71egNZ4GSOIWdHOcUpN6/oFiPSJMF
         A+60AwwtKXpNmPyHLosablQqAjRgC2NEXvZdVafBbW1JrK1peRmOMIj4xDbwwbTrEpz2
         w1GPLMXda9qvRv6Ra5qKFx5sNXiTBCmfFdzV36XhdCsAPC+RV/6TVAJqsyJCq9+mmAvj
         cawQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=bY0+m4945nWumwbU1TQ36SLdrna7sXMlUaFEMn9azHM=;
        b=YjHZ5k9dChd4gEU5sBy/IkuIcL0zWcJZ4fDqCxxfON1L0oca4xyhj33vCBo9v48yVt
         T6SEIYtSprOVsjYsbzPgP1oDQd66B/71Nrxi460BSh+sMKhZKVx7730DxLQOlyHy9FM/
         8IrAwIXfH6yrthAAP+0yYIxCiGSF43p/iqiRd52LxwxcwSDtRgIc1R0uHf1J3RVMAbTq
         m2/D4lXICpaGbF7fF+rpLI8dq+clITuWHoCkgg+j+wb614PNGUoXbHZPDjbxhrAzUVGx
         edVf7HqRvCt79/uF4SkLxZoJGpyKd+xeGB4Tpr0lnN9TOi2jJwoV3jdAiZlC7L9T7b/4
         JUAw==
X-Gm-Message-State: AOAM531tiEwICLo+ZK2cmfCVmTNJBlJcVmgrrGB6hOBxkjLdIvoU6Oqs
        yNjFDIXAz4qJQeB1pBIoXsE=
X-Google-Smtp-Source: ABdhPJxaG61OapcH+qCGgTpLGcWf8cvXcfM4YrAfMSY5mvjCygYR8PMQZXdWfG/BQof6ssxK0ITAqw==
X-Received: by 2002:a62:144c:0:b029:1c0:d62d:e16e with SMTP id 73-20020a62144c0000b02901c0d62de16emr4542328pfu.25.1611656328201;
        Tue, 26 Jan 2021 02:18:48 -0800 (PST)
Received: from localhost (192.156.221.203.dial.dynamic.acc50-nort-cbr.comindico.com.au. [203.221.156.192])
        by smtp.gmail.com with ESMTPSA id 77sm13765743pfz.100.2021.01.26.02.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 02:18:47 -0800 (PST)
Date:   Tue, 26 Jan 2021 20:18:42 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v4 14/23] powerpc/syscall: Save r3 in regs->orig_r3
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>, msuchanek@suse.de,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1611585031.git.christophe.leroy@csgroup.eu>
        <5d375bea8f519924e110842f6b0d05e83cd04470.1611585031.git.christophe.leroy@csgroup.eu>
In-Reply-To: <5d375bea8f519924e110842f6b0d05e83cd04470.1611585031.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1611656262.d3l09kg9o2.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christophe Leroy's message of January 26, 2021 12:48 am:
> Save r3 in regs->orig_r3 in system_call_exception()
>=20
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/kernel/entry_64.S | 1 -
>  arch/powerpc/kernel/syscall.c  | 2 ++
>  2 files changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_6=
4.S
> index aa1af139d947..a562a4240aa6 100644
> --- a/arch/powerpc/kernel/entry_64.S
> +++ b/arch/powerpc/kernel/entry_64.S
> @@ -278,7 +278,6 @@ END_BTB_FLUSH_SECTION
>  	std	r10,_LINK(r1)
>  	std	r11,_TRAP(r1)
>  	std	r12,_CCR(r1)
> -	std	r3,ORIG_GPR3(r1)
>  	addi	r10,r1,STACK_FRAME_OVERHEAD
>  	ld	r11,exception_marker@toc(r2)
>  	std	r11,-16(r10)		/* "regshere" marker */

This misses system_call_vectored.

Thanks,
Nick

> diff --git a/arch/powerpc/kernel/syscall.c b/arch/powerpc/kernel/syscall.=
c
> index cb415170b8f2..b66cfcbcb755 100644
> --- a/arch/powerpc/kernel/syscall.c
> +++ b/arch/powerpc/kernel/syscall.c
> @@ -29,6 +29,8 @@ notrace long system_call_exception(long r3, long r4, lo=
ng r5,
>  {
>  	syscall_fn f;
> =20
> +	regs->orig_gpr3 =3D r3;
> +
>  	if (IS_ENABLED(CONFIG_PPC_IRQ_SOFT_MASK_DEBUG))
>  		BUG_ON(irq_soft_mask_return() !=3D IRQS_ALL_DISABLED);
> =20
> --=20
> 2.25.0
>=20
>=20
