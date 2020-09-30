Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBCF027F5C4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 01:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732163AbgI3XPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 19:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732128AbgI3XPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 19:15:54 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94207C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 16:15:54 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id i26so5231044ejb.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 16:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7NtR8Af5mbsnJurMxCwsT1Qowr1kj5d6Fb9bCF6cp9U=;
        b=pw30qPK5acsamYkNqSxjNDViySQWHBINt4pgak0I6oN9BDI2yBlrAFZ7PYx4lB9T7Z
         HSrQSc1m3X5dyYBHGoAmUL/eyRBqa4xUzqWaH7PPDscJ1Ae2Zj08246uHc//sWeYewck
         53vyf72uWa6WOVK8gjf/qYZCkdVIPELn9Fli/FR8OcSgczqjUafRdcOgWuLdh2XYL6bq
         9yo/Wp/DaQt/aD69hGgaaI814TkUEQgm3uAVeUNGSM2dH5tXzayx9rjzSQhya0noqQzX
         nlRgaN7NdT0G8csaLaoJ6G5fx7nFre50Qp1dtsv6Mz5h6A9s/9Z2tcPJRzbi7ACupfCp
         9b6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7NtR8Af5mbsnJurMxCwsT1Qowr1kj5d6Fb9bCF6cp9U=;
        b=QzmIXAZ+L1Um9qAiwo0mALfUgBZPtWYCh/8NqDUY/xNs1VGSs/tKROJQiAG9evDvH5
         z+mU1sVMdEbhDUKA5YQ1gSTx0c/TrKvXncKxUNQ2pNF9tabX97Qppipyqo3n97J+dask
         syL0PXOpWifvG7KdKV+HV+VHf7KLKdsjucDrxEeLRvlS1nPaElpGaL6ACt0/FdhJlqQj
         +OFw9aJ19pJ/LJ4euZ4s0ufCJLn4keGo5e5kO2pr4mQDdMehh+cQpZA8xy1tFw5laaUE
         Vv7onGwpOCD//+4e2RDg0Av+WzD2Rl5M6nSsGe2llRkFQuRCrN5xtJi+Io+u0DmAzEhU
         pecQ==
X-Gm-Message-State: AOAM532hjcxAUS5rkHO77pGEr9w4aed5g9imPUUu2tomKa7LsAkNZXNV
        sjmkvEWls757QCJCzd13nJyVwoktMHHT9HsabUNEFc2cAyo=
X-Google-Smtp-Source: ABdhPJy9ik0VDeL+cu6VtcVQ/+hDXc248kSGiAvJX6+w/4UrgfNPOUORWDEnAsA6QMlkA5tDhYvPNM8Qid/ySYOAIHQ=
X-Received: by 2002:a17:906:980f:: with SMTP id lm15mr5403777ejb.184.1601507753153;
 Wed, 30 Sep 2020 16:15:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1601478774.git.yifeifz2@illinois.edu> <484392624b475cc25d90a787525ede70df9f7d51.1601478774.git.yifeifz2@illinois.edu>
 <202009301418.20BA0CE33@keescook> <CAG48ez3039B+w_D7SJBaGGXw9sd1_SzWO+qUnhMs6tcweGa-+w@mail.gmail.com>
 <202009301549.17D3DE5@keescook>
In-Reply-To: <202009301549.17D3DE5@keescook>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 1 Oct 2020 01:15:26 +0200
Message-ID: <CAG48ez1cj5Ff7CiU5jZetfe0KppPSOUzE-TFKMEZ0JmofL7abw@mail.gmail.com>
Subject: Re: [PATCH v3 seccomp 1/5] x86: Enable seccomp architecture tracking
To:     Kees Cook <keescook@chromium.org>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 1, 2020 at 12:53 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Sep 30, 2020 at 11:33:15PM +0200, Jann Horn wrote:
> > On Wed, Sep 30, 2020 at 11:21 PM Kees Cook <keescook@chromium.org> wrote:
> > > On Wed, Sep 30, 2020 at 10:19:12AM -0500, YiFei Zhu wrote:
> > > > From: Kees Cook <keescook@chromium.org>
> > > >
> > > > Provide seccomp internals with the details to calculate which syscall
> > > > table the running kernel is expecting to deal with. This allows for
> > > > efficient architecture pinning and paves the way for constant-action
> > > > bitmaps.
> > > >
> > > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > > [YiFei: Removed x32, added macro for nr_syscalls]
> > > > Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>
> > [...]
> > > But otherwise, yes, looks good to me. For this patch, I think the S-o-b chain is probably more
> > > accurately captured as:
> > >
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > Co-developed-by: YiFei Zhu <yifeifz2@illinois.edu>
> > > Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>
> >
> > (Technically, https://www.kernel.org/doc/html/latest/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by
> > says that "every Co-developed-by: must be immediately followed by a
> > Signed-off-by: of the associated co-author" (and has an example of how
> > that should look).)
>
> Right, but it is not needed for the commit author (here, the From:),
> the second example given in the docs shows this:

Aah, right. Nevermind, sorry for the noise.
