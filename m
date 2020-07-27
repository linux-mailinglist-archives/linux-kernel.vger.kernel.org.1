Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B28E822ECEB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jul 2020 15:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbgG0NLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 09:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728650AbgG0NLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 09:11:17 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0591CC061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 06:11:17 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id o18so16983997eje.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 06:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=03/lTD6gUKcdbUV3ApBEJOEEfkVhDvjq29crBVxnwW8=;
        b=TZzhkQHx3+DVyRxN/0UnhReq5CJ6kmUTzRT/cO67yfGO/ykjt3XWu9dUu/uMqnSAB+
         2O1/4I29ZaCE6R+fOZ2+jdCHH/Xech8smuI7RUAIVEZtpC0jgkHlN4GgMcNZNDt6fjFg
         +k54N8jLTJ30JRfEhGJ0IYocaCxY1g2fdRVvQmSt9f97VBlbAJ8FruEdyRugW3Neq2RN
         NmlDmcSGUZl1Rtr5WniFngdDh3dtdU6DCH4nSQS1xPq4lT/GRz1Mpxz1eAytH0t6op26
         HJ/M9ur1iTr/7suSg0EQEPTLsn84pwrlwjjt6oHkrpHD+eqdwZH070d/mub+2SZM/eXX
         olGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=03/lTD6gUKcdbUV3ApBEJOEEfkVhDvjq29crBVxnwW8=;
        b=dutyNew7d7JJXND3pXoBUtSOx9RpwK2Si1py+bgKvf1qOz8DRuAXDtv2BpvmHTac/i
         Fy3uyarTVsbWKToKAiqqq5OSJ24WKUs6BWz6Hh1M13Y/pfS238W952tMgldOksvMx5lL
         a+0TekTfuMpn4a04m9k79m2txUAQjCU+TzfiQ6UErtDlmzRHCEA8jBMT8qgE5MMlrTLu
         l6Q7uKUT1NYPlGjk8GtVBSx4tmp/c9YnmvRQIARu2q1fvPnylUqxT+3Fcgpw4EYIqjCs
         ESmKrrRt4P21UGtf5TSN9GF7MDFbHvLa6Sudd00jPXdRH1eSHRiFXhnqrw6b2ubO61q5
         Hynw==
X-Gm-Message-State: AOAM531Pw+/eCMEB45mSlSmZTYiIDXO0g3WHtjzD6hjT0eDiNQ0eDL6y
        M2xFIMZYj+toKvVpe7bgzrQ=
X-Google-Smtp-Source: ABdhPJyIW6NFv+6mATUimL4cdWliBr0bhFuQ2IVI449l5NIsYxkQ5ep9UnHMydvAkSy8+dA+m/FEtg==
X-Received: by 2002:a17:907:42cb:: with SMTP id nz19mr20750985ejb.447.1595855475803;
        Mon, 27 Jul 2020 06:11:15 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id q17sm6901780ejd.20.2020.07.27.06.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 06:11:15 -0700 (PDT)
Date:   Mon, 27 Jul 2020 15:11:13 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     peterz@infradead.org
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, mbenes@suse.cz
Subject: Re: [PATCH] objtool,x86: Verify poke_int3_handler() is self contained
Message-ID: <20200727131113.GA105139@gmail.com>
References: <20200727104050.GH119549@hirez.programming.kicks-ass.net>
 <20200727112144.GA55660@gmail.com>
 <20200727125019.GL119549@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727125019.GL119549@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* peterz@infradead.org <peterz@infradead.org> wrote:

> On Mon, Jul 27, 2020 at 01:21:44PM +0200, Ingo Molnar wrote:
> > 
> > * peterz@infradead.org <peterz@infradead.org> wrote:
> > 
> > > 
> > > Abuse the SMAP rules to ensure poke_int3_handler() doesn't call out to
> > > anything.
> > > 
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > ---
> > >  tools/objtool/check.c |    8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > > 
> > > --- a/tools/objtool/check.c
> > > +++ b/tools/objtool/check.c
> > > @@ -551,6 +551,14 @@ static const char *uaccess_safe_builtin[
> > >  	"__memcpy_mcsafe",
> > >  	"mcsafe_handle_tail",
> > >  	"ftrace_likely_update", /* CONFIG_TRACE_BRANCH_PROFILING */
> > > +	/*
> > > +	 * Abuse alert!
> > > +	 *
> > > +	 * poke_int3_handler() is not in fact related to uaccess at all, we
> > > +	 * abuse the uaccess rules to ensure poke_int3_handler() is self
> > > +	 * contained and doesn't CALL out to other code.
> > > +	 */
> > > +	"poke_int3_handler",
> > 
> > So ->uaccess_safe makes sure that we don't CALL into non-uaccess-safe 
> > functions, but it still allows CALLs into *other* uaccess-safe 
> > functions, right?
> > 
> > So unless I missed something in the logic, the comment should say 
> > something like "doesn't CALL out to other non-uaccess safe code" or 
> > so? Which is, arguably, like 99% of all functions - but still, a whole 
> > bunch are allowed, such as low level instrumentation and other utility 
> > functions.
> 
> Right, so poke_int3_handler() is also noinstr and by that isn't allowed
> to call out into !noinstr code. The intersection should be small.
> 
> But yeah, perhaps this is a bad idea and I should add another annotation
> for this,.. dunno.

'nocall' ? :-)

	Ingo
