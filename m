Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F95A2B0E7F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 20:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgKLTwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 14:52:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbgKLTwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 14:52:06 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2292C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 11:52:05 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id g7so5545513pfc.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 11:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6grGTHRg8rsQq1ytOmJKPPc/a47JtcnHiEDyRqBbLFo=;
        b=euZJ1KFslUbqxplovouyxG8p0U+5+xuKJD4/GMN4ixlQJDzc/G0SQZTp3Fl2aryH9a
         jZuQg6p73xPEgXHx7QgnJGdxpcO43wqgWjrCEiigP6qhu0Z1ONy4LM69d5xWn5fqiAjf
         nKQRjWnb43kbs/G6nf27kwm0DIdmx4dezF7NZ18jeI0t3egMDcup0GnZ2C86V2fJPBJf
         O5Hjp9M28mx002EbXyvkABmb714LZbbKkBYqGZG7Sbv2lJZUBFQi+18Yw8nt7GZAmYC6
         HR2kUslyxlb8trjZS5Y3X95dlNU7osxVXNTIhdobS1PtxwPkWIxUCsaMmLuKGdsZ3WpH
         Q9LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6grGTHRg8rsQq1ytOmJKPPc/a47JtcnHiEDyRqBbLFo=;
        b=XxHe5preXqlfk/BVL27CR9d5zwHAe9Xh8acjIahsk5GqnQ5FAUZVfeDl7ZVRK1ej9E
         S2LBbc8lBSXNZav96INuEfqySkbulWgXmWNRvIfrfpooGvBauv0TKVici8D78hGzomp1
         Hnp7OMu4t3sLEEQe16D7tcsxZMX0MP5zBWJFzQ1lfxG+R6r3Au8zlsSqp4D/F7j9RVdZ
         IhFzzqQCFSPFOINHqKv+oOXoeX6AnOAxmtpl0Nd0CKtkKbba2e0+jtkXciGtk+uFfYqx
         5z6Fd2ob1wdLq1ykVKbIMvq5cZvgMrIPrJhDlZmN1KRvloKE903/dVfFWTI6U5C8CGVb
         v0lA==
X-Gm-Message-State: AOAM5335KgNZhUL2Kw7zZiLODN/mUauG6/9QhtVGSdO5/o3nnuY6wONJ
        eXYtonH+/4XyXXMei9tdI85yoAt+TQelbPOfTdA6bQ==
X-Google-Smtp-Source: ABdhPJwKzVqKpDX9KBt9y8fPXoFH25yT6OCFViJDkBsmWi4+WIsb92nIDpsfYsvWT4Q0Jq4is2aH0qhBhL/vC1bjOoE=
X-Received: by 2002:a17:90a:eb02:: with SMTP id j2mr842940pjz.136.1605210725310;
 Thu, 12 Nov 2020 11:52:05 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605046662.git.andreyknvl@google.com> <fdf9e3aec8f57ebb2795710195f8aaf79e3b45bd.1605046662.git.andreyknvl@google.com>
 <20201111182931.GM517454@elver.google.com>
In-Reply-To: <20201111182931.GM517454@elver.google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 12 Nov 2020 20:51:52 +0100
Message-ID: <CAAeHK+wJz6qnX1Tsb9BTsbd4zjDXr61DLRmmNwDZ2+F6CwpQ1A@mail.gmail.com>
Subject: Re: [PATCH v2 11/20] kasan: add and integrate kasan boot parameters
To:     Marco Elver <elver@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 7:29 PM Marco Elver <elver@google.com> wrote:
>
> > +#include <linux/init.h>
> > +#include <linux/jump_label.h>
>
> This should include <linux/static_key.h> -- although the rest of the
> kernel seems to also inconsistently use on or the other. Since the name,
> as referred to also by macros are "static keys", perhaps the
> static_key.h header is more appropriate...

Will fix.

> > +enum kasan_arg_stacktrace {
> > +     KASAN_ARG_STACKTRACE_DEFAULT,
>
> It seems KASAN_ARG_STACKTRACE_DEFAULT is never used explicitly. Could
> the switch statements just be changed to not have a 'default' but
> instead refer to *DEFAULT where appropriate?

We need to either cover all cases explicitly, or use default in each
switch, otherwise there's a warning. I guess covering everything
explicitly is a better approach, in case more values are added in the
future, as we'll get warnings for those if they aren't covered in
switches. Will do.
