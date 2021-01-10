Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7E3B2F04A6
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 02:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbhAJA4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 19:56:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbhAJA4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 19:56:50 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEDDAC061786
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jan 2021 16:56:09 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id x20so32191214lfe.12
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jan 2021 16:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y1TK5R1FLhqUZHzbZyE7M4Dp0Iue9KfHCBqgmZJIg4A=;
        b=AVQ2wT4R/pilMT7+jZVuipht74IAH3YCX14vesrft3syqoEeGPIytKbWZxWcF3FWPs
         1zXY9kXUAb1gRWJ1Lp6xuWksyVJrsBomCAf4x2GwcLUYGGYpE07qDPb5zIqZySfZ3mOB
         gQNwVUSISMUSiKt1kdVoXFc4Jh0OsdEPYLhjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y1TK5R1FLhqUZHzbZyE7M4Dp0Iue9KfHCBqgmZJIg4A=;
        b=n/rKYLV2bXSoIqkncs/KXG2YvixSMUY0wsSKieJYgOo0d+hCiIlrQRFAGSiNfU9uY1
         duDJdNsfKdU2VsU949s6T1DG7CCbapGsg1YQ6NW1jDp0gGj03YaywiBJK56ToqBmjvDe
         6bJbEJBbMhS3Os70S26GUR9gzGmGpiG/z+IvfGtqnkT6lBpMaKEQnCEuCsbI+yu688BF
         Ibl7nMwcAcfCozCpUkpBhUowZ9TsvL3n6vfWZ8Dref8PZsJdK1EPGojRiNyMCDWVAawA
         bkiQTgI9kuBa4R8EmEu+Z/euWhgAloJeGVZoUrbB4ucjnbgEkXL2nWvp/eLuviNEaVBT
         1dlw==
X-Gm-Message-State: AOAM533LEmb5Xla7EloYYGIJFPh1C+0lL0op+8eS1+NX1WZakq6Wj6RY
        vk8t196kto73woLiWLjS0HzEv9+sBjGnBg==
X-Google-Smtp-Source: ABdhPJwkWRE9/mBV/2ViG9ZbVIEd0eZPt0uptG6TqVBXG0DeCXTEWecSgn/A7Bi0rVJrqzzYC3QSGQ==
X-Received: by 2002:a19:716:: with SMTP id 22mr4296654lfh.390.1610240167754;
        Sat, 09 Jan 2021 16:56:07 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id k18sm2805445ljb.80.2021.01.09.16.56.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Jan 2021 16:56:06 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id x20so32191084lfe.12
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jan 2021 16:56:05 -0800 (PST)
X-Received: by 2002:a19:8557:: with SMTP id h84mr4187473lfd.201.1610240165669;
 Sat, 09 Jan 2021 16:56:05 -0800 (PST)
MIME-Version: 1.0
References: <20210110004435.26382-1-aarcange@redhat.com>
In-Reply-To: <20210110004435.26382-1-aarcange@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 9 Jan 2021 16:55:49 -0800
X-Gmail-Original-Message-ID: <CAHk-=wghqNywtf=sRv_5FmG=+hPGqj=KWakw34tNeoZ1wPuaHg@mail.gmail.com>
Message-ID: <CAHk-=wghqNywtf=sRv_5FmG=+hPGqj=KWakw34tNeoZ1wPuaHg@mail.gmail.com>
Subject: Re: [PATCH 0/1] mm: restore full accuracy in COW page reuse
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
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
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Nadav Amit <nadav.amit@gmail.com>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 9, 2021 at 4:44 PM Andrea Arcangeli <aarcange@redhat.com> wrote:
>
> Once we agree that COW page reuse requires full accuracy, [...]

You have completely and utterly ignored every single argument against that.

Instead, you just continue to push your agenda.

The thing is, GUP works fine.

COW works fine.

The thing that is broken is clear_refs.

Yet you try to now "fix" the two fine cases, because you don't want to
fix clear_refs.

What part of "clear_refs is the _least_ important of the three cases"
are you not willing to understand?

                 Linus
