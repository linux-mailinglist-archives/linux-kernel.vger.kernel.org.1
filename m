Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDEA727F5E7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 01:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732194AbgI3XVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 19:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731255AbgI3XVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 19:21:24 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A39AC061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 16:21:23 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id f70so2557073ybg.13
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 16:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yrpPLLVt8wKM3iqW9ZiiFDeORkAMwl036WYIC41BrP0=;
        b=v4Ukut/5haJelh51Q3Yfml8ane6b7t82geBuv+2gaQgEs7KTFY0XlEY69WChsLfVKu
         MKvforcAyLkkgaa7rglJ2+OT5drFkLjoGnSVKR1ClTCDPWgwyPWkp9f4KtNHjpAEUB5D
         WBDA0M+/5S4H7l8nRuf30gXeG2CinxtBkGclBiTw2uFIMuQSxpH358o0yKc+B7MQM0wm
         8qL7D+zuckxZ0AXMvLoe/vi9XMS/qSbaqEC3kEoXW4LmY+nJ/o98nU7+Jn8nmxMxFmcR
         hWjQr7zTggVTGLGQ6RFHDxplYrS7pVyiHN0DHo4tXTmMaTwtXCkWrxbuOHWe7aAX9c+w
         VXJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yrpPLLVt8wKM3iqW9ZiiFDeORkAMwl036WYIC41BrP0=;
        b=GAb9rrtZaDc9pHCCx8vRuMCWZXGHWYw0MdJBuITejpF7P2WBwvE4WqoyJ7ZdqhVRpO
         hfwwdipyfixrl0KAh/puij7Qey5mlpesio0mFUy7pDfP2O6c+PyS6rrifShsow3KMux9
         QTW74BLfIJbS0GmHbTRyZbKexzsG9OrF8LdsxlZJUKoN9XeW6gaJlbTqeLEeegdjIk7J
         axq5LE5/Ha67WjrsxGDMW3bsoBSffqScrFRdU6V/iP4FAJ/gsVl83hNTn2hNkmVp/JOq
         1WV0BEx2fC3fpS4gGklbWqnZPOM2f1U4QXkyYxpkanrynh3jCxki6TVaelDgXbZbiXeP
         yG2g==
X-Gm-Message-State: AOAM532j/AIYFj1QKxbzTSkNVHcXqp5sPFd80myYd5CAqmqZrIsV8cOC
        +gqyJBZDPB86oCFXhgoOfnLKSQJPI3oPvOqpamEAvA==
X-Google-Smtp-Source: ABdhPJzwEtWH0sHKPzgO//AINaKkaCCF9YqLLPoAQVMrYySJaubkHVFJMEgfvcio/aElNZn9XksgnqO18MZt6T21T7E=
X-Received: by 2002:a25:5056:: with SMTP id e83mr6551483ybb.287.1601508082038;
 Wed, 30 Sep 2020 16:21:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez3SG6ngZLtasxJ6LABpOnqCz5-QHqb0B4k44TQ8F9n6+w@mail.gmail.com>
In-Reply-To: <CAG48ez3SG6ngZLtasxJ6LABpOnqCz5-QHqb0B4k44TQ8F9n6+w@mail.gmail.com>
From:   Michel Lespinasse <walken@google.com>
Date:   Wed, 30 Sep 2020 16:21:09 -0700
Message-ID: <CANN689ESNEt7Ju0_jSVeP-37J+a0AvXsVRzNQ-s2cjM--AND+Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] mm/gup_benchmark: Take the mmap lock around GUP
To:     Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 6:20 PM Jann Horn <jannh@google.com> wrote:
> To be safe against concurrent changes to the VMA tree, we must take the
> mmap lock around GUP operations (excluding the GUP-fast family of
> operations, which will take the mmap lock by themselves if necessary).
>
> This code is only for testing, and it's only reachable by root through
> debugfs, so this doesn't really have any impact; however, if we want to add
> lockdep asserts into the GUP path, we need to have clean locking here.
>
> Signed-off-by: Jann Horn <jannh@google.com>

Acked-by: Michel Lespinasse <walken@google.com>

Thanks for these cleanups :)

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
