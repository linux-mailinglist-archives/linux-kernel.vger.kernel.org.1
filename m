Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B32629A56D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 08:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507515AbgJ0HXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 03:23:45 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38196 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbgJ0HXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 03:23:45 -0400
Received: by mail-wr1-f67.google.com with SMTP id n18so661142wrs.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 00:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7tx0YPg6hpp27By2xo6VuaHqJWwMOTqv7NkOCV8DeDI=;
        b=EHLSTODQBuxG/3fUEbcoSa8K5PNxs+3x7GBcKP1WxyJiWJ1v9T050kV7gJ/5H/H8e1
         U1J1ES6+Enqjzjh5FwxD3l/+DHlNQbdgQ23/yfLyHMtFwcGWESM/iAunSkSbbLbgyXuD
         e94AF5mP5EPlX2nFkOcGs6Q+RJyTiXmslS0Ws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7tx0YPg6hpp27By2xo6VuaHqJWwMOTqv7NkOCV8DeDI=;
        b=BB70E/LvzmUO9d+gPZaHPK7ov9BW9hq2euSJvyVOcW4WIDaRVfSEL4t2XofSrBGdkf
         63ClyxRI1/I9ExBCBpztVFIrhG5Xm3YKk3RUpXMJ9hNv5SZiZsSZcPzJIX+1HqN7sZYM
         /EDI5fGqPfLMeE2JsxlbiZEKWTVyuBuaepDXo00U3STCNyW2yMti7L9iSUW1VqjUgi7w
         BMczGQsFOgpgteR0ZtWMxn4iZ3CsAU0bW95Sugcj92zN8bn6QZy2REU+S+Z7IJE+NIsO
         gUwM63x7CwPvVHcsANnVJRt/ZxVZFuhh+BkFXdgTlhRDQI4tLOYR7frBBi93bkO4+HpW
         0r1Q==
X-Gm-Message-State: AOAM532Gd1Eqt2R5PexmfMhFdEVV1QPO0qppZ7y5zQoQNrmQrVFq8E2Q
        jvwn+/vqELrcqcBcHyug2O+0Gho5f3TrSfHQi38=
X-Google-Smtp-Source: ABdhPJz/SjtnHvxf98WbPrGXGD9iosj2lLQ0/k10W/ee1K1GzbCDsQFYy9AvD3WLGfL43kleggpUQQ==
X-Received: by 2002:a5d:4c4f:: with SMTP id n15mr1033892wrt.137.1603783421231;
        Tue, 27 Oct 2020 00:23:41 -0700 (PDT)
Received: from [172.16.11.132] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id y201sm814408wmd.27.2020.10.27.00.23.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 00:23:40 -0700 (PDT)
Subject: Re: [PATCH] printf: fix Woverride-init warning for EDEADLK errno
To:     Arnd Bergmann <arnd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
References: <20201026215004.3893088-1-arnd@kernel.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <8f5c673a-0265-a6d0-57fc-98c788caadc9@rasmusvillemoes.dk>
Date:   Tue, 27 Oct 2020 08:23:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201026215004.3893088-1-arnd@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/10/2020 22.49, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> On most architectures, gcc -Wextra warns about the list of error
> numbers containing both EDEADLK and EDEADLOCK:
> 
> lib/errname.c:15:67: warning: initialized field overwritten [-Woverride-init]
>    15 | #define E(err) [err + BUILD_BUG_ON_ZERO(err <= 0 || err > 300)] = "-" #err
>       |                                                                   ^~~
> lib/errname.c:172:2: note: in expansion of macro 'E'
>   172 |  E(EDEADLK), /* EDEADLOCK */
>       |  ^
> lib/errname.c:15:67: note: (near initialization for 'names_0[35]')
>    15 | #define E(err) [err + BUILD_BUG_ON_ZERO(err <= 0 || err > 300)] = "-" #err
>       |                                                                   ^~~
> lib/errname.c:172:2: note: in expansion of macro 'E'
>   172 |  E(EDEADLK), /* EDEADLOCK */
>       |  ^
> 
> Make that line conditional on the two values being distinct.
> 

NAK. That would end up using the "EDEADLOCK" string for the value 35 on
those architectures where they are the same, despite EDEADLK being the
by far the most used symbol. See the comments and original commit log,
the placement of these is deliberate.

How about we do this instead?

From: Rasmus Villemoes <linux@rasmusvillemoes.dk>

The table of errno value->name contains a few duplicate entries since
e.g. EDEADLK == EDEADLOCK on most architectures. For the known cases,
the most used symbolic constant is listed last so that takes
precedence - the idea being that if someone sees "can't do that:
-EDEADLK" in dmesg, grepping for EDEADLK is more likely to find the
place where that error was generated (grepping for "can't do that"
will find the printk() that emitted it, but the source would often be
a few calls down).

However, that means one gets

  warning: initialized field overwritten [-Woverride-init]

when building with W=1. As the use of multiple initializers for the
same entry here is quite deliberate, explicitly disable that warning
for errname.o.

Reported-by: Arnd Bergmann <arnd@kernel.org>
Fixes: 57f5677e535b ("printf: add support for printing symbolic error
names")
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 lib/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/Makefile b/lib/Makefile
index ce45af50983a2a5e3582..a98119519e100103818d 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -224,6 +224,7 @@ obj-$(CONFIG_HAVE_ARCH_TRACEHOOK) += syscall.o

 obj-$(CONFIG_DYNAMIC_DEBUG_CORE) += dynamic_debug.o
 obj-$(CONFIG_SYMBOLIC_ERRNAME) += errname.o
+CFLAGS_errname.o += $(call cc-disable-warning, override-init)

 obj-$(CONFIG_NLATTR) += nlattr.o

-- 
2.23.0

