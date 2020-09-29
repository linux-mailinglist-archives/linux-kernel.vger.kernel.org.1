Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 333B027BF97
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 10:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbgI2IdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 04:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727893AbgI2IdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 04:33:13 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED92EC0613D5;
        Tue, 29 Sep 2020 01:33:11 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id e22so5418560edq.6;
        Tue, 29 Sep 2020 01:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=HK41/qbPxO+SoGRXquqjP/gEh3I+38ZE+z63fzbFSAM=;
        b=S8yJWuwRM6E6vG99yfmoQMLxY2mnpbYIcvbtstIvuN666T+YtUHi8dh3la0w5Yafct
         PZ/XVQQn9ZDZjIkn4uGu2dWW1+YOT5H5gGswkiD/F5rQIANePpgPusGcvJ6YplN7IZfP
         WshdCVcyQ4ipZgpJwuIkCAotuYHX/k7lKN4DNBdxG1vIVH5x0h00kep03tjP3ggBWszA
         nj8BzeKlG4yfnwmTtrV1GJoGQDLgRRI1iVYvEBI9TD5nYieaMf8Np5G1atY+LEHy8GBo
         tfAdIRvOSPfaa6A2tJ/HySv258TxNjiCkJvG4IwF6Pn8G83LykzK+q8vWwIbnOcYDMYZ
         tH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=HK41/qbPxO+SoGRXquqjP/gEh3I+38ZE+z63fzbFSAM=;
        b=RBmB2+3xCKjVc9l35kLufYxUL/276DTJufkP+incWKuwnaQttEW/3kSGj+9RHHpusr
         uW0Ny049s6cTT5jHV3e3pzMskAq4b/N3oiG8jFWE3zsjGvpIiB5TrIcY3Zop8Dx/CIqv
         UButUDOe8bIDHJx/F+9T5uqqKy6vH8WucaoOOj/GY4dXVMFHwI0Wls5TkRrAwQafu4R/
         9D2MKj6JnYwWkmH4feNvaDlknujHfNRYtcjjyyERGRTSsmtwQRczR3hnGRGti6VFSzRN
         67M1drh3P980l53v/DCz5VFuqgwb8iYp+nkH8w+8o+o46p8kZ0XaqWYmfnTB6/Rudaps
         HDcA==
X-Gm-Message-State: AOAM532NCrt/OQaI/HcV326JdRWmLQhT6aZEA9rsdaSl0sYaf9OrmB08
        wdxEqBgm8seE2D6uAePBDf4=
X-Google-Smtp-Source: ABdhPJyYvViBHNSY5FE7CXdKUdCiD1GV8vYp3T3pZ0xf9ePqRUqG3AW2pTxyVkmCuZ7dASJFxLP47Q==
X-Received: by 2002:aa7:d4d0:: with SMTP id t16mr2020758edr.83.1601368390650;
        Tue, 29 Sep 2020 01:33:10 -0700 (PDT)
Received: from felia ([2001:16b8:2d89:9100:1da1:773b:dbb4:3fc9])
        by smtp.gmail.com with ESMTPSA id cn21sm5173410edb.14.2020.09.29.01.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 01:33:09 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Tue, 29 Sep 2020 10:33:08 +0200 (CEST)
X-X-Sender: lukas@felia
To:     Peter Zijlstra <peterz@infradead.org>,
        Balbir Singh <sblbir@amazon.com>
cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        kernel-janitors@vger.kernel.org, linux-safety@lists.elisa.tech
Subject: Re: [PATCH -next for tip:x86/pti] x86/tlb: drop unneeded local vars
 in enable_l1d_flush_for_task()
In-Reply-To: <20200929071211.GJ2628@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.2009291022000.17656@felia>
References: <20200928124457.27289-1-lukas.bulwahn@gmail.com> <20200929071211.GJ2628@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 29 Sep 2020, Peter Zijlstra wrote:

> On Mon, Sep 28, 2020 at 02:44:57PM +0200, Lukas Bulwahn wrote:
> > diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> > index 6b0f4c88b07c..90515c04d90a 100644
> > --- a/arch/x86/mm/tlb.c
> > +++ b/arch/x86/mm/tlb.c
> > @@ -316,7 +316,7 @@ EXPORT_SYMBOL_GPL(leave_mm);
> >  
> >  int enable_l1d_flush_for_task(struct task_struct *tsk)
> >  {
> > -	int cpu, ret = 0, i;
> > +	int i;
> >  
> >  	/*
> >  	 * Do not enable L1D_FLUSH_OUT if
> > @@ -329,7 +329,7 @@ int enable_l1d_flush_for_task(struct task_struct *tsk)
> >  			!static_cpu_has(X86_FEATURE_FLUSH_L1D))
> >  		return -EINVAL;
> >  
> > -	cpu = get_cpu();
> > +	get_cpu();
> >  
> >  	for_each_cpu(i, &tsk->cpus_mask) {
> >  		if (cpu_data(i).smt_active == true) {
> > @@ -340,7 +340,7 @@ int enable_l1d_flush_for_task(struct task_struct *tsk)
> >  
> >  	set_ti_thread_flag(&tsk->thread_info, TIF_SPEC_L1D_FLUSH);
> >  	put_cpu();
> > -	return ret;
> > +	return 0;
> >  }
> 
> If you don't use the return value of get_cpu(), then change it over to
> preempt_{dis,en}able(), but this got me looking at the function, wtf is
> that garbage supposed to do in the first place

I also thought that preempt_{dis,en}able() would do, but thought maybe 
Balbir just considered {get,put}_cpu stylistically nicer... so I stayed 
with the functions as-is.

> 
> What do we need to disable preemption for?
>

I have no clue... not a good premise for touching the code, but I just 
wanted to make clang-analyzer happy without modifying any semantics.

Balbir, can you help out here? What was your intent?
 
> Please explain the desired semantics against sched_setaffinity().
> 

I am happy to send a proper v2 once I understand if disabling preemption 
is required and the preempt_{dis,en}able() function are preferred to the 
{get,put}_cpu functions.

Lukas
