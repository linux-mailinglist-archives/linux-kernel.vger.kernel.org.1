Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0FA1ED0E0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jun 2020 15:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgFCNdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jun 2020 09:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgFCNdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 09:33:09 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA643C08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 06:33:09 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id 25so877910oiy.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 06:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2Q5Izy2Q3y4sMGHFp3V6FithAv0OmwTAETmoYPgsSps=;
        b=qQY7fexkdXeUYXj2Vn3mtQ9pFavPkAkOY0O4TkwT3wvzZakAEYeluUK5+Oe3s3ppO0
         qavwoK0Nln6Kn63yuf//RUB6+cPLni/WGHcjw4n5CIk89nBLdcZKKveYoE1otLVR6R41
         mWuhbSYdhj9RoKed54uojOahfA2GxFLkyiJJzpXHjPpLNKHsLOlCiG66JBrl3IUU94NN
         l03v5tLS8rODVU7q4FjctdZQ8jKchvFfhknyNbPWMB6LA7rvGPgWw3w5jSN483GH8N+P
         puOvSLftiHypXmIH5XEGLZotLzijthRqeimO1P1SxL+dx9gkS5fWtQm9J35ryesz+SFS
         T6LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Q5Izy2Q3y4sMGHFp3V6FithAv0OmwTAETmoYPgsSps=;
        b=FCbXl+gmgXNkzKIQPuhABUHrf3ukHKD3OKNawhA7ljuPrEpKGPmJFjYASgA2DeDdK0
         E+/fln7Xop+w2wY9s2PoPA/CiRVneBqRdxMQbqsdOO06zazOEQ0ri6n7mgb639XC7gt3
         MlHDMeeflb4f4j1Pq4h4xtTkgazzypE9LZg1T/fJRFz1wU3DKy+SmP0f/ilY9I9UqQWK
         8QrkDEvYKx4JKvJDCcdSTDop0U1TNpZGmWvh5lUa7EjWV/aoykW5UJkfWZxRN96zQCNz
         mt7owPsdGQFn2I5EicXbJPogXEWxZGbJjZ1B+NexscEMfcTPhBMV2XtGHUoPYhW0ixFv
         /7nA==
X-Gm-Message-State: AOAM531qoD3V9lwFiOS2fJC/vxJhJrakZlzXrvhgwwx2n/pwrEPVV1D4
        w19r5BsT6UGkKdP2Uoympow/0doeJxwY/JEcwYHC1A==
X-Google-Smtp-Source: ABdhPJwYH/jBClsBY+AiWl09LlisxEXBMp5e0AmwhVNdHgR1jR9lxHsOBJ5yycyMvYU3baQSoHRY0K2wvKCNcqK3gos=
X-Received: by 2002:a05:6808:34f:: with SMTP id j15mr6473850oie.121.1591191188821;
 Wed, 03 Jun 2020 06:33:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200603114014.152292216@infradead.org> <20200603120037.GA2570@hirez.programming.kicks-ass.net>
 <20200603120818.GC2627@hirez.programming.kicks-ass.net> <CANpmjNOxLkqh=qpHQjUC_bZ0GCjkoJ4NxF3UuNGKhJSvcjavaA@mail.gmail.com>
 <20200603121815.GC2570@hirez.programming.kicks-ass.net>
In-Reply-To: <20200603121815.GC2570@hirez.programming.kicks-ass.net>
From:   Marco Elver <elver@google.com>
Date:   Wed, 3 Jun 2020 15:32:57 +0200
Message-ID: <CANpmjNPxMo0sNmkbMHmVYn=WJJwtmYR03ZtFDyPhmiMuR1ug=w@mail.gmail.com>
Subject: Re: [PATCH 0/9] x86/entry fixes
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jun 2020 at 14:18, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Jun 03, 2020 at 02:08:57PM +0200, Marco Elver wrote:
>
> > What is the .config you used? I somehow can't reproduce. I've applied
> > the patches on top of -tip/master.
>
> So tip/master, my patches, your patches, this series.
>
> $ make CC=/opt/llvm/bin/clang O=defconfig-build/ -j80 -s bzImage
>
> is what I used, with the below config.
>

Thanks, can reproduce now. So far I haven't found any indication that
there is a missing check in Clang's instrumentation passes somewhere.
I'm a bit suspicious because both Clang and GCC have this behaviour.
I'll continue looking.

Thanks,
-- Marco
