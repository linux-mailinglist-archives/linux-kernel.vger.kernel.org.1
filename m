Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEBA32A1AA1
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 22:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbgJaVJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 17:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgJaVJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 17:09:00 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3E5C0617A6
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 14:08:58 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id g12so7705690pgm.8
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 14:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=STFCbYRPv2yU83dYWIC6SPt0n63+PWxDCXwz4hu1xak=;
        b=c/eCGJsVgWFUksm6BHkLj9nLhlxEpWl9gT+5F3PMnaixPTok1DOkQsDQKGkGieH2GW
         xnF46V6rRJOYpxQyZ0CdgKAo60fGtUjvmRcOubxqufM6E6AQqri1GVZf3uqtKrQCF8lN
         QQqevMdCv4yggljJDQtdmOMi5V7CmumSOchQ6VsM8bO1JlThZrOGDWBH/WKXXLOgt9Jd
         V4a3ch0amAZRsRp1+bMMD+gvw0VavrOwkA/Q+01+mMQ/B/yufgaXdIa0KAuEumKBklH7
         Mb80nLW5cFdwrCjXIrwgvW7+YYA8JH8ygLgiQ8Sog+gu0lmm5yb+TwyThVPftLtU605T
         N/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=STFCbYRPv2yU83dYWIC6SPt0n63+PWxDCXwz4hu1xak=;
        b=GEjIoJCNGtSHCVUYRIgzQgvNYH9KXnjWPIpNG+bXs4Z/BHkDNLHHmFEowMnC25h9hM
         Dd/7BVA5/1iml7kjjU2wov9WhrrKNx6n3aK+JeKzHL0JzKdsmty50sjV8Jao1678hxcM
         4JUvtWi+AejHmWjGDNRlwgSUJfAP2n9ybLnANUVZ7XbZP+GxKJmz3cTst9PzseyyOvyn
         OdtQMXCm68qbA7B+08l0fHE5Pc7PHJu2GuJwNpzRNKJMC/BQCqvTcUtbRLOtqzskJKRv
         24HAN4fdHKnfj2zsx27VMVORSvo6gKrcGWz/QCiqb7MnaEUfZmnbdvcha63ZW/kpWrXQ
         dUWw==
X-Gm-Message-State: AOAM530R7t7anw+72NJVxdYZ1/WBZQAAZp3hBH6b5yQAA+z3AyMTEuTy
        ZsLXVeGfP/7QpoRL7CzknoU=
X-Google-Smtp-Source: ABdhPJydIc1aJXg3z4heRq0M4C3WTx7YSJXFcX+kYPrqA7M6r6aVGuWlsnjSeWhcABlfmL0mXfJpfQ==
X-Received: by 2002:a62:6885:0:b029:164:51c0:b849 with SMTP id d127-20020a6268850000b029016451c0b849mr11628609pfc.58.1604178538034;
        Sat, 31 Oct 2020 14:08:58 -0700 (PDT)
Received: from ?IPv6:2405:201:9004:6856:950f:2c13:9e63:dda0? ([2405:201:9004:6856:950f:2c13:9e63:dda0])
        by smtp.gmail.com with ESMTPSA id n5sm9576182pfa.156.2020.10.31.14.08.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Oct 2020 14:08:57 -0700 (PDT)
Subject: Re: [PATCH] checkpatch: improve handling of email comments
To:     Joe Perches <joe@perches.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Aditya Srivastava <yashsri421@gmail.com>
References: <20201030090704.40533-1-dwaipayanray1@gmail.com>
 <9d5c8699f94481ab5bf2d37348199ca1d6343c8b.camel@perches.com>
 <alpine.DEB.2.21.2010301255460.16621@felia>
 <8b9beccf81735f2e042447026a1043f8d21c2566.camel@perches.com>
 <CABJPP5Ca8SNGmoE7GVc0OBotFhA6mLuX46QQETiVcQwTKHRosA@mail.gmail.com>
 <8b6d8af8ef3e3499f647c5895c79891e0b26ac6c.camel@perches.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Message-ID: <ba6d66ee-4470-afe9-da1d-790dc3b318fc@gmail.com>
Date:   Sun, 1 Nov 2020 02:38:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <8b6d8af8ef3e3499f647c5895c79891e0b26ac6c.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Try this git log grep:
>
> $ git log --format=email -100000 | \
>    grep -P '^(?:[\w\-]+-by:|cc:|CC:|Cc:)' | \
>    grep -v 'stable\@' | \
>    grep -P '\>.+'
>
> This finds any signature/cc line with content after an
> email address that end with a close angle bracket that
> doesn't go to the stable address.
>
> Think about what content after that close angle bracket
> should and shoud not be allowed.
>
> There are a few variants here:
>
> o comments (optional whitespace, followed by '#' or '[' or '(' or c89)
> o misuse of quote (around the whole name and address)
> o Odd commas after '>' likely from defective cut'n'paste use
>
> Then add this to the first grep to avoid the comments as above
>
> $ git log --format=email -100000 | \
>    grep -P '^(?:[\w\-]+-by:|cc:|CC:|Cc:)' | \
>    grep -v 'stable\@' | \
>    grep -P '\>.+' | \
>    grep -vP '\>\s*(?:\#|\(|/\*|\[)'
>
> Shouldn't all these be reported?
> Are they if your patch is applied?
>
> Then look at the addresses that do not have a close angle
> bracket and also have more content after the email address.
>
> $ git log --format=email -100000 | \
>    grep -P '^(?:[\w\-]+-by:|cc:|CC:|Cc:)' | \
>    grep -v 'stable@' | \
>    grep -vP '<[\w\.\@\+\-]+>' | \
>    grep -vP '[\w\.\@\+\-]+$'
>
> What of all of these should be reported?
>
> Happy testing...
>
Hi,
So I ran the tests and there are some interesting results.

The warnings were the same before and after this patch
was applied.

For illegal elements after the closing braces, there were
several errors for which no warnings were reported. These
are:

       6 Cc: Peter Zijlstra <peterz@infradead.org>,
       5 Reviewed-by: "Dietmar Eggemann <dietmar.eggemann@arm.com>"
       1 Suggested-by: Julia Lawall <julia.lawall@lip6.fr>.
       1 Signed-off-by: Vishal Kulkarni <vishal@chelsio.com>"
       1 Signed-off-by: Vishal Kulkarni <vishal@chelsio.com>"
       1 Signed-off-by: Vishal Kulkarni <vishal@chelsio.com>"
       1 Signed-off-by: Veerabhadrarao Badiganti 
<vbadigan@codeaurora.org> Link:
       1 Signed-off-by: Jingle Wu <jingle.wu@emc.com.tw>.
       1 Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
       1 Reviewed-by: Max Gurtovoy <maxg@mellanox.com 
<mailto:maxg@mellanox.com>>
       1 Reviewed-by: Maulik Shah <mkshah@codeaurora.org> Thanks, Maulik
       1 Reviewed-by: Marc Zyngier <maz@kernel.org> Link: 
https://lore.kernel.org/r/20200826112331.047917603@linutronix.de
       1 Reviewed-by: David Sterba <dsterba@suse.com>i
       1 Reviewed-by: David Sterba <dsterba@suse.com>c
       1 Reviewed-by: David Sterba <dsterba@suse.com>3
       1 Reviewed-by: Christoph Hellwig <hch@lst.de>,
       1 Reviewed-by: Christian König <christian.koenig@amd.com> for both.
       1 Reviewed-by: Christian König <christian.koenig@amd.com>.
       1 Reported-by: Randy Dunlap <rdunlap@infradead.org>>
       1 Reported-by: Qian Cai <cai@redhat.com>>
       1 Reported-by: Qian Cai <cai@lca.pw> writes:
       1 Reported-by: kernel test robot <lkp@intel.com> for missing #include
       1 Reported-by: "kernelci.org bot" <bot@kernelci.org>"
       1 Reported-by: kbuild test robot <lkp@intel.com>]
       1 Reported-by: Bob Sanders <bob.sanders@hpe.com> and the LTP 
testsuite
       1 Cc: Wolfram Sang <wsa@kernel.org>,
       1 Cc: Valdis Kletnieks <valdis.kletnieks@vt.edu>,
       1 Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
       1 CC: Stephen Rothwell <sfr@canb.auug.org.au>,
       1 Cc: Sia, Jee Heng <jee.heng.sia@intel.com>; 
alsa-devel@alsa-project.org; linux-kernel@vger.kernel.org; 
clang-built-linux@googlegroups.com; Nathan Chancellor 
<natechancellor@gmail.com>
       1 Cc: Robert Sesek <rsesek@google.com>,
       1 CC: Peter Zijlstra <peterz@infradead.org>,
       1 Cc: Omar Sandoval <osandov@fb.com>,
       1 Cc: Michael Neuling <mikey@neuling.org> <mikey@neuling.org>
       1 Cc: Maxime Ripard <mripard@kernel.org>,
       1 Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
       1 Cc: Mark Scott <mscott@forcepoint.com>,
       1 Cc: Mark Rutland <mark.rutland@arm.com>.
       1 Cc: Mark Rutland <mark.rutland@arm.com>,
       1 Cc: Mark Rutland <mark.rutland@arm.com>,
       1 Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
       1 Cc: Kees Cook <keescook@google.com>,
       1 Cc: Jonas Karlman <jonas@kwiboo.se>,
       1 Cc: Jernej Skrabec <jernej.skrabec@siol.net>,
       1 Cc: Jason Wang <jasowang@redhat.com>; Parav Pandit 
<parav@mellanox.com>; virtualization@lists.linux-foundation.org; 
linux-kernel@vger.kernel.org; kernel-janitors@vger.kernel.org
       1 Cc: Jann Horn <jannh@google.com>,
       1 Cc: James Bottomley <james.bottomley@hansenpartnership.com>,
       1 Cc: Icenowy Zheng <icenowy@aosc.io>,
       1 Cc: Dan Murphy <dmurphy@ti.com>A
       1 Cc: Daniel Vetter <daniel@ffwll.ch>,
       1 Cc: Christoph Lameter <cl@linux.com>Cc: Pekka Enberg 
<penberg@kernel.org>
       1 Cc: Christoph Hellwig <hch@lst.de>,
       1 Cc: Christian König <christian.koenig@amd.com>.
       1 CC: "Chang S. Bae" <chang.seok.bae@intel.com>,
       1 Cc: Al Viro <viro@zeniv.linux.org.uk>e
       1 Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>A
       1 Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>A


For cases with no closing '>', following cases were not
reported by checkpatch:

       6 Cc: linux-arm-kernel@lists.infradead.org,
       1 Reviewed-by: Max Gurtovoy <maxg@mellanox.com 
<mailto:maxg@mellanox.com>>
       1 Cc: rostedt@goodmis.org,
       1 Cc: linux-wireless@vger.kernel.org,
       1 Cc: dri-devel@lists.freedesktop.org,

So it's mostly extra commas at the end. But other
illegal characters were also there. Also in one or two
cases, multiple addresses were stacked together.
I think these all deserve to be reported.

Thanks,
Dwaipayan.

