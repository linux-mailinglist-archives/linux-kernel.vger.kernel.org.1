Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 070002826D5
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 23:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbgJCVap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 17:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgJCVap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 17:30:45 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FA9C0613D0
        for <linux-kernel@vger.kernel.org>; Sat,  3 Oct 2020 14:30:45 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id x20so3837040ybs.8
        for <linux-kernel@vger.kernel.org>; Sat, 03 Oct 2020 14:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lcSuAPDuR5owltRu+RJj4igLRMjBT0ActUXd/IKaJVQ=;
        b=sOuG2fbgXWfn3Mdv9IcMc1tTr1NqTg1KIp2+mcpJ/MA6BFTsEEPWIEcUOI2FC1zaFM
         NW14U7tBeUn9/qIGFv3q9a+IgUFOldU/eonjBOIgTAgFEtMNT45AkFfvXk07tRgnSUPP
         dsN8ehmwf2swWbW8HcdBJpLyG1Nye/vFZcTXwaO5vFC2VI6Q7xEp7KqQ/NU3PCoXp+ej
         VGmBAxNwXzWlw6dEe/53ECKc8eVu9qN31KHVAKy8iHy+s0lb4wfCfUPrDKKjZMQPmPpE
         Z7dDs6JS6u7BQqUMT8vgdDlYKOINy9e11yTt2W0aSEkEdwPq44yXIuPpeyxOIGMx+9HY
         qS+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lcSuAPDuR5owltRu+RJj4igLRMjBT0ActUXd/IKaJVQ=;
        b=te0cJAIcm/hQV7jXGbVFsW2Tmti9nqUgtYOE4wOdySPUGIxpDjo9P1EU3zPXjvTjMN
         4rPh8o3kPq859QbSvVzl2nIIXkyQ6aUdCA+hWr+6OlkIUEaquEbd4Od/v7vBNaNDRZ9a
         smxdjfzF8yWa93nIgNNgNEVFgNOEzFxdP0R/LzABdYhniei8bQ8+lgWbR4G2Num9MkRO
         qjUgtiiKm6mzaVlovcwL4ZqcdHkC1sFew/6dvwnLnI+UjTMVN5s8W4c77zFMNr5uuqFK
         MbctpiVAsI/OZ6e+USJmgkDvX4XRcvuL2h/hc/28GY9xBVdYIexQOyHT/D2jv0PU8wrN
         nRIw==
X-Gm-Message-State: AOAM533xEilV/MkeD/NM+uOlbf5t1wwQ0ZafrzBpaT4FraXq5352zmu6
        5y4jUF13pbNAorKXCWTPLVoNzyn1ULgWY+wpO1EB0Q==
X-Google-Smtp-Source: ABdhPJyufCi5mVUm8hjg3iNyu72VIpcgco1LGvM7+rVdd/9XqdlFjhzs0SHB5b06m3cdSxM1kiFRG3XHp1Al9pFAv9Y=
X-Received: by 2002:a25:14d5:: with SMTP id 204mr10464626ybu.162.1601760641501;
 Sat, 03 Oct 2020 14:30:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez1+ok5c5PK4DjA6-rYkg9qPeKoRrJmc5jsGf=TZZbShJg@mail.gmail.com>
 <CAG48ez1kMuPUW8VKp=9=KDLVisa-zuqp+DbYjc=A-kGUi_ik3A@mail.gmail.com>
 <CANN689H9hXzaV0_vpFfrvjQD6xAEaPnjok_17zWGHumRNs-ZWg@mail.gmail.com> <CAG48ez2LdreJtHcZBL=t010PghjVECcsat2e2kzgakDvR0ue5w@mail.gmail.com>
In-Reply-To: <CAG48ez2LdreJtHcZBL=t010PghjVECcsat2e2kzgakDvR0ue5w@mail.gmail.com>
From:   Michel Lespinasse <walken@google.com>
Date:   Sat, 3 Oct 2020 14:30:28 -0700
Message-ID: <CANN689H6fQkSXL8U0M-MoSrw8b8cQFMDaTRKr2v8oacZJ_FhKA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmap locking API: Order lock of nascent mm outside
 lock of live mm
To:     Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org, Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 2, 2020 at 9:33 AM Jann Horn <jannh@google.com> wrote:
> On Fri, Oct 2, 2020 at 11:18 AM Michel Lespinasse <walken@google.com> wrote:
> > On Thu, Oct 1, 2020 at 6:25 PM Jann Horn <jannh@google.com> wrote:
> > > Until now, the mmap lock of the nascent mm was ordered inside the mmap lock
> > > of the old mm (in dup_mmap() and in UML's activate_mm()).
> > > A following patch will change the exec path to very broadly lock the
> > > nascent mm, but fine-grained locking should still work at the same time for
> > > the new mm.
> > > To do this in a way that lockdep is happy about, let's turn around the lock
> > > ordering in both places that currently nest the locks.
> > > Since SINGLE_DEPTH_NESTING is normally used for the inner nesting layer,
> > > make up our own lock subclass MMAP_LOCK_SUBCLASS_NASCENT and use that
> > > instead.
> > >
> > > The added locking calls in exec_mmap() are temporary; the following patch
> > > will move the locking out of exec_mmap().
> >
> > Thanks for doing this.
> >
> > This is probably a silly question, but I am not sure exactly where we
> > lock the old MM while bprm is creating the new MM ? I am guessing this
> > would be only in setup_arg_pages(), copying the args and environment
> > from the old the the new MM ? If that is correct, then wouldn't it be
> > sufficient to use mmap_write_lock_nested in setup_arg_pages() ? Or, is
> > the issue that we'd prefer to have a killable version of it there ?
>
> We're also implicitly locking the old MM anytime we take page faults
> before exec_mmap(), which basically means the various userspace memory
> accesses in do_execveat_common(). This happens after bprm_mm_init(),
> so we've already set bprm->vma at that point.

Ah yes, I see the issue now. It would be much nicer if copy_strings
could coax copy_from_user into taking a nested lock, but of course
there is no way to do that.

I'm not sure if it'd be reasonable to kmap the source pages like we do
for the destination pages ?

Adding a nascent lock instead of a nested lock, as you propose, seems
to work, but it also looks quite unusual. Not that I have anything
better to propose at this point though...


Unrelated to the above: copy_from_user and copy_to_user should not be
called with mmap_lock held; it may be worth adding these assertions
too (probably in separate patches) ?


> Uuugh, dammit, I see what happened. Sorry about the trouble. Thanks
> for telling me, guess I'll go back to sending patches the way I did it
> before. :/

Yeah, I've hit such issues with gmail before too :/

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
