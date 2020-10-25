Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF17298330
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 19:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1418211AbgJYStL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 14:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1418204AbgJYStL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 14:49:11 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A097C061755
        for <linux-kernel@vger.kernel.org>; Sun, 25 Oct 2020 11:49:11 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id h62so6117447oth.9
        for <linux-kernel@vger.kernel.org>; Sun, 25 Oct 2020 11:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LSg549qy70Mq7dxJx8/6H70bAuT8V5694im40uZ0SNs=;
        b=WmeUWocI/jqPKq73+rYbo+xz2qdR0hRyoH4pjmzU9LtqMXqYYWenX11WTMuk5zQSzO
         U4+RTBdGoKLpecF3Cl5qICawY1f/84Tizup3ZyMgxTph0ryPQvnEQDPtB6+k+aCLfuR+
         A6keO3DgOhi5kMbVvA8psDTdZd6YD5pvAt8HTkQTfwijdM6fzH5MNAtFMUa07FmhbUXD
         HRSRlEM5yqQUu228lqFff3z67Nm5VRnzpawKbKSIe0sd0ip/ouSUtv7wH5AQE2OssiIt
         +AvR/01/R4DASlEWqdFyoWJO5vKpKHqxz+ShW6A7gXXcdNZ8kXwaJ3kMyIj22Xb+WbgG
         4aFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LSg549qy70Mq7dxJx8/6H70bAuT8V5694im40uZ0SNs=;
        b=BStWpcksFEysRgzMKA/nzt7mRG5S96S32HOgEpISBYXpGjOFm+8SCZQ9qr+JR2fjR5
         8TyMlcaYBc2mDZ5p/Y2sQcLOMeagMyZudqo3M+g+A9GfTdE6ZKHdWJw9fwfI1bVo37sa
         g+8Yob5fkCmaiFaB3B+UOY1Xe4rS7sIGSTsyK/4HMK9MvNEadRJmfBIGLwHeaRDGPj8x
         SuxBuxVHu7JyzhxPxLZzNgYB3Tu2F8aIergiXt8mizoG/niNJSDHvJjevx9xbuAPGVm1
         G03BZjOYOoZfiWvAheOdp9dnf95GyEGuN1y2f+mx25AAYGjHfF78BIafrQvQcAVRYPee
         f+CA==
X-Gm-Message-State: AOAM533wMl75E5JCFSgL8ZyVHjDsNMf6od6+MNk898YXCmmaFAqRmKUY
        evzMhmrz5o1q7pIwV/9TeOAaAOornQ599UNHV6um5NQpOeMc16xo
X-Google-Smtp-Source: ABdhPJywsp59BNbGZIhRY2VFs0P/GUR4cmO5ePdL2IzHwq77KfL/KwynUQctQCzCm3jrGYrmuTR3mk+Vsu420cK4VF8=
X-Received: by 2002:a05:6830:1db1:: with SMTP id z17mr11626632oti.30.1603651750122;
 Sun, 25 Oct 2020 11:49:10 -0700 (PDT)
MIME-Version: 1.0
References: <20201025101537.59133-1-dwaipayanray1@gmail.com> <52f88d0bb938c5063ede693a05bf64961af5a496.camel@perches.com>
In-Reply-To: <52f88d0bb938c5063ede693a05bf64961af5a496.camel@perches.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Mon, 26 Oct 2020 00:18:40 +0530
Message-ID: <CABJPP5Azq7Pnq+Ki5gKjAGuymHGxK0HwTKsWWw6t3p4dmOSzaw@mail.gmail.com>
Subject: Re: [PATCH v5] checkpatch: extend attributes check to handle more patterns
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +                     if (scalar @conv_array > 0 && $conv_possible == 1) {
> > +                             my $replace = join(' ', @conv_array);
> > +                             if (WARN("PREFER_DEFINED_ATTRIBUTE_MACRO",
> > +                                      "$replace is preferred over __attribute__(($attr))\n" . $herecurr) &&
> > +                                     $fix) {
> > +                                     $fixed[$fixlinenr] =~ s/\b__attribute__\s*\(\s*\(\s*\Q$attr\E\s*\)\s*\)/$replace/;
>
> I looks it would be useful to add
>                                         $fixed[$fixlinenr] =~ s/\}\Q$replace\E/} $replace/;
> so there's a space added between } and any replacements.
>
Hi once again,
Sorry to interrupt your work so many times.

I tried this and seems the space is being applied even without this
fix.
I think the spacing check applies this fix already.

if (ERROR("SPACING",
"space required after that close brace '}'\n" . $herecurr) &&
$fix) {
$fixed[$fixlinenr] =~
s/}((?!(?:,|;|\)))\S)/} $1/;
}

So do you think it's okay without that perhaps?

Thanks,
Dwaipayan.
