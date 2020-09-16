Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C891326BDB8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 09:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgIPHMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 03:12:39 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40434 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbgIPHMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 03:12:37 -0400
Received: by mail-wm1-f65.google.com with SMTP id k18so1769972wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 00:12:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iltSbkYCjMyL9scIVNsPpJhoH89KP44GjCnLHdx3WGo=;
        b=XseuHRIEAfBJIhSRamHybtoDG1/8S6Umkp+kdpQzx5CKR2zCHtoML0rGaBEj4imgoo
         TGZoobFkXw1bL4Hby7xiNplPpT4IWzQU+JOuLUYES/QZx1npfnXMy4pI/xU8xwxLTbdv
         fKNmQWRSFVvMNfGWruD5v6Od3e8HN8R/IUJVgS4C9Jld+cQluQRoqlGBrGfjO0xiDt4K
         12sE1zp+YWZLL84xHv0Q504NQakBW0PQbJBF70mXXCg5ySL7iy8bg7NxpITYUlbNW7v6
         oeXnq9tJNj6lpzkE33+8ZnzoF9CLZQc91vsuvTRfATL3QrYqa9mqeb03jIlo0Fz4kH+3
         mOnA==
X-Gm-Message-State: AOAM531O1X05b/l6bNATiMQ1zC9Al2IC5vOw0A0uo9S/oE7ZeWSylrib
        mQJUPNQW5sapqrLcJbLvKE5i9hw3qk+ZlyFkzaY=
X-Google-Smtp-Source: ABdhPJydW40v/gfHXsm7vfKEIq4jHEDPoXd8XxG5o5S1wdU69iH3gF46CUt6obLWeYwV/DFk5jZHXPGpGOOYPg0qFgM=
X-Received: by 2002:a7b:c404:: with SMTP id k4mr3077191wmi.168.1600240355921;
 Wed, 16 Sep 2020 00:12:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200915031819.386559-1-namhyung@kernel.org> <20200915031819.386559-6-namhyung@kernel.org>
 <20200915121912.GF720847@kernel.org> <CAP-5=fXwuS_GAjnQgBav=Ugc26OACimUmbhtAHbeThb_BEk0UQ@mail.gmail.com>
 <0679eacce01f187037e726a45e6acdacde61f99d.camel@redhat.com>
In-Reply-To: <0679eacce01f187037e726a45e6acdacde61f99d.camel@redhat.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 16 Sep 2020 16:12:24 +0900
Message-ID: <CAM9d7cgtDq8yOFDEGEdTD9kN=Ko1gX=5o+tAB4+EDtN0WtGQPw@mail.gmail.com>
Subject: Re: [PATCH 05/11] perf parse-event: Fix memory leak in evsel->unit
To:     David Malcolm <dmalcolm@redhat.com>
Cc:     Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ian and David,

Thank you for the good suggestions!

On Wed, Sep 16, 2020 at 4:56 AM David Malcolm <dmalcolm@redhat.com> wrote:
> Some ideas (with the caveat that I'm a GCC developer, and not a regular
> on LKML): can you capture the ownership status in the type system?
> I'm brainstorming here but how about:
>   typedef char *owned_string_t;
>   typedef const char *borrowed_string_t;
> This would at least capture the intent in human-readable form, and
> *might* make things more amenable to checking by a machine.  It's also
> less macro cruft.
> I take it that capturing the ownership status with a runtime flag next
> to the pointer in a struct is too expensive for your code?

Adding more random thoughts..

I think we can make it more generic like __attribute__((owned))
so that it can be applied to any pointers.  And we can use a
conventional macro like '__owned' in the declaration..

__owned char *name;
__owned char *strdup(const char *);
...

Thanks
Namhyung
