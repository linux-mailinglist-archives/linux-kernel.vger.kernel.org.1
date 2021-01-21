Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71FDB2FE444
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 08:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbhAUHpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 02:45:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727499AbhAUHoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 02:44:11 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3AEBC0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 23:43:28 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id c6so1324319ede.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 23:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+Ud3fXdIWo7gdvXB9iOcxGx6zaDy2XA9zGpX9wbfpTg=;
        b=K6bFi5acT2vTgIuXksQBaN43HdNaFrhL91l/ls1250qv9W0jR6jgm59wTdunqvwuQj
         CRoRES1f2hjqgZvzUmYfwoNFd52RkWI1S1m36CqanmN/XLHFYJJ5C8PBcvlwbRkvKTXl
         PtPR/uC4qTgvw33HBu3s6dS1UMlYkbSezOAcWWaC7ipvere6+J3qnFaHZl3WcoEi/9b0
         TIgyXkTBpeIMqSgpDB41QIPJhMOuAQxK7gSh5wl3b+fBkRNRalNJI9/ejVG1RkGJHNVO
         /0g/KsTgeigZzYaFP+SO8S/WRkiytqmQxuoZuBjfVpQz6CdXBgg37c2XKUsesFmrMl01
         Nd+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+Ud3fXdIWo7gdvXB9iOcxGx6zaDy2XA9zGpX9wbfpTg=;
        b=F+Qb5j4Ey9LVlMRxCkiWir9PL9GURtW7yjbteW8W8hfTd1DNotknS5Hpu0n1W0X4vQ
         uFW/MnCukL2u46R4cKV0U/BqJEQ4eW7h+G0aQRhuJO8WXtZT+YFYTd6+jQk8v+KMP/Wn
         JvncOKr4wa6wpANPJNjL2skGB/qMF7xnBs/CBEviw9wCA9IA8Em1H4AAU91FFU5/fln9
         RgOUFXNUNmMocu5EN7x1wZRSNMrngqmleeUOcI3cwRXXQgpAH7TlDdVC+rIJKK3uz7L3
         qLVa3dF7kLYNalzAwRXXTHv5fTZJcqcUW9b7KPEiyvmWro3fCpgQlaxe4dxovoUYqOn+
         be4g==
X-Gm-Message-State: AOAM531YmnAzakwkD0G1jFHLizlwXuYQoYYr+KQq6RQoEzX+deyKNmHH
        ub3gDbn6mdegWvKPvUsz9Xg=
X-Google-Smtp-Source: ABdhPJx6gq49tHPNF4zFCu6bE60oEE5Mucdy6Kh7G5nSIvcZoL+8Uok8SHLvg0KDFVjNeWnJN6j6TA==
X-Received: by 2002:a50:d60f:: with SMTP id x15mr9809124edi.224.1611215007579;
        Wed, 20 Jan 2021 23:43:27 -0800 (PST)
Received: from ?IPv6:2a02:ab88:2803:dd80:1c0e:c256:df62:8e1e? ([2a02:ab88:2803:dd80:1c0e:c256:df62:8e1e])
        by smtp.gmail.com with ESMTPSA id j23sm2341299edv.45.2021.01.20.23.43.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 23:43:27 -0800 (PST)
Subject: Re: [PATCH] objtool: Don't fail the kernel build on fatal errors
To:     Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>, Borislav Petkov <bp@suse.de>,
        Julien Thierry <jthierry@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>, x86@kernel.org
References: <9ec7a9531e99f461e02adc18a4124c921c0ab777.1610664286.git.jpoimboe@redhat.com>
 <545be952-908a-f125-ebb0-d96ed1e25cd5@linux.vnet.ibm.com>
From:   =?UTF-8?Q?Gy=c3=b6rgy_Andrasek?= <jurily@gmail.com>
Message-ID: <581806c7-091e-b1f0-41f2-b770e8fd7f5b@gmail.com>
Date:   Thu, 21 Jan 2021 08:32:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <545be952-908a-f125-ebb0-d96ed1e25cd5@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 > This is basically a revert of commit 644592d32837 ("objtool: Fail the
kernel build on fatal errors").

 > That change turned out to be more trouble than it's worth.

...I'm sorry, what? Fatal errors are normal for you people? Seriously? 
I've been compiling my own kernel since 2004, I've never seen one. I'd 
like some explanation on this.

 > Failing the build is an extreme measure which sometimes gets too much 
attention and blocks CI build testing.

If you already know it's broken, there's no point testing it. Why are 
you so desperately trying to ignore it? Are you getting paid to be here 
or are you this stupid for free?

Have you tried calling an ambulance on Android lately? I can reboot my 
Huawei with schedtool on Termux. Unrooted, stock. THE LINUX KERNEL IS 
MEASURED IN HUMAN LIVES.

 > These fatal-type warnings

GET THE FUCK OUT WITH YOUR BULLSHIT DOUBLESPEAK

 > aren't yet as rare as we'd hope

How many times do you need to ignore an obvious compiler bug until you 
hope it away?

 > due to the ever-increasing matrix of supported toolchains/plugins

llvm+clang compiles with cmake. In "Release" mode, cmake helpfully 
appends a -O3 for you, which is the kind of "optimization" where the 
compiler deliberately misinterprets the programmer's intention to 
declare an UB, and then uses its godlike might to decide the target of 
an explicit constcast is unreachable. If you recompile systemd with the 
result, it will not understand your password anymore. This was 
yesterday. The day before, it errored out on m4 with some undefined 
linkage into compiler-rt. WITH AN EXPLICIT --rtlib=libgcc FLAG ON A 
GCC-BASED DISTRO

#!/bin/sh
exec /usr/bin/gcc "${@}" -O2

...or did you find a third broken compiler somewhere?


 > Also, there are more people (and bots) looking for objtool warnings 
than ever before, so such warnings not likely to be ignored for long.

Why not? You seem to be doing just fine.

Ask OpenBSD for a toolchain, see if it works. Or better yet, ask them to 
build the kernel for you.

This has already been Reviewed-by.

I'm rejecting both these morons as invalid. Please review everything 
they've been doing lately.

---

Yo, Linus! What the fuck is this shit?  I'm tempted to I don't care 
which one of these whiny little bitches cut your dick off and stuffed it 
into your mouth. Either spit it out or swallow and shit it out, but we 
can't afford this.

Source-based Linux is dead. Gentoo is a cronjob spewing out endless 
broken stage3's, and every single Exherbo dev has unsubscribed from 
their own mailing list. I'm the last one standing. I've spent the last 
two weeks trying to review the damage. I'm not going to package it 
either, but you need to know why. Also, I've quit my job because I 
couldn't sleep for four days straight.

I'm typing this in Thunderbird because fucking KONSOLE SEGFAULTED WHEN I 
TYPED VIM. I do not feel at home on a binary distro, and I cannot build 
a browser on a real one. I would like to explain politely, under the 
[foxfire] tag. Anyone who does not want to know why I think it likely 
that some Gentoo+ maintainers have literally committed suicide, feel 
free to filter it out.

Should you happen to agree with some of my opinions, I'd like you to 
revert every single "fix" for "undefined behavior" that was merged for 
clang. The C standard committee does not define the result because they 
have no idea whether it makes sense in context AND THEY KNOW IT. I mean 
seriously, why do these need a lawyer to know whether or not const is 
just a helpful suggestion in a UNIX KERNEL?

And we build with -std=gnu -fgnu-keywords -fuck-your-pdf (I mean, did 
you get at least this far?). We don't have any more flags to tell you 
you're not in Kansas, Dorothy. You don't give us more.

There's nothing undefined about the concept of "Linux boots on MIPS". 
THERE IS LITERALLY NO OTHER DEFINITION OF A KERNEL AND IT WORKS WHEN I 
BUILD THE TOOLCHAIN. If you fucked it up, that's not our problem.

cmake+llvm builds with -Wno-maybe-uninitialized. They can't even fix 
their warnings, so they hide it. This is not a compiler, it's a random 
number generator.

---

I came here as a last, desperate stance to get organized and shovel the 
shit back in the horse, and this is what I find. Oh well. At least it 
will be educational.




