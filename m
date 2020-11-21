Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D41B52BBACE
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 01:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbgKUAYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 19:24:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728275AbgKUAYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 19:24:06 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D287EC061A04
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 16:24:05 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id b3so5714322pls.11
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 16:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=A7SWgXPCiajknxZfIgmm/Chff6x+olo2cJ70dACeOlI=;
        b=Ufe7L8IQ5v/I7T8tt4gsPuDnhpRA272mwrcmv9XewlpzYhDUXW2jqTxD1hslQrth5g
         eDmR9NJxf5+la/wDoV9T4gAXWEe4Q7fIOQHWwX9t1BmbdmwqQejV3fWvEwLhxFduJBYM
         xKz63gHciuxUu58RjUr5pEfsRqThUo8eAQyEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A7SWgXPCiajknxZfIgmm/Chff6x+olo2cJ70dACeOlI=;
        b=gUTemwMEtRM66WVCf3bksm8fDhowLJSdYn88+J9AdaeQ+5WXKa40aifqO9n2s+wp5Z
         wTq6k5Xc0bfgS11rA206uGfI5uVIrdMBqYCuVKIq3XenppbuLrYbphkH2QHK3vp1FSa3
         73GRdCbCNf3Z0n8M+JtArg8oAkw6OYQL/9gAcgzWwKb6hUGGN1kvtwlJuhUNxIde8X/P
         TSYuwn7oxIh0WGElaMNBnvL55CfKR4afvJ5e11iHtzLF2sYEkJ+swL3zKGxOQlOX+xBj
         Tn2OnoymDc9gHWvyXBpTssGqV6qeIl8YhyakQUgjiQmjEU5YsPrRypqbYPpWeUL0WLab
         t54w==
X-Gm-Message-State: AOAM530tn8klZmGtnLR1ROYvB1si26Tq+HNS1Nz7dx8zzEK/+d3FFckL
        qzCMq+TA1nO11tqYEK2olIBPiQ==
X-Google-Smtp-Source: ABdhPJzjpCFLnLrUalvrO32PJt+53p5u2neas7NkD6ncxIwW6NEts5vwrkfDaOU5cA3xZBMV+Vy9Gg==
X-Received: by 2002:a17:902:8e81:b029:d9:f1a8:54ac with SMTP id bg1-20020a1709028e81b02900d9f1a854acmr2502635plb.69.1605918245442;
        Fri, 20 Nov 2020 16:24:05 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y5sm5324184pfc.165.2020.11.20.16.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 16:24:04 -0800 (PST)
Date:   Fri, 20 Nov 2020 16:24:03 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>, luto@kernel.org,
        tglx@linutronix.de, christian.brauner@ubuntu.com,
        willy@infradead.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kselftest@vger.kernel.org, x86@kernel.org, gofmanp@gmail.com,
        kernel@collabora.com
Subject: Re: [PATCH v7 0/7] Syscall User Dispatch
Message-ID: <202011201623.FBFA4471@keescook>
References: <20201118032840.3429268-1-krisman@collabora.com>
 <20201119123827.GL3121392@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119123827.GL3121392@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 01:38:27PM +0100, Peter Zijlstra wrote:
> On Tue, Nov 17, 2020 at 10:28:33PM -0500, Gabriel Krisman Bertazi wrote:
> > Gabriel Krisman Bertazi (7):
> >   x86: vdso: Expose sigreturn address on vdso to the kernel
> >   signal: Expose SYS_USER_DISPATCH si_code type
> >   kernel: Implement selective syscall userspace redirection
> >   entry: Support Syscall User Dispatch on common syscall entry
> >   selftests: Add kselftest for syscall user dispatch
> >   selftests: Add benchmark for syscall user dispatch
> >   docs: Document Syscall User Dispatch
> 
> Aside from the one little nit this looks good to me.
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Agreed, and thank you Gabriel for the SYSCALL_WORK series too. :) That's
so nice to have!

-- 
Kees Cook
