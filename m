Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E025A2A94A1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 11:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgKFKrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 05:47:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgKFKrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 05:47:23 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA75C0613CF;
        Fri,  6 Nov 2020 02:47:22 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id o21so1276029ejb.3;
        Fri, 06 Nov 2020 02:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=sS6LjFB1Hny842iCOSq0gSFHnnlXSZfE6BxMZzj8mek=;
        b=ZOkhO3Uri73lGsBrJPKvQX8VfO8Y4OPTkk4naQG0B0lDGfmkvc+TcbWh8irWkItyZD
         /wNP/VlswRYcgt1dxzWOOklcwF/wIc+XVz5HMZZ59bIvpa+nXXZR5/QrC45AfJLQkrS4
         1uKyO4isqOEnbdePOQM5kdSAApfh7e7S6MDCjjl75noImrWi2rvs5YEn3hwLRDhyVhIQ
         4O+kbMiTHt2CU0oQ4UMtWHKMuXXwCweQeylgQGOAyeqtpIWHS1dg9O6+VVeMmwLgoWzA
         oIZJn3fmXaQtsv3wiCpJ5YGvw04WZp2NXHggqSE56JoV5Bk4SrMeO2sn+xzaN7Oa/MX+
         FiaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=sS6LjFB1Hny842iCOSq0gSFHnnlXSZfE6BxMZzj8mek=;
        b=Wvq4ws2kr3g0QhMepOQTHfk/4brfsxnsHi1X0Tafv5ZFheBqIVIoCgnGTvVxEIU8ms
         ex6EcSnVMiRR9a5T9cgt3YGjR+FM3Q/70+zgGLHYkZo8EbwgiMLxHS7nACp+ZWHTc7X+
         LeIhV8H5JMlBWsm48lCuBwN4D9LeycDOvx2DKNqos2CLPHryqdkkHwk6YFisiVzfOm4j
         CfXYDuN0+G5GnsQrnH/sNF5c4q/j+o1tMHC0QMRKrvaCWc6cfzyugsUqLNMSJsn9PZ20
         76pwcsBJtqRmBi4/3gKVj4ctmq43aSy+BP/rpHuGvJzf7uCkFtA5j9YThLRibDEwFbUp
         +PQg==
X-Gm-Message-State: AOAM533MnQ6mseAtBpGCKzaeDwYZV9kCyiMRDh5qzC5NSdHT2T8kBaNb
        PZxaR2Ce+LInco//WIPMffc=
X-Google-Smtp-Source: ABdhPJzz26n2g8FhiIWfpK7A4HRHvPwzif7bm2XgrIEz3r+SKhwnURR9agiRHDAabN2fY9KHoMPhcQ==
X-Received: by 2002:a17:906:748b:: with SMTP id e11mr1306240ejl.513.1604659641272;
        Fri, 06 Nov 2020 02:47:21 -0800 (PST)
Received: from felia ([2001:16b8:2d20:9d00:e580:adb5:1ef:950d])
        by smtp.gmail.com with ESMTPSA id j4sm649195ejs.8.2020.11.06.02.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 02:47:20 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Fri, 6 Nov 2020 11:47:19 +0100 (CET)
X-X-Sender: lukas@felia
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Tom Rix <trix@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-janitors@vger.kernel.org, linux-safety@lists.elisa.tech,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] taskstats: remove unneeded dead assignment
In-Reply-To: <alpine.DEB.2.21.2011061113270.20338@felia>
Message-ID: <alpine.DEB.2.21.2011061135510.20338@felia>
References: <20201106062210.27920-1-lukas.bulwahn@gmail.com> <20201106095004.GA3269193@ubuntu-m3-large-x86> <alpine.DEB.2.21.2011061113270.20338@felia>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 6 Nov 2020, Lukas Bulwahn wrote:

> 
> 
> On Fri, 6 Nov 2020, Nathan Chancellor wrote:
> 
> > On Fri, Nov 06, 2020 at 07:22:10AM +0100, Lukas Bulwahn wrote:
> > > make clang-analyzer on x86_64 defconfig caught my attention with:
> > > 
> > >   kernel/taskstats.c:120:2: warning: Value stored to 'rc' is never read \
> > >   [clang-analyzer-deadcode.DeadStores]
> > >           rc = 0;
> > >           ^
> > > 
> > > Commit d94a041519f3 ("taskstats: free skb, avoid returns in
> > > send_cpu_listeners") made send_cpu_listeners() not return a value and
> > > hence, the rc variable remained only to be used within the loop where
> > > it is always assigned before read and it does not need any other
> > > initialisation.
> > > 
> > > So, simply remove this unneeded dead initializing assignment.
> > > 
> > > As compilers will detect this unneeded assignment and optimize this anyway,
> > > the resulting object code is identical before and after this change.
> > > 
> > > No functional change. No change to object code.
> > > 
> > > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > 
> > Question below.
> > 
> > Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
> > 
> > > ---
> > > applies cleanly on current master and next-20201105
> > > 
> > > Balbir, please pick this minor non-urgent clean-up patch.
> > > 
> > >  kernel/taskstats.c | 1 -
> > >  1 file changed, 1 deletion(-)
> > > 
> > > diff --git a/kernel/taskstats.c b/kernel/taskstats.c
> > > index a2802b6ff4bb..bd18a7bf5276 100644
> > > --- a/kernel/taskstats.c
> > > +++ b/kernel/taskstats.c
> > > @@ -117,7 +117,6 @@ static void send_cpu_listeners(struct sk_buff *skb,
> > >  
> > >  	genlmsg_end(skb, reply);
> > >  
> > > -	rc = 0;
> > >  	down_read(&listeners->sem);
> > >  	list_for_each_entry(s, &listeners->list, list) {
> > 
> > Would it be worth moving the scope of rc into the for loop, now that it
> > is only used there? Looks like it used to be used in the main function
> > scope before commit 053c095a82cf ("netlink: make nlmsg_end() and
> > genlmsg_end() void") but if this is removed, it is only used to check
> > the return of genlmsg_unicast within the list_for_each_entry loop. Not
> > sure that buys us anything but I know you have done it in patches
> > before so I thought it was worth considering.
> >
> 
> I thought about moving it into the local scope, but it is a purely 
> cosmetic matter. Compilers are smart enough to generate the same code no 
> matter where it is defined.
> So, I always look around in the same file to determine if there is some 
> kind of strong preference for very locally scoped variable definition or 
> if they are generally just all defined at the function entry.
> 
> Depending on my gut feeling in which style the file has mainly been 
> written, I then go with the one or other option. In this case, I went 
> with just keeping the definition at the function entry.
> 
> There is really no strong rule, though, that I see serving as good 
> indicator.
> 
> Thanks for your review.
>

More specifically, if I think rc should be only defined locally, I would 
probably need to apply the same argument to skb_next in this function and 
put that in local scope as well. That did not happen in the past, so I am 
not going to change that now neither. Hence, the change stays minimal 
invasive but and that is important: it makes clang-analyzer happy.

And a happy clang-analyzer will eventually point to real bugs :)

There are a few examples of dead store warnings that in the end really 
point to missing or wrong paths in some functions...

Lukas
