Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA012A8FB1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 07:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbgKFGwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 01:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgKFGwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 01:52:08 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321B5C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 22:52:08 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id b8so161877wrn.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 22:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q3f9Pa023kq6nDLJQQNpO49x4systkFNrJf/4ta2NQU=;
        b=crgTZXSkON6Ldq2Mi5vOY6+SDVkFbigcyoKW4Ko57LfLXxyRjoSGqaaw+inQCog26J
         HP3nKhTooJi1kTgDi0DdvoP1dVBtblDXupJL7iSdPendjz5YX+XUyv2Ol9GN3E+Ohcw7
         +wzDrDJa3efME21bmHeecMbrtdtrO8PNAdHNVD6624MT6DbEI46z2TB9oRLxMWnFqZil
         xX+jEFO8zJMrU6Q8K05a8NydPTyNhXjRSRelkuShFDeCoNfUILw4UjJg2yOOlMhHsl89
         N3acSXvwZS9OwWEXr1pOtyOBxI1Le2G7IPPLMnz0W+Fmv9tdVtgl9t5noVAf+Pi6GdDD
         GH/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q3f9Pa023kq6nDLJQQNpO49x4systkFNrJf/4ta2NQU=;
        b=cgs1z+QvPdr9rcH93J+eYYgssOZsGMPCdtDikVE4BdVw+6ANN2glkbXo2CSR6h6a4d
         zozDeyF9FO5ZCu9udvL/h5ru5Ch1RxtMCvpbRpurYIZBk5RTUG/U2k4rMn6t8Q5NWK9k
         UqQvhoLEzcBZlZ7Vu8B1SuTmMbmN7ToSGVlDtrJJ3rLsKX0gmC0GVFEMYUNi84323PiM
         wmlIq1IRmwha5RrRRz9hlj4NizBCqNnulSVnD3LXPs0RLClfurMYF+9C5fYUaKik4d91
         w1AJHa5ESJkktXHC5vSAWqNw0aO1CVocT4MaGptmRkXInJhKqilXdMuUQDtD1Un8VJvJ
         Zx0A==
X-Gm-Message-State: AOAM533eQJCh+8VUaZKh3ZsykKsSdoJf4K8Kcw/AooqIuDIf/O95+AuH
        WDft1XvpkAC7xl3Xn9BgBJaJEBNKqoyH6e4VBtSEdA==
X-Google-Smtp-Source: ABdhPJzZm4YL9DpLTGxAwJRmfLGYPkjw0QWgiOEd+3cjNtmIWWOXF/NBBhiUrWGaVMGF06WfCBZpebumPfBq1YS4BuE=
X-Received: by 2002:adf:eec2:: with SMTP id a2mr969252wrp.128.1604645526458;
 Thu, 05 Nov 2020 22:52:06 -0800 (PST)
MIME-Version: 1.0
References: <20201102073052.199638-1-changbin.du@gmail.com>
In-Reply-To: <20201102073052.199638-1-changbin.du@gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 6 Nov 2020 12:21:52 +0530
Message-ID: <CAAhSdy12JRy5uF5t-e=bw=K1Gk5PKuTErg0kmKOxBKBn4MnhJw@mail.gmail.com>
Subject: Re: [PATCH] riscv: uaccess: fix __put_kernel_nofault()
To:     Changbin Du <changbin.du@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 2, 2020 at 1:01 PM Changbin Du <changbin.du@gmail.com> wrote:
>
> The copy_from_kernel_nofault() is broken on riscv because the 'dst' and
> 'src' are mistakenly reversed in __put_kernel_nofault() macro.
>
> copy_to_kernel_nofault:
> ...
> 0xffffffe0003159b8 <+30>:    sd      a4,0(a1) # a1 aka 'src'
>
> Fixes: d464118cdc ("riscv: implement __get_kernel_nofault and __put_user_nofault")
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> Cc: Christoph Hellwig <hch@lst.de>
> ---
>  arch/riscv/include/asm/uaccess.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
> index c47e6b35c551..824b2c9da75b 100644
> --- a/arch/riscv/include/asm/uaccess.h
> +++ b/arch/riscv/include/asm/uaccess.h
> @@ -476,7 +476,7 @@ do {                                                                        \
>  do {                                                                   \
>         long __kr_err;                                                  \
>                                                                         \
> -       __put_user_nocheck(*((type *)(dst)), (type *)(src), __kr_err);  \
> +       __put_user_nocheck(*((type *)(src)), (type *)(dst), __kr_err);  \
>         if (unlikely(__kr_err))                                         \
>                 goto err_label;                                         \
>  } while (0)
> --
> 2.17.1
>
>

Looks good to me.

Tested-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Anup Patel <anup@brainfault.org>

@Palmer Dabbelt , This patch fixes jump label implementation in
Linux-5.10-rc2. In general, this patch fixes all kernel instruction
patching related features. Can you take this for Linux-5.10-rcX ??

Regards,
Anup
