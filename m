Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6242E0156
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 20:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgLUT4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 14:56:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgLUT4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 14:56:03 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451C0C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 11:55:23 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id b26so17025253lff.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 11:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vCBFPsCpCA9jFChy+wbQC9wCUWkajD5jyJSjFoZ0ofo=;
        b=RoUfL1UQrju6L48+iQbnAuB+O5aGNFDdmcnK2mRc37NBlEcyy3oNTYfXpUHSUk0B35
         dyl68X414Hb7YAzAj1hsl3TCaId7C7UFi67zJ4SoucOav2U+/iSnEu4JiV4cxpWLeNcM
         8qVKyAtxm6Xi83AKNirlrvn4iBrF7Tec+b0I0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vCBFPsCpCA9jFChy+wbQC9wCUWkajD5jyJSjFoZ0ofo=;
        b=q/pZ29NL0mIC5IjbnKdWRn15TtB5+xx/ESiF+jtz5Fn5nOepS+K72isZYpCchpUJjz
         Ygu/uVcdNrnt0h1FiWwE5YAL33k0aj4T77qPFpKPvWTKmPpeSFz0F2+yR6SNga9cmViW
         xn+wzm0pC/nC8YpcC7oZ9bcJxm4+g7qKizuDIQ73JsrTxhqI52zs47vRFNYyaHgnLgY+
         CQOrs4jV64CCL/50As35xa3guKR54RzqwFjyRGM7i38ELdLWNjSrVwYf3rOt8m/CywWl
         D/Kp2PCEHVIgZT3UQG+MlUvVtpkfr+z8R8lGsx24FwXA/xYAnnWNX2ReEmMRdyw9mgBD
         CwAw==
X-Gm-Message-State: AOAM533U4U10gIEnwCi7i9IQNpGi+ojhgAFchKSgtV9BuFX/bcFug3k4
        jtBH3FaVX/ygxZfjUhUzQTLLH5ocP4w0Jw==
X-Google-Smtp-Source: ABdhPJxOVtjc4e/vMooxSxeH5sxrLXBMUCzc23OK7W9LCahuG8an1Wh62X2MUS/Xxe8nPN2ZX/XIKw==
X-Received: by 2002:a19:b97:: with SMTP id 145mr6880775lfl.457.1608580520936;
        Mon, 21 Dec 2020 11:55:20 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id a8sm2198456lfj.65.2020.12.21.11.55.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Dec 2020 11:55:19 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id h205so26542336lfd.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 11:55:19 -0800 (PST)
X-Received: by 2002:ac2:41d9:: with SMTP id d25mr6675489lfi.377.1608580519056;
 Mon, 21 Dec 2020 11:55:19 -0800 (PST)
MIME-Version: 1.0
References: <20201219043006.2206347-1-namit@vmware.com> <X95RRZ3hkebEmmaj@redhat.com>
 <EDC00345-B46E-4396-8379-98E943723809@gmail.com> <X97pprdcRXusLGnq@google.com>
 <DDA15360-D6D4-46A8-95A4-5EE34107A407@gmail.com> <20201221172711.GE6640@xz-x1>
 <76B4F49B-ED61-47EA-9BE4-7F17A26B610D@gmail.com> <X+D0hTZCrWS3P5Pi@google.com>
In-Reply-To: <X+D0hTZCrWS3P5Pi@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 21 Dec 2020 11:55:02 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg_UBuo7ro1fpEGkMyFKA1+PxrE85f9J_AhUfr-nJPpLQ@mail.gmail.com>
Message-ID: <CAHk-=wg_UBuo7ro1fpEGkMyFKA1+PxrE85f9J_AhUfr-nJPpLQ@mail.gmail.com>
Subject: Re: [PATCH] mm/userfaultfd: fix memory corruption due to writeprotect
To:     Yu Zhao <yuzhao@google.com>
Cc:     Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        stable <stable@vger.kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nadav Amit <nadav.amit@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 21, 2020 at 11:16 AM Yu Zhao <yuzhao@google.com> wrote:
>
> Nadav Amit found memory corruptions when running userfaultfd test above.
> It seems to me the problem is related to commit 09854ba94c6a ("mm:
> do_wp_page() simplification"). Can you please take a look? Thanks.
>
> TL;DR: it may not safe to make copies of singly mapped (non-COW) pages
> when it's locked or has additional ref count because concurrent
> clear_soft_dirty or change_pte_range may have removed pte_write but yet
> to flush tlb.

Hmm. The TLB flush shouldn't actually matter, because anything that
changes the writable bit had better be serialized by the page table
lock.

Yes, we often load the page table value without holding the page table
lock (in order to know what we are going to do), but then before we
finalize the operation, we then re-check - undet the page table lock -
that the value we loaded still matches.

But I think I see what *MAY* be going on.  The userfaultfd
mwriteprotect_range() code takes the mm lock for _reading_. Which
means that you can have

Thread A     Thread B

 - fault starts. Sees write-protected pte, allocates memory, copies data

                   - userfaultfd makes the regions writable

                   - usefaultfd case writes to the region

                   - userfaultfd makes region non-writable

 - fault continues, gets the page table lock, sees that the pte is the
same, uses old copied data

But if this is what's happening, I think it's a userfaultfd bug. I
think the mmap_read_lock(dst_mm) in mwriteprotect_range() needs to be
a mmap_write_lock().

mprotect() does this right, it looks like userfaultfd does not. You
cannot just change the writability of a page willy-nilly without the
correct locking.

Maybe there are other causes, but this one stands out to me as one
possible cause.

Comments?

              Linus
