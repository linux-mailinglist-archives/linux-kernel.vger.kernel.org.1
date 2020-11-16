Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E15252B4C85
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732719AbgKPRTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732711AbgKPRTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:19:54 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36261C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:19:53 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id x18so2048815ilq.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2cDMST3loBmPEvX019dbwyMNULGzjxVtVrkk6taLCiY=;
        b=I2/AEI+J2uOrdL+VzQ+YLHqurMISMWwy90/fFJ399bYZ9AWrHzW0BJ50tC2tJoO6nJ
         tE8aEuMCgORkymYeamzS9okalmgb/rXqVhznQO9otzGxGf83vwc6wKOV+4APJqe8Tjx7
         bfBg5W3djzGz9/7U9hcjeypuQ39BD+CbVjPFPaJg5uPiPfkAQT3E9ZN1skSa6oG6m/qk
         h+YNVyepPqtiXr99rpziwhQvbOAJsxlugtuKvDzrzhMoV0YBj/smHw1CqVVy+UlzqotY
         MOyNYuAFtyn8w/uKg0/7sMfs/oEDhEi3cThm1RGWJr9SIAXru5jPaj7lMlntQFQcYrEf
         zqcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2cDMST3loBmPEvX019dbwyMNULGzjxVtVrkk6taLCiY=;
        b=r4INNAhPcK+hSoaNLESmWgbXZNWkhmh1LlSENCGMg/Q4sjBHqHym2kuOF+WO0nZG59
         pGlg2FJQaIQo/umE5vAYkxeeIbjnGRxyyKcuZK5gtQJgIFRZQnuoO1bz3ERxbmtiTI1e
         CXlyZXUzSN073kJxVv8w95gby/2ZmOMt4I5gWr6yw7ztKvA0TiKrbeLX47+r3svGmrhO
         tRqRzHewQfwS636ryCJbnLcMEVMUCmycOXCJd5COLzIFJ1pGay1HqgqZ+swy2uNhFFNx
         2P1BNF+Bx6CUEXFshqAgONkSrvXkiuw+HJFOmS69S89xrHNIgJAIjAtisA+zm8m3HAbO
         3PAw==
X-Gm-Message-State: AOAM531i3OJ51Fdlc8OyWVkPzRnWzo1C8RdGUwjGh84kdAziamFH1wd2
        DOgUhaecSBZslb4HKxz/0McI30lI+VViYShh5wX/1w==
X-Google-Smtp-Source: ABdhPJzElPUJjtskrFleP7E3SdPQRsAoyT1yuPaEsbXdGdP+ZaGwNiERgoW0cL+yKMh7Fz49XPtfiKOQapoAEGTRmVE=
X-Received: by 2002:a92:7914:: with SMTP id u20mr9039534ilc.203.1605547192238;
 Mon, 16 Nov 2020 09:19:52 -0800 (PST)
MIME-Version: 1.0
References: <20201115152752.1625224-1-pbonzini@redhat.com>
In-Reply-To: <20201115152752.1625224-1-pbonzini@redhat.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Mon, 16 Nov 2020 09:19:41 -0800
Message-ID: <CANgfPd8QjQEpSrNXxYUztOZ=+_Vp6KwbS7PyPwH-MxT906Aa8Q@mail.gmail.com>
Subject: Re: [PATCH] kvm: mmu: fix is_tdp_mmu_check when the TDP MMU is not in use
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 15, 2020 at 7:27 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> In some cases where shadow paging is in use, the root page will
> be either mmu->pae_root or vcpu->arch.mmu->lm_root.  Then it will
> not have an associated struct kvm_mmu_page, because it is allocated
> with alloc_page instead of kvm_mmu_alloc_page.
>
> Just return false quickly from is_tdp_mmu_root if the TDP MMU is
> not in use, which also includes the case where shadow paging is
> enabled.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Ben Gardon <bgardon@google.com>

> ---
>  arch/x86/kvm/mmu/tdp_mmu.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
> index 27e381c9da6c..ff28a5c6abd6 100644
> --- a/arch/x86/kvm/mmu/tdp_mmu.c
> +++ b/arch/x86/kvm/mmu/tdp_mmu.c
> @@ -49,7 +49,14 @@ bool is_tdp_mmu_root(struct kvm *kvm, hpa_t hpa)
>  {
>         struct kvm_mmu_page *sp;
>
> +       if (!kvm->arch.tdp_mmu_enabled)
> +               return false;
> +       if (WARN_ON(!VALID_PAGE(hpa)))
> +               return false;
> +
>         sp = to_shadow_page(hpa);
> +       if (WARN_ON(!sp))
> +               return false;
>
>         return sp->tdp_mmu_page && sp->root_count;
>  }
> --
> 2.26.2
>
