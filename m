Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 878AA2F29DC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 09:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392280AbhALISs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 03:18:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729017AbhALISr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 03:18:47 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0233DC061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 00:18:07 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id y19so2291922iov.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 00:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LbpidrRYCyxn/Boo+Mnw7fCYz2z4a2W9yfy+reOhTtI=;
        b=irh1MNudW5++QFQkK9wYg3b4JSFoPpJuSa96vD8+3KArO1qwg/nvqPAo3puDqLcnOL
         Qt8zQxyopi8QR49rCc10xPEiWWJW/qVkawMVrSc19dhjK6VIXFla/GRYfjBV+VLs3J/j
         PCEOkNx58uCzYZbphmnTSSzzUf18vyL0SIdkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LbpidrRYCyxn/Boo+Mnw7fCYz2z4a2W9yfy+reOhTtI=;
        b=T9wCfdHeRdH70b9zB+X7rZNAFJ4+XydthIgtTwfBZoXKekXrNOAB4VqU8sVvt1QDoR
         TpcUV0E17C1VzYU8JC2/AZV1Iy3YJF2f1/aEq2coxGVQ1ELOhlEOWnAgxhJFEMxzwZYD
         BW+XERwvnqaq02DyBDXU/hmJ8dqOHAIBcWzKQsZbkfymZXcQD7GPuFITOf80jdbrzvOe
         JkEf1EUOuhOcHHhcY+06wgt4vUKOETc5jHergV7NF8xBM1fK75IA+EOiK/y2Lov6vos7
         4Wsy1Hq4NwhrAguJl3HOoyDlpy72h5K2EPFr1U5ll3Rj1sElljgn19qjQhebsNFbGwh2
         UHlA==
X-Gm-Message-State: AOAM531v2xvYReUFdxlORPEZj5pkgzF6XupzrX/kVRvskWpcfxnxM6SO
        hjVaXUn2lxu6pQJt3qNy09RqJ7kjJss2QtJ4lDsU
X-Google-Smtp-Source: ABdhPJyTfOUQm2SQX5x8heSHTT4WGxDATytLmMi3Xt03IMwgr+v5SF1qMvKgbhiOoDcK8/6NoVk7SGsiFEW/I8iQlgc=
X-Received: by 2002:a6b:b74e:: with SMTP id h75mr2453290iof.0.1610439486459;
 Tue, 12 Jan 2021 00:18:06 -0800 (PST)
MIME-Version: 1.0
References: <20210112023534.117354-1-guoren@kernel.org>
In-Reply-To: <20210112023534.117354-1-guoren@kernel.org>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Tue, 12 Jan 2021 00:17:55 -0800
Message-ID: <CAOnJCUK89rwjfnpMtavbaf-pwBndnS-=kVwsdP2yJnJAwJi-kg@mail.gmail.com>
Subject: Re: [PATCH] riscv: Remove duplicate definition in pagtable.h
To:     Guo Ren <guoren@kernel.org>
Cc:     Palmer Dabbelt <palmerdabbelt@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 6:38 PM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> PAGE_KERNEL_EXEC has been defined above.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Pekka Enberg <penberg@kernel.org>
> ---
>  arch/riscv/include/asm/pgtable.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 41a72861987c..dff51a84e52e 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -101,7 +101,6 @@
>  #define PAGE_KERNEL            __pgprot(_PAGE_KERNEL)
>  #define PAGE_KERNEL_EXEC       __pgprot(_PAGE_KERNEL | _PAGE_EXEC)
>  #define PAGE_KERNEL_READ       __pgprot(_PAGE_KERNEL & ~_PAGE_WRITE)
> -#define PAGE_KERNEL_EXEC       __pgprot(_PAGE_KERNEL | _PAGE_EXEC)
>  #define PAGE_KERNEL_READ_EXEC  __pgprot((_PAGE_KERNEL & ~_PAGE_WRITE) \
>                                          | _PAGE_EXEC)
>
> --
> 2.17.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

It's already on the fixes.

http://lists.infradead.org/pipermail/linux-riscv/2021-January/004134.html


-- 
Regards,
Atish
