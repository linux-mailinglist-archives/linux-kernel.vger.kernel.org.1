Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 857FC27F442
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 23:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730506AbgI3Vdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 17:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729792AbgI3Vdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 17:33:43 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83509C0613D0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 14:33:43 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id nw23so4984341ejb.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 14:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=auUqGvs0gHMXAey6wH7F9Apr7r/9WxxEyJFZn6Y4ccM=;
        b=jEZZuulTAkEP8ra+dIdb67z4FyGG96oF+vkHW7GlTvPFyN0nVCVZIn9qGMllZOit52
         xj0H2s8ta9HYmC2xhPb1zHhF4HfH+UhZxwQYGniF7NYVP6OGvTjHST+AO2oYeFOeDzel
         K80B8lQVwG4BEz/c3n+OhRltgv2kxMciDlkUAu7SwpTzBlHY9YZEb+zGocLMIulaTJ3J
         E7rnlY8Jfjcr2wvOlQGr2UqSv2R9Lw2k+Fdc+cXBVe0Ad8TjzEjIzvxQ50rU3fUPEfwn
         gx6czlTmSA/lyvlJ3ErszHDOy3n8+mW25p41M/y9O9bguu9kmnvyQfZQsfnrXknVZngO
         XeRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=auUqGvs0gHMXAey6wH7F9Apr7r/9WxxEyJFZn6Y4ccM=;
        b=YWSH7gCjVzLOJnrxlTHu0+PhZGDpf9MVuV/mntoGKOG/ms1OuayFGfUrfaRZcWc8Ru
         bxEt8p13KLjgpEUNgWJMhbS/kMZ72BwITXLZBFiDaHs1zyaV7d1GFTLkczt2IdN5N6oX
         14TdYGOdIjO70+5x5DHxhHNoZxcdlfHZ6Ln0S0p/4r+lcu79SJnfE9J/oV60B5KaN9Xf
         N7/lHvPticRoJFhFok1wvk2fIM8QdihDIRHim7WOqKbrr6xcIKDcR63tDdtY7CCXb95o
         GbNcnZ/tW6mzMMxBOv98Z2OQ94EVr+4i3lUIRZkeCcmuRm8m/hxFFqe0Ji1uIXeIz2nR
         0ftA==
X-Gm-Message-State: AOAM5316kWZZeHLfEphMY3aTIOdNqUFrOcrDIifd8S3yVwwhOTQ/G+VP
        JamRoqmS7zZ5GMVTP96yKCn2IDHlDHUeQuqQD1UZvQ==
X-Google-Smtp-Source: ABdhPJyMPW38MT/cpIj3rWIUCaLGD/HFhM0te7s40TzgBb3ydM7D9Qbrn6/eFy/iZ1fva2zDw42UX+OK4+/N0TeEOLw=
X-Received: by 2002:a17:907:94cf:: with SMTP id dn15mr5042513ejc.114.1601501622005;
 Wed, 30 Sep 2020 14:33:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1601478774.git.yifeifz2@illinois.edu> <484392624b475cc25d90a787525ede70df9f7d51.1601478774.git.yifeifz2@illinois.edu>
 <202009301418.20BA0CE33@keescook>
In-Reply-To: <202009301418.20BA0CE33@keescook>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 30 Sep 2020 23:33:15 +0200
Message-ID: <CAG48ez3039B+w_D7SJBaGGXw9sd1_SzWO+qUnhMs6tcweGa-+w@mail.gmail.com>
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

On Wed, Sep 30, 2020 at 11:21 PM Kees Cook <keescook@chromium.org> wrote:
> On Wed, Sep 30, 2020 at 10:19:12AM -0500, YiFei Zhu wrote:
> > From: Kees Cook <keescook@chromium.org>
> >
> > Provide seccomp internals with the details to calculate which syscall
> > table the running kernel is expecting to deal with. This allows for
> > efficient architecture pinning and paves the way for constant-action
> > bitmaps.
> >
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > [YiFei: Removed x32, added macro for nr_syscalls]
> > Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>
[...]
> But otherwise, yes, looks good to me. For this patch, I think the S-o-b chain is probably more
> accurately captured as:
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Co-developed-by: YiFei Zhu <yifeifz2@illinois.edu>
> Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>

(Technically, https://www.kernel.org/doc/html/latest/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by
says that "every Co-developed-by: must be immediately followed by a
Signed-off-by: of the associated co-author" (and has an example of how
that should look).)
