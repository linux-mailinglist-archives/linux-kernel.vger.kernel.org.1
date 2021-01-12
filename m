Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D78A32F264B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 03:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730567AbhALCcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 21:32:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:37080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726645AbhALCca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 21:32:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4921C22CA2;
        Tue, 12 Jan 2021 02:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610418709;
        bh=4VFefuHt3FLjxAlUJPyc/xO8ouPzYSZlv+YmZIxUmF4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Z1GWOzE1O2g3fUPDWsh7AXLzfzy1SSfCF6Xuo0qfeO3NeoGzlHUc2tJFL2kRHxsnI
         vXqrsyAYQwL83JhqFVnoY+SjysOwH17n4bsFwkNZZ6ZNwKTTKRNO/GORJffz+6xLxY
         z/VemQQ4d9oSQX5rMNzoe5Q1mH/R/fgdC0iB1I5WZE3mvoLsgw05gtvcBixSUCXs5N
         fItbeR6KIAMDoTdDIROCJljnlBngSDHsEF6zpeEToqT3WrsObsgZYdq+hUKaDkKJxy
         WmIkoNvbsPqI1uEhAdKqpvlgs4jHJObI2FQpcXHwKXQDWDwDrTnoe+556oET2ZTDgY
         lfPAGVPqokYbQ==
Received: by mail-lf1-f50.google.com with SMTP id 23so1008786lfg.10;
        Mon, 11 Jan 2021 18:31:49 -0800 (PST)
X-Gm-Message-State: AOAM5307A4ZZpHKYrPHyFBQHu1H2eccBY4iU2lNqLvufODN0sPgSfZtj
        OO3rI3TWsVCnHT9Ui7TJgURkxqxFcp4oqftTQsA=
X-Google-Smtp-Source: ABdhPJwM93BqOuL2la8yQbEPwB2EQR8HRO6JS0dIBwyAnDuAnsShgxySJeaYWJEr7/c2v4cuCA0pbhTqfp0gD8+kGPs=
X-Received: by 2002:a19:40d6:: with SMTP id n205mr1060500lfa.24.1610418707559;
 Mon, 11 Jan 2021 18:31:47 -0800 (PST)
MIME-Version: 1.0
References: <20210111142517.4959-1-dong.menglong@zte.com.cn>
In-Reply-To: <20210111142517.4959-1-dong.menglong@zte.com.cn>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 12 Jan 2021 10:31:36 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQjKXR9gpo06WAWG1aquiT87mATiMGorXs6ChxOxoe90Q@mail.gmail.com>
Message-ID: <CAJF2gTQjKXR9gpo06WAWG1aquiT87mATiMGorXs6ChxOxoe90Q@mail.gmail.com>
Subject: Re: [PATCH] csky: kprobe: fix unreachable code in simulate_blz32
To:     menglong8.dong@gmail.com
Cc:     dong.menglong@zte.com.cn, linux-csky@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi menglong,

On Mon, Jan 11, 2021 at 10:25 PM <menglong8.dong@gmail.com> wrote:
>
> From: Menglong Dong <dong.menglong@zte.com.cn>
>
> The type of 'val' is 'unsigned long' in simulate_blz32, so 'val < 0'
> can't be true.
>
> When 'csky_insn_reg_get_val' fails, 'false' will be returned. We
> can directly use its return value here.
>
> Fixes: 33e53ae1ce41 ("csky: Add kprobes supported")
> Signed-off-by: Menglong Dong <dong.menglong@zte.com.cn>
> ---
>  arch/csky/kernel/probes/simulate-insn.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/arch/csky/kernel/probes/simulate-insn.c b/arch/csky/kernel/probes/simulate-insn.c
> index 4e464fed52ec..b09ddcbcfa18 100644
> --- a/arch/csky/kernel/probes/simulate-insn.c
> +++ b/arch/csky/kernel/probes/simulate-insn.c
> @@ -346,9 +346,7 @@ simulate_blz32(u32 opcode, long addr, struct pt_regs *regs)
>         unsigned long tmp = opcode & 0x1f;
>         unsigned long val;
>
> -       csky_insn_reg_get_val(regs, tmp, &val);
> -
> -       if (val < 0) {
if ((long) val < 0) {
?

We need val to determine branch taken or not.

> +       if (!csky_insn_reg_get_val(regs, tmp, &val)) {
>                 instruction_pointer_set(regs,
>                         addr + sign_extend32((opcode & 0xffff0000) >> 15, 15));
>         } else
> --
> 2.17.1
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
