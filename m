Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 068132BAC1D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 15:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbgKTOoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 09:44:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727782AbgKTOoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 09:44:19 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA84C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 06:44:18 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id q5so9000495qkc.12
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 06:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C1CYOETxY2mWhhteoELoIdcbW6dqQyY7MF0yoQEntsU=;
        b=RTlyczdaOkh7geh5ZkV5GWqqUHxPFzM+/EHAond4ShJYOtFveN+sTMYTYpHgQ3qw9r
         4OCkjKwSJHsceu0+nXK8loM3AVTBFS75aQPAYKdJgOphR7CRICAABfzh2r1lr150wYko
         R+D3NyVAow6YMlcGvxOKbs41nuzOmhP+RWkQl7DrCHEGm0KGA0pr2pCv4AUF32psYd2Q
         MUv4Hz7kJrHs6Vr4QMJoQ57rfNDvVFd+jOm23dB4GkMajSHqjOrHjWK+/6LejpwZb2E8
         moGMGJMG9qiVmJOXe8kK1nAw7nH/ygEbeVvJccO1/wiK3Q7q4IPkor735omM5ig5how2
         iifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C1CYOETxY2mWhhteoELoIdcbW6dqQyY7MF0yoQEntsU=;
        b=XEM4AQSFKkfHMtk6W3RXHrGcWIHpvET8mxMsQQtVnGSKz5azVBNyRFCShOFVACFQRv
         WdecryqZWbocT1H/EAVoickZrNxp5CSYVuwQE27DF084M1Opog3hAHHpSkVPottYw9nU
         me0z+Fw6s2FHRu49gWyVChc581x9xkjCDsqYdalE+Gco6G9kFryQeFqmoRIT+yQvll8h
         Id/gkqyp2FqQDSZfx/NdQ+lBLC3o23+UsvUI8zQvNs6I/z5dhHsehcx0Tqd8hNKycUPf
         hlpNcRm7eLb5qqUOhK7V4HT8UYrflCmQkjwOor8sdqtCCqRDpA5SGuexKpZzhS/lFx0L
         8jZg==
X-Gm-Message-State: AOAM531d70QSONfJmVM5q1Rc2QnM0mWTo9QItNfF5cFyfE4qtpIsws7k
        69zlKboWykbhINZy4B7ww+9bCOgcShd9CXHltWJJzQ==
X-Google-Smtp-Source: ABdhPJwZrlT2iMbWNY1ZMJAir2bIhu343U9ppzqmXLgR+ajdYkR5kBk2dzPNIsC8Na83xEoHeqe293oVTudB3x2YG5E=
X-Received: by 2002:a05:620a:15ce:: with SMTP id o14mr17381328qkm.231.1605883457341;
 Fri, 20 Nov 2020 06:44:17 -0800 (PST)
MIME-Version: 1.0
References: <20201118035309.19144-1-qiang.zhang@windriver.com>
 <20201119214934.GC1437@paulmck-ThinkPad-P72> <CACT4Y+bas5xfc-+W+wkpbx6Lw=9dsKv=ha83=hs1pytjfK+drg@mail.gmail.com>
 <20201120143440.GF1437@paulmck-ThinkPad-P72>
In-Reply-To: <20201120143440.GF1437@paulmck-ThinkPad-P72>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 20 Nov 2020 15:44:04 +0100
Message-ID: <CACT4Y+ZNBRaVOK4zjv7WyyJKeS54OL8212EtjQHshYDeOVmCGQ@mail.gmail.com>
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

On Fri, Nov 20, 2020 at 3:34 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Fri, Nov 20, 2020 at 09:51:15AM +0100, Dmitry Vyukov wrote:
> > On Thu, Nov 19, 2020 at 10:49 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > On Wed, Nov 18, 2020 at 11:53:09AM +0800, qiang.zhang@windriver.com wrote:
> > > > From: Zqiang <qiang.zhang@windriver.com>
> > > >
> > > > Add kasan_record_aux_stack function for kvfree_call_rcu function to
> > > > record call stacks.
> > > >
> > > > Signed-off-by: Zqiang <qiang.zhang@windriver.com>
> > >
> > > Thank you, but this does not apply on the "dev" branch of the -rcu tree.
> > > See file:///home/git/kernel.org/rcutodo.html for more info.
> > >
> > > Adding others on CC who might have feedback on the general approach.
> > >
> > >                                                         Thanx, Paul
> > >
> > > > ---
> > > >  kernel/rcu/tree.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > index da3414522285..a252b2f0208d 100644
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -3506,7 +3506,7 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> > > >               success = true;
> > > >               goto unlock_return;
> > > >       }
> > > > -
> > > > +     kasan_record_aux_stack(ptr);
> > > >       success = kvfree_call_rcu_add_ptr_to_bulk(krcp, ptr);
> > > >       if (!success) {
> > > >               run_page_cache_worker(krcp);
> >
> > kvfree_call_rcu is intended to free objects, right? If so this is:
>
> True, but mightn't there still be RCU readers referencing this object for
> some time, as in up to the point that the RCU grace period ends?  If so,
> won't adding this cause KASAN to incorrectly complain about those readers?
>
> Or am I missing something here?

kvfree_call_rcu does not check anything, not poison the object for
future accesses (it is also called in call_rcu which does not
necessarily free the object).
It just notes the current stack to provide in reports later.
The problem is that the free stack is pointless for objects freed by
rcu. In such cases we want call_rcu/kvfree_call_rcu stack in
use-after-free reports.
