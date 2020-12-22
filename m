Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 528082E0D55
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 17:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbgLVQYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 11:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbgLVQYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 11:24:04 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34507C0613D6;
        Tue, 22 Dec 2020 08:23:24 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id d9so12460066iob.6;
        Tue, 22 Dec 2020 08:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ANErGQVIqQj48QsZur9ujVXtxW39rQn+lJjWeUAYdrA=;
        b=veeydcPeh0M2CCM3R/Rh0jUfggTZDkL8vqlYZxVAiCvkzpGWTEZ614+2DnsCHMmlz3
         pQMKSKTCZDlI40VbP2PmVD6SvrYFINcKscFIY/MXeJDR63rAFqGVP1+jwSwVx4QcXd65
         GU5QAE7gY6Tbcrt7HaFXvzavk7xeSwlu7vbC9S5bGWwNCnLVbtj4pdATxlEpQ/mCr+pG
         31OGYoIVphYuh8wbdZ4qgLjp7QidVe8iEnTJBtyMLFnrglMZ0MAQppx1GobNoHof810i
         S1876VV7fWF7H2CvpdNV0srMdydKxnOcCVFwG+BO1qkBuGqsDWczT8oyFSCu/tLaeynS
         2Orw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ANErGQVIqQj48QsZur9ujVXtxW39rQn+lJjWeUAYdrA=;
        b=S1Zik3QputyUYnmoGXRm/TbwgEYl35Nx++FAVBHHFW71AWcSVdknhabfPmgcQIpOpb
         9kmD/86IduCLfryZvn4tl1pFAx53JF6NSb8ZpFjZxV0OEkys3o6sfc9XYRhWWdjcaoHO
         UXDofnevBUp3JVOoTT+95T+m6QtPoVnkWiz+KCD7Vd6SciKLHYbatcRHOLiDe+DMX0rt
         5dOQ/N4sZZF5++peiwPHdlr9msC+t9q6BdTLaJqOuMNaMZ5+tZvpEb/Qkbv/4pXmoY5R
         3LLRKNyrZVdo1rCkjG2IOtgNAQlni5w23QXSfvTdGZWAyuB7uo6ZqzYCDNib5WNEH13n
         3o7g==
X-Gm-Message-State: AOAM5330ytPjISvm5KFaOvryz5ZaxCVpoyizguzUAm7r8shKO9GYz4Kl
        8HO4FPH+J7fMiaz3FK0GEDf0i7cGNSyWL0o7RC79AakKuZw=
X-Google-Smtp-Source: ABdhPJzhlQMVpEILVIPZ4JARLz6t9lY6qdQHVYRORmaQ6AhXWklFhgpJy6oI+dXqc9s8dBMn078l7xs0TMk8vnh+yHk=
X-Received: by 2002:a6b:6d1a:: with SMTP id a26mr18703014iod.158.1608654203503;
 Tue, 22 Dec 2020 08:23:23 -0800 (PST)
MIME-Version: 1.0
References: <1608064956-5512-1-git-send-email-milan.lakhani@codethink.co.uk> <20201221095209.4dd4233e@lwn.net>
In-Reply-To: <20201221095209.4dd4233e@lwn.net>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Tue, 22 Dec 2020 17:23:18 +0100
Message-ID: <CAKXUXMwR9i5bJx+_rXkv4SK0yU1cHpGexH9RjsN7UFqJ-Ozsew@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation: process: Correct numbering
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Milan Lakhani <milan.lakhani@codethink.co.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-safety@lists.elisa.tech,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 21, 2020 at 5:52 PM Jonathan Corbet <corbet@lwn.net> wrote:
>
> On Tue, 15 Dec 2020 20:42:36 +0000
> Milan Lakhani <milan.lakhani@codethink.co.uk> wrote:
>
> > Renumber the steps in submit-checklist.rst as some numbers were skipped.
> >
> > Fixes: 72deb455b5ec ("block: remove CONFIG_LBDAF")
> > Signed-off-by: Milan Lakhani <milan.lakhani@codethink.co.uk>
> > ---
> >  Documentation/process/submit-checklist.rst | 24 ++++++++++++------------
> >  1 file changed, 12 insertions(+), 12 deletions(-)
> >
> > diff --git a/Documentation/process/submit-checklist.rst b/Documentation/process/submit-checklist.rst
> > index 1879f88..230ee42 100644
> > --- a/Documentation/process/submit-checklist.rst
> > +++ b/Documentation/process/submit-checklist.rst
> > @@ -75,44 +75,44 @@ and elsewhere regarding submitting Linux kernel patches.
> >  13) Has been build- and runtime tested with and without ``CONFIG_SMP`` and
> >      ``CONFIG_PREEMPT.``
> >
> > -16) All codepaths have been exercised with all lockdep features enabled.
> > +14) All codepaths have been exercised with all lockdep features enabled.
> >
> > -17) All new ``/proc`` entries are documented under ``Documentation/``
> > +15) All new ``/proc`` entries are documented under ``Documentation/``
> [...]
>
> I've applied this, but, if you're going to stick a "Fixes" tag onto a
> patch, it's probably only polite to copy the original author.  I'm not
> fully convinced that the tag is warranted in this case.
>
> This document seems out of date in a number of ways; it could really use a
> rather more thorough updating than this.
>

Jon, I completely agree on your out-of-date comment. That is why we
pointed Milan to that checklist to start with some small basic changes
and continue with increasingly more challenging and complex updates.

Milan, next update for you to consider: what does "make headers_check"
do nowadays? (spoiler alert: it does nothing) Adjust the documentation
for that.

Then, a more general improvement: think about structuring the
checklist to follow the structure of the other submission guidelines.
So, reorder the current checklist and check if the step is mentioned
in submitting-patches and where and make the checklist much more
aligned to submitting-patches.

Lukas
