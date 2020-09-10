Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2487264CF7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 20:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbgIJSbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 14:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbgIJS3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 14:29:42 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CB0C061757
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 11:29:40 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id gf14so432572pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 11:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wjAWuNbVBoEPyXn+QBzLMnCnG3b1YEYkoDZS6EgQpPI=;
        b=UCp+FppW+25RCEWuidrdmD2H7oNwJWAPscXMA2ljdT7Hwfc6emJQQRXJKlonqRXwCr
         ZNZwT1diexj1oIPFx0vZRCKp8ePiBMfI0fNJK+PDlwitnt2/pXVXXfcmv7xMHDx85MGD
         jjgpGgVOnGdOdetQ71hUdu1jBGb560fU84u+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wjAWuNbVBoEPyXn+QBzLMnCnG3b1YEYkoDZS6EgQpPI=;
        b=A1xCMsoyMIZDYKONvubkV9iiiLUdSo1Uro9A7p/iQ3+3k479Cwf+/xTX9aNim2T5Cn
         0e2A+0fUGvWwrqgwMhFkkMeCYUonfW1E19v6CFdmLdix9HASQHlenq4jl0MXsmBzwrdQ
         JETSUeCHTrjVXyxmxp5Dd/G2epZxKxXU7zSKreRt1EkJNf2HgHlolID5DHM6m3eZnnEg
         L5XYtpxy/UVYTNqW1UNHqGHyInzA8Rv2ZbAcsChbtPvsjOv4uFh3M/kuLmwRhlOZSHEw
         DFIRn9A+HczcZVHZuMou7V6VioGhRFGEEmS4y2E/Ku7gt1yZlY+NfDESXxUGxeG4Yy95
         3IBg==
X-Gm-Message-State: AOAM532v4xfTok9d6QlEzJos4QIFhIhcLwNlZSvdV0c5iDppk1K6UB1S
        v4HPIksTepGYTkx1KfwZC3LN3Q==
X-Google-Smtp-Source: ABdhPJwQHia5IxoItB0v8TFyFBQYaMjt9d9oEodKfnuR8Fqxq3O6+WSooIjqvBiG9AzcqTroMIMGDQ==
X-Received: by 2002:a17:90b:3717:: with SMTP id mg23mr1229702pjb.42.1599762580221;
        Thu, 10 Sep 2020 11:29:40 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z9sm6606733pfk.118.2020.09.10.11.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 11:29:39 -0700 (PDT)
Date:   Thu, 10 Sep 2020 11:29:38 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>, peterz@infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
        X86 ML <x86@kernel.org>
Subject: Re: [PATCH v2 05/28] objtool: Add a pass for generating __mcount_loc
Message-ID: <202009101127.28B4414D2A@keescook>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200903203053.3411268-1-samitolvanen@google.com>
 <20200903203053.3411268-6-samitolvanen@google.com>
 <202009031450.31C71DB@keescook>
 <CABCJKueF1RbpOKHsA8yS_yMujzHi8dzAVz8APwpMJyMTTGhmDA@mail.gmail.com>
 <20200904093104.GH1362448@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904093104.GH1362448@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 04, 2020 at 11:31:04AM +0200, peterz@infradead.org wrote:
> On Thu, Sep 03, 2020 at 03:03:30PM -0700, Sami Tolvanen wrote:
> > On Thu, Sep 3, 2020 at 2:51 PM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > On Thu, Sep 03, 2020 at 01:30:30PM -0700, Sami Tolvanen wrote:
> > > > From: Peter Zijlstra <peterz@infradead.org>
> > > >
> > > > Add the --mcount option for generating __mcount_loc sections
> > > > needed for dynamic ftrace. Using this pass requires the kernel to
> > > > be compiled with -mfentry and CC_USING_NOP_MCOUNT to be defined
> > > > in Makefile.
> > > >
> > > > Link: https://lore.kernel.org/lkml/20200625200235.GQ4781@hirez.programming.kicks-ass.net/
> > > > Signed-off-by: Peter Zijlstra <peterz@infradead.org>
> > >
> > > Hmm, I'm not sure why this hasn't gotten picked up yet. Is this expected
> > > to go through -tip or something else?
> > 
> > Note that I picked up this patch from Peter's original email, to which
> > I included a link in the commit message, but it wasn't officially
> > submitted as a patch. However, the previous discussion seems to have
> > died, so I included the patch in this series, as it cleanly solves the
> > problem of whitelisting non-call references to __fentry__. I was
> > hoping for Peter and Steven to comment on how they prefer to proceed
> > here.
> 
> Right; so I'm obviously fine with this patch and I suppose I can pick it
> (and the next) into tip/objtool/core, provided Steve is okay with this
> approach.

Hello Steven-of-the-future-after-4000-emails![1] ;)

Getting your Ack on this would be very welcome, and would unblock a
portion of this series.

Thanks! :)

[1] https://twitter.com/srostedt/status/1303697650592755712

-- 
Kees Cook
