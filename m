Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60C6D281061
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 12:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387682AbgJBKMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 06:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgJBKMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 06:12:14 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6441AC0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 03:12:12 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id j136so1129661wmj.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 03:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m/SMXR0WTC1i07sAp2rBkJenFVz4ZRXCT9v8+fEk1HM=;
        b=jdKpI7zjeEpre1vYKl1llHg5roONWPJQ7JqKVv4Wo2qu1suhAE0WqQM/HfxZ4v+Kcu
         /uZ4IgzzHXpzPn9a1kScghdKdKvT640vpxoDs48TH1ihs6yhvT2IFiw57Wsnuxu/Mo0w
         6TgD2Ed/NRtog6sM1gzWjqg9I1iCNm8vLn0Wvgb5687+eqVeGmZIw5oUi5Gfz7ALnNl2
         2Gj5dYpRebGJ9tNEXWrKwTcApfuAxHZGuVWaRHys0G2csZI16dkp2dIVX/5LEAQW513i
         1ES7Po0MZsPPCoQcuPTePlgIs2qj/oJTfxFOOqzt2/mQ3Tic7iEPLDLforbotWP/cuWy
         L7Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m/SMXR0WTC1i07sAp2rBkJenFVz4ZRXCT9v8+fEk1HM=;
        b=hpNQtY/Dv5PVpe9tD3KpvLnz9z2Q/c5EyN8bbJ4AoFxwz7GLuV0Mpd3U7SoLeJ8bJ7
         lf1cJjOHMJayimLgOMG/X8pMiSzHB3WIX4dmiWLB/Bw+lt45oaD8nQvrqVynkC9PjnQY
         ZjN1aueJKuupDwcuVfK1ObytycFivl9KGYTz8UL+k5OTcna5z3hnQgZA/CAUhtqyYCVZ
         g5J8pOOJtTVud0oE6WNPwMkG1iOuxSSeWcVK+6046L62ocUMJm5WpRFNSajeb5HC8XEc
         CJVpueZsfcTjbUpGLwGyUJZ2eDiAGMgB1KwImOtvs3LLmDisZYb2zZ2pWWxlLKw/PEna
         d9kw==
X-Gm-Message-State: AOAM530eiTwptg2S6MMzjkbhGGVl6oFeWDm3wy62/Wq5XcrAmCnfCQ8X
        UlNmKMI7WKLJtscmh2aManB24UkJZqGjMhwHM8hS3Q==
X-Google-Smtp-Source: ABdhPJzjtu2ldCXGUZ6c7WUNaHsuBBr/EaRswVbZdK5JyiNzslXpkSJaUDTMRj5g8PDDkhAQ7IDHk2IKQu0FN0+hABs=
X-Received: by 2002:a7b:c24b:: with SMTP id b11mr2106354wmj.134.1601633530944;
 Fri, 02 Oct 2020 03:12:10 -0700 (PDT)
MIME-Version: 1.0
References: <20201001190456.2860155-1-atish.patra@wdc.com>
In-Reply-To: <20201001190456.2860155-1-atish.patra@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 2 Oct 2020 15:41:57 +0530
Message-ID: <CAAhSdy11LqKFGA37cz8jYw9UtT+Niu7qKFm38jHP=49OYs0PFw@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Make sure memblock reserves the memory containing DT
To:     Atish Patra <atish.patra@wdc.com>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup.patel@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Zong Li <zong.li@sifive.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 2, 2020 at 12:35 AM Atish Patra <atish.patra@wdc.com> wrote:
>
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
>         dtb_early_va = (void *)dtb_pa;
>  #endif
> +       dtb_early_pa = dtb_pa;
>  }
>
>  static inline void setup_vm_final(void)
> --
> 2.25.1
>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
