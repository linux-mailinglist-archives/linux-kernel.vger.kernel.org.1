Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C15B82EE6A1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 21:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbhAGUSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 15:18:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbhAGUSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 15:18:40 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCA4C0612F4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 12:18:00 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id o17so17626431lfg.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 12:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dGs5SC/WgPGPwKJAjM4eEmzVICBqZQ76JG19WsL7/rQ=;
        b=FQSGvmK+Xq6jpxFayh+QAC+i2+ruwFl+7GQruzMXs4TpJg88gnkX97b2mPGKPlgJGX
         AMrAJMDLYYA+DHS2uYLi42G+367WhqwDgya7y4vMNHXqZ4lSr2ADFnbQw8rUyv/G3+vo
         vp9ggy2xaeUofO3SQxirTt7eGCncCcRZZ9eJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dGs5SC/WgPGPwKJAjM4eEmzVICBqZQ76JG19WsL7/rQ=;
        b=ljHqk8AZZK8g5YFCrO8fdurd8MVLclEyrAwKFWAVe1CH6IVW3Cdp2ErV71w3OOjqpG
         8qlh+wWKC2hloZPddtMaqTn1A3bBQWvnQhqIhNoffpgYyVD2FiL90bS1GWj23nfT2UgT
         OLn1wNR0urfdQuCFDdYrTGTjKjMsqZtpiq5sZ5oMaCBuTWU9bAw5fOSSn/aUiPoamb31
         TeNMxdC0RTiovA1+7jswZu5yH9Sks+u7k9aT/BVoLQQqRhvOwZvgKTxiskx7q2dGC+yl
         jMaXO1Jlk9aczjJTdc2Fpz525XewhKrONo+VnUaiuYF1vowODpRKIlEtDM1pwOuchGKo
         JwbA==
X-Gm-Message-State: AOAM530rbWou25O+LP4ceCOKyX3TuF8q5GZkrHU4lB/kp/940CIqzzVw
        Om860ZIGFFPwMwsoY4Kn7j5jUNK4iO8QEA==
X-Google-Smtp-Source: ABdhPJysUHnMvX/bXtG3zWq+kWHeBaGz7aoEiS81Jd7HevI620hjrNG7uovd53v5X1B+g4Q64SQ/lQ==
X-Received: by 2002:ac2:4249:: with SMTP id m9mr212201lfl.594.1610050678025;
        Thu, 07 Jan 2021 12:17:58 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id b5sm1391219lfo.126.2021.01.07.12.17.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jan 2021 12:17:56 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id m25so17482756lfc.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 12:17:56 -0800 (PST)
X-Received: by 2002:a05:6512:338f:: with SMTP id h15mr189659lfg.40.1610050676088;
 Thu, 07 Jan 2021 12:17:56 -0800 (PST)
MIME-Version: 1.0
References: <B1B85771-B211-4FCC-AEEF-BDFD37332C25@vmware.com>
 <20210107200402.31095-1-aarcange@redhat.com> <20210107200402.31095-3-aarcange@redhat.com>
In-Reply-To: <20210107200402.31095-3-aarcange@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 7 Jan 2021 12:17:40 -0800
X-Gmail-Original-Message-ID: <CAHk-=whg-91=EF=8=ayyDQGx_3iuWKp3aHUkDCDkgUb15Yh8AQ@mail.gmail.com>
Message-ID: <CAHk-=whg-91=EF=8=ayyDQGx_3iuWKp3aHUkDCDkgUb15Yh8AQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: soft_dirty: userfaultfd: introduce wrprotect_tlb_flush_pending
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yu Zhao <yuzhao@google.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 7, 2021 at 12:04 PM Andrea Arcangeli <aarcange@redhat.com> wrote:
>
> However there are two cases that could wrprotecting exclusive anon
> pages with only the mmap_read_lock:

I still think the real fix is "Don't do that then", and just take the
write lock.

The UFFDIO_WRITEPROTECT case simply isn't that critical. It's not a
normal operation. Same goes for softdirty.

Why have those become _so_ magical that they can break the VM for
everybody else?

         Linus
