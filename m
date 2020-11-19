Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37E432B8C2A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 08:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbgKSHSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 02:18:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:40290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbgKSHSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 02:18:48 -0500
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E00BD246B8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 07:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605770327;
        bh=CfTRLb6jrTUyy0Sv+Xze9EsqIKgByb8FY5Hqq6L8s6M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0wVSCfpqZeoN50C+Ap3A2c/cNLXYwBCDzQQUMu/EljQgSzCBZE69FNj99y1bmhiki
         6pku9DGzKnWNkhsz9QSn4GmyPgBuY1TU1NDwsWMFdiI6xHsdXM27KP3o81VbuEhm36
         u+ukxU8sE01QwQs7zdA7uMRBRI6CCqivG5js8qQU=
Received: by mail-oi1-f170.google.com with SMTP id t16so5255581oie.11
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 23:18:46 -0800 (PST)
X-Gm-Message-State: AOAM531qK2DCKkOSGJSdxfldE1AlPbxGKOA6ekiBsn3x+9WP6+7pPp54
        hjL1FDQtRnHx8yC9UbAmix8dGA0KezCvXqFhBBQ=
X-Google-Smtp-Source: ABdhPJy8syhWHlZQNyMTjjhgB5DCe8sheG9ntMlOkh8OWhMCnwYK2rRKEKFk4BNLFkwyNKePhivteOHwAS08tPsnJFk=
X-Received: by 2002:aca:c657:: with SMTP id w84mr475939oif.47.1605770326125;
 Wed, 18 Nov 2020 23:18:46 -0800 (PST)
MIME-Version: 1.0
References: <1605750340-910-1-git-send-email-tangyouling@loongson.cn>
In-Reply-To: <1605750340-910-1-git-send-email-tangyouling@loongson.cn>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 19 Nov 2020 08:18:35 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFr+1Khbisq2je41j_nFQnFhdYBW9bg+Ka5xbBJXHHkyg@mail.gmail.com>
Message-ID: <CAMj1kXFr+1Khbisq2je41j_nFQnFhdYBW9bg+Ka5xbBJXHHkyg@mail.gmail.com>
Subject: Re: [PATCH] arm64: vmlinux.lds.S: Drop redundant *.init.rodata.*
To:     Youling Tang <tangyouling@loongson.cn>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>,
        Mike Rapoport <rppt@kernel.org>,
        James Morse <james.morse@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Nov 2020 at 02:45, Youling Tang <tangyouling@loongson.cn> wrote:
>
> We currently try to emit *.init.rodata.* twice, once in INIT_DATA, and once
> in the line immediately following it. As the two section definitions are
> identical, the latter is redundant and can be dropped.
>
> This patch drops the redundant *.init.rodata.* section definition.
>
> Signed-off-by: Youling Tang <tangyouling@loongson.cn>

.init.rodata.* was added to INIT_DATA in
266ff2a8f51f02b429a987d87634697eb0d01d6a, so removing it here seems
reasonable. However, it does conflict with the for-next/lto branch in
the arm64 tree.

> ---
>  arch/arm64/kernel/vmlinux.lds.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index 1bda604..7dba3c4 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -201,7 +201,7 @@ SECTIONS
>                 INIT_CALLS
>                 CON_INITCALL
>                 INIT_RAM_FS
> -               *(.init.rodata.* .init.bss)     /* from the EFI stub */
> +               *(.init.bss)    /* from the EFI stub */
>         }
>         .exit.data : {
>                 EXIT_DATA
> --
> 2.1.0
>
