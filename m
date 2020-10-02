Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51AB8281D24
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 22:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725775AbgJBUvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 16:51:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:35634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbgJBUvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 16:51:31 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D29082065D;
        Fri,  2 Oct 2020 20:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601671890;
        bh=3BKMr+EOEI1gnVhZpxDZb0tWF1pOUyldw2fQ6orExd8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Cho9pbhtSh3iOvZTPIo6lIPsMYh0N4MvaJJbHH459EnXOAv8j4bJFGFpLcR0vJfMu
         tmKFvpF4aWb+8kkDdsfP6H1m5QDFz5kmBQEpQHy06+z9icFSQfx423gInYldDlynV8
         ASpFVdEyqvsov2ok2lT31K552WHo9W31pJ4Db6K0=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 9705335230A9; Fri,  2 Oct 2020 13:51:30 -0700 (PDT)
Date:   Fri, 2 Oct 2020 13:51:30 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH v2] srcu: avoid escaped section names
Message-ID: <20201002205130.GK29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <CAKwvOd=s+N4+X94sTams_hKn8uV5Hc6QyCc7OHyOGC-JFesS8A@mail.gmail.com>
 <20200929192549.501516-1-ndesaulniers@google.com>
 <20200930204044.GZ29330@paulmck-ThinkPad-P72>
 <CAKwvOd=nabONrWyYFK7Y06TrKBOyHHfNUiiy69VJQ2NtCpbp5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=nabONrWyYFK7Y06TrKBOyHHfNUiiy69VJQ2NtCpbp5Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 01:55:48PM -0700, Nick Desaulniers wrote:
> On Wed, Sep 30, 2020 at 1:40 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Tue, Sep 29, 2020 at 12:25:49PM -0700, Nick Desaulniers wrote:
> > > The stringification operator, `#`, in the preprocessor escapes strings.
> > > For example, `# "foo"` becomes `"\"foo\""`.  GCC and Clang differ in how
> > > they treat section names that contain \".
> > >
> > > The portable solution is to not use a string literal with the
> > > preprocessor stringification operator.
> > >
> > > Link: https://bugs.llvm.org/show_bug.cgi?id=42950
> > > Fixes: commit fe15b50cdeee ("srcu: Allocate per-CPU data for DEFINE_SRCU() in modules")
> > > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> >
> > I am guessing that this needs to go up with other patches.  If so:
> >
> > Acked-by: Paul E. McKenney <paulmck@kernel.org>
> >
> > If not, let me know and I will queue it.
> 
> I could have bundled them up as a series.  I think you can pick it up,
> and I'll owe you a beer?

It is queued, thank you!

When does it need to hit mainline?  (Your default is the v5.11 merge
window, that is, the one following the upcoming merge window.)


                                                        Thanx, Paul

> > > ---
> > > Changes V1->V2:
> > > * drop unrelated Kconfig changes accidentally committed in v1.
> > >
> > >  include/linux/srcutree.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
> > > index 9cfcc8a756ae..9de652f4e1bd 100644
> > > --- a/include/linux/srcutree.h
> > > +++ b/include/linux/srcutree.h
> > > @@ -124,7 +124,7 @@ struct srcu_struct {
> > >  # define __DEFINE_SRCU(name, is_static)                                      \
> > >       is_static struct srcu_struct name;                              \
> > >       struct srcu_struct * const __srcu_struct_##name                 \
> > > -             __section("___srcu_struct_ptrs") = &name
> > > +             __section(___srcu_struct_ptrs) = &name
> > >  #else
> > >  # define __DEFINE_SRCU(name, is_static)                                      \
> > >       static DEFINE_PER_CPU(struct srcu_data, name##_srcu_data);      \
> > > --
> > > 2.28.0.709.gb0816b6eb0-goog
> > >
> 
> 
> 
> -- 
> Thanks,
> ~Nick Desaulniers
