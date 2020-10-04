Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9405282E48
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 01:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725885AbgJDXUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 19:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgJDXUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 19:20:42 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57DC8C0613CE
        for <linux-kernel@vger.kernel.org>; Sun,  4 Oct 2020 16:20:41 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id kk9so4259223pjb.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Oct 2020 16:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=jcJgO6uXgL0y2gYnRqgUThvhgsEJ1n5wWS6ZD66anDU=;
        b=ksGLoj1il+Ym3SZtJ22Ri9Ps5d/OGXKo8qz5gf0hgrnOG1fgBwXXUaJuNvn1vPDKKG
         lMwHm5P3XbMeyLZXIit9GOGwWV7gJ3+QFGBrtuJ+2D38ZE/f7bQgPdBDvnqXD5AdqnWv
         QnDMxUP9gC6DdIw8eqvqoG/V1r9tlwvsl8Pl+dt2YumkQ3fyxlQTCRHUKWSxLNoS4zvS
         Yw0BwDztZW4cjVn686I9JBLRLBDpj+b/uehU7dV5QqWm9Po5Nuc89DTnKRW+NE5FCysz
         nZJ+2ZbtNp4FcA1SPGUOEIr65K6nt4/OsEHJ5ZcZLBEBSaoYSEy0qcRL16QPKuoNZsPC
         vG7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=jcJgO6uXgL0y2gYnRqgUThvhgsEJ1n5wWS6ZD66anDU=;
        b=S561YJg/2JVaUqMsEjD1W38iaOtWGXP0SS3/rZlcRQ/5UFKdLKELH2xinMEnJaMfkb
         /Oqh22Q3C2MovVUdaEGsyRbVCZXPOkVqsfYtKeMCyS+BLFdZ2SQ6f7st/Scb9SZGByIT
         80j2pb9Z4hbtXOMLUtln2/ALnC7/gNoT61OsAqZgo65r//4pG6dHp/nkz3fPxPTC0TZW
         Ek/Ml0sBuLdJn6h1G1KV4L7BVxfjVvDfEXrG8InFRqYg59MDOm8sN3iCoSFGA88Gx9rV
         MnbBDDD+1x/tTfAkY0KLQ7bum0WRcYRvw1vRtMhTQi+8GddFWYDUSfXflbThvRuXZV2U
         a/cg==
X-Gm-Message-State: AOAM531tvoj7N6Y0b2pB3lq9I0Wf0RdTD36Ek91F5v8+vQ7/PGe8lY1t
        n71+kNIYvA+U707oin2i0jJgDPjwX87O13hj
X-Google-Smtp-Source: ABdhPJxnItVYLJO4Qv3u+Vya1S62lhz6G9wsZCmXGoKkDuzMmnMswIJOzjkNw3l1yq8j54+Fmlxivg==
X-Received: by 2002:a17:90a:3984:: with SMTP id z4mr13391873pjb.131.1601853640498;
        Sun, 04 Oct 2020 16:20:40 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id h9sm9460508pfc.28.2020.10.04.16.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2020 16:20:40 -0700 (PDT)
Date:   Sun, 04 Oct 2020 16:20:40 -0700 (PDT)
X-Google-Original-Date: Sun, 04 Oct 2020 16:20:36 PDT (-0700)
Subject:     Re: [PATCH] RISC-V: Make sure memblock reserves the memory containing DT
In-Reply-To: <20201001190456.2860155-1-atish.patra@wdc.com>
CC:     linux-kernel@vger.kernel.org, Atish Patra <Atish.Patra@wdc.com>,
        aou@eecs.berkeley.edu, Anup Patel <Anup.Patel@wdc.com>,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>, zong.li@sifive.com,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Christoph Hellwig <hch@lst.de>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Atish Patra <Atish.Patra@wdc.com>
Message-ID: <mhng-b6639b2b-fb32-4522-b5ec-63ccb8886dfe@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Oct 2020 12:04:56 PDT (-0700), Atish Patra wrote:
> Currently, the memory containing DT is not reserved. Thus, that region
> of memory can be reallocated or reused for other purposes. This may result
> in  corrupted DT for nommu virt board in Qemu. We may not face any issue
> in kendryte as DT is embedded in the kernel image for that.
>
> Fixes: 6bd33e1ece52 ("riscv: add nommu support")
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
>
> ---
> @Palmer This patch is applicable for v5.9 & before. This fix is already
> part of the "RISC-V: Move DT mapping outof fixmap" patch from UEFI support
> series. That's why, this patch doesn't need to go into for-next.
> ---
>  arch/riscv/mm/init.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 564e0be677b7..cabf1697e748 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -510,6 +510,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>  #else
>  	dtb_early_va = (void *)dtb_pa;
>  #endif
> +	dtb_early_pa = dtb_pa;
>  }
>
>  static inline void setup_vm_final(void)

Thanks, this is on fixes.
