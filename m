Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE39D2E2FCF
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 05:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgL0Dod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Dec 2020 22:44:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbgL0Dod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Dec 2020 22:44:33 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4444C0613ED
        for <linux-kernel@vger.kernel.org>; Sat, 26 Dec 2020 19:43:52 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id w5so5342514pgj.3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Dec 2020 19:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=PqQAiv/DQ/uaBJdeYRX64iJn5cpjW9UmaoLzhs/v7gQ=;
        b=k+0kpygEpvpRQrKERc+fKM5XAznyq5hqFRfc60opTUASejqHiJlAzhSZgg4y6K4ShD
         gQIrFeshokZUVkuYDpN8YpyEsI1MM9DHrWrHtctqBKcgFSp4t1kZpn0NayFWWZ/pOAs3
         N+7Z9JgXtxCiK2Ja3sXtXQFNBnrbmD/spdpfLAt74N0cbsfl+Nd/bJlTHsKJRdVPHZhZ
         vudHKtTyU43BtZMVN9FUcKWAruE3ypiJkmwPYPa9VDs8UUf4/4uCv3AUzDcQQXfmBZp7
         i6ePfeeLbsHPMpIGeh5Q940hDMAopGzkoA088506WoIYkP07moagfyL4Co1kPheTmvDW
         iqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=PqQAiv/DQ/uaBJdeYRX64iJn5cpjW9UmaoLzhs/v7gQ=;
        b=BJL7CsCvAR8R0ufyR9NylRLx6vnp0YrQr/LEqDCycz5tMaVE1cowfZgpKfXYpZjO76
         4Q08VjTAwWqOvZhDBYeZ0diY9bkgoMpW99lUXYu2Ne1rmtDwiYYHOrb/1xmIPtI/HLOT
         1BImjHrX/oaBAqbQXNA14WVrBwoRWG582ZT8nTfg64wFLEwRFJzkfMQooZAKh/L3nVQc
         H1CZhvDs/D/J1Wj672prdjWhudhexSiy8AWcpEoKfNLtNTlmFwtFHtEividiADY6HbQd
         XDnQQClWcOCT58U5LMi6IwUoH5hB8AF6ICrT79h4qOMuOqpdzwMJz8/+RfZCkIivnoT0
         zAfg==
X-Gm-Message-State: AOAM5301BJgsWasmB79ioHxbycD3tXRqZaBrILY9tbfEOzzwjw9EcLjv
        CByKNCNo8BOGwGkCxRsMtwvW0p+TNYA=
X-Google-Smtp-Source: ABdhPJzdTwlK7o6258DVLKqKafO4JukKjw1jlnIPg1nVAtK0U/oG+l5aGN/CskMK4XvXkubY+5y0gw==
X-Received: by 2002:a62:3:0:b029:160:d92:2680 with SMTP id 3-20020a6200030000b02901600d922680mr36208228pfa.44.1609040631533;
        Sat, 26 Dec 2020 19:43:51 -0800 (PST)
Received: from localhost (193-116-97-30.tpgi.com.au. [193.116.97.30])
        by smtp.gmail.com with ESMTPSA id a1sm32106315pfo.56.2020.12.26.19.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Dec 2020 19:43:51 -0800 (PST)
Date:   Sun, 27 Dec 2020 13:43:45 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v1 05/15] powerpc: Remove address argument from
 bad_page_fault()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1608641532.git.christophe.leroy@csgroup.eu>
        <181cb8d6899a298e8ddab3b8f669a48c11b43cca.1608641533.git.christophe.leroy@csgroup.eu>
In-Reply-To: <181cb8d6899a298e8ddab3b8f669a48c11b43cca.1608641533.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1609039746.005aiasorf.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christophe Leroy's message of December 22, 2020 11:28 pm:
> The address argument is not used by bad_page_fault().
>=20
> Remove it.
>=20
> Suggested-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/include/asm/bug.h             | 4 ++--
>  arch/powerpc/kernel/entry_32.S             | 4 +---
>  arch/powerpc/kernel/exceptions-64e.S       | 3 +--
>  arch/powerpc/kernel/exceptions-64s.S       | 8 +++-----
>  arch/powerpc/kernel/traps.c                | 2 +-
>  arch/powerpc/mm/book3s64/hash_utils.c      | 2 +-
>  arch/powerpc/mm/book3s64/slb.c             | 2 +-
>  arch/powerpc/mm/fault.c                    | 6 +++---
>  arch/powerpc/platforms/8xx/machine_check.c | 2 +-
>  9 files changed, 14 insertions(+), 19 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/bug.h b/arch/powerpc/include/asm/bu=
g.h
> index 464f8ca8a5c9..af8c164254d0 100644
> --- a/arch/powerpc/include/asm/bug.h
> +++ b/arch/powerpc/include/asm/bug.h
> @@ -112,8 +112,8 @@
> =20
>  struct pt_regs;
>  extern int do_page_fault(struct pt_regs *, unsigned long, unsigned long)=
;
> -extern void bad_page_fault(struct pt_regs *, unsigned long, int);
> -void __bad_page_fault(struct pt_regs *regs, unsigned long address, int s=
ig);
> +void bad_page_fault(struct pt_regs *regs, int sig);
> +void __bad_page_fault(struct pt_regs *regs, int sig);
>  extern void _exception(int, struct pt_regs *, int, unsigned long);
>  extern void _exception_pkey(struct pt_regs *, unsigned long, int);
>  extern void die(const char *, struct pt_regs *, long);
> diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_3=
2.S
> index 238eacfda7b0..abd95aebe73a 100644
> --- a/arch/powerpc/kernel/entry_32.S
> +++ b/arch/powerpc/kernel/entry_32.S
> @@ -671,15 +671,13 @@ ppc_swapcontext:
>  handle_page_fault:
>  	addi	r3,r1,STACK_FRAME_OVERHEAD
>  	bl	do_page_fault
> -	cmpwi	r3,0
> +	mr.	r4,r3

This looks like an unrelated change so I'll leave it out. Nice little=20
improvement though.

Thanks,
Nick
