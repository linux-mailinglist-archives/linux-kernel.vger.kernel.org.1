Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 662072E2FC0
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 04:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgL0D0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Dec 2020 22:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbgL0D0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Dec 2020 22:26:12 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDDBC0613ED
        for <linux-kernel@vger.kernel.org>; Sat, 26 Dec 2020 19:25:32 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id b8so4028949plx.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Dec 2020 19:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=jahrBbB1Xsikyivt0QZLDy7t69iyTwYFTr3ACK4DSmo=;
        b=IB/2iReamurlk8Fm3AXeUfE2PLQ8A15zYqC9kuurF8x1BaJzVlI0/mp1Z7yQxLeJUu
         gNz+ImPCTaAZFrt5gQ0Lq9ssI/hwuehvDHx5T4McjzuI1fyDBDIIV5162Onqz3dgzIPG
         FxpX6OIftiCXuvRTC6lTwTFZPlpKOp7RnLJR7NQB2C4kSZtb2KLwNZXemqrWw/UX2J0q
         YkrGrtYEZNyPsbvgwlgj4IjGw7MftyTzGaTJyyV2Tb5GKt/V79/tRs8xiQkjOA+4lFy6
         b3LnIRoDq47D1bNSFwqa7DoqUS13n+7bXax0nD/mI+TEP5K10+wd7NOiX4X2vk5CuCHU
         MVOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=jahrBbB1Xsikyivt0QZLDy7t69iyTwYFTr3ACK4DSmo=;
        b=Zyh2WbK1/Am6JUpqm8ySl6utIzCGxi53v66IeI2NVxAqKexT3k6EHqTVKzy+gyp1eJ
         nQJ0ogrwQJfw47LkDiswiBYPuICek2QwffDMEHTgDt51dxaVmMYdWn5iFMhoI+PF+M+J
         CeZcOrZtTPZxwiqn1lowGujXxl5zEtXV1xSHpNp+IqoS2s3zjhha8SCXmnVFp3aHPTBi
         dKJ+2w7dug/qaoIa5E+9y1oVqxVG6dNg7kps1f030SYjyiiRFFf0qdfZqzBDuOFO3UkW
         n69jhJAG/gUqFrbNOE6e1rYtS21F3KVwsKNTZaR7U4j8LrhcEJXw2R3qTX8OoHBoeTv8
         hxgA==
X-Gm-Message-State: AOAM530c8LtgYTSvy9hAQOsbZ3bnzI+K8xDgDZaOAPe0DLMvY1yS2XtV
        E6QIFRcdJqhkxX0UZpbcjsHt0bcaTKg=
X-Google-Smtp-Source: ABdhPJw6GbV+OVKSHYarpMSTr6gbkZuEnUYX0mTVktW4oYygcdihcPKQTM6ZqAm9yUFHlRmeferM6Q==
X-Received: by 2002:a17:902:7e85:b029:da:72a2:de1 with SMTP id z5-20020a1709027e85b02900da72a20de1mr38774333pla.57.1609039531706;
        Sat, 26 Dec 2020 19:25:31 -0800 (PST)
Received: from localhost (193-116-97-30.tpgi.com.au. [193.116.97.30])
        by smtp.gmail.com with ESMTPSA id ga12sm9705436pjb.48.2020.12.26.19.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Dec 2020 19:25:31 -0800 (PST)
Date:   Sun, 27 Dec 2020 13:25:25 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v1 06/15] powerpc: Remove address and errorcode arguments
 from do_break()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1608641532.git.christophe.leroy@csgroup.eu>
        <0246430576c2ff0aed1d35ccbd6f44e658908102.1608641533.git.christophe.leroy@csgroup.eu>
In-Reply-To: <0246430576c2ff0aed1d35ccbd6f44e658908102.1608641533.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1609039258.ijw9vns8wh.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christophe Leroy's message of December 22, 2020 11:28 pm:
> Let do_break() retrieve address and errorcode from regs.
>=20
> This simplifies the code and shouldn't impeed performance as
> address and errorcode are likely still hot in the cache.
>=20
> Suggested-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/include/asm/debug.h     | 3 +--
>  arch/powerpc/kernel/exceptions-64s.S | 2 --
>  arch/powerpc/kernel/head_8xx.S       | 5 -----
>  arch/powerpc/kernel/process.c        | 8 +++-----
>  4 files changed, 4 insertions(+), 14 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/debug.h b/arch/powerpc/include/asm/=
debug.h
> index ec57daf87f40..0550eceab3ca 100644
> --- a/arch/powerpc/include/asm/debug.h
> +++ b/arch/powerpc/include/asm/debug.h
> @@ -52,8 +52,7 @@ extern void do_send_trap(struct pt_regs *regs, unsigned=
 long address,
>  			 unsigned long error_code, int brkpt);
>  #else
> =20
> -extern void do_break(struct pt_regs *regs, unsigned long address,
> -		     unsigned long error_code);
> +void do_break(struct pt_regs *regs);
>  #endif
> =20
>  #endif /* _ASM_POWERPC_DEBUG_H */
> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/e=
xceptions-64s.S
> index cfbd1d690033..3ea067bcbb95 100644
> --- a/arch/powerpc/kernel/exceptions-64s.S
> +++ b/arch/powerpc/kernel/exceptions-64s.S
> @@ -3262,8 +3262,6 @@ handle_page_fault:
> =20
>  /* We have a data breakpoint exception - handle it */
>  handle_dabr_fault:
> -	ld      r4,_DAR(r1)
> -	ld      r5,_DSISR(r1)
>  	addi    r3,r1,STACK_FRAME_OVERHEAD
>  	bl      do_break
>  	/*
> diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8x=
x.S
> index 52702f3db6df..81f3c984f50c 100644
> --- a/arch/powerpc/kernel/head_8xx.S
> +++ b/arch/powerpc/kernel/head_8xx.S
> @@ -364,11 +364,6 @@ do_databreakpoint:
>  	addi	r3,r1,STACK_FRAME_OVERHEAD
>  	mfspr	r4,SPRN_BAR
>  	stw	r4,_DAR(r11)
> -#ifdef CONFIG_VMAP_STACK
> -	lwz	r5,_DSISR(r11)
> -#else
> -	mfspr	r5,SPRN_DSISR
> -#endif

I didn't think you can do this (at leastuntil after your patch 10). I have =
my
!VMAP path doing mfspr r5,DSISR ; stw r3,_DSISR(r11);=20

Thanks,
Nick

