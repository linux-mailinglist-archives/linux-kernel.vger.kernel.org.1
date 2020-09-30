Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8DB27F5BD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 01:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732102AbgI3XM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 19:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732094AbgI3XM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 19:12:27 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C79C0613D0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 16:12:27 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t7so800850pjd.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 16:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GcGfH7kHx9j3QvyhQc4NcbAnPXZ+xitJlnC9m04nhjQ=;
        b=gm5u2PcQKPEnnJP1IJQaMsMKmuVSqh4mDV+SE3B7HkfYd1s4DfKRJ5JPUSmnYUHwJ8
         a+XP4WcTYmVhx04y548/+0CYzCszHMJsUlfqTuWHhOFXsePMVlmUXi21FLje4PBXRm98
         Jo1/sYLM65/hhSixFbPryuAHtryh7BTjsn8Us=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GcGfH7kHx9j3QvyhQc4NcbAnPXZ+xitJlnC9m04nhjQ=;
        b=fphYKNjOJafcmHj7T9cLadtMZE5G0cXR04q4XtUtWdgotrHGpcPbSFIDLTOUX44BB2
         +ox5TbFJmcCEmQHVZKHG+1x/7vc6iTLktLAWo8IIpPHKoGHkZ+94perxEQvbr1yHYZip
         su2w1fgYfhIQ+DM3b9JFXJxDgeRwcjrodEFdJuBQu8ba94hrSEbG5uiu+K6/eQ2ZZQi9
         +celFgSEoCwcwnGKqyr+zcQrh3zEJUgk1WSMHJojA68WLgcPl9gz18bSzuYgEpmmqUTA
         2ZXMHL2AxJimMohYqldTeRmtN6qLPpaBj+Rnu6+kbxeDlcXDFnNB2TbTEuZ7rfEZ4Pdm
         hDyw==
X-Gm-Message-State: AOAM532XGt9YQTFIWCes12vbdR47C5MOQooUQs4sStZYiCv5WknwUtlz
        VIEv+y4a03QEOuPOwZ5+gVLOXg==
X-Google-Smtp-Source: ABdhPJzERV8mYc2Hm3YRyOthOTUpcKBJEFFaKP6HXJWxaQaOtJgHHdz5S1SjWX7xipFAAf48W71nEw==
X-Received: by 2002:a17:90a:cf13:: with SMTP id h19mr941884pju.88.1601507546488;
        Wed, 30 Sep 2020 16:12:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q15sm1321933pjp.26.2020.09.30.16.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 16:12:25 -0700 (PDT)
Date:   Wed, 30 Sep 2020 16:12:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jann Horn <jannh@google.com>
Cc:     YiFei Zhu <zhuyifei1999@gmail.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        David Laight <David.Laight@aculab.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>
Subject: Re: [PATCH v3 seccomp 5/5] seccomp/cache: Report cache data through
 /proc/pid/seccomp_cache
Message-ID: <202009301559.49BEDB79D@keescook>
References: <cover.1601478774.git.yifeifz2@illinois.edu>
 <d3d1c05ea0be2b192f480ec52ad64bffbb22dc9d.1601478774.git.yifeifz2@illinois.edu>
 <CAG48ez0whaSTobwnoJHW+Eyqg5a8H4JCO-KHrgsuNiEg0qbD3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez0whaSTobwnoJHW+Eyqg5a8H4JCO-KHrgsuNiEg0qbD3w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 01, 2020 at 12:00:46AM +0200, Jann Horn wrote:
> On Wed, Sep 30, 2020 at 5:20 PM YiFei Zhu <zhuyifei1999@gmail.com> wrote:
> [...]
> > diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> [...]
> > +int proc_pid_seccomp_cache(struct seq_file *m, struct pid_namespace *ns,
> > +                          struct pid *pid, struct task_struct *task)
> > +{
> > +       struct seccomp_filter *f;
> > +
> > +       /*
> > +        * We don't want some sandboxed process know what their seccomp
> > +        * filters consist of.
> > +        */
> > +       if (!file_ns_capable(m->file, &init_user_ns, CAP_SYS_ADMIN))
> > +               return -EACCES;
> > +
> > +       f = READ_ONCE(task->seccomp.filter);
> > +       if (!f)
> > +               return 0;
> 
> Hmm, this won't work, because the task could be exiting, and seccomp
> filters are detached in release_task() (using
> seccomp_filter_release()). And at the moment, seccomp_filter_release()
> just locklessly NULLs out the tsk->seccomp.filter pointer and drops
> the reference.

Oh nice catch. Yeah, this would only happen if it was the only filter
remaining on a process with no children, etc.

> 
> The locking here is kind of gross, but basically I think you can
> change this code to use lock_task_sighand() / unlock_task_sighand()
> (see the other examples in fs/proc/base.c), and bail out if
> lock_task_sighand() returns NULL. And in seccomp_filter_release(), add
> something like this:
> 
> /* We are effectively holding the siglock by not having any sighand. */
> WARN_ON(tsk->sighand != NULL);

Yeah, good idea.

-- 
Kees Cook
