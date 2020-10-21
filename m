Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D76C42954D8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 00:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506750AbgJUWb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 18:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437578AbgJUWb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 18:31:29 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29D8C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 15:31:27 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id p16so4036091ilq.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 15:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a57dxvhGl8rVyiXX85ftzv8E1G0yYaqyRUK+4JSQTeQ=;
        b=A7pCRop9afVnOSNeD5d7Y3k09ajdeLYtonUESKJ9K1K8gjp8+xyJNaIR9X8c0kwqwY
         U3Au/jOCS9q9nX7JJUFm8XHMbVAeEIhyMbmc65jWgQpBcopEoPgA3HLCv9K8YKUZGIuv
         pDkAcrFeXJxewpqS2ACu8ORkXqd8qWZyWUONk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a57dxvhGl8rVyiXX85ftzv8E1G0yYaqyRUK+4JSQTeQ=;
        b=q6HK7ykQmPxmy0+YQrUVFSbldEJHZRYyMjCcehv60ITYgHvBWrn+6oQEhtKuq0yYEd
         Uqx8wzcLQqW+7zifMLlTa/Nr2LiZa9mB4ZweLX+iNixFDxFJHVAclhhVX0A/VgekkQDw
         /IiZAoPjPDI676j7T3Ey6aG7LJTICc6zTVhOMBo/YPa8isPAFU2XgCL3ipo+muc9LryN
         aR83YAEpYV/NOm+eQ0ow/jrBag5SNm3akj4L3pMERY/1FQDY8GSFh8+blxWz45OKGGt3
         orKUzDrt3wQHlDKBihxnG655yV4RJNT1dR081zWVfF7hVm4WPQqp10K1MoSZu4L9ArCv
         sJEw==
X-Gm-Message-State: AOAM5304OmZECNKI7qj5AmsK1aPHmLDMww0kf8SP0DLBdMnAWHWilR9g
        JTZ9/kUI9XTlCOoQ1OUAs9GR6fXHyQgJfRKlHJMtsg==
X-Google-Smtp-Source: ABdhPJxJQZW6OdGUrZ61EZKzt0kxREgEL/GgwrftJkOu1Ya6XPE4XIk9uyzvaXXHOpokviPir6Cd9wRoGSQcL6p20cM=
X-Received: by 2002:a92:dec2:: with SMTP id k2mr4287795ilp.78.1603319486982;
 Wed, 21 Oct 2020 15:31:26 -0700 (PDT)
MIME-Version: 1.0
References: <20201015002301.101830-1-joel@joelfernandes.org>
 <20201015002301.101830-3-joel@joelfernandes.org> <20201015122158.GA127222@lothringen>
 <20201021153314.GB2828884@google.com> <20201021215304.GB78735@lothringen>
In-Reply-To: <20201021215304.GB78735@lothringen>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 21 Oct 2020 15:31:16 -0700
Message-ID: <CAEXW_YRhU7SPqmh26AtDWxr48-1t2RDQ=MEax+F2+mqbyxH1yw@mail.gmail.com>
Subject: Re: [PATCH v7 2/6] rcu/segcblist: Add counters to segcblist datastructure
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu <rcu@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 2:53 PM Frederic Weisbecker <frederic@kernel.org> wrote:
>
> On Wed, Oct 21, 2020 at 11:33:14AM -0400, joel@joelfernandes.org wrote:
> > On Thu, Oct 15, 2020 at 02:21:58PM +0200, Frederic Weisbecker wrote:
> > > On Wed, Oct 14, 2020 at 08:22:57PM -0400, Joel Fernandes (Google) wrote:
> > > > Add counting of segment lengths of segmented callback list.
> > > >
> > > > This will be useful for a number of things such as knowing how big the
> > > > ready-to-execute segment have gotten. The immediate benefit is ability
> > > > to trace how the callbacks in the segmented callback list change.
> > > >
> > > > Also this patch remove hacks related to using donecbs's ->len field as a
> > > > temporary variable to save the segmented callback list's length. This cannot be
> > > > done anymore and is not needed.
> > > >
> > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > ---
> > > >  include/linux/rcu_segcblist.h |   2 +
> > > >  kernel/rcu/rcu_segcblist.c    | 133 +++++++++++++++++++++++-----------
> > > >  kernel/rcu/rcu_segcblist.h    |   2 -
> > > >  3 files changed, 92 insertions(+), 45 deletions(-)
> > > >
> > > > diff --git a/include/linux/rcu_segcblist.h b/include/linux/rcu_segcblist.h
> > > > index b36afe7b22c9..d462ae5e340a 100644
> > > > --- a/include/linux/rcu_segcblist.h
> > > > +++ b/include/linux/rcu_segcblist.h
> > > > @@ -69,8 +69,10 @@ struct rcu_segcblist {
> > > >   unsigned long gp_seq[RCU_CBLIST_NSEGS];
> > > >  #ifdef CONFIG_RCU_NOCB_CPU
> > > >   atomic_long_t len;
> > > > + atomic_long_t seglen[RCU_CBLIST_NSEGS];
> > >
> > > Also does it really need to be atomic?
> >
> > Yes, it need not be. I will make the change for ->seglen.
> >
> > BTW, for the existing ->len field, doesn't the following need to acquire nocb
> > lock?
> > rcu_nocb_try_bypass -> rcu_segcblist_inc_len
> >
> > It seems that will do a lock-less non-atomic RMW on a nocb offloaded list,
> > otherwise.
>
> I believe it shouldn't be necessary. That's an atomic add and the kthreads
> manipulating it shouldn't have any trouble concurrently. None that I can
> imagine tonight at least...

Ah yeah, of course. I got confused! Thanks.

> > Certainly rcu_nocb_do_flush_bypass() does do it so maybe it was missed?
>
> I believe it increments under the lock here because the inc happens to be on the way
> to the insertion of the callbacks :o)

Makes sense :)

thanks,
 - Joel
