Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0196D1A346E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Apr 2020 14:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgDIMzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Apr 2020 08:55:55 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41285 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbgDIMzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 08:55:55 -0400
Received: by mail-qk1-f195.google.com with SMTP id y3so3741256qky.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 05:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jAXAQOk0ErVc2APrR6OinTn7FZoQNNgdHYwvSLGe2yc=;
        b=fjomRjM4YA1sWzArY/6IvCLtRmgdXIsOkn+ejcLJ33W+TsvSbfN8V6vZqD8KEv9qcD
         LKtS1OGfk7WKZ6S63AjKKpNbyLI0IJN//oK3icStX1HZl/UXYsg+xxmWFyuPCdGGqmKb
         ukFQzIhW9gJx9WRhaPdP00U7BRTn2LvCEXyGmEdaC7Gvp3FEY+G03cReqaYBU61TViY6
         R4twEnNB2lbUs9UH0lz8lPiFBIHGLBBQ6D1O+7tOU3GsY/q2672MRWe3Q6bsvR/5lBtE
         PU6nBXTDuRdNnujb4SkdrR3qWmdF0nGZY4j8FYO1vRvMm6FVFJzMR9BDQWMHyxXbTgjX
         IW7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jAXAQOk0ErVc2APrR6OinTn7FZoQNNgdHYwvSLGe2yc=;
        b=T0nhthDgMqg38HNy+ePyM6IkMHDx/VqdarslCyXcXhA+oqw70SvpJeK/e5cBd7hMWh
         WlO7pJy+lJMVuzyA17jwJQ3WjzvveOPTUp7jjPFGxgLLXLlB+jWO0d7RXdiBtQY/Hksw
         kZK8DGGSBIcboymnrK0CRmNESuaKscEGLzxJ6ad19FOrWRZ/DNoTBSwvzll6T8nc/+og
         thsYgkLVkNPuqggLNEGq2AydtYVmtGB1toLZTXHgJNC3EQSZ9WUgWDnt6gWnAMsnIsBF
         4ObR7DqE/X2Esy1zy8//eiNCMzzwuNJHQfvNf//OeTdWvGJffGeiq9AXgJKTcAQZxNu4
         PXOA==
X-Gm-Message-State: AGi0PuaDC0Cw2/h8MkyvUJeDnUv//NEwg4DVQjduoYVV7f9LnezIMRPt
        by2OSk4FGHzv1wohrWHZyDjY72EKaT2V2al5lx0wVA==
X-Google-Smtp-Source: APiQypJgYrBXlCxuuAQfsdESu3sOZUB8jewml+8aR9cEdCQX8DHlXGwINB+Y0v2ChKiBtjQlmnBl37BBspufq/L7nls=
X-Received: by 2002:a05:620a:348:: with SMTP id t8mr11010209qkm.407.1586436954251;
 Thu, 09 Apr 2020 05:55:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200408014010.80428-1-peterx@redhat.com> <20200408174732.bc448bbe41d190bfe5cc252e@linux-foundation.org>
In-Reply-To: <20200408174732.bc448bbe41d190bfe5cc252e@linux-foundation.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 9 Apr 2020 14:55:42 +0200
Message-ID: <CACT4Y+bhQVcpSkSh_OZ5ZanfFZUqn2iypLhG_Z-nWKTkaYr1jw@mail.gmail.com>
Subject: Re: [PATCH 0/2] mm: Two small fixes for recent syzbot reports
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Xu <peterx@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 9, 2020 at 2:49 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Tue,  7 Apr 2020 21:40:08 -0400 Peter Xu <peterx@redhat.com> wrote:
>
> > The two patches should fix below syzbot reports:
> >
> >   BUG: unable to handle kernel paging request in kernel_get_mempolicy
> >   https://lore.kernel.org/lkml/0000000000002b25f105a2a3434d@google.com/
> >
> >   WARNING: bad unlock balance in __get_user_pages_remote
> >   https://lore.kernel.org/lkml/00000000000005c65d05a2b90e70@google.com/
>
> (Is there an email address for the syzbot operators?)
>
> sysbot does test linux-next, yet these patches sat in linux-next for a
> month without a peep, but all hell broke loose when they hit Linus's
> tree.  How could this have happened?

The same thing:
https://groups.google.com/d/msg/syzkaller-bugs/phowYdNXHck/qU1P0TsjBAAJ

linux-next is boot-broken for more than a month and bugs are piling
onto bugs, I've seen at least 3 different ones.
syzbot can't get any working linux-next build for testing for a very
long time now.
