Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 083942BA518
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 09:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgKTIv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 03:51:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbgKTIv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 03:51:29 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1510C0617A7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 00:51:28 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id 9so150398qvk.9
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 00:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TgKQ0jWCyLF8z2NTHwlOXu9zgvtMphj2U7UOjEtl2cs=;
        b=mms/xhSWmqcXguiITMTxEYFxy5whwovPqXgDasVuSPBnzuvt+FaOG4Ocx5YOLZmmeH
         XsQ7f+hPwMD5ZPlRWU84tn9MTwQBmAnYhPq1Vk1M+cMbMsMk+uGdqx+Wp+Hj8Ws/E8n3
         BrSaGXtn9mrfrougXU23y147c9DFqgWVpU+RKqURylRzK7+8Dpvn9VFiNhe6rkBy9TMv
         ppvrDtMlnXiNOaumSnWdps+prPKjegyPhtU8sGtW3wg9K7NzidlNAvKJi2RkucCpkkIF
         Dttdnm9ON5cDBnYmnNqAR8iZs0CitgMYXpxVXYHFrNbSNgKyaFllLMtHxqi/jVPznegl
         vCww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TgKQ0jWCyLF8z2NTHwlOXu9zgvtMphj2U7UOjEtl2cs=;
        b=ZXNIaTze3+edL4HPXskFsxjVoIm1/UfPGBbZnZx7vCMYHw3W3SxvhnLIpNOk+4tYnl
         AiNHSZt6oIyHCFcbAeMwFfALj9okUquCFIgfsmm+jLmkfulX4HnmDjm40OKWoAjGF6pj
         tPifhOp1Y4maLHMCwandKVXVkrzJ0F1XxMIGm+v60KFricxA/5BPlyz/MFHqj0nqgfkC
         tZfDs5T9qEMtyADS6ZNkHG9X/oYU9BGEqEDYA0vz8sVav/tqH/dGJtY4LB5ta+PbPuVw
         RVFL894adJuqXBlqh51VtziDP4m9aiqjTpH5ppLnudU0TgqhNnQNZQmEJbkc3ubXdBY6
         xoCA==
X-Gm-Message-State: AOAM530oF94Ff2lT/G6PkmYJgxNTv+iOaT1ix2mPKWlfTxjMuhjWMtu1
        1fMJ8m8fMHAJasUgiv7FGrmaXTXhmqc5FYWKrTwdFQ==
X-Google-Smtp-Source: ABdhPJzb6O//6AjfiZ5KBkpRTUKELEs6fhxptpGzjNCjn5qXkB06zRlu+IyXmcm2Dm+OcXKk+D4see3m1wjyZHGr6I8=
X-Received: by 2002:ad4:46cb:: with SMTP id g11mr15564762qvw.37.1605862287761;
 Fri, 20 Nov 2020 00:51:27 -0800 (PST)
MIME-Version: 1.0
References: <20201118035309.19144-1-qiang.zhang@windriver.com> <20201119214934.GC1437@paulmck-ThinkPad-P72>
In-Reply-To: <20201119214934.GC1437@paulmck-ThinkPad-P72>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 20 Nov 2020 09:51:15 +0100
Message-ID: <CACT4Y+bas5xfc-+W+wkpbx6Lw=9dsKv=ha83=hs1pytjfK+drg@mail.gmail.com>
Subject: Re: [PATCH] rcu: kasan: record and print kvfree_call_rcu call stack
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Zhang, Qiang" <qiang.zhang@windriver.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Uladzislau Rezki <urezki@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 10:49 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Wed, Nov 18, 2020 at 11:53:09AM +0800, qiang.zhang@windriver.com wrote:
> > From: Zqiang <qiang.zhang@windriver.com>
> >
> > Add kasan_record_aux_stack function for kvfree_call_rcu function to
> > record call stacks.
> >
> > Signed-off-by: Zqiang <qiang.zhang@windriver.com>
>
> Thank you, but this does not apply on the "dev" branch of the -rcu tree.
> See file:///home/git/kernel.org/rcutodo.html for more info.
>
> Adding others on CC who might have feedback on the general approach.
>
>                                                         Thanx, Paul
>
> > ---
> >  kernel/rcu/tree.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index da3414522285..a252b2f0208d 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -3506,7 +3506,7 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> >               success = true;
> >               goto unlock_return;
> >       }
> > -
> > +     kasan_record_aux_stack(ptr);
> >       success = kvfree_call_rcu_add_ptr_to_bulk(krcp, ptr);
> >       if (!success) {
> >               run_page_cache_worker(krcp);


kvfree_call_rcu is intended to free objects, right? If so this is:

Acked-by: Dmitry Vyukov <dvyukov@google.com>
