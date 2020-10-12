Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0B3628BEEE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 19:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404104AbgJLRTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 13:19:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:45962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403963AbgJLRTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 13:19:09 -0400
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01FA4208B8;
        Mon, 12 Oct 2020 17:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602523149;
        bh=wl0o+SYD4qRU8FNYmgCsWz7TjkIKtNRRG6C2CoCtz6Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Gx3Cn0CmLBl1Zhh5JnMbZlpAzcM36fenhtbQLPaXa/YB8ML+cYsXa/nZ8YorZOzPT
         Oc1oZdHarNSFmdSY+Ka1wsxZp9AagB+/zuVxZCfzeUR4Ms0HGnix+AoXiP1f/gdUhZ
         okLszCn2/qjagh+zRk/ReDFBAceKeekY17i5OJ60=
Received: by mail-ej1-f51.google.com with SMTP id c22so24318739ejx.0;
        Mon, 12 Oct 2020 10:19:08 -0700 (PDT)
X-Gm-Message-State: AOAM530fJ8EKk1ntKB4J4MYbzzYClE9qFgFTrlZ2poRax2CS9tuqHgZb
        t5tz/3Km6SfLYGQJnnNc/npsQRP9X7RKfPDYv/M=
X-Google-Smtp-Source: ABdhPJzT2zTp6/dBYTUl1DVU5Qnm36/KSZ1tOBUj/D0oj3p+j9jBoqk1ddp9KI22QbA+Wp/V96EMVQb2D1RVmc13yqY=
X-Received: by 2002:a17:906:6a07:: with SMTP id o7mr28963825ejr.454.1602523147452;
 Mon, 12 Oct 2020 10:19:07 -0700 (PDT)
MIME-Version: 1.0
References: <20201007084306.12591-1-krzk@kernel.org> <20201009093804.7a130063@lwn.net>
In-Reply-To: <20201009093804.7a130063@lwn.net>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 12 Oct 2020 19:18:55 +0200
X-Gmail-Original-Message-ID: <CAJKOXPe5Jw7iXmai234Za=x3X5qXDyGM1ECVtQcNuL+0cXyP3A@mail.gmail.com>
Message-ID: <CAJKOXPe5Jw7iXmai234Za=x3X5qXDyGM1ECVtQcNuL+0cXyP3A@mail.gmail.com>
Subject: Re: [PATCH] docs: submitting-patches: describe preserving review/test tags
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-doc@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Oct 2020 at 17:38, Jonathan Corbet <corbet@lwn.net> wrote:
>
> On Wed,  7 Oct 2020 10:43:06 +0200
> Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> > From time to time, the novice kernel contributors do not add Reviewed-by
> > or Tested-by tags to the next versions of the patches.  Mostly because
> > they are unaware that responsibility of adding these tags in next
> > version is on submitter, not maintainer.
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  Documentation/process/submitting-patches.rst | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
> > index 58586ffe2808..9752b6311674 100644
> > --- a/Documentation/process/submitting-patches.rst
> > +++ b/Documentation/process/submitting-patches.rst
> > @@ -527,6 +527,13 @@ done on the patch.  Reviewed-by: tags, when supplied by reviewers known to
> >  understand the subject area and to perform thorough reviews, will normally
> >  increase the likelihood of your patch getting into the kernel.
> >
> > +Both Tested-by and Reviewed-by tags, once received on mailing list from tester
> > +or reviewer, should be added by author to the applicable patches when sending
> > +next versions.  However if the patch is changed in following version, these
> > +tags might not be applicable anymore and thus should be removed.  Usually
> > +removal of someone's Tested-by or Reviewed-by tags should be mentioned
> > +in the patch changelog (after '---' separator).
>
> after *the* "---" separator
>
> This is a bit ambiguous, though, since the point of sending a new version
> of a patch is usually that it has changed.  I'm not quite sure how to best
> articulate when a patch has changed enough that reviews and such are no
> longer applicable...  If nothing else, "if the patch *has changed
> substantially*" or something like that?

Yes, it is ambiguous because different people see the amount of
changes invalidating tags differently. I do not think we could make
the paragraph above stricter and formalize such rule. I'll rework it
to match your choice of wording.

Best regards,
Krzysztof
