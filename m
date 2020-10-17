Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 241BD2912D1
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 18:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437869AbgJQQBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 12:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437772AbgJQQBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 12:01:47 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1D3C061755
        for <linux-kernel@vger.kernel.org>; Sat, 17 Oct 2020 09:01:47 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id u17so6532204oie.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Oct 2020 09:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R8NJjCBei+UeB+MzclJEuZNeo91P2U/6rtV8C+ufyxg=;
        b=NVi5G2gKtCf6TCnZ/ONOCXsNWjiFdBP0ydbzYseoJ3VLIQH13OBdVGeWKcFFsWWtld
         w525JKCWohJY7QI6fuRIOWWCPrGXQFXoUGx7AkvQvBY3czBqXZKj8ThL8UdWUHGys7iq
         leQWHq1y1ZrcQMFkYH8r7LauNMDE7lqvjALSYf0PTqoXYDMAjSTyXD3JIbbmNx/FM0mp
         GbmxrjUq7W9Y2K4ENpaqGdHBEKT0bKx09lCg6vu4cK15X2iz8qXIFNQy9MOH0jwMVmTY
         /jbUSa5nSg7nSSk+JDzjozosufT0KtlGDBCl6nXuwUVQIUY1zFygAFWtWNwIUjxEj04l
         sTBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R8NJjCBei+UeB+MzclJEuZNeo91P2U/6rtV8C+ufyxg=;
        b=jXcvOWsyh1yfHHl/PK8Vhzf/G4xkV+wlQ2ddOVWzf0eJ3JUqn9tpVLLNWBYuNVJ5Bg
         K9ZcaVmdrPyLgJSu7cI0a6cuDtmJym3TQZFEwB4Nsq2hWL0FIHckF01/gxVXF2Dtwafe
         YE8QwbzxIdrej3WCk5zmvoNATOl922qdN0c7aJRjXnXtOjvSHzaCocUll2hhAjkBI7Pc
         jdHsg83HXOe2nxUY4vfCoqAUU5UyOM9V0F+sApvEdW0rhpaJ/xKN/GM4cGdpYOUUFnxl
         fZkyrPT8u9UQPlEGrKjlBOieCGvWoOoKYGC+g8xxOtlEYY8ikyj6sQDM7XrwvJAwOHKv
         YJag==
X-Gm-Message-State: AOAM530NYs0aKv7gE6ldnBAHKna06brV1kWdEOE80z3rVMK1FZH7g1lp
        U6JeWtgVMTLFxX8qOqCF46Tm3AWKe5pHnjGsE31OTat41geWFw==
X-Google-Smtp-Source: ABdhPJzTQqZq9xS5kTWm5FNhbsDhaK+z8sbQx7cgtbVS/GqXobJFxXC0QmXtkopAadkJ5xtfbWehRsZeyCX4e7l2tbY=
X-Received: by 2002:aca:420a:: with SMTP id p10mr5785693oia.117.1602950506500;
 Sat, 17 Oct 2020 09:01:46 -0700 (PDT)
MIME-Version: 1.0
References: <20201017075131.47566-1-dwaipayanray1@gmail.com> <d2254db39f798b408bdd16237c86dea1617bcfac.camel@perches.com>
In-Reply-To: <d2254db39f798b408bdd16237c86dea1617bcfac.camel@perches.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Sat, 17 Oct 2020 21:31:20 +0530
Message-ID: <CABJPP5DkJbPZCkXdOewFjvZhS5gYmEfjSK8m3ZpZsR7sAvQ+8A@mail.gmail.com>
Subject: Re: [PATCH v4] checkpatch: add new exception to repeated word check
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 17, 2020 at 9:24 PM Joe Perches <joe@perches.com> wrote:
>
> On Sat, 2020-10-17 at 13:21 +0530, Dwaipayan Ray wrote:
> > Recently, commit 4f6ad8aa1eac ("checkpatch: move repeated word test")
> > moved the repeated word test to check for more file types. But after
> > this, if checkpatch.pl is run on MAINTAINERS, it generates several
> > new warnings of the type:
> >
> > WARNING: Possible repeated word: 'git'
> >
> > For example:
> > WARNING: Possible repeated word: 'git'
> > +T:   git git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git
> >
> > So, the pattern "git git://..." is a false positive in this case.
> >
> > There are several other combinations which may produce a wrong
> > warning message, such as "@size size", ":Begin begin", etc.
> >
> > Extend repeated word check to compare the characters before and
> > after the word matches. If the preceding or succeeding character
> > belongs to the exception list, the warning is avoided.
>
> Not true.
>
> This excludes any non-space character before the first word
> and excludes space or punctuation after the second word.
>
> This also adds case insensitive word matching.
>

Right, I didn't change the commit message. I will update it
properly.

> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
> > @@ -3052,19 +3052,30 @@ sub process {
> >
> >  # check for repeated words separated by a single space
> >               if ($rawline =~ /^\+/ || $in_commit_log) {
> > +                     pos($rawline) = 1 if (!$in_commit_log);
> >                       while ($rawline =~ /\b($word_pattern) (?=($word_pattern))/g) {
> >
> >                               my $first = $1;
> >                               my $second = $2;
> > -
> > +                             my $start_pos = $-[1];
> > +                             my $end_pos = $+[2];
> >                               if ($first =~ /(?:struct|union|enum)/) {
> >                                       pos($rawline) += length($first) + length($second) + 1;
> >                                       next;
> >                               }
> >
> > -                             next if ($first ne $second);
> > +                             next if (lc($first) ne lc($second));
>
> case-insensitive matching
>
> >                               next if ($first eq 'long');
> >
> > +                             # check for character before and after the word matches
> > +                             my $start_char = '';
> > +                             my $end_char = '';
> > +                             $start_char = substr($rawline, $start_pos - 1, 1) if ($start_pos > ($in_commit_log? 0 : 1));
> > +                             $end_char = substr($rawline, $end_pos, 1) if ($end_pos < length($rawline));
> > +
> > +                             next if ($start_char =~ /^\S$/);
>
> non-space
>
> > +                             next if ($end_char !~ /^[\.\,\;\?\!\s]?$/);
>
> space or punctuation.
>
> trivia:
>
> I believe using index would be ~50% faster than !~ here
> Perhaps more readable too.
>
>                                 next if (index(" \t.,;?!", $end_char) >= 0);
>
Yes, it looks better. Thanks for the suggestion.

I will send in a new iteration after all of this is incorporated.

Thank you,
Dwaipayan.
