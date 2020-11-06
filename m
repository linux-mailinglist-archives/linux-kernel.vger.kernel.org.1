Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 577DA2A9417
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 11:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgKFKXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 05:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgKFKXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 05:23:44 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C47BC0613CF;
        Fri,  6 Nov 2020 02:23:43 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id h2so851874wmm.0;
        Fri, 06 Nov 2020 02:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=mzNiuNqGeFamlvkvbNuJC+7srQmi+KnHfUNnRKxl8XQ=;
        b=Iu8FzfnHSSbyRw4Xkh4ON1v8jlTRgybmQWaJOIbTX7rUOOXLGIYdD4dvaZIp88OJ4Y
         aAs0pJIFdX96yHi/i50h9sPJMXQYJkSxDTJR2Caiy5ZEpe8kf/xWH54BPlM/SzQ6LO94
         qD1Rk1a9QsXdaWaO5Q6eu8+gy4GqrSRB/N2b0FxZ3sMG6YOkv4hz/YrNnevzMXoJ7mp4
         z1dKo3MhAdXPNk33P1hEtwm1WFpzwpmmp/dfJPh/HVK/9QI+OQRHATiIkZrTieZE9kzu
         YAL3hTiRy1kbWzZW04Nkv85Ji1YQch663yNJ9uRoh1WXGDQ8k+LEMjlZQnzPZvE0rusm
         56Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=mzNiuNqGeFamlvkvbNuJC+7srQmi+KnHfUNnRKxl8XQ=;
        b=ftkl52ltV9/Cg7ki4zqkbYDUF3lWWI4jrYi7u6X2sLHngWJNCrLYx/bijR9x1Q8F39
         dvFKQ4IB3WxlQyvEYRbtJ5bjizFlWP2Ocf1gq9RE2xI2dSWMhrU6Ci91cn2dHI0M6wuK
         sA7YtuJePX8uBpEczTij5VcJVSTm2l9C6raUs+/T8j6GiiioSgnE7AccUjR9iAgRSug4
         +OQC5n5HCI50xZxJNGLQau1mn0bqdrNy9LFkU8fbSXEJNbYSjGWewdiVXgK3fgputVFj
         +Jh3cE2Zhy09DW7Jh/vPRJR2VQObPIH5m7YF1/4uigTsd96nBXMZ+9kvnptGYdYPLQub
         xp+g==
X-Gm-Message-State: AOAM533rnlqEX600i6U/dr2VQZ9J9iE5oWMeLl3It8t5Jui5Nu9r+xaw
        JWeBmgeXmd8wsarTDWMkx/tvtw+4MD1LDA==
X-Google-Smtp-Source: ABdhPJxXzfKlYpUDKox/cdmpMNPTttMWjBfu7xNSzMPizbrEmkEvbLIdyUSuPmWDt5AlAstsxO33Tg==
X-Received: by 2002:a1c:7515:: with SMTP id o21mr1724178wmc.5.1604658221759;
        Fri, 06 Nov 2020 02:23:41 -0800 (PST)
Received: from felia ([2001:16b8:2d20:9d00:e580:adb5:1ef:950d])
        by smtp.gmail.com with ESMTPSA id k81sm2067568wma.2.2020.11.06.02.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 02:23:41 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Fri, 6 Nov 2020 11:23:34 +0100 (CET)
X-X-Sender: lukas@felia
To:     Nathan Chancellor <natechancellor@gmail.com>
cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Tom Rix <trix@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-janitors@vger.kernel.org, linux-safety@lists.elisa.tech,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] taskstats: remove unneeded dead assignment
In-Reply-To: <20201106095004.GA3269193@ubuntu-m3-large-x86>
Message-ID: <alpine.DEB.2.21.2011061113270.20338@felia>
References: <20201106062210.27920-1-lukas.bulwahn@gmail.com> <20201106095004.GA3269193@ubuntu-m3-large-x86>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 6 Nov 2020, Nathan Chancellor wrote:

> On Fri, Nov 06, 2020 at 07:22:10AM +0100, Lukas Bulwahn wrote:
> > make clang-analyzer on x86_64 defconfig caught my attention with:
> > 
> >   kernel/taskstats.c:120:2: warning: Value stored to 'rc' is never read \
> >   [clang-analyzer-deadcode.DeadStores]
> >           rc = 0;
> >           ^
> > 
> > Commit d94a041519f3 ("taskstats: free skb, avoid returns in
> > send_cpu_listeners") made send_cpu_listeners() not return a value and
> > hence, the rc variable remained only to be used within the loop where
> > it is always assigned before read and it does not need any other
> > initialisation.
> > 
> > So, simply remove this unneeded dead initializing assignment.
> > 
> > As compilers will detect this unneeded assignment and optimize this anyway,
> > the resulting object code is identical before and after this change.
> > 
> > No functional change. No change to object code.
> > 
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> 
> Question below.
> 
> Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
> 
> > ---
> > applies cleanly on current master and next-20201105
> > 
> > Balbir, please pick this minor non-urgent clean-up patch.
> > 
> >  kernel/taskstats.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/kernel/taskstats.c b/kernel/taskstats.c
> > index a2802b6ff4bb..bd18a7bf5276 100644
> > --- a/kernel/taskstats.c
> > +++ b/kernel/taskstats.c
> > @@ -117,7 +117,6 @@ static void send_cpu_listeners(struct sk_buff *skb,
> >  
> >  	genlmsg_end(skb, reply);
> >  
> > -	rc = 0;
> >  	down_read(&listeners->sem);
> >  	list_for_each_entry(s, &listeners->list, list) {
> 
> Would it be worth moving the scope of rc into the for loop, now that it
> is only used there? Looks like it used to be used in the main function
> scope before commit 053c095a82cf ("netlink: make nlmsg_end() and
> genlmsg_end() void") but if this is removed, it is only used to check
> the return of genlmsg_unicast within the list_for_each_entry loop. Not
> sure that buys us anything but I know you have done it in patches
> before so I thought it was worth considering.
>

I thought about moving it into the local scope, but it is a purely 
cosmetic matter. Compilers are smart enough to generate the same code no 
matter where it is defined.
So, I always look around in the same file to determine if there is some 
kind of strong preference for very locally scoped variable definition or 
if they are generally just all defined at the function entry.

Depending on my gut feeling in which style the file has mainly been 
written, I then go with the one or other option. In this case, I went 
with just keeping the definition at the function entry.

There is really no strong rule, though, that I see serving as good 
indicator.

Thanks for your review.

Lukas
