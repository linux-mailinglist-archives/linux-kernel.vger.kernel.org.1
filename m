Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6E926E7F1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 00:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgIQWGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 18:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgIQWGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 18:06:41 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD146C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 15:06:41 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id m15so1856157pls.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 15:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=KGNmIQxkdvUG3FJy4i5PBk+ji2PTypNkOa0bskKz16s=;
        b=EaqigPaJOr6zzGO1gy3rVaDoZkIxYX1OWLosQF+sjumKAYPELnTLFQ6bdp1H+yafVN
         HXWuwkjp9Zd4RV142Qe0R8wi6t+9dYOVRkwH0gGxAIL9j2GhMUlDd76IwzQZTGTCjyAT
         gGCBimh9PMJ72w2Oa2z4sAEFv0bybwKf8JJ04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=KGNmIQxkdvUG3FJy4i5PBk+ji2PTypNkOa0bskKz16s=;
        b=qWN1Amxn6WO7Zj49lUbxt8rMf5yGGrC6z9B35s8WI8feIjVIjDP416A20Vj2Mdb/hW
         vaDbkhkR2E2GgjN8/zch/AuRsnXvwAkHBvusktZ+Dk9vse1WBQzIe4AplyDC9bpmAm72
         wJhBVjbn7mTBN35ojmexjrsDzPoMluObCoYFPTA1MI6yHZsinTJyZhUMgdFDWF0/cEf1
         crvDa5ezcjvr2Yt3otRebRy9kvEUJAIuddFWOTVFKWnMfmHFyCEExTwH1rWcPc87I8rM
         qAiTejkSh5OIhySgQevveXN4c2p/HV39KOqBU/7gLA5cp6yannFsETd6AVwEWOMQnJhy
         DfdQ==
X-Gm-Message-State: AOAM531qkMkLEb26EC4Jbd+U5ZGeDbpN/UAFhdaD65ZKq31pCe0koMG1
        dWhBqelDIZFuvqzzl2TGGB/aQA==
X-Google-Smtp-Source: ABdhPJxVxMDAVNtxxj0yGmkKjx8X6uSL8vN/TWKF3VyOltmqZVZ34+YdBYAC7vSM7w8gckWvKUnQVg==
X-Received: by 2002:a17:902:b10b:b029:d1:e5e7:bdf8 with SMTP id q11-20020a170902b10bb02900d1e5e7bdf8mr12609117plr.43.1600380401403;
        Thu, 17 Sep 2020 15:06:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d128sm661053pfc.8.2020.09.17.15.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 15:06:40 -0700 (PDT)
Date:   Thu, 17 Sep 2020 15:06:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] selftests/harness: Flush stdout before forking
Message-ID: <202009171506.535C5678@keescook>
References: <20200917041519.3284582-1-mpe@ellerman.id.au>
 <CAMo8BfJ5j4nG0z1Bk00J=3xPM++J68Hp2idJ-D5aHT84-vOzsQ@mail.gmail.com>
 <e24df908-c50d-59ef-563c-9db24c819248@linuxfoundation.org>
 <99f67c84-4dcd-278a-e7b8-e19054818ecf@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <99f67c84-4dcd-278a-e7b8-e19054818ecf@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 10:51:32AM -0600, Shuah Khan wrote:
> On 9/17/20 6:58 AM, Shuah Khan wrote:
> > On 9/16/20 10:53 PM, Max Filippov wrote:
> > > On Wed, Sep 16, 2020 at 9:16 PM Michael Ellerman
> > > <mpe@ellerman.id.au> wrote:
> > > > 
> > > > The test harness forks() a child to run each test. Both the parent and
> > > > the child print to stdout using libc functions. That can lead to
> > > > duplicated (or more) output if the libc buffers are not flushed before
> > > > forking.
> > > > 
> > > > It's generally not seen when running programs directly, because stdout
> > > > will usually be line buffered when it's pointing to a terminal.
> > > > 
> > > > This was noticed when running the seccomp_bpf test, eg:
> > > > 
> > > >    $ ./seccomp_bpf | tee test.log
> > > >    $ grep -c "TAP version 13" test.log
> > > >    2
> > > > 
> > > > But we only expect the TAP header to appear once.
> > > > 
> > > > It can be exacerbated using stdbuf to increase the buffer size:
> > > > 
> > > >    $ stdbuf -o 1MB ./seccomp_bpf > test.log
> > > >    $ grep -c "TAP version 13" test.log
> > > >    13
> > > > 
> > > > The fix is simple, we just flush stdout & stderr before fork. Usually
> > > > stderr is unbuffered, but that can be changed, so flush it as well
> > > > just to be safe.
> > > > 
> > > > Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> > > > ---
> > > >   tools/testing/selftests/kselftest_harness.h | 5 +++++
> > > >   1 file changed, 5 insertions(+)
> > > 
> > > Tested-by: Max Filippov <jcmvbkbc@gmail.com>
> > > 
> > 
> > Thank you both. Applying to linux-kselftest fixes for 5.9-rc7
> > 
> 
> Kees,
> 
> I haven't pulled this in yet. If you want to take this through seccomp
> tree for dependencies:
> 
> Acked-by: Shuah Khan <skhan@linuxfoundation.org>

You can have it -- it's a global fix and more than the seccomp selftest
is likely affected. :)

-- 
Kees Cook
