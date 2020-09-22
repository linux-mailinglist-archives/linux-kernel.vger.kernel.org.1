Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14792273983
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 05:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbgIVD5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 23:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728897AbgIVD5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 23:57:50 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19438C061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 20:57:50 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id p24so4516246vsf.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 20:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EkUjUieCb6XRK6uMlDV2dbwExrL7ULDE403JBTQMbwM=;
        b=dPC6uIvpOEmGqHW4WivurYxYCFSJHZfgFJDFtzIWLMhx4cIEIxkN/KxiBhD5WJaVz2
         aifgipxlkEm0y9WvPjFzVOZIfyBxc5IyvAKjZt/3hAYP5Lk4E4O8uOgNLin3Htyr+np8
         sjtOgr918HNnA067xHasLX5RdXcQSi7kyAQw9wkrtx1bVAfAPEeFb3+mLXHgeLE+K3kg
         RBSUvRiojkRrFyfZV0/TeqgoH4JRDbg4mQBUEplTB/iTdeDnQQBLx8V8Sdsq6ttEvOsp
         Z0ze6VZks1W+IFccjmfAk2nEw+Fpfk/yeeqhhBAIBuRUDW6akbnLG8wwYlshF0Tx/SEe
         I8TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EkUjUieCb6XRK6uMlDV2dbwExrL7ULDE403JBTQMbwM=;
        b=jBlPsJl4tWAI6t9rfvD7joO4gHGk19NxuFqV6OpzPHlIIlaVP1jtfel7+SJpsa7tXc
         75WPkiQoIQR9RsbmgrFCB/dhGaofCz8lGIApNNGLpdVcgsnB+2Jn5kMrkbUMdl5xVO6L
         FNc/H+iPmaWE42NpAKE0V77Ub9jWEuan59WWuwiwO3vwbLsqng5VlZQpbbtMerwiBWjA
         HFT1kdbD9tN0ndYeKL8haJ2wgxpxZdbVG/cH3tkPi/Ik6mViqRHzdcu4LZRHeSuW0pKd
         PGLwj4UNjbpea7n/w4rTOtbYmoR16fVAjfUdhVHXfkzFAR5UTyOv2o01hiKEsVJH6+Sw
         JxYw==
X-Gm-Message-State: AOAM530+Lx9UrrGExU2Oo/oy8vcW9B07cirov0hAhaNAvyl3kIKNoM6U
        w/hyycfpGD+zJwsGI8MVNSYuubFJuQcnYMA/+SNAGQ5STRaaoA==
X-Google-Smtp-Source: ABdhPJyU2TYRB3f91Xk/UVfh76QqpMtsFxWcw8JGgLpVKKxUbUBGXpHljYCrgcFxuCyBxzOU5dPUe49CKZb7xGPo2Os=
X-Received: by 2002:a67:f90d:: with SMTP id t13mr2207494vsq.60.1600747069091;
 Mon, 21 Sep 2020 20:57:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200921190433.1149521-1-jim.cromie@gmail.com>
 <20200921190433.1149521-2-jim.cromie@gmail.com> <88110ffe6b08a2b403f30f4ea7463d5dad50b80b.camel@perches.com>
In-Reply-To: <88110ffe6b08a2b403f30f4ea7463d5dad50b80b.camel@perches.com>
From:   jim.cromie@gmail.com
Date:   Mon, 21 Sep 2020 21:57:22 -0600
Message-ID: <CAJfuBxz1Qt6xXky7hT2NM6G0XRQ5SEQii7ydNJRMFZmV15o4Yw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dyndbg: dont panic over bad input
To:     Joe Perches <joe@perches.com>
Cc:     Jason Baron <jbaron@akamai.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 1:29 PM Joe Perches <joe@perches.com> wrote:
>
> On Mon, 2020-09-21 at 13:04 -0600, Jim Cromie wrote:
> > This BUG_ON, from 2009, caught the impossible case of a word-char both
> > starting and ending a string (loosely speaking).  A bad (reverted)
> > patch finally hit this case, but even "impossibly bad input" is no
> > reason to panic the kernel.  Instead pr_err and return -EINVAL.
> []
> > diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> []
> > @@ -259,7 +259,10 @@ static int ddebug_tokenize(char *buf, char *words[=
], int maxwords)
> >               } else {
> >                       for (end =3D buf; *end && !isspace(*end); end++)
> >                               ;
> > -                     BUG_ON(end =3D=3D buf);
> > +                     if (end =3D=3D buf) {
> > +                             pr_err("expected non-empty bareword");
>
> missing newline
>
> This message is also unintelligible.
> What is a non-empty bareword?
>
>

hmm, I borrowed the term from perl

en.wiktionary.org =E2=80=BA wiki =E2=80=BA bareword
(programming, chiefly Perl) A sequence of text characters in source
code that do not form a keyword nor part of a quoted string, and may
potentially be interpreted ...

basically, a not-quoted word, a keyword or not-quoted-value

Im open that there might be better terminology.
have any suggestions ?
