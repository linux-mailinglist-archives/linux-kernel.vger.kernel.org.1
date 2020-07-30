Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97707233828
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jul 2020 20:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730344AbgG3SKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jul 2020 14:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbgG3SKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 14:10:39 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F82C061575
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 11:10:39 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id t6so1443174pjr.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 11:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eCWZ0AKDmj5eYAH74+r2M/mKN/7ZXpbrEknxIsef3Yc=;
        b=ajUAXfrDq0Mb2pI9UhL+Deo64bgfocmrSQ7S3+wN7kirbVua2E3Fo7cLCk9f3YO1UW
         ySTM5mAzc7dfFuSgMadQN4k6RAqOOA77JKEXrw0mlGAWt0AsYKbmNK/x2KOhQAdYugUz
         KrLA08z7cNDfrOZbVmzsCMWDpbJywwGPnUhKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eCWZ0AKDmj5eYAH74+r2M/mKN/7ZXpbrEknxIsef3Yc=;
        b=lSdwcsxbCvaJiHF5HE35Xxk7dqYacMvie0pWjwqZ5YelTpSkRsUo6sI7KJA6VR0r0U
         Ca8NyNSbK0wfFAXTveIWasmII5hSSg+9+q8yTJnYMB8/C2p9ipkhFjQcSteD9gYktlzu
         +ELJVKvJNNVVDVcmXIhGckWi+TPQYVH0d4n/leuAI69tMCXmw1N0Btq7MzFzX+S2HlzE
         fANDXpjk/5sRhpjkMNyTKhHSPSfLICe/VcsurIGkqobZa1MLq6sJCRlT8qOuTcQyyrdx
         0070o8+rzutO73BwgxOoxVCITcJ6o1v6g/S40NpeslobysL08V1mXkBYC1wmdSUv9LXA
         kpEA==
X-Gm-Message-State: AOAM533/1MTyR0CTxHO59N0ChiQMuAFmwnZqs/DlC9XO6JSRruRTLxof
        GCxCBcLdbuyjPW7wlyr/9ZRT1g==
X-Google-Smtp-Source: ABdhPJzJ1U3yCIj3cyycYFAeqg2w0SXGmg6Cxo8SvVZQ1srTSSZywo4dwa9+2kFhFvmNxkh040WAvA==
X-Received: by 2002:a17:902:8a90:: with SMTP id p16mr373142plo.167.1596132638877;
        Thu, 30 Jul 2020 11:10:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d24sm6177185pjx.36.2020.07.30.11.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 11:10:37 -0700 (PDT)
Date:   Thu, 30 Jul 2020 11:10:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Denis Efremov <efremov@linux.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [Linux-kernel-mentees] [PATCH v2] block/floppy: Prevent
 kernel-infoleak in raw_cmd_copyout()
Message-ID: <202007301056.D3BD1805B0@keescook>
References: <20200728141946.426245-1-yepeilin.cs@gmail.com>
 <20200729115157.8519-1-yepeilin.cs@gmail.com>
 <20200729125820.GB1840@kadam>
 <f2cf6137-987a-ab41-d88a-6828d46c255f@linux.com>
 <CAK8P3a20SEoYCrp3jOK32oZc9OkiPv+1KTjNZ2GxLbHpY4WexQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a20SEoYCrp3jOK32oZc9OkiPv+1KTjNZ2GxLbHpY4WexQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 10:11:07AM +0200, Arnd Bergmann wrote:
> > On Wed, Jul 29, 2020 at 3:22 PM Denis Efremov <efremov@linux.com> wrote:
> 
> > And checked for leaks on x86_64 with the script test.sh
> > $ cat test.sh
> > #!/bin/bash
> >
> > for i in 4.8 5 6 7 8 9 10
> > do
> > ./run_container.sh gcc-$i $(pwd)/src $(pwd)/out bash -c 'gcc test.c; ./a.out'
> > ./run_container.sh gcc-$i $(pwd)/src $(pwd)/out bash -c 'gcc -O2 test.c; ./a.out'
> > ./run_container.sh gcc-$i $(pwd)/src $(pwd)/out bash -c 'gcc -O3 test.c; ./a.out'
> > done
> >
> > No leaks reported. Is it really possible this this kind of init, i.e. cmd = *ptr?
> 
> The problem is that the behavior is dependent not just on the compiler
> version but
> also optimization flags, target architecture and specific structure
> layouts. Most
> of the time, both gcc and clang will initialize the whole structure
> rather than just
> the individual members, but you still can't be sure that this is true
> for all configurations
> that this code runs on, except by using CONFIG_GCC_PLUGIN_STRUCTLEAK.
> 
> Kees pointed me to the lib/test_stackinit.c file in the kernel in which he has
> collected a number of combinations that are known to trigger the problem.
> 
> What I see there though are only cases of struct initializers like
> 
>   struct test_big_hole var = { .one = arg->one, .two=arg->two, .three
> = arg->three, .four = arg->four };

test_stackinit.c intended to use six cases (where "full" is in the sense
of "all members are named", this is intentionally testing the behavior
of padding hole initialization):

full static initialization:

          = { .one = 0,
              .two = 0,
              .three = 0,
              .four = 0,
          };

partial static init:

          = { .two = 0, };

full dynamic init:

          = { .one = arg->one,
              .two = arg->two,
              .three = arg->three,
              .four = arg->four,
          };

partial dynamic init:

          = { .two = arg->two, };

full runtime init:

          var.one = 0;
          var.two = 0;
          var.three = 0;
          memset(&var.four, 0, sizeof(var.four));

partial runtime init:

          var.two = 0;

(It seems in refactoring I botched the "full static initialization"
case, which I'll go fix separately.)

> but not the syntax used in the floppy driver:
> 
>    struct test_big_hole var = *arg;

So this one is a "whole structure copy" which I didn't have any tests
for, since I'd (perhaps inappropriately) assumed would be accomplished
with memcpy() internally, which means the incoming "*arg"'s padding holes
would be copied as-is. If the compiler is actually doing per-member copies
and leaving holes in "var" untouched, that's unexpected, so clearly that
needs to be added to test_stackinit.c! :)

> or the a constructor like
> 
>   struct test_big_hole var;
>   var = (struct test_big_hole){ .one = arg->one, .two=arg->two, .three
> = arg->three, .four = arg->four };
> 
> Kees, do you know whether those two would behave differently?
> Would it make sense to also check for those, or am I perhaps
> misreading your code and it already gets checked?

I *think* the above constructor would be covered under "full runtime
init", but it does also seem likely it would be handled similarly to
the "whole structure copy" in the previous example. I will go add more
tests...

-- 
Kees Cook
