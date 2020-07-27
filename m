Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDDB22FC92
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 01:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgG0XD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 19:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgG0XD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 19:03:27 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28238C061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 16:03:27 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id u64so16945127qka.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 16:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GBftFvyHvrin0kdl06v10bVa3MCqdXQloUXFuRhSc9k=;
        b=dGOnxmLzwK+/tLLwNr0I9cnSw4nho2QwiTGJwt0v2qNs6Z+PbQ1OhL4xeADddYSfQE
         +KuWpveDYW1bObBiAAEn3QwjAy0tzAfgtgE9TGnAVDe5A1V9ec/MZQsj5xzbPrNLF0RW
         xVesQErP5QQ8EtaQWU2UWIwv1t7gcE+ZM0XOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GBftFvyHvrin0kdl06v10bVa3MCqdXQloUXFuRhSc9k=;
        b=M7IE1I2IgpVADYFKYHVq0HhRpCUWCO09BrnVhtk4sfRGbyhczju6Hr7UjzUhFf/+eh
         3ouJPk5S/+xITUm9insgKwQUxJl0TZkL3T5wzfU7EtxB7/63r7rnkbv1OoqMtgv6NiVk
         jjH2ho1A2D0OzlpAqUifl4lTDFvd+j1J2KO8aFDVtA/WSc3z4p8pPCuAFqjvHjSNXEuV
         BMzSKksgR2ghTZX4ypZjd+zLYOjf9rIVZnGTdHs1UUg/BbLXPHX2p6cV932i6wdJWH1T
         gE7UTH8vmlkDgomFXjY0H+y77nQV9RAudCJmUhvA80ETV/h/duXSN8V2sWcp/OG228Wb
         ztyA==
X-Gm-Message-State: AOAM533rqwu/FvsJ6NmaMUuqeCgw2hu2J/OxvJrpDNbyb+e13zsyU/5g
        CtpHxzk33bdARJbHvlUrMW67Mw==
X-Google-Smtp-Source: ABdhPJzSqUgi++lBXyma31OuRRPsRzshcfFme7Q9i4ZBKMuKkAbLkRrL3kq111ejLYEBNlmHdA2LDg==
X-Received: by 2002:a37:458f:: with SMTP id s137mr25188859qka.129.1595891005462;
        Mon, 27 Jul 2020 16:03:25 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id t83sm20045377qke.133.2020.07.27.16.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 16:03:24 -0700 (PDT)
Date:   Mon, 27 Jul 2020 19:03:23 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu <rcu@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RFC v2] rcu/segcblist: Add counters to segcblist
 datastructure
Message-ID: <20200727230323.GA3390623@google.com>
References: <20200719035518.2386828-1-joel@joelfernandes.org>
 <CAEXW_YQhYiYQZOJ95dqBcu_fAZ_6k7HGbrw53eTgPrgXU+5few@mail.gmail.com>
 <20200719041841.GA2398236@google.com>
 <20200720082211.GA35358@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
 <CAEXW_YR4dxuPV+Yu9HcYCSAdiV1H=9Rk9HJgCST-YMMc7J2Mgg@mail.gmail.com>
 <20200727134925.GB79404@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727134925.GB79404@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 09:49:25PM +0800, Boqun Feng wrote:
[...] 
> So C11 features are available to gnu89 as extensions, also I tried to
> compile the following code with -std=gnu89:
> 
> 	#include <stdio.h>
> 
> 	typedef struct {
> 		int a;
> 	} atomic_t;
> 
> 	void g(void) {
> 		printf("this is g\n");
> 	}
> 
> 	void h(void) {
> 		printf("this is f\n");
> 	}
> 
> 	#define gen(x) _Generic((x), atomic_t : h(), int : g())
> 
> 	int main(void) {
> 		int a;
> 		atomic_t b;
> 		gen(a);
> 		gen(b);
> 		gen(b);
> 	}
> 
> , and it worked.
> 
> Besides, please note that in include/linux/compiler_types.h, _Generic is
> already used.

> > > With these primitives introduced, you can avoid () to add those
> > > rcu_segcblist_*_seglen() which have #ifdefs in them. Of course, an
> > > alternative would be that we implement rcu_segcblist_*_seglen() using
> > > _Generic, but I think someone else may have the similar problems or
> > > requirement (already or in the future), so it might be worthwhile to
> > > introduce the gen_ primitives for broader usage.
> > 
> > One issue is code using memory barriers around the operation, such as
> > in rcu_segcblist_add_len() where you use smp_mb__before_atomic() for
> > the atomic version, and regular smp_mb() for the non-atomic version.
> > So ifdef will still exist to some degree.
> > 
> 
> Right, I think we can have two functions: long_add_mb() and
> atomic_long_add_mb(), this part is similar to ifdef approach, but we can
> make a gen_long_add_mb() based on these two functions, and
> gen_long_add_mb() simply switches between those functions according to
> the actual type of the field, which I think is better than ifdef
> approach at readability and maintenance.

Thanks for clarification. I agree with your idea, would you be able to write
a patch to add the helpers my patch can use?

If others are Ok with your idea, I can go ahead and use your helpers.

(I could write the helpers myself as well, next time I send the patch).

thanks,

 - Joel

