Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC47D2817FE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 18:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387974AbgJBQdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 12:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbgJBQdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 12:33:54 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A38DC0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 09:33:54 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id l24so2283471edj.8
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 09:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5SVFNy1oh9mYZaze1/AxVhEs3Bssp/B/apnHoAiZ48k=;
        b=al9p87J+2nxtEoL5mL7fBOjKzyzi+xyjcQuKCNKeqVDl0CLxxJqeQrgM+2eINtL1M2
         Igo7k0g13Xh6JcyPO1fMYP4UYEnWIuNRX/otgCKdIM6AcbtuisbtWyOKlZWQNFmzabAB
         DbsgUPEDX4Nfu4Xo9kym9GzzWqDB4xnvK3NtaSHB52+/WW4gKkBh+p6SzsiBX+UpMkRN
         oBvj4bysMC4KMW9Xtsi/hWzpOLbROGKs0kiAFruMJKLIujz9XcjgYPLvgj0JG/vyW/kH
         Q19nHdVl6lA1ohWvA4O/AZdDHtOf7u+z6vlEUNUPk4unObMEw7SZp2AhF71zhoyr0opR
         OgsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5SVFNy1oh9mYZaze1/AxVhEs3Bssp/B/apnHoAiZ48k=;
        b=mQm7S0mqQq/sAU+XgFFN5Xqk2Vj00SVI6rI4blkGC5vrqPS/UxI2dq5xPaVFYYYCS3
         +54eL+vz1FA28BlncYi2S/G3QdPFTsfumVR8Gai3yoq8pNNTVjHqEsLs0NeOHxm8Rlpx
         T7YovSH0jqU82ieJ7jp7JpmS8nAe5qxTosTkxlijK1KmMuN3P36QOMVdom8wnqyt0Of/
         VpqMj33J6yaMpuryIZ2IPe+zI3DPr5tZL+2vbvEGXEVTtgraGe3RfL2expytKm7QcHXg
         Dze6NasLl1dQliMW+HuetX0miITYPJJZo4qeqqhb6+CwJ53zR38UQeZZ2eszvZEj7T/k
         xkZg==
X-Gm-Message-State: AOAM532SWUzPTyhZXCbSkYuQ1mT0KG8M0SxvNW7+ONqhjoioiSP95Jfs
        yKEajqqhwM34EcGWGUinJYAAdZ91B3Rk4/kToRgcyi0vRLDPZQ==
X-Google-Smtp-Source: ABdhPJxQHPBBBJWXb3LmBeXtJgTGTETOWYtvI23S3mg2BLYAfuoIDdjw/DYbTO6arsLsUUM8JB6TAd2eJK36q0WtCJE=
X-Received: by 2002:a50:fe98:: with SMTP id d24mr3157020edt.223.1601656432627;
 Fri, 02 Oct 2020 09:33:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez1+ok5c5PK4DjA6-rYkg9qPeKoRrJmc5jsGf=TZZbShJg@mail.gmail.com>
 <CAG48ez1kMuPUW8VKp=9=KDLVisa-zuqp+DbYjc=A-kGUi_ik3A@mail.gmail.com> <CANN689H9hXzaV0_vpFfrvjQD6xAEaPnjok_17zWGHumRNs-ZWg@mail.gmail.com>
In-Reply-To: <CANN689H9hXzaV0_vpFfrvjQD6xAEaPnjok_17zWGHumRNs-ZWg@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 2 Oct 2020 18:33:26 +0200
Message-ID: <CAG48ez2LdreJtHcZBL=t010PghjVECcsat2e2kzgakDvR0ue5w@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmap locking API: Order lock of nascent mm outside
 lock of live mm
To:     Michel Lespinasse <walken@google.com>
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

On Fri, Oct 2, 2020 at 11:18 AM Michel Lespinasse <walken@google.com> wrote:
> On Thu, Oct 1, 2020 at 6:25 PM Jann Horn <jannh@google.com> wrote:
> > Until now, the mmap lock of the nascent mm was ordered inside the mmap lock
> > of the old mm (in dup_mmap() and in UML's activate_mm()).
> > A following patch will change the exec path to very broadly lock the
> > nascent mm, but fine-grained locking should still work at the same time for
> > the new mm.
> > To do this in a way that lockdep is happy about, let's turn around the lock
> > ordering in both places that currently nest the locks.
> > Since SINGLE_DEPTH_NESTING is normally used for the inner nesting layer,
> > make up our own lock subclass MMAP_LOCK_SUBCLASS_NASCENT and use that
> > instead.
> >
> > The added locking calls in exec_mmap() are temporary; the following patch
> > will move the locking out of exec_mmap().
>
> Thanks for doing this.
>
> This is probably a silly question, but I am not sure exactly where we
> lock the old MM while bprm is creating the new MM ? I am guessing this
> would be only in setup_arg_pages(), copying the args and environment
> from the old the the new MM ? If that is correct, then wouldn't it be
> sufficient to use mmap_write_lock_nested in setup_arg_pages() ? Or, is
> the issue that we'd prefer to have a killable version of it there ?

We're also implicitly locking the old MM anytime we take page faults
before exec_mmap(), which basically means the various userspace memory
accesses in do_execveat_common(). This happens after bprm_mm_init(),
so we've already set bprm->vma at that point.

> Also FYI I was going to play with these patches a bit to help answer
> these questions on my own, but wasn't able to easily apply them as
> they came lightly mangled (whitespace issues) when I saved them.

Uuugh, dammit, I see what happened. Sorry about the trouble. Thanks
for telling me, guess I'll go back to sending patches the way I did it
before. :/

I guess I'll go make a v2 of this with some extra comment about where
the old MM is accessed, as Jason suggested, and without the whitespace
issues?
