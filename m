Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 553C42C8B2B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 18:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387633AbgK3RdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 12:33:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbgK3RdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 12:33:18 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87B0C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 09:32:37 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id t6so23134874lfl.13
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 09:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PE8fp+K02SctplBIINuNHMFuhz2IiCxj8rV/VVtbRc4=;
        b=XCfLarjdvF4B6QXu1MuLj8xXcDCUUSxB7m+BzaDrWlh3CDnGoStPuI+RcWZ3yVGyL7
         2hSnjlmIkLsHC4oJBR7MZCNbRnDqNl5MlJ/DK4o1ZeFVnIA37ip/TvaZgzJHYuYRiV7s
         9H/GPN74T/PzK9PDaG/KTThIKOHetiJX3hsMxAu2oX8l2DxPSnRVqxnwtub+5jo8E1Gz
         SQTBhm3Y9QK5aAIJ+TvCpckp50ifpVl+DWwiPIaPPg1QZQOaQWT0CPE+wSnxGEEV2cjc
         3x4arCyrog8OoRXESNMhEobaGSjSQAGs27Nqr+ejQhbiqcWHyBAuX3mniDtLQEPgIezF
         4wCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PE8fp+K02SctplBIINuNHMFuhz2IiCxj8rV/VVtbRc4=;
        b=LXbVgi2iyGEN8fFH4hWp9JN3EmjUhb+kOTGJPdjN6IPhKdJY+nDALFViXSe+aYsEIL
         JbVd49xZIC1apgHE34uUDXhOtxluGPreewypzHjRclrujsAjqSsTp3Wpl3EwF/Q/79tf
         sK6s+D6bADlUc1cV7WeCciudAQ3PorL9zwIOxYaKncqMy0HPUmGYBvRQTKph6QOisMlM
         pCGLzySW7qo3IKBSzZhsWTDiZuf2nVnu6XMXdqOOorc0CxQCw0FF5AO0Q1L8fCFW9kwW
         fGOYwKfy/OiCTcA9zuNJVM7vKxmLjEqVUa2pwkoGqXNAY/fHyKaAg3yGlrQ79av4WDp9
         TxYA==
X-Gm-Message-State: AOAM531oYtOn3TS61aBOQA2FNr4lQ8ZXRVKLp6kRdF+Td5nUl/EkB9uK
        dzdcO4rhF1s1BnzG17MlNZVlSR/I5mWBusG8jXG6uQAhWeSVxvA5
X-Google-Smtp-Source: ABdhPJzqA9bsEW0q/DO4Rr8ve27Ee1mCQ0wNwOSJkd87RsHSepIgRTxq06oZzdVW0QQxi+xwWlAHHFF3CY7zBWFK9Gg=
X-Received: by 2002:ac2:51a4:: with SMTP id f4mr9808064lfk.365.1606757555939;
 Mon, 30 Nov 2020 09:32:35 -0800 (PST)
MIME-Version: 1.0
References: <20201130144515.8320-1-dwaipayanray1@gmail.com>
 <c8eeab847fc09368ce270ea3e06ea0bbbd7d1b7f.camel@perches.com>
 <CABJPP5BLjbx3FbvB3nAOiHfkRLUo7s0n-vboE+AXJqrZXseUNQ@mail.gmail.com> <070109a56817288562a91dfeec74359eb948234e.camel@perches.com>
In-Reply-To: <070109a56817288562a91dfeec74359eb948234e.camel@perches.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Mon, 30 Nov 2020 23:02:07 +0530
Message-ID: <CABJPP5BxO20-YzbTZij4gZGm4R63iG_n2kH58pSz5mgyXXwVBw@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: fix TYPO_SPELLING check for words with apostrophe
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Peilin Ye <yepeilin.cs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 10:54 PM Joe Perches <joe@perches.com> wrote:
>
> On Mon, 2020-11-30 at 22:33 +0530, Dwaipayan Ray wrote:
> > On Mon, Nov 30, 2020 at 10:13 PM Joe Perches <joe@perches.com> wrote:
> > >
> > > On Mon, 2020-11-30 at 20:15 +0530, Dwaipayan Ray wrote:
> > > > checkpatch reports a false TYPO_SPELLING warning for some words
> > > > containing an apostrophe.
> > > >
> > > > A false positive is "doesn't". Occurrence of the word causes
> > > > checkpatch to emit the following warning:
> > > >
> > > > "WARNING: 'doesn'' may be misspelled - perhaps 'doesn't'?"
> > > >
> > > > Check the word boundary for such cases so that words like
> > > > "doesn't", "zig-zag", etc. aren't misinterpreted due to wrong
> > > > splitting of the word by the \b regex metacharacter.
> > > []
> > > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > > []
> > > > @@ -3106,7 +3106,7 @@ sub process {
> > > >  # Check for various typo / spelling mistakes
> > > >               if (defined($misspellings) &&
> > > >                   ($in_commit_log || $line =~ /^(?:\+|Subject:)/i)) {
> > > > -                     while ($rawline =~ /(?:^|[^a-z@])($misspellings)(?:\b|$|[^a-z@])/gi) {
> > > > +                     while ($rawline =~ /(?:^|[^a-z@])($misspellings)(?:\b(?![^\w]?[a-z@]+)|$|[^a-z@])/gi) {
> > >
> > > Wouldn't it be simpler to change the existing [^a-z@] blocks to [^a-z@'-] ?
> > >
> > Hi,
> > I tried it and it doesn't seem to work. Probably because the first
> > group already causes the
> > word to be captured. In this case `doesn'` was already captured
> > because of the \b group.
> >
> > Is the first group modification perhaps okay? Or would you suggest
> > something else?
>
> Seems to work for me:
>
> $ git diff --stat -p scripts/checkpatch.pl
>  scripts/checkpatch.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 7dc094445d83..a6d4d524ae66 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3106,7 +3106,7 @@ sub process {
>  # Check for various typo / spelling mistakes
>                 if (defined($misspellings) &&
>                     ($in_commit_log || $line =~ /^(?:\+|Subject:)/i)) {
> -                       while ($rawline =~ /(?:^|[^a-z@])($misspellings)(?:\b|$|[^a-z@])/gi) {
> +                       while ($rawline =~ /(?:^|[^a-z@'-])($misspellings)(?:\b|$|[^a-z@'-])/gi) {
>                                 my $typo = $1;
>                                 my $typo_fix = $spelling_fix{lc($typo)};
>                                 $typo_fix = ucfirst($typo_fix) if ($typo =~ /^[A-Z]/);
>
> $ cat t_spell.c
> // SPDX-License-Identifier: GPL-2.0-only
> void foo(void)
> {
>         //misspelled arne't word
> }
>
> $ ./scripts/checkpatch.pl -f --strict t_spell.c
> CHECK: 'arne't' may be misspelled - perhaps 'aren't'?
> #4: FILE: t_spell.c:4:
> +       //misspelled arne't word
>
> total: 0 errors, 0 warnings, 1 checks, 5 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
>
> t_spell.c has style problems, please review.
>
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
>

Sorry I think i explained wrong. For words like "doesn't", it still
has the same problem.
With your suggested modification in place:

$ ./scripts/checkpatch.pl
0001-checkpatch-fix-TYPO_SPELLING-check-for-words-with-ap.patch
--codespell
WARNING: 'doesn'' may be misspelled - perhaps 'doesn't'?
#9:
A false positive is "doesn't". Occurrence of the word causes

WARNING: 'doesn'' may be misspelled - perhaps 'doesn't'?
#15:
"doesn't", "zig-zag", etc. aren't misinterpreted due to wrong

Thank you,
Dwaipayan.
