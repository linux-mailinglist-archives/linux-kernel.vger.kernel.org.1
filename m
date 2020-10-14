Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE44528EA64
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 03:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389486AbgJOBkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 21:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389018AbgJOBjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 21:39:37 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926A6C051134
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 16:10:07 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a17so614930pju.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 16:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5i9RX/7LLxmrH8rBcOGx5ZAh0fv2U4CKPToQx716NOw=;
        b=oGRZNzoYxfLBq+jYkh15LST+vJruXffi/oGyCk1fcTDUTinUUqCNlCjHiWEH1loun3
         D99Y7uXme1RJ+x03S1ZRfVIfehyyKMQSm4JjX/z6yjerFgaNY2Q4dcCQzR3YB9o6wphs
         9W5yNldSPU2aFLGvMKd6fjTNpIDd26ZPf4lVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5i9RX/7LLxmrH8rBcOGx5ZAh0fv2U4CKPToQx716NOw=;
        b=RobrU2Z6Iv6chiHfgHbMrNqXWlvZAhoYDo+dGlHmXYnOiSLSdedl1MiMG/PQJ/P9oU
         WE4tWekx6x39GtfhydEPb7lX46Tsyi36Q55yNcley0jxFHDM0siIDTFHPApSTYuzS4Fs
         MHluji6/mLMKXbJCWr+FmaIXH3oXaUdbRWCBwBAkVPdfVyhjSIjmkp19JZabV37EXNSP
         +l7c55zR4LbXK+J2s/xKffsVdEOPp2c5JO9cRTMk1ZUxqxQ8r+Mxmqrf1xpvkfRaRuDa
         3Q0Wq6OtAhHN5KNghaTzR+ortyvXB+D6U0ZUOP37JhFBCAAbJPYz0jyJHC0vC9g6h4Yn
         CFAg==
X-Gm-Message-State: AOAM532bICWQ26GWmftFLkCTx/kxxBILfIkR8BmNV6CpTO/pJGC0DKTP
        uWUbZRowQfzOPd/MhWsRhxjxhw==
X-Google-Smtp-Source: ABdhPJyT0qwmZMqs3tfgsmGgYZuiVnPj6eFP9zB9CYcBCgdImi4JnPhHrMxTOyMKNMeqX48hJ1m8hQ==
X-Received: by 2002:a17:902:aa06:b029:d3:7e55:ad75 with SMTP id be6-20020a170902aa06b02900d37e55ad75mr1150077plb.37.1602717007102;
        Wed, 14 Oct 2020 16:10:07 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b15sm652405pju.16.2020.10.14.16.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 16:10:06 -0700 (PDT)
Date:   Wed, 14 Oct 2020 16:10:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the tip tree
Message-ID: <202010141607.E9A032C686@keescook>
References: <20200914132249.40c88461@canb.auug.org.au>
 <202010031451.ABC49D88@keescook>
 <20201004102437.12fb0442@canb.auug.org.au>
 <202010040125.B5AD5B757@keescook>
 <20201004210018.5bbc6126@canb.auug.org.au>
 <202010041944.7FEE22407B@keescook>
 <20201015092526.144df583@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015092526.144df583@canb.auug.org.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15, 2020 at 09:25:26AM +1100, Stephen Rothwell wrote:
> Hi Kees,
> 
> On Sun, 4 Oct 2020 19:44:52 -0700 Kees Cook <keescook@chromium.org> wrote:
> >
> > On Sun, Oct 04, 2020 at 09:00:18PM +1100, Stephen Rothwell wrote:
> > > Hi Kees,
> > > 
> > > On Sun, 4 Oct 2020 01:27:01 -0700 Kees Cook <keescook@chromium.org> wrote:  
> > > >
> > > > I assume CONFIG_CONSTRUCTORS is enabled for your build (it should be for  
> > > 
> > > yes, indeed.
> > >   
> > > > allmodconfig). Does this patch fix it? (I'm kind of blindly guessing
> > > > based on my understanding of where this could be coming from...)
> > > > 
> > > > 
> > > > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> > > > index e1843976754a..22f14956214a 100644
> > > > --- a/include/asm-generic/vmlinux.lds.h
> > > > +++ b/include/asm-generic/vmlinux.lds.h
> > > > @@ -701,6 +701,7 @@
> > > >  #ifdef CONFIG_CONSTRUCTORS
> > > >  #define KERNEL_CTORS()	. = ALIGN(8);			   \
> > > >  			__ctors_start = .;		   \
> > > > +			KEEP(*(SORT(.ctors.*)))		   \
> > > >  			KEEP(*(.ctors))			   \
> > > >  			KEEP(*(SORT(.init_array.*)))	   \
> > > >  			KEEP(*(.init_array))		   \  
> > > 
> > > And that makes the messages go away.  
> > 
> > Okay then! Thanks for testing. :) I'm not sure why the ppc-hosted
> > compiler generates those. Regardless, I'll send a proper patch...
> 
> I get these warnings from Linus' tree now ...

I've pinged the thread of the patch (from Oct 4th) that fixes this.
Hopefully that or this email will float to the top for an x86
maintainer. :) If it doesn't get picked up soon, I can try sending this
direct to Linus, though it makes more sense that it come through Ingo
(as he'd done the orphan tree pull request).

-- 
Kees Cook
