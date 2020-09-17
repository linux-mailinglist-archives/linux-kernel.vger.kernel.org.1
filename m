Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6089126E782
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 23:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgIQVlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 17:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbgIQVlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 17:41:53 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E04EC061756
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 14:41:53 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id f1so1808662plo.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 14:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QVbYh+hXgKacyMS8b9RupbFvdNVcoZTVLthm30rJh0k=;
        b=qva0PxBNIauoP4RVFxq+mnTtDV6motdFEtAM/huTELxaa+6aTVPVOjDuJT2Le+oQ9/
         fSz+RJ6WO3mvKxB4VDDpGFHQ2s14FIXchmUS4qoCCv/7L7c+s4g4PqLhJ+pPtXTCGiJ+
         vw0q8Z1WGKqphcAZteTCyYXKLeobNb0mGVemJtA3PdmC/D9A/vTQutfaslfPUPinnTzq
         fwoA4oMlk1d6B4ssiGnNQvRZS0LjbEwIVBPvzeJLTib/e5T9qK0fNenoxPukTdJfNKYQ
         XLVZ1b0wyv+ZfLVihqFBwJbvPDHFpjHs0g3Q3tTJtjTysQKj1abT+JNe5ShCDYZiGP5z
         9JuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QVbYh+hXgKacyMS8b9RupbFvdNVcoZTVLthm30rJh0k=;
        b=SO2j4AW58zRsJwyT05laK+Ql9OotB/2mH464/fKtZHJybn/FOFvnAj4h9BLWYI1Fgx
         Cod4OzbdvN8/N9H5E9tn8jdNLEcsbu505b94CbrxN3dePpskl0kEfAu/C1uN7zHngjVa
         dwkhf+mN4BbepJRZH5/SNg1hVjY2Om9vl4gIpKXtC/T/BFaAO5vNwq9hTTST+NjkcQKq
         zrhtANO4uYWFQskmGemeHGMSEgNRAUIDZndidAZN3CHqrKjEst6xnCbyxxFsXNuEG0iG
         FczJJqRw9aE8p9m4TwiQWAp2COkELR+JDAWJTiYE2+Xpf9apbJd049vC1jal3mXBlRhT
         gXTw==
X-Gm-Message-State: AOAM532r+ftlvxDIfnzLAs3k6bdGfo1aqsgNFA4JkfGAx22sk/WygwRO
        isyy/vAibgafNnQNbyxhnG8XVoMT5Q3zY9fgOcaGYQ==
X-Google-Smtp-Source: ABdhPJxm1R9qXapA1g24qa0BCvyvSmLzw521I4Sm0yUaOj8NV1FGLHLMBu93ItQ1iox62avObD1AJFpoqhez34HgjxM=
X-Received: by 2002:a17:90b:698:: with SMTP id m24mr10118248pjz.32.1600378912642;
 Thu, 17 Sep 2020 14:41:52 -0700 (PDT)
MIME-Version: 1.0
References: <9441ed0f247d0cac6e85f3847e1b4c32a199dd8f.camel@perches.com>
 <20200916200255.1382086-1-ndesaulniers@google.com> <ce28bb9bc25cb3f1197f75950a0cfe14947f9002.camel@perches.com>
In-Reply-To: <ce28bb9bc25cb3f1197f75950a0cfe14947f9002.camel@perches.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 17 Sep 2020 14:41:41 -0700
Message-ID: <CAKwvOdm84xCFq_KVQcNws2QveJdOM_uRrH9s023Gv8sp8V79JA@mail.gmail.com>
Subject: Re: [PATCH v2] nfs: remove incorrect fallthrough label
To:     Joe Perches <joe@perches.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Hongxiang Lou <louhongxiang@huawei.com>,
        Miaohe Lin <linmiaohe@huawei.com>, linux-nfs@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 1:19 PM Joe Perches <joe@perches.com> wrote:
>
> On Wed, 2020-09-16 at 13:02 -0700, Nick Desaulniers wrote:
> > * (call of function with __attribute__(__noreturn__))
>
> I guess panic counts.  I count 11 of those.
>
> Are there any other uses of functions with __noreturn
> in switch/case label blocks?

If you look at global_noreturns in tools/objtool/check.c:
 145   static const char * const global_noreturns[] = {
 146     "__stack_chk_fail",
 147     "panic",
 148     "do_exit",
 149     "do_task_dead",
 150     "__module_put_and_exit",
 151     "complete_and_exit",
 152     "__reiserfs_panic",
 153     "lbug_with_loc",
 154     "fortify_panic",
 155     "usercopy_abort",
 156     "machine_real_restart",
 157     "rewind_stack_do_exit",
 158     "kunit_try_catch_throw",
 159   };

Whether they occur or not at the position you ask; I haven't checked.
-- 
Thanks,
~Nick Desaulniers
