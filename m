Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5442C2CEE12
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 13:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729445AbgLDMaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 07:30:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgLDM37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 07:29:59 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A94C0613D1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 04:29:13 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id o1so3730172qtp.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 04:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=E+yzFXIW/SQF93FksrpbqqTewefE+vrapU8Z3tg/OfY=;
        b=vQyupD/hnfpF1w+LBmivJCLJbF/uyr95MEQGWWFEUS55KnvlgBibrZJ5tV2uofztNP
         9wEffK+/5P3iYW5hKwx3rmO1TTRcvSS2j/fNq2BkP6tGhz/wbai7GjeJyRrRHEfxJMTz
         XfAoPoI9tKsoOB+uZdAdLQUToK/GXFYqOXIkGw06uZKp0mAtTtcuK9shfdwjGZik7bWB
         76EPD7uyiW9hOTbMBXV3I/ZrnG+ZhvzGjupfzeAlSnQnTz9DZg/okSUa7uAdxRZCOnYD
         OWEiTm/bAebMah9fe/BmfT8emf8SaKenWSF7e2+15ZBr3Af4Vm6rHqmPFRTnycqqwE3p
         V26g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=E+yzFXIW/SQF93FksrpbqqTewefE+vrapU8Z3tg/OfY=;
        b=qjtsmSRVuXiWv9F5Dx9QTPbTeLmQ2ba+kaiyKP1jVH4AjjAb1NcEiDjcViF327W49F
         msbpCIPjDYgBOsRBeLXPpLwGYJQEAPTPaVwVgzSbaguZ5AFp1wbSFKZzGcRgj/PiOc63
         OCKAmFhb3D8Uw0sORdZh8Ljbyzg05+3mMlDh8bMb4AcjoGROW7vYS/pmfFm7EH5H4VHA
         hRNNV+X2FXCqZUg6c9I+MNmbxEME9KFrpd7F7Nw/2QpWL+Iu1I4IqbWF4pzbZqWhaWHm
         iXHn0mxWo8qDGLgzg1hwcw8UfcPSlwCorDr6Lui82QGLDbnk+TxTswW+5J/qxSwIgbTv
         JHew==
X-Gm-Message-State: AOAM531PsMAwXh4Anfvr/o5Ckm6EVhOyxWklpTwi9h98BXezQdedHy9o
        WN4QNQnRs4bfYdT+k+R15XB/iaLNuqDkc/jX5A7rDQ==
X-Google-Smtp-Source: ABdhPJzt8D+UI/bRjnIjspRkJfEKkMKQoOvjAujo3pizFQRDHEqt6L8+g0r9NmRNjgUJQ2DgeOFcAyo1k6p0KISWCkY=
X-Received: by 2002:ac8:4c89:: with SMTP id j9mr8912771qtv.8.1607084952474;
 Fri, 04 Dec 2020 04:29:12 -0800 (PST)
MIME-Version: 1.0
References: <20201204121804.1532849-1-anders.roxell@linaro.org>
In-Reply-To: <20201204121804.1532849-1-anders.roxell@linaro.org>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 4 Dec 2020 13:29:01 +0100
Message-ID: <CAG_fn=VJZC=HfVk_Tx6DUp+M17NZQO4Dao7jrj4WVaQp9jd3=A@mail.gmail.com>
Subject: Re: [PATCH] kfence: fix implicit function declaration
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 4, 2020 at 1:18 PM Anders Roxell <anders.roxell@linaro.org> wro=
te:
>
> When building kfence the following error shows up:
>
> In file included from mm/kfence/report.c:13:
> arch/arm64/include/asm/kfence.h: In function =E2=80=98kfence_protect_page=
=E2=80=99:
> arch/arm64/include/asm/kfence.h:12:2: error: implicit declaration of func=
tion =E2=80=98set_memory_valid=E2=80=99 [-Werror=3Dimplicit-function-declar=
ation]
>    12 |  set_memory_valid(addr, 1, !protect);
>       |  ^~~~~~~~~~~~~~~~
>
> Use the correct include both
> f2b7c491916d ("set_memory: allow querying whether set_direct_map_*() is a=
ctually enabled")
> and 4c4c75881536 ("arm64, kfence: enable KFENCE for ARM64") went in the
> same day via different trees.
>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Alexander Potapenko <glider@google.com>


Thanks!

> ---
>
> I got this build error in todays next-20201204.
> Andrew, since both patches are in your -mm tree, I think this can be
> folded into 4c4c75881536 ("arm64, kfence: enable KFENCE for ARM64")
>
>  arch/arm64/include/asm/kfence.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/include/asm/kfence.h b/arch/arm64/include/asm/kfe=
nce.h
> index 6c0afeeab635..c44bb368a810 100644
> --- a/arch/arm64/include/asm/kfence.h
> +++ b/arch/arm64/include/asm/kfence.h
> @@ -3,7 +3,7 @@
>  #ifndef __ASM_KFENCE_H
>  #define __ASM_KFENCE_H
>
> -#include <asm/cacheflush.h>
> +#include <asm/set_memory.h>
>
>  static inline bool arch_kfence_init_pool(void) { return true; }
>
> --
> 2.29.2
>


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
