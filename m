Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15FBB2EE941
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 23:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbhAGWw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 17:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727669AbhAGWwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 17:52:24 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADEEC0612F4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 14:51:44 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id o13so18539789lfr.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 14:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MpUXPlOpjoaY/t+m2AK2xZLsPyG5FSaY9KMpLdS2dhw=;
        b=G4oJ39ti8dgcRqvI7baXd54HVqR6F0iRx/fnKM96EUoWqgYKtQCN07SCaol2E0qoZA
         1/0qyVSNPbPjKiFYtyydwwn63S8AffyVbCftg3OOFVFN20qvxP36tMnvcmtcQcHudZJa
         XZ2BPp/sEsPoEEDpsVVoQUye8djTn0iPsEm0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MpUXPlOpjoaY/t+m2AK2xZLsPyG5FSaY9KMpLdS2dhw=;
        b=mjOyo7oeX0S15nE1IhQ8/wDhunb3IJvQ+BktQI+rvMd83ZXvUryeoB6WAVU/eGR3jv
         nw08yz8FLEm8PiEkrsiJPleYwnuPochaHWhEH/D1T/eCeiU/gFl4lF9XSnblBmEpfwvM
         coP/mODeUCAiUAyeQ9BeEhla4ou52EAbGcYAXpVCobaGJBu8CzGpXHnjAZ4u/hjjDa0Z
         ZABZS2vH2Lo+jZJUU2jXwYWFHq7HpZVhUQWS5wR0sjmm5m27dkOVLTNV4lALyn509YzN
         ihrqT/WXd4FkLM5UKXI6xPyVVR5DU5n16mx5YocPaOF87fLEIME1rRIAGRobcVMcuGOo
         SayA==
X-Gm-Message-State: AOAM530PBiQJYfUSriogvs8B24G5ecMN1AHgnJGqVswssjtxe5yd7ecB
        9OypayXpfDjczucFCfrYeavl+Vk7a4XSgA==
X-Google-Smtp-Source: ABdhPJx2qulEq4wq4fV8kqOmKqDcuNSzyhzimj5r0GVhwW8nf+Uu3kJ1bZQPvfRatPigKbFXi3J0tQ==
X-Received: by 2002:a2e:87cb:: with SMTP id v11mr276920ljj.218.1610059902216;
        Thu, 07 Jan 2021 14:51:42 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id s4sm1593726ljp.123.2021.01.07.14.51.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jan 2021 14:51:41 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id h205so18497893lfd.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 14:51:40 -0800 (PST)
X-Received: by 2002:a2e:b4af:: with SMTP id q15mr255547ljm.507.1610059900270;
 Thu, 07 Jan 2021 14:51:40 -0800 (PST)
MIME-Version: 1.0
References: <B1B85771-B211-4FCC-AEEF-BDFD37332C25@vmware.com>
 <20210107200402.31095-1-aarcange@redhat.com> <20210107200402.31095-3-aarcange@redhat.com>
 <CAHk-=whg-91=EF=8=ayyDQGx_3iuWKp3aHUkDCDkgUb15Yh8AQ@mail.gmail.com>
 <X/d2DyLfXZmBIreY@redhat.com> <CAHk-=wjs9v-hp_7HV_TrTmisu7pNX=MwZ62ZV82i0evLhPwS1Q@mail.gmail.com>
 <X/eLwQPd5bi620Vt@redhat.com> <CAHk-=whjS3pUZRJLR_HdgB0_1Sd4gWXUbLLyShKxOg0ySCdnUA@mail.gmail.com>
In-Reply-To: <CAHk-=whjS3pUZRJLR_HdgB0_1Sd4gWXUbLLyShKxOg0ySCdnUA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 7 Jan 2021 14:51:24 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgRZ5o5pUqKC6cwTLU=V-G+rF5DTexGh1kCMGrgXDufew@mail.gmail.com>
Message-ID: <CAHk-=wgRZ5o5pUqKC6cwTLU=V-G+rF5DTexGh1kCMGrgXDufew@mail.gmail.com>
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

On Thu, Jan 7, 2021 at 2:42 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> But I thought we agreed earlier that that is a bug. And I thought the
> softdirty code already got it for writing.

Ho humm. I had obviously not looked very much at that code. I had done
a quick git grep, but now that I look closer, it *does* get the
mmap_sem for writing, but only for that VM_SOFTDIRTY bit clearing, and
then it does a mmap_write_downgrade().

So that's why I had looked more at the UFFD code, because that one was
the one I was aware of doing this all with just the read lock. I
_thought_ the softdirty code already took the write lock and wouldn't
race with page faults.

But I had missed that write_downgrade. So yeah, this code has the same issue.

Anyway, the fix is - I think - the same I outlined earlier when I was
talking about UFFD: take the thing for writing, so that you can't
race.

The alternate fix remains "make sure we always flush the TLB before
releasing the page table lock, and make COW do the copy under the page
table lock". But I really would prefer to just have this code follow
all the usual rules, and if it does a write protect, then it should
take the mmap_sem for writing.

Why is that very simple rule so bad?

(And see my unrelated but incidental note on it being a good idea to
try to minimize latency by making surfe we don't do any IO under the
mmap lock - whether held for reading _or_ writing. Because I do think
we can improve in that area, if you have some good test-case).

              Linus
