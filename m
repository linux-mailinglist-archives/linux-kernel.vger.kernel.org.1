Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 703AB2FD8B2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 19:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391831AbhATSqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 13:46:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727517AbhATS1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 13:27:55 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671B3C061757
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 10:27:15 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id b8so12951385plh.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 10:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uiW6R+4OroO7DV/CnGwFhudMKTgvqDzlldk0/NCSxIM=;
        b=quWaPHodtXoBEM4er9UrGLPUP4C6pIAo1GfMKNEJNcdOz4TFWyZR+oBy9LoOaUlFpl
         8zpzY1PKROmbQwEOb7yvm8ggsN9fh0D1uwXu6rYsXh2rrh8Ae7WULfiPMhN/wy/nSRCI
         bC5+7Z4yH/Gwiini9VCTaujDniBcpQbsPaB6W5srOSFSJAZJq4HUPc9GyKumH2lLxyr3
         20iZoVwN++wb61UullUjVK81Uk1yMkOgyxRPZrMBoFPKC/Pif8PM0GebcQCf9fh+YXJ0
         VbKja2a8YxlBdC9zs8HV9JhEIVyR7e35k1j86OtY9JFvpJyNFWIHgdArmjw1XwzIwuJ9
         x9Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uiW6R+4OroO7DV/CnGwFhudMKTgvqDzlldk0/NCSxIM=;
        b=aBZKkuPV4oimfHdmuTPHU8KOe7gDiiyTneuACkZBW76Jzzxu9Q3Tt63oMIqSU18U3b
         KqTGlAAcB35a+Uu+KW9t3e5Koja1cv/8ed6JTBfLsmiB3fBYcfvjcErmtF23yLEle2nr
         qloUOmRAN4cbHs0EH7H7tj9YIsaGeNA6G3XYhKSOeijRMJQlIPNvCim63dBM4J6Rmkog
         /PVS9fOf/YBegwP3jOKFUfEzRnHaZH7As+80DtjsljagU9aP/BUNkls3DfcQ+xPSxo62
         7I6XC2jQ3nK7JjGtzYMc0z8KZ7c0A8UZe0YIvWUIbmwuOcgj5G7bXSUyiqRO4IpSaRaO
         OuOQ==
X-Gm-Message-State: AOAM5336z6sxs8XCxJVFAOxdWgYL9p9/+KW1PzAgzefydAcjJFVZBd+E
        XKRbO4H+zPPrsQWPEHWw2y6Z4LUZDkqpeYQKojrTmEm7A5KNCQ==
X-Google-Smtp-Source: ABdhPJztSwBi+iAIwUggUK6+sTeRb+j0bW0Cdtft+/KRMsHKFTPOr75taMb9vlVZxWG24rYXR0mZQzqMPzxZOXgDSK4=
X-Received: by 2002:a17:902:26a:b029:da:af47:77c7 with SMTP id
 97-20020a170902026ab02900daaf4777c7mr11275754plc.10.1611167234448; Wed, 20
 Jan 2021 10:27:14 -0800 (PST)
MIME-Version: 1.0
References: <20210120173612.20913-1-will@kernel.org> <20210120173612.20913-9-will@kernel.org>
In-Reply-To: <20210120173612.20913-9-will@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 20 Jan 2021 10:27:04 -0800
Message-ID: <CAKwvOd=B+tMi7-82Q8hEYnQ+BzkLDygOhMh6cQ2L+3SaL+F4tQ@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] mm: Mark anonymous struct field of 'struct
 vm_fault' as 'const'
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
> The fields of this struct are only ever read after being initialised, so
> mark it 'const' before somebody tries to modify it again.
>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  include/linux/mm.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index e0f056753bef..7ff3d9817d38 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -514,7 +514,7 @@ static inline bool fault_flag_allow_retry_first(unsigned int flags)
>   * pgoff should be used in favour of virtual_address, if possible.
>   */
>  struct vm_fault {
> -       struct {
> +       const struct {
>                 struct vm_area_struct *vma;     /* Target VMA */
>                 gfp_t gfp_mask;                 /* gfp mask to be used for allocations */
>                 pgoff_t pgoff;                  /* Logical page offset based on vma */

Is there a difference between:

+       const struct {
+               struct vm_area_struct *vma;     /* Target VMA */
+               gfp_t gfp_mask;                 /* gfp mask to be used
for allocations */
+               pgoff_t pgoff;                  /* Logical page offset
based on vma */
+               unsigned long address;          /* Faulting virtual address */
+       };

vs

+       struct {
+               struct vm_area_struct * const vma;     /* Target VMA */
+               const gfp_t gfp_mask;                 /* gfp mask to
be used for allocations */
+               const pgoff_t pgoff;                  /* Logical page
offset based on vma */
+               const unsigned long address;          /* Faulting
virtual address */
+       };

ie. marking the members const vs the anonymous struct?  Does anything
need to change in the use of these structures?

> --
> 2.30.0.284.gd98b1dd5eaa7-goog
>


-- 
Thanks,
~Nick Desaulniers
