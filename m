Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB9B52BA9CD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 13:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbgKTMGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 07:06:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbgKTMGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 07:06:51 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76517C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 04:06:51 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id a13so8612372qkl.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 04:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ONlxph66vinoq7WQfOgvS0BntK6G4N++ZL2XryVnJQ0=;
        b=MljDJCHkujFrU1c2g2ZELpi5rlMJCDGjG/DmHtXJkIoff9yjCv9f/ikpnKtgIbOWcD
         G4bIlhmWLD/f3G2+R8EYH4Bls3hTAxDGWJ59YSyW8ExYtaLvMVYZTBI+U1S2DI7pR6qk
         qiWHwcQIFJZ6umxP1DryKwMxVbbDZaHrBo1jMZOsQUA9z2lH27uusK1KxB7ymfd5QsKn
         e9buBHIaWBzIaBMDgNRElLwyGqORtZZiPkWip3SnVXExioFjo1Mq4C2nGblp0T3NFbDn
         GyNYCeK/OQBjZsHeYtVegfTmj4rSkPvbLlFSfIav+MOCR88DklVns02fycEcnsgO1SmX
         QQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ONlxph66vinoq7WQfOgvS0BntK6G4N++ZL2XryVnJQ0=;
        b=I3Q2+eq1bJcRGdjOvQtOq1xuZRLJig9GLuRbT0oaaCHnMbApOhVDbPOi+Tw4+8+k6b
         bEfbOu2z+CI0jQX8UeXhgocNrDTBVSWDyVlnGrHY438LbqFTwI1w1TmBZ540KUwuRIFg
         MniZ75Ol8AiyLDYMiwSllfDHV6q/eLE31blXpDRnLhPB4FN6Q6UfSPKyZTbpUI4qQu6D
         CEvi2NYf0kdBn9RdMJTjTHIMwao+3MOhvv0XD5fe5PWy2eY1wmkp6yW7nSk3PipQ3y6y
         erRnGDdrxZErLjKQRcpxz6f6ErbPWx7AoNNsp7o0aU8sGhQbv4zSg9ulFkvvybSHtnyT
         YkwA==
X-Gm-Message-State: AOAM531nErQaWgBLe8aU31mPFnoCD/erxyEsBOok4h6FDT8SQ3Jk2MBi
        sEfQe4h0JQmlB/LIEEQiPYk+Uq4qJpIjFw/6eQkJBQ==
X-Google-Smtp-Source: ABdhPJxlzoLbJUDOR5DZrfB3R91d4OSUz1r4Uyt4EmTjFvPWYFscosYrTT9xdvonmTIzg6R/ZwORId0Js5HU/Rbszeo=
X-Received: by 2002:a05:620a:15ce:: with SMTP id o14mr16608080qkm.231.1605874010482;
 Fri, 20 Nov 2020 04:06:50 -0800 (PST)
MIME-Version: 1.0
References: <20201118035309.19144-1-qiang.zhang@windriver.com>
 <20201119214934.GC1437@paulmck-ThinkPad-P72> <20201120115935.GA8042@pc636>
In-Reply-To: <20201120115935.GA8042@pc636>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 20 Nov 2020 13:06:39 +0100
Message-ID: <CACT4Y+bHpju_vXjdtb46O=zbQKTFaCSuoTKu1ggZ=CZ9SqWhXQ@mail.gmail.com>
Subject: Re: [PATCH] rcu: kasan: record and print kvfree_call_rcu call stack
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Zqiang <qiang.zhang@windriver.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 12:59 PM Uladzislau Rezki <urezki@gmail.com> wrote:
>
> On Thu, Nov 19, 2020 at 01:49:34PM -0800, Paul E. McKenney wrote:
> > On Wed, Nov 18, 2020 at 11:53:09AM +0800, qiang.zhang@windriver.com wrote:
> > > From: Zqiang <qiang.zhang@windriver.com>
> > >
> > > Add kasan_record_aux_stack function for kvfree_call_rcu function to
> > > record call stacks.
> > >
> > > Signed-off-by: Zqiang <qiang.zhang@windriver.com>
> >
> > Thank you, but this does not apply on the "dev" branch of the -rcu tree.
> > See file:///home/git/kernel.org/rcutodo.html for more info.
> >
> > Adding others on CC who might have feedback on the general approach.
> >
> >                                                       Thanx, Paul
> >
> > > ---
> > >  kernel/rcu/tree.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index da3414522285..a252b2f0208d 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -3506,7 +3506,7 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> > >             success = true;
> > >             goto unlock_return;
> > >     }
> > > -
> > > +   kasan_record_aux_stack(ptr);
> Is that save to invoke it on vmalloced ptr.?

Yes, kasan_record_aux_stack should figure it out itself.
We call kasan_record_aux_stack on call_rcu as well, and rcu structs
can be anywhere.
See:
https://elixir.bootlin.com/linux/v5.10-rc4/source/mm/kasan/generic.c#L335
