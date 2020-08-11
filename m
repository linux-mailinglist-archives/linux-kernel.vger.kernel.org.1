Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D195B241CE9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Aug 2020 17:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbgHKPFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Aug 2020 11:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728873AbgHKPFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 11:05:43 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D297C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 08:05:43 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id v9so13910985ljk.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 08:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TaPumgxPjnd+MZwdU/KPpO4ZkCcirToPKuAM/OHOrZ8=;
        b=cPvbvK0qtt0DSX98ByGWOqz50YA0tE0K8uuQ4uIsZWUOR9+u7UiyblnJaV4/MELZ+g
         AT6cJeqrtn5NAjcKmPQHIeMYzwSvlfiiQ7WGKy/sPmFsMDF0sruzmYzPL37JWz8JlzX8
         l9KTUnxhv8BD7fRwIsdDwW7mzuiDF7KkaPvz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TaPumgxPjnd+MZwdU/KPpO4ZkCcirToPKuAM/OHOrZ8=;
        b=eh36jfxM+OgpjEW1StcBjlXaHjg3YwPKV54dxyembwLhLesn4oJJTre1uL5bve604V
         Mv86+pm72ttnGNPgB5eNE3eYWiiLbKKr9u+J3tV/FOwgEqbFPZZN+e63Tc2eJvleAS4P
         t/HCwmNq4oVEw529bqfnC8JmRPBKxnDhxfXQZUkY8rqx+achSKJtcxdqz2tdh8wbefPA
         kOr5tcU+bQ9Ox7Bo+Dj6zQbEovTRsc9G+PA6iSG5wqaYbeF2QNKvbl0YKlkk7b23WNIc
         kN7LbjlIObpr7PwkrL0RYyMkVYN3qyyXl/MuOs5AFZWt/Qds46xmrUcS6jPFputKoUxe
         L8JQ==
X-Gm-Message-State: AOAM530U4yOa9bxNxjGxWcbESTJdxsVB9s0XDfBp6C6WaCKTv3L4eM3R
        Gs2oIPmJ6zrxWU8fBGi+rfm+w8JLtwE=
X-Google-Smtp-Source: ABdhPJzYwJN/VhToDrEmKw4E16meUj7qJXmruhtDgvGHD3gpIKsMujdsSAZdvQLgzVmJd38L1BLEBA==
X-Received: by 2002:a2e:9b4c:: with SMTP id o12mr3253082ljj.49.1597158340987;
        Tue, 11 Aug 2020 08:05:40 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id d22sm11651352lfs.26.2020.08.11.08.05.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 08:05:39 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id 140so6849990lfi.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 08:05:39 -0700 (PDT)
X-Received: by 2002:a19:c206:: with SMTP id l6mr3385024lfc.152.1597158338674;
 Tue, 11 Aug 2020 08:05:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200810145701.129228-1-peterx@redhat.com> <CAHk-=wiSF+aKhDOewxQGCGUPyGnA=K7OtAczL5M7aisA5mgFzg@mail.gmail.com>
 <20200810191520.GA132381@xz-x1> <CAHk-=whUVHA-=4mwGaUA42teESc2mX1nwZjbbOMQsvPaoYxh3w@mail.gmail.com>
 <20200810215734.GB132381@xz-x1> <CAHk-=whng9zK-GMM+UHsTptF=mgH164Zt_Gok3ohbcWaYee71Q@mail.gmail.com>
 <CAG48ez1R_F-Oxz++sQ0dGTqZKHCyKazVEKZTTAutQbSuohXXnw@mail.gmail.com>
In-Reply-To: <CAG48ez1R_F-Oxz++sQ0dGTqZKHCyKazVEKZTTAutQbSuohXXnw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Aug 2020 08:05:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgyrfrpRvM8CYiiZR8s7MKC_exFDw=mPGnEKzqXBcYJxA@mail.gmail.com>
Message-ID: <CAHk-=wgyrfrpRvM8CYiiZR8s7MKC_exFDw=mPGnEKzqXBcYJxA@mail.gmail.com>
Subject: Re: [PATCH v2] mm/gup: Allow real explicit breaking of COW
To:     Jann Horn <jannh@google.com>
Cc:     Peter Xu <peterx@redhat.com>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Kirill Shutemov <kirill@shutemov.name>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 4:39 PM Jann Horn <jannh@google.com> wrote:
>
> The way I understand Peter, he doesn't want to avoid doing COW; he
> wants to decouple userfaultfd-WP's fault handling from COW, so that
> userfaultfd-wp notifies only when a previously-write-protected page is
> actually written to. In other words, he wants the COW to basically
> happen as it happens now, but it should only create a readonly PTE;
> and if someone later triggers a real write fault, the fault handling
> path would run again, and this time userfaultfd-wp would be notified
> before that readonly PTE is turned into a writable one.

Ahh.

A light goes on.

Thank you.

And apologies to Peter - I misread that patch entirely.

That said, now that I (finally) understand what Peter wants to do, I
don't think the patch does what you say.

Because the GUP will now indeed avoid userfaultfd-wp unless it's
_actually_ a write, but then any reads will cause a COW that turns
things writable. There is no second fault.

So now later writes will never cause any userfaultfd-wp notifications at all.

Which for all I know might be acceptable and ok, but it seems to be
against userfaultfd rules, and against the whole synchronization idea.

So I think the patch is broken, but I'm less fundamentally concerned about it.

Because at that point, it's "only" userfaultfd that might break.

                  Linus
