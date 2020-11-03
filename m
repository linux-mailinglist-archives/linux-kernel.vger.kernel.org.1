Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 225122A4D44
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 18:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbgKCRkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 12:40:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbgKCRkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 12:40:45 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E519C0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 09:40:45 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id y16so20008587ljk.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 09:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VNuZGY4bpOVQ0MWLoadHLlFU7CajKxxBqUm83XLo9pg=;
        b=HMA9GKwvbdKK/+0mVxuViEE+jonKrCcpg4izx74kjD6cePewJ27tQSij8RYpkFdSs1
         w/SVIscNoPKqcQGjWeedtzu6vz+iecm8rT4dumRlRdUsVWQGr2OnOXiqvB1acZS2dN/I
         I9ODfraNHzaYMpRzWgSmjhMzYpYEx67/w2iyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VNuZGY4bpOVQ0MWLoadHLlFU7CajKxxBqUm83XLo9pg=;
        b=LmnVFH7UA+zC6t6mvmTbo+Fkw19jGbBmiRkivS9hsY8DUq+UXfM1cyTNSb7xb46rSA
         IPQ6CQTV1QMkNbs9Z3CO/lT+e/fvUkWBDbMHCusyQuNcTiEinwuuk6xkDPCa+sJKAiTJ
         FpjOPeck1jSiORAK5eO6ot+WwICG3LCIPuoVQWHjFEdb/LKZdFmQKKFb/JfICmnLOlw9
         nqvGdX5B2y1SS3dl0+Hq2cRzrXvQmLnpRFY4ifY4UBUv8NfsyI3BWqn09wseVOeI40KB
         cP0B10s3L/0KuDGkLT2JWMOElnau9xmRto6AA7hUugGcqv/4wCgS4IIF1XOQEQ8tWLZX
         W9hA==
X-Gm-Message-State: AOAM533CD87gp9u5qQIWBL84sNlSI+1+32TnAb0qtnMl8BIYAGR8Gxwy
        ThME5IiY5pP4rI3ytgYOjSsvOjh2FQtRFQ==
X-Google-Smtp-Source: ABdhPJwmEAPuSNeHiIJC7Pi3uoP/8nfnNQpfuawo1vS5UlbI3RWwRS3EcC1rnqcIvp6uYeYB4PPh9A==
X-Received: by 2002:a2e:9c8d:: with SMTP id x13mr9601732lji.253.1604425242960;
        Tue, 03 Nov 2020 09:40:42 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id 21sm4092142lfa.183.2020.11.03.09.40.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2020 09:40:39 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id 141so23335415lfn.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 09:40:38 -0800 (PST)
X-Received: by 2002:a19:83c9:: with SMTP id f192mr7604236lfd.148.1604425238332;
 Tue, 03 Nov 2020 09:40:38 -0800 (PST)
MIME-Version: 1.0
References: <0-v2-dfe9ecdb6c74+2066-gup_fork_jgg@nvidia.com>
 <2-v2-dfe9ecdb6c74+2066-gup_fork_jgg@nvidia.com> <20201030225250.GB6357@xz-x1>
 <20201030235121.GQ2620339@nvidia.com> <20201103001712.GB52235@lx-t490>
 <20201103002532.GL2620339@nvidia.com> <20201103004133.GD52235@lx-t490>
 <e03dba4e-fd1d-a32c-c99c-fc3fa51419c4@nvidia.com> <20201103065225.GA63301@lx-t490>
In-Reply-To: <20201103065225.GA63301@lx-t490>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 3 Nov 2020 09:40:22 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgB8nyOQufpn0o6a5BpJCJPnXvH+kRxApujhsgG+7qAwQ@mail.gmail.com>
Message-ID: <CAHk-=wgB8nyOQufpn0o6a5BpJCJPnXvH+kRxApujhsgG+7qAwQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm: prevent gup_fast from racing with COW during fork
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linux-MM <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 2, 2020 at 10:52 PM Ahmed S. Darwish
<a.darwish@linutronix.de> wrote:
>
> The problem is, I've already documented seqlock.h to death.... There are
> more comments than code in there, and there is "seqlock.rst" under
> Documentation/ to further describe the big picture.

Well, honestly, I think the correct thing to do is to get rid of the
*_seqcount_t_*() functions entirely.

They add nothing but confusion, and they are entirely misnamed. That's
not the pattern we use for "internal use only" functions, and they are
*very* confusing.

They have other issues too: like raw_write_seqcount_end() not being
usable on its own when preemptibility isn't an issue like here. You
basically _have_ to use raw_write_seqcount_t_end(), because otherwise
it tries to re-enable preemption that was never there.

                   Linus
