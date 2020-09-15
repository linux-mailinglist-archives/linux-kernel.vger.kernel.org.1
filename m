Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5841426B244
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 00:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbgIOWoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 18:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbgIOWoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 18:44:05 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E84C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 15:44:05 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id n10so4636349qtv.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 15:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o79PTdFn/15aj6meTzLNWAkBFe/bmmGLEv7ppsxzM80=;
        b=cdGECQNCrrDN8kZH2VSjriese1ZZ20Ue7eyj55CPLtQ9PH2mlgbZrViJrAY20VHQBA
         q9XLD0S6aGgvvfAqzo6KBljF99SmSHZVhTORWc/sa6wX6xRL5Wx5xhKAC0O2tO0xmETI
         qk8zqZt2AwkTUCtm3gRPv4j5lDizNIDEW3e6VCnoFQaaYdD8K1HYHqO5Dia5WmFag0vw
         xOZonIcoJTy6hsvgqEmpsFuSTdnNXcb4mfmd9+z9bHog76LHRYjsd9J3VinPlkMdbYnH
         Bg0SgsgenvRDeo//jVXMo1MXsnZQNtHX7AWlq1IuEhC1xBNDaOYePINrtrLZoVDJMlgT
         AJNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=o79PTdFn/15aj6meTzLNWAkBFe/bmmGLEv7ppsxzM80=;
        b=PGQRNJKQ46w1d6WVrpPF1bRba7g+TWz/fdiUzZM++uaYiopbZ04JoFpL4Ek6mWTcl7
         vbLIjoKiPIml1Km9VMgjpcQlSb/xc5GCqpbUaFfKpOM0Z9zmqnwa+L9PUIX/JgD40PtR
         Z6V6vlsZeX2kOVoAq8++7IvONoZhsKRXSwnbWzZp3/OaQG3fK8bGejcvErj0/XdEY6xM
         qZYlvNDMSTZke4gXhaktm5MF0U38gp0yi1LSTdsbPOx/7lxtIGeqkHX+/zBryvRCQ+kk
         MsfXHgQARJlCiy6dFhmSh00D+vsm3BoCrXUUBHjqt+/6edoZLQG+SN6uQJVnb1tK8VB7
         8MHw==
X-Gm-Message-State: AOAM533ab77UyI1dvGLS7cwieJfgaX0jWeOwd6Fyv/tohwTSuUEZm7Vu
        X0sR3WdYmrTJ58H7QXmJCLQ=
X-Google-Smtp-Source: ABdhPJzLzRAMueKF1IYIStkmOrB6cKfGeVaEu1DpzTlbRXuntpE+nIAixhzKtOxmfN62aZMsVKRARA==
X-Received: by 2002:ac8:615d:: with SMTP id d29mr7864123qtm.286.1600209844220;
        Tue, 15 Sep 2020 15:44:04 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id z74sm18471581qkb.11.2020.09.15.15.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 15:44:03 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 15 Sep 2020 18:44:01 -0400
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Rong Chen <rong.a.chen@intel.com>,
        kernel test robot <lkp@intel.com>,
        "Li, Philip" <philip.li@intel.com>, x86-ml <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Marco Elver <elver@google.com>
Subject: Re: [tip:x86/seves] BUILD SUCCESS WITH WARNING
 e6eb15c9ba3165698488ae5c34920eea20eaa38e
Message-ID: <20200915224401.GA1156663@rani.riverdale.lan>
References: <5f60c4e0.Ru0MTgSE9A7mqhpG%lkp@intel.com>
 <20200915135519.GJ14436@zn.tnic>
 <20200915141816.GC28738@shao2-debian>
 <20200915160554.GN14436@zn.tnic>
 <20200915170248.gcv54pvyckteyhk3@treble>
 <CAKwvOdnc8au10g8q8miab89j3tT8UhwnZOMAJdRgkXVrnkhwqQ@mail.gmail.com>
 <20200915204912.GA14436@zn.tnic>
 <20200915215054.GA1104608@rani.riverdale.lan>
 <CAKwvOdnctit9cQ9Na8kO5TXbZh-3ZV5x1=GLHhRVdBUK23HjnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdnctit9cQ9Na8kO5TXbZh-3ZV5x1=GLHhRVdBUK23HjnA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 02:59:19PM -0700, Nick Desaulniers wrote:
> On Tue, Sep 15, 2020 at 2:50 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > On Tue, Sep 15, 2020 at 10:49:12PM +0200, Borislav Petkov wrote:
> > >
> > > (Btw, clang doesn't need to add that "xor %eax,%eax" - panic() should not be
> > >  returning, ever. :-))
> > >
> >
> > I think this is because panic() is varargs, and clang doesn't support
> > gcc's -mskip-rax-setup. The normal ABI requires the caller to set RAX to
> > the number of arguments in vector registers.
> >
> > https://patchwork.ozlabs.org/project/gcc/patch/20141218131150.GA32638@intel.com/
> 
> Thanks for the report.  Filed
> https://bugs.llvm.org/show_bug.cgi?id=47538.  Do you have an account
> there Arvind so that I can CC you on them?

Nope, no bugzilla account.

If you're adding flags, another set the kernel uses is the
-falign-{jumps,labels,loops} to turn off alignment of jumps and loops.

> 
> Yikes, it looks like gcc 5.0 supports that.  We'd better get to
> implementing that lest someone try to remove the cc-option on it soon.
> -- 
> Thanks,
> ~Nick Desaulniers
