Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20DBC269959
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 01:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbgINW7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 18:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbgINW7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 18:59:52 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121CDC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 15:59:52 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id b12so1015591lfp.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 15:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2G/hRodaEbdwMTJFpgACQrYpQlQOkpSJnW9fYCTn//U=;
        b=P2zwY7nDqwbuhESYBJOt1I5qmdHytgOKwp422wQetkvqkPjEYwKyETCI9Liciynnql
         +LRT09+Z5sFr23gNmEfkesJnuBCjjAx188+w1PEfPjFqavBZzukRtc2pwBD4XSgKnVbq
         U11bfkaeAq7pNwAN2Dbw8dBEQ22pJBXPQNi4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2G/hRodaEbdwMTJFpgACQrYpQlQOkpSJnW9fYCTn//U=;
        b=SqhETzHHkOxyFy4ErYa/lHsrBOt07iP3tCqa9EUpSksR3wZIDaTwhRt/ouhBtV5qMj
         zvCDfFzG5m9y4imdh+LP0E0lY5tg0VIe9MHU6EOUdftn/ptQ8MIoQ+aQU2GDYiDttcmQ
         aWE3RYPiayt1zi8c5lHnvwpOj69G7gE/MKCjurFPUuHxlBmN8w8+AHyvtxNsaBfcvASO
         F6kQFaPf3JGiIZLrJLRk1zjtnT6+v6LQHpv9QrZm2VkBXOEiTHDcDrLLQ0VjDIQCB2Hx
         zIffsM9Wbc5tLjh64MyAxK3PkGNJCQgo17TEQvYYg0EKSjnDkqUWE7jmR9eako/e0b/y
         It3w==
X-Gm-Message-State: AOAM530+w/zJEMsKs1ATw3Y1RLm97vUiLzx8BtDJwgW0U98UlGbP5x2e
        bNodIG/Hoh05Hu2H1c7Z+/Ky+9KtA1Shtg==
X-Google-Smtp-Source: ABdhPJzK8X+QNYp9TY4JMc4gQTHpTHTrzgHQpdpaeh0Lpdk2n7JeKDIuvVxD3N+lknY00xB2v0GiOQ==
X-Received: by 2002:a19:604e:: with SMTP id p14mr4820448lfk.385.1600124389959;
        Mon, 14 Sep 2020 15:59:49 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id o3sm3570319lfb.168.2020.09.14.15.59.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 15:59:48 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id m5so1031879lfp.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 15:59:47 -0700 (PDT)
X-Received: by 2002:ac2:4ec7:: with SMTP id p7mr4498792lfr.352.1600124387573;
 Mon, 14 Sep 2020 15:59:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200821234958.7896-1-peterx@redhat.com> <20200821234958.7896-2-peterx@redhat.com>
 <20200914143829.GA1424636@nvidia.com> <CAHk-=wj1EDd3dUGz_992_oRqvsy3LGDvxvyQBvutLhBqkYqgcQ@mail.gmail.com>
 <20200914183436.GD30881@xz-x1> <20200914211515.GA5901@xz-x1> <20200914225542.GO904879@nvidia.com>
In-Reply-To: <20200914225542.GO904879@nvidia.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 14 Sep 2020 15:59:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgdn5sJ0UEVZRQvj6r5kqOkU24jA_V6cPkqb9tqoAKBJg@mail.gmail.com>
Message-ID: <CAHk-=wgdn5sJ0UEVZRQvj6r5kqOkU24jA_V6cPkqb9tqoAKBJg@mail.gmail.com>
Subject: Re: [PATCH 1/4] mm: Trial do_wp_page() simplification
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Peter Xu <peterx@redhat.com>, Leon Romanovsky <leonro@nvidia.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Maya B . Gokhale" <gokhale2@llnl.gov>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        Kirill Shutemov <kirill@shutemov.name>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Jan Kara <jack@suse.cz>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 3:55 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> Just as an aside, the RDMA stuff is also supposed to set MADV_DONTFORK
> on these regions, so I'm a bit puzzled what is happening here.

Did the fork perhaps happen _before_ , so the pages are shared when
you do the pin?

MADV_DONTFORK doesn't mean COW doesn't happen. It just means that the
next fork() won't be copying that memory area.

That said, it's possible that the test cases do something invalid - or
maybe we've broken MADV_DONTFORK - and it all just happened to work
before.

So it's possible the breakage is exposing some other bug..

             Linus
