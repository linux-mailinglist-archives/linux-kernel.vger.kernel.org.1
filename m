Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8A57292CE7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 19:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgJSReL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 13:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727632AbgJSReL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 13:34:11 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCB6C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 10:34:09 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id e7so328499pfn.12
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 10:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G5rjackHCXux/EOEOhw9b0KT9npfluDyAp2p7HpwGaQ=;
        b=bQfZ0uUmc4a1+7282KvpS6VxDOyxzFiVk30B1cfvXgHWoucBI4PlZgrrWHLNiBqLF9
         f43GVvAQUG6ZcHbr/HCZXMv7FJvDA1bD/JSn6eyOfVhXJxGBlmn+tZvdnj7ePcIXhCbY
         /UU10phXk9rYjC7NPJ08YUEvken2H+rOvMS5jOA9bpSyv3O3iE/x0oqBBR7M6UuUx4l0
         j7xZN3QgfELWcgZAX0nZ+w2djGvq6hbTVKhaaujFnJUPxjUGf6jPzIvejH7YCt6o16+V
         hVYO+dScnRRv2jhfxxQUXuASJyWUrr6wUOGAwB8CkCOJavodmPtqieHOFjD4aGLenNv1
         s75g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G5rjackHCXux/EOEOhw9b0KT9npfluDyAp2p7HpwGaQ=;
        b=d05U9uS/PgbKlzOaoVnf7pPavGdBJOFiiPRqEUuy75CIC4HgpeLpwZpOD/KQuZFGEQ
         vASo5SHbFb9bMSYAh+Moo/QYQQa8e5BhAkA8Wo8sQ1wp9ZcPT6/S+E5mAEubR1HymIfE
         5D7beK/r+TOgQlBD1RA5npOFzwnik1AvzGPzetLCQWyO6BhxaSM0cmdv3K7LxOTfQGGp
         6ogQLm7mKf+lvOv0miH9NIkt70sZS/tumKofAAYIMiBnDVsItx94d/fzGYwQfYB0cEbQ
         OIc/S2XdmGWRuXpfb6DMmXPhzuBwcs2okMHaIb38X/VPk+DAXdA3ghyugl2JFubytbG9
         spjA==
X-Gm-Message-State: AOAM533qdNn7rkwT0gewafuY2i5ihshLGwPOB2bS/qDfiT1xIgWLQyyc
        bkJizT0RG4dXsohrj5X5qG4Gv90/aXIw0GBt5xajpg==
X-Google-Smtp-Source: ABdhPJwEcZvdVEQl4Pv26jjEuNJj+teJXpN4LQ9zSwZ/v1q1cuw4bCYWpOp3mgzjKLNTNLgiBoxwpb7HgB1kDGeJKhE=
X-Received: by 2002:a63:1906:: with SMTP id z6mr686372pgl.286.1603128849279;
 Mon, 19 Oct 2020 10:34:09 -0700 (PDT)
MIME-Version: 1.0
References: <44861eaca17ffbb51726473bc8e86ad9e130c67e.1602876780.git.andreyknvl@google.com>
 <CABVgOSnMiNHZoj36NfHTuQ3xLOu-W7FqMnE93cgJv465Kv1QUQ@mail.gmail.com>
In-Reply-To: <CABVgOSnMiNHZoj36NfHTuQ3xLOu-W7FqMnE93cgJv465Kv1QUQ@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 19 Oct 2020 19:33:58 +0200
Message-ID: <CAAeHK+zrLvkkvQSjEt1r3uvj+W=xAx3gdroDF6eKeXuMQeZn+g@mail.gmail.com>
Subject: Re: [PATCH] kasan: adopt KUNIT tests to SW_TAGS mode
To:     David Gow <davidgow@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 17, 2020 at 9:42 AM David Gow <davidgow@google.com> wrote:
>

Hi David,

[...]

> This looks good to me. Though, as you mention, writing to freed memory
> might not bode well for system stability after the test runs. I don't
> think that needs to be a goal for these tests, though.

We generally tried to avoid this, since we run multiple tests, and if
one crashes the kernel, the rest won't work. I'll fix this in v2.

> One thing which we're hoping to add to KUnit soon is support for
> skipping tests: once that's in place, we can use it to mark tests as
> explicitly skipped if they rely on the GENERIC mode. That'll take a
> little while to get upstream though, so I wouldn't want to hold this
> up for it.

This will indeed be useful.

> Otherwise, from the KUnit side, this looks great.
>
> I also tested it against the GENERIC mode on x86_64 (which is all I
> have set up here at the moment), and nothing obviously had broken.
> So:
> Tested-by: David Gow <davidgow@google.com>

Perfect, thank you!
