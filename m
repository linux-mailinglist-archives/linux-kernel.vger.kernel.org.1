Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34B942FD87C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 19:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404548AbhATSXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 13:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733046AbhATSOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 13:14:38 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D87C061757
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 10:13:49 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id q7so15721861pgm.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 10:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vqS6EOPx1v3lWV34LsE0XHCb+L3kcvteEkC/GfC64BE=;
        b=b7UUDohhc2AV/P0BT5XU6kMSxgSGbx9gumh1WGnEmTDRseGY7iJA+G6oMj8f74T9IP
         g7a7ce/MHu3y6yyAsCnkxfz+Sij+ZD9X53N4EGLxVW+NhVxW+PPlfDegkd2p/b5Sl4NF
         /T0Ghpwz5b3UQGdqc+aqnf8kvfVQhb4Dlm8c1q0rpeW7q7/AKR8/JjIcYqXvUo5zXR9X
         Cp9U8UPguu/Y+CbVFSmiq5i2BAv7P9gMdYGQftTwxXU19cGKiRRWhyYWV8+NGNks0/is
         H5PkLSsnH7KRZWM3XEO9AYVK4icTY92ntUCzRoE9EA25RmD+U4wHNbUD2SV4sxDner+r
         VoRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vqS6EOPx1v3lWV34LsE0XHCb+L3kcvteEkC/GfC64BE=;
        b=OK3eHvv2gprcPWjGmjeZap4WBxKqq/VuVtGb5Jbk808suLgvM7B1TzQJuiF8TNV6NU
         y8wdaNS8COZdTJ+fVq96FC3PcVa8O8oUhyS/KcNc+/iBbu+xroQRnyYbzUJ0u/m/3RrD
         d4nuHLKtVzSCkQtT4oSmjJMeP+kyDxPfBC0kfy8gYvEXohoajIu4HRMjWjyj+txIKjCO
         jOPMcZc9UOM39yzb9d0rrT0OfGH/uD3eMdnbcvyht72Gc8N+RAdSXvAXzHW7rnwj84XU
         Fnz+tjkCRmGqzvrUoZcxLzjsObX0CmgcJ7HFbrhw+mIS9I607tZ0NGhb65m1IFFCyPeE
         vTfg==
X-Gm-Message-State: AOAM532UqF47dbQmDvRaBrkLGQc4eXqi+ec5paEpOtGvduibuNwDaLgZ
        RvjxRHvGQAo1Ue2HD1Tr/7I3I+rVoEOLknzNM1QxiugQEsY=
X-Google-Smtp-Source: ABdhPJzxKvvh4dLbPl6a/sMb5hnfqVGEKnrS2VQPwNZAtsZj2lhEVlzA2jjsOwNk5IvxDMpihfHJvdns9QRf9aoD2V8=
X-Received: by 2002:a62:838d:0:b029:1ba:9b85:2eac with SMTP id
 h135-20020a62838d0000b02901ba9b852eacmr5037355pfe.36.1611166428292; Wed, 20
 Jan 2021 10:13:48 -0800 (PST)
MIME-Version: 1.0
References: <20210120173612.20913-1-will@kernel.org> <20210120173612.20913-5-will@kernel.org>
In-Reply-To: <20210120173612.20913-5-will@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 20 Jan 2021 10:13:37 -0800
Message-ID: <CAKwvOd=UvtSnWiB94gvm0SE9DeJsaaVTJ_fpfh2B4NT1mhr-GQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/8] mm: Move immutable fields of 'struct vm_fault'
 into anonymous struct
To:     Will Deacon <will@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Hugh Dickins <hughd@google.com>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 9:36 AM Will Deacon <will@kernel.org> wrote:
>
> 'struct vm_fault' contains both information about the fault being
> serviced alongside mutable fields contributing to the state of the
> fault-handling logic. Unfortunately, the distinction between the two is
> not clear-cut, and a number of callers end up manipulating the structure
> temporarily before restoring it when returning.
>
> Try to clean this up by moving the immutable fault information into an
> anonymous struct, which will later be marked as 'const'. GCC will then
> complain (with an error) about modification of these fields after they
> have been initialised, although LLVM currently allows them without even
> a warning:
>
> https://bugs.llvm.org/show_bug.cgi?id=48755

I think this paragraph+link would be better on patch 8/8.

>
> Ideally, the 'flags' field would be part of the new structure too, but
> it seems as though the ->page_mkwrite() path is not ready for this yet.
>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Link: https://lore.kernel.org/r/CAHk-=whYs9XsO88iqJzN6NC=D-dp2m0oYXuOoZ=eWnvv=5OA+w@mail.gmail.com
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  include/linux/mm.h | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 251a2339befb..b4a5cb9bff7d 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -517,11 +517,14 @@ static inline bool fault_flag_allow_retry_first(unsigned int flags)
>   * pgoff should be used in favour of virtual_address, if possible.
>   */
>  struct vm_fault {
> -       struct vm_area_struct *vma;     /* Target VMA */
> -       unsigned int flags;             /* FAULT_FLAG_xxx flags */
> -       gfp_t gfp_mask;                 /* gfp mask to be used for allocations */
> -       pgoff_t pgoff;                  /* Logical page offset based on vma */
> -       unsigned long address;          /* Faulting virtual address */
> +       struct {
> +               struct vm_area_struct *vma;     /* Target VMA */
> +               gfp_t gfp_mask;                 /* gfp mask to be used for allocations */
> +               pgoff_t pgoff;                  /* Logical page offset based on vma */
> +               unsigned long address;          /* Faulting virtual address */
> +       };
> +       unsigned int flags;             /* FAULT_FLAG_xxx flags
> +                                        * XXX: should really be 'const' */
>         pmd_t *pmd;                     /* Pointer to pmd entry matching
>                                          * the 'address' */
>         pud_t *pud;                     /* Pointer to pud entry matching
> --
> 2.30.0.284.gd98b1dd5eaa7-goog
>


-- 
Thanks,
~Nick Desaulniers
