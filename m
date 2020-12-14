Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8EE32D940B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 09:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439190AbgLNIQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 03:16:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439172AbgLNIQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 03:16:41 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65231C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 00:16:01 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id o13so4742938lfr.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 00:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kEiE91xjRqboMrMOwQRljc3YWAqftJK41N5HKM4igOI=;
        b=qMC1JGRLHRSKZk7A0uPJZuKKHNe9dwIqCU8m2Aak3TIgIoCD+87Tw3UFPGaBxxsOTw
         gN8YsFgbapfW6ZJ+GYnIdg1M8tuCcDaFhabiy2Ov7KlZdf2gi7GetmqLOSVppOLTNly1
         7gQURnVyKGwgLn6qM74nyfDhiGWKc53k1BuU5gUTVVXpWNbVbF1lp2hHS3pYt15/jRuG
         19O4WXrLBL8VXGAJoT4ezEVxO+YYi0Krg4tUto6/Y9Ut5krgkXXGirnJ080BP2ESvBQb
         VEjDi8pWWL3dP0nTfatZJmUxrLh56+EHICVyDykQ/pwjL8EcZ2r76bj8rnyhubSmt4Sk
         sUjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kEiE91xjRqboMrMOwQRljc3YWAqftJK41N5HKM4igOI=;
        b=H2c04vthoifsl+eFgp2ZNDakwacCKhIJ2U+paxlodYSUi++R+bQwWd/Hp1nnHYE6iH
         CXQwvp1H0rvQtVGkAdoFLINVqrPKNSXpGzTlWuqYl6GVpJpLnDdlLuaNoIs6taqVK9xI
         l7+J8WjiI2G3nUkZgOBJtAkxhGSvJ6k502ZrdTNhbn0PGIfmne3P4cW4bPmK1vLrnYwl
         e3N867pZS2v0VzHKQxBkM0zkZxG9Pt2p1IC5jtzeDrWi0dzKtPqRyp2oGnmpknzJsRlg
         IQ41zoJAVqM7zB79mHhjLKNpZ+5JDU6iWiwOAH95Pt0FrMM43CpqKB0u330MM9KKq4s1
         sSLA==
X-Gm-Message-State: AOAM531EtuFGTYASTJ5cB7rHGdna1aPyTjQCGXPZdqQiKEEVOnvJC9SQ
        Q0YwrXP2K7YCyzxJZ9n281s2dKKJgFyGCL2C1an+yJ5WRY7xfg==
X-Google-Smtp-Source: ABdhPJwDU7ibn9oG1GanMUbhBQ5WoLOAXgBhCIkuXq0Epl+FlNMWE81UC7IubVVxtXT8C1uF4Nr7AXKqhhTQVHc8twk=
X-Received: by 2002:ac2:47e7:: with SMTP id b7mr5985963lfp.117.1607933759850;
 Mon, 14 Dec 2020 00:15:59 -0800 (PST)
MIME-Version: 1.0
References: <20201214075831.34282-1-dwaipayanray1@gmail.com> <fa376fd6d0b70f98f1d52f61f2f35f5890ec7e81.camel@perches.com>
In-Reply-To: <fa376fd6d0b70f98f1d52f61f2f35f5890ec7e81.camel@perches.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Mon, 14 Dec 2020 13:45:37 +0530
Message-ID: <CABJPP5Dn1+U_eqeJy+UARbRK5_Q3p8HCH_xERWZvxYifoX6brA@mail.gmail.com>
Subject: Re: [PATCH] scripts: add more corrections to spelling.txt
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14, 2020 at 1:39 PM Joe Perches <joe@perches.com> wrote:
>
> On Mon, 2020-12-14 at 13:28 +0530, Dwaipayan Ray wrote:
> > Analyzing misspellings over the past 10k commit messages,
> > a few more corrections are added to spelling.txt
>
> I don't agree with all of these.
>
> > diff --git a/scripts/spelling.txt b/scripts/spelling.txt
> []
> > @@ -1253,6 +1260,7 @@ senarios||scenarios
> >  sentivite||sensitive
> >  separatly||separately
> >  sepcify||specify
> > +seperate||separate
> >  seperated||separated
> >  seperately||separately
> >  seperate||separate
>
> seperate is already here.
>
> > @@ -1482,6 +1493,8 @@ unuseful||useless
> >  unvalid||invalid
> >  upate||update
> >  upsupported||unsupported
> > +upto|| up to
>
> No space before correction
>
> > +uptodate||up-to-date
>
> This one is fairly commonly used as an identifier so it should not
> be added here.
>
> > @@ -1528,8 +1543,11 @@ wiil||will
> >  wirte||write
> >  withing||within
> >  wnat||want
> > +wont||won't
>
> wont is a properly spelled word and also should not be added here.
>

Okay thanks, will replace those.

Also please ignore the v2 of this patch. That was sent earlier your review.
I will send in a v3 to fix these.

Thank you,
Dwaipayan.
