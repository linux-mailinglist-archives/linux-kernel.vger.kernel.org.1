Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 209F727E8EE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 14:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729997AbgI3Mu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 08:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729898AbgI3Mu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 08:50:57 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C19C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 05:50:56 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id nw23so2639298ejb.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 05:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2oyhULf73PbSRNA3Qsr0tiDBEcqWN9KNz6Hu/4QKeuw=;
        b=U+CynULl3FdR3YB/IUVSRlkvgJEzMr2/jA76c1mc1t7baIc/ZBAJIQpEH+d/N9kwgG
         EBK/jUHXxXVq5snRZOX2WgdZo8IQ1D2oypmsdwf9iUSnNLMz/Qas4ZcQRTh1P+vv+uMO
         6dBT1nhqX2C6eSZrh6NlHP2qZGUPhK7t3axRQKZ+l4YUYlweCQNsCKvwJn92QvdY89Fa
         +GC8spCxEOdulImMXe00oUFBIFVJnPdotyyGbKUsOdn4UbnVwi4Pg0jdTM8Q6FdrzlK8
         lcR/RhauyTxrK6KOSDt07FQpgSs4missXaEdj5dhIboZQ0z9dxy9fKLmKQPN9/4uXwQK
         Mo+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2oyhULf73PbSRNA3Qsr0tiDBEcqWN9KNz6Hu/4QKeuw=;
        b=uMI/px3va/sm5oYbih1P1zIHr1JOLcTRgVesyLG8eomH12ek/nrbErJePk5dBU2ESl
         PjyBaYgPS8T5hK/sq2+Le9xYPmFfwN2iytZLvZ0A94G7ouKKqkD8xbLtb5f3ugw6yVwH
         ugD0XCtoGiIB3Jq91vPR9B7a7myZTjrG3g+qSZiAiD5DWTIhb5M5qNXniDtE9nz1BEK2
         iuvp8JkjaVb1IjCPRtVWx+IfptfPsIEw/PJvAz7oldLt3Acb3z/Vt6169lhY7VsMDR1W
         I9OPNE1zVRptC8Oa1JwKnG1WVIuJur0AHDvJ/qmW9LSMRx2uvXvJnorLCOsU0A/fcHwh
         F1MA==
X-Gm-Message-State: AOAM533Yz0kSuJS12XmuZw1uP/Mg+xWzQ+Cfi8liJfQu6i6gUPU7t6IU
        RkFw8qhsaFkeqi6JsLzVahMwlXAHDQ8W6ALyhWSKIA==
X-Google-Smtp-Source: ABdhPJwQ4TGMb5KzsAnZJ0zAu9KSAa3TQc+xsd/dxqDV/OmiFTAxg0DppfxNBpruoSZcCLTXEv29YwSq8MtYfcOEGC0=
X-Received: by 2002:a17:906:f917:: with SMTP id lc23mr2594183ejb.233.1601470255231;
 Wed, 30 Sep 2020 05:50:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200930011944.19869-1-jannh@google.com> <CAG48ez03YJG9JU_6tGiMcaVjuTyRE_o4LEQ7901b5ZoCnNAjcg@mail.gmail.com>
 <20200930123000.GC9916@ziepe.ca>
In-Reply-To: <20200930123000.GC9916@ziepe.ca>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 30 Sep 2020 14:50:28 +0200
Message-ID: <CAG48ez2z1R8MLS0_pjhBSGnJC8RwaHMpiGdv8GhJUCrwtsLOPg@mail.gmail.com>
Subject: Re: [PATCH 3/4] mmap locking API: Don't check locking if the mm isn't
 live yet
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Michel Lespinasse <walken@google.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 2:30 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> On Tue, Sep 29, 2020 at 06:20:00PM -0700, Jann Horn wrote:
> > In preparation for adding a mmap_assert_locked() check in
> > __get_user_pages(), teach the mmap_assert_*locked() helpers that it's fine
> > to operate on an mm without locking in the middle of execve() as long as
> > it hasn't been installed on a process yet.
>
> I'm happy to see lockdep being added here, but can you elaborate on
> why add this mmap_locked_required instead of obtaining the lock in the
> execv path?

My thinking was: At that point, we're logically still in the
single-owner initialization phase of the mm_struct. Almost any object
has initialization and teardown steps that occur in a context where
the object only has a single owner, and therefore no locking is
required. It seems to me that adding locking in places like
get_arg_page() would be confusing because it would suggest the
existence of concurrency where there is no actual concurrency, and it
might be annoying in terms of lockdep if someone tries to use
something like get_arg_page() while holding the mmap_sem of the
calling process. It would also mean that we'd be doing extra locking
in normal kernel builds that isn't actually logically required.

Hmm, on the other hand, dup_mmap() already locks the child mm (with
mmap_write_lock_nested()), so I guess it wouldn't be too bad to also
do it in get_arg_page() and tomoyo_dump_page(), with comments that
note that we're doing this for lockdep consistency... I guess I can go
change this in v2.
