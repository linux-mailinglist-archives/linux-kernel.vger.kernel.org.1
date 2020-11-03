Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBD12A3B26
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 04:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbgKCDx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 22:53:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbgKCDx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 22:53:57 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA553C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 19:53:55 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id m8so11430923ljj.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 19:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hOJLDVXUo2LYw/7eDqVKdvCpcOI5OkMeU4TObpOzbdA=;
        b=nGryO6t7u5LQu5kU9mZ+mS82QJqavaetK3PvEK1jSllCww9cFAOlqgl+ZXOVfolt+6
         Lbel5ZOBIcwr8mB+tOJCTbIvaA0KOFW9hkOfux8hU/Az3HFaHnYrM6wCOc9u4VzQcTnJ
         s7znfJLu3pDWLASwp5KbsfcymSdKDPRwV4/FAM+EKMKdXD2aD5sHEBfZ21UdFW+64tkH
         U6BbzwHdiSshZTRujcM5oF/zpgVjpB2s8FcnsbXCWHAtUh9FJSQozDussSKwrwmC6xpf
         fp6HpolycvO274DYNn8eIzMeftx0Y1hadLn/9eNPo3o9WvDMSAleygzKeFew3uoBgLZi
         gnHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hOJLDVXUo2LYw/7eDqVKdvCpcOI5OkMeU4TObpOzbdA=;
        b=lHiprgLipKeM38p7/A/pouHlfHPUVQKQsP2C39AohAE6w8V6MObAQQJ+H20EFKDYSx
         59lQvQAVQ1R5qZMbz06lSlV+gZzEXsQ9bReEBCwR9bwFAbGskXJlh80r+Li57OklnHGk
         /8fF2bhubnfE/5cXefM0BLlYRBlalIM7g+RNDI8j46U0b4fflaPngvVw9k/Ndus0KG0M
         zEx5Xya28bs3rxx87vtS2PFzIQ2kWhEQ9t2ksZpg+toX577Ym0j1bUmotbk2pnytbb0G
         cPEfo4GZa6R84CVC6cUyftg4XS0uyLwblI1gmQr5nCnASHEdsSY+RbXQ0yR42g23B5za
         NItA==
X-Gm-Message-State: AOAM533lPx/yrCDyuDezIiPHmuxaFw+js0lwwN05pU7/kwkYLHhBagzn
        qVIvmgo5wgl8GFILxLcUt+wDjivdc6R+NLM9DfJYuVXDgRtd0Q==
X-Google-Smtp-Source: ABdhPJytzGrAlZ+geOqqf0gsRtPO+IpgQeE7cjS654fjb4jYrz8aC9GaN67i2t8B+Lxs4h4awY4MB3zEJ1GdtR7omzI=
X-Received: by 2002:a05:651c:1126:: with SMTP id e6mr6168296ljo.47.1604375634057;
 Mon, 02 Nov 2020 19:53:54 -0800 (PST)
MIME-Version: 1.0
References: <20201016225713.1971256-1-jannh@google.com> <20201016225713.1971256-3-jannh@google.com>
 <20201020191540.GM6219@nvidia.com>
In-Reply-To: <20201020191540.GM6219@nvidia.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 3 Nov 2020 04:53:27 +0100
Message-ID: <CAG48ez0XS+0sLLsVg_=hJo6MB1MgSCWvCL03EQ3Ja08d_us+ew@mail.gmail.com>
Subject: Re: [PATCH resend v3 2/2] exec: Broadly lock nascent mm until setup_arg_pages()
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Michel Lespinasse <walken@google.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org, John Hubbard <jhubbard@nvidia.com>,
        Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 9:15 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> On Sat, Oct 17, 2020 at 12:57:13AM +0200, Jann Horn wrote:
> > @@ -1545,6 +1532,18 @@ void setup_new_exec(struct linux_binprm * bprm)
> >       me->mm->task_size = TASK_SIZE;
> >       mutex_unlock(&me->signal->exec_update_mutex);
> >       mutex_unlock(&me->signal->cred_guard_mutex);
> > +
> > +     if (!IS_ENABLED(CONFIG_MMU)) {
> > +             /*
> > +              * On MMU, setup_arg_pages() wants to access bprm->vma after
> > +              * this point, so we can't drop the mmap lock yet.
> > +              * On !MMU, we have neither setup_arg_pages() nor bprm->vma,
> > +              * so we should drop the lock here.
> > +              */
> > +             mmap_write_unlock(bprm->mm);
> > +             mmput(bprm->mm);
> > +             bprm->mm = NULL;
> > +     }
>
> The only thing I dislike about this is how tricky the lock lifetime
> is, it all looks correct, but expecting the setup_arg_pages() or
> setup_new_exec() to unlock (depending!) is quite tricky.
>
> It feels like it would be clearer to have an explicit function to do
> this, like 'release_brp_mm()' indicating that current->mm is now the
> only way to get the mm and it must be locked.

That was a good suggestion; I tried to amend my patch as suggested,
and while trying to do that, noticed that under CONFIG_MMU,
binfmt_flat first does setup_new_exec(), then vm_mmap(), and then
later on setup_arg_pages()...

So your suggestion indeed helped make it clear that my patch was
wrong. Guess I'll have to go figure out how to rearrange the pieces in
binfmt_flat to make this work...
