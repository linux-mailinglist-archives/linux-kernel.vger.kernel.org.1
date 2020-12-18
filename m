Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D18B2DE306
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 14:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbgLRNBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 08:01:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgLRNBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 08:01:24 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65043C0617B0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 05:00:44 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id 75so2018969ilv.13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 05:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GqHdabW+m1T+9vxsF2B9K4CaE6AFzPZu+c/zny8P/SE=;
        b=FhiDMEk6SrTf9jq223CRiMNPspZbutfIGugRIjWOyAUs3TG+qLP9K1KZVcfzQAGbMw
         AfoUsn6dDVgW8JdeptHYZ+/twQRQtCxO+cnMAJWyaIzV0Hm+ZmYFLjoI0DTBoaxqcQq9
         jGrSYsyGJs6ubPxxYVdsPJ9KxOca+UxbfldlXTJgQUc3QeD2j8C12vWb2R3omphpFSTw
         pyq/O0c2uT3q9Ic30BpnetmQ5oh/MXZJtojb+Yfmj9mRTY0hKRZIMeDrnJDemwGj3hDr
         CD5DgkihJ5LfU5EMMEZPzIAmuJhGJFMkkOMqgJlB2kjkDel3m6Qmls2OfDDTXC1AfOBm
         Xv4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GqHdabW+m1T+9vxsF2B9K4CaE6AFzPZu+c/zny8P/SE=;
        b=jKdzT9cw6+NtTvLBR7+jQs8gbsS0qh6sq7onA1foiWfHp9Qt65n+5ZNbdwvs5MAPVN
         KYJKK5VRRxffEFiVRVaRZ5uGrZo6bcC3CViBSq7DWCf+SFiidzI/OXoXKePsYq6H7Dpm
         6Kx9xkAOrj3nxiWShZJh6DPLSKcKtdCUI/OStZ51PD2jsUJGNMt7DE/9UGk2tsMoBoWS
         4wp86jUPdREr8curdiUQ00eeHuGFbklHfKzrLxddjKo1IrGiyfdIGEMSC1YoxB4FJNSt
         +Mxmvz66PUtjgzlSiAntiQ5qtPArFRAK4n8nhjrBbAIwrMYTo7tPp3KwNzI9KBr8EWRI
         NYAw==
X-Gm-Message-State: AOAM5331Qo77I4ZJ2EjYjGaPtrd4KIOeDPCja0k9wRtZ3bKabwx5OYuH
        ApaPRuY5fLHTUmz+j2UfChM9NYBzK1/xOTlkYVlMeKDN4qk=
X-Google-Smtp-Source: ABdhPJxDUuTugyxuLhoMZvfvQkQAiEyrH4QxSTclEmKPpKnIqoGyuBk4iaCzH+adYm+GZKpFtVWbaltvJxKYSdRgae4=
X-Received: by 2002:a05:6e02:f14:: with SMTP id x20mr3745809ilj.94.1608296441414;
 Fri, 18 Dec 2020 05:00:41 -0800 (PST)
MIME-Version: 1.0
References: <0766416e-bab5-c8e7-9466-a72e965fdb8a@intel.com> <20201210143527.2398-1-jiangshanlai@gmail.com>
In-Reply-To: <20201210143527.2398-1-jiangshanlai@gmail.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Fri, 18 Dec 2020 21:00:30 +0800
Message-ID: <CAJhGHyAVH1z8A3J9C1U5SOCbq2Z=YeQ=3QbuZ3FC1u5ZLqgxcA@mail.gmail.com>
Subject: Re: [PATCH V2 1/3] x86/mm/pti: handle unaligned address for pmd clone
 in pti_clone_pagetable()
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Dave Hansen

Could you help review the patches, please?

I think they meet your suggestion except for forcing alignment in the
caller.  The reason is in the code.

Thanks
Lai

On Thu, Dec 10, 2020 at 9:34 PM Lai Jiangshan <jiangshanlai@gmail.com> wrote:
>
> From: Lai Jiangshan <laijs@linux.alibaba.com>
>
> The commit 825d0b73cd752("x86/mm/pti: Handle unaligned address gracefully
> in pti_clone_pagetable()") handles unaligned address well for unmapped
> PUD/PMD etc. But unaligned address for mapped pmd also needs to
> be aware.
>
> For mapped pmd, if @addr is not aligned to PMD_SIZE, the next pmd
> (PTI_CLONE_PMD or the next pmd is large) or the last ptes (PTI_CLONE_PTE)
> in the next pmd will not be cloned when @end < @addr + PMD_SIZE in the
> current logic in the code.
>
> It is not a good idea to force alignment in the caller due to one of
> the cases (see the comments in the code), so it just handles the alignment
> in pti_clone_pagetable().
>
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> ---
>  arch/x86/mm/pti.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
> index 1aab92930569..7ee99ef13a99 100644
> --- a/arch/x86/mm/pti.c
> +++ b/arch/x86/mm/pti.c
> @@ -342,6 +342,21 @@ pti_clone_pgtable(unsigned long start, unsigned long end,
>                 }
>
>                 if (pmd_large(*pmd) || level == PTI_CLONE_PMD) {
> +                       /*
> +                        * pti_clone_kernel_text() might be called with
> +                        * @start not aligned to PMD_SIZE. We need to make
> +                        * it aligned, otherwise the next pmd or last ptes
> +                        * are not cloned when @end < @addr + PMD_SIZE.
> +                        *
> +                        * We can't force pti_clone_kernel_text() to align
> +                        * the @addr to PMD_SIZE when level == PTI_CLONE_PTE.
> +                        * But the problem can still possible exist when the
> +                        * first pmd is large. And it is not a good idea to
> +                        * check whether the first pmd is large or not in the
> +                        * caller, so we just simply align it here.
> +                        */
> +                       addr = round_down(addr, PMD_SIZE);
> +
>                         target_pmd = pti_user_pagetable_walk_pmd(addr);
>                         if (WARN_ON(!target_pmd))
>                                 return;
> --
> 2.19.1.6.gb485710b
>
