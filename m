Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C70762830FF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 09:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbgJEHlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 03:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgJEHlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 03:41:08 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9990C0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 00:41:06 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id w141so7887130oia.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 00:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7uumRQsWGvzxWlskcb2yDBCiZdajJKEbj4tFeXnJlFo=;
        b=sx2Az/hKCEXFmLC0coVUrDVTdLhTxfNpQ7fPvHMGd792RQprqobx/x+oW7Qa8jfadu
         Xiw9q2zBgkwS0k9fFtg+MxQRhFq67EFzkytH3YGB95UWPAxYnipg2VCa8ljuLrtnx09M
         J2GLQnnTHez6xEmWVBG6QMPrNeKY+L6dglRamRxqbiFBqEyDmCHOMXdEd2z3XaBIjY5d
         qGqW39be3R4OEVVl3MAzoS5Oxa8bF/xJrqcxKD6UShTUcfS3jxZrzP7J+U3LXDWsTBHm
         TZx6tIGklMKJ2PVt9MRgiWjcakG8QqCOW4gjD1cSItT/6ny95iA4nyjaMski+mjy7x+2
         rI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7uumRQsWGvzxWlskcb2yDBCiZdajJKEbj4tFeXnJlFo=;
        b=NPX/yku39G/HVVpmYX9Da7dfTou+NfjRqeX4JEt2yx6OJVtM3scccQewIiYMqNBGhC
         FfUQL6hjFQcKhRheJwaecPnXiiO+cij0MDa2z1pt3RHbFNDKB8a0mDnJHitttzT/Rp9g
         cqvcaIAN4DiqbkK7T3dXNsFYFlrMgE7FfZFbC8Kg+i529DWibi+1hirWL+KeaMG/iPMR
         HyXOHJ+vRkl6DM2bgCz2/AJ8B1Y5bWroWx6nEbsSyCIalZPZP9eMqndb1d1kN3Ty9qk4
         D32kRQfW1Q7AC6KLxCIu9NdPazH7JVJyYIVCvcCb8rfP2zWK3+Ipqw+lW0FsIGBAmbQF
         CLQQ==
X-Gm-Message-State: AOAM533P3Flt2/9KqFlz0yFRloZO3aC3e/Lbn7EuqCwrrIk/7Pf2o28d
        OYSAw7UZteVKBsSU/o+ePp2QxEPsYUx6+UL2+J/Ev8goMiSTRA==
X-Google-Smtp-Source: ABdhPJx8BUKzjcSCuzPJBJ4ITiy8QoPK9yEc7N/aHL1TvkvEHBthWFPOcie9/rqwUfzukqSdPWcUpjNqDJRj5fl/MNY=
X-Received: by 2002:aca:cc54:: with SMTP id c81mr7677550oig.74.1601883665861;
 Mon, 05 Oct 2020 00:41:05 -0700 (PDT)
MIME-Version: 1.0
References: <20201005064842.33495-1-dwaipayanray1@gmail.com> <a5cba9bb723626091f8790c794efe8de4ab184b8.camel@perches.com>
In-Reply-To: <a5cba9bb723626091f8790c794efe8de4ab184b8.camel@perches.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Mon, 5 Oct 2020 13:10:44 +0530
Message-ID: <CABJPP5BwVmWiFcxHKdCYnN_mOE1G=eHUDq8yqqHFaO3cYhp+oA@mail.gmail.com>
Subject: Re: [PATCH RFC] checkpatch: add new warnings to author signoff checks.
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 5, 2020 at 12:48 PM Joe Perches <joe@perches.com> wrote:
>
> On Mon, 2020-10-05 at 12:18 +0530, Dwaipayan Ray wrote:
> > The author signed-off-by checks are currently very vague.
> > Cases like same name or same address are not handled separately.
> >
> > For example, running checkpatch on commit be6577af0cef
> > ("parisc: Add atomic64_set_release() define to avoid CPU soft lockups"),
> > gives:
> >
> > WARNING: Missing Signed-off-by: line by nominal patch author
> > 'John David Anglin <dave.anglin@bell.net>'
> >
> > The signoff line was:
> > "Signed-off-by: Dave Anglin <dave.anglin@bell.net>"
> >
> > Clearly the author has signed off but with a slightly different version
> > of his name. A more appropriate warning would have been to point out
> > at the name mismatch instead.
> >
> > Introduced three new types of warnings:
> >
> > 1) Address matches, but names are different.
> >    "James Watson <james@gmail.com>", "James <james@gmail.com>"
> >
> > 2) Name matches, but addresses are different.
> >    "James Watson <james@watson.com>", "James Watson <james@gmail.com>"
> >
> > 3) Name matches, but addresses without mail extensions are same.
> >    "James Watson <james@gmail.com>", "James Watson <james+a@gmail.com>"
> >
> > For the 3rd class, a --strict check message is generated, and for the
> > other two, warnings are generated.
>
> I don't have any issue with the concept, but please
> be consistent with spacing after if tests.
>
> Always use a single space after if
>

Okay sure I will take care of that.

> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>
> > @@ -2347,6 +2347,7 @@ sub process {
> >       my $signoff = 0;
> >       my $author = '';
> >       my $authorsignoff = 0;
> > +     my $authorsignoff_ctx = '';
>
> ctx isn't a descriptive name.
>
> Maybe $author_sob

Yes that's more illustrative. I will change that.

>
> > @@ -2674,9 +2675,34 @@ sub process {
> >               if ($line =~ /^\s*signed-off-by:\s*(.*)/i) {
> >                       $signoff++;
> >                       $in_commit_log = 0;
> > -                     if ($author ne '') {
> > +                     if ($author ne ''  && $authorsignoff != 1) {
>
> Has space after if
>
> >                               if (same_email_addresses($1, $author)) {
> >                                       $authorsignoff = 1;
> > +                             } else {
> > +                                     my $ctx = $1;
> > +                                     my ($email_name, $email_comment, $email_address, $comment1) = parse_email($ctx);
> > +                                     my ($author_name, $author_comment, $author_address, $comment2) = parse_email($author);
> > +
> > +                                     if($email_address eq $author_address) {
>
> No space after if, etc...
>
> > @@ -6891,9 +6917,32 @@ sub process {
> >               if ($signoff == 0) {
> >                       ERROR("MISSING_SIGN_OFF",
> >                             "Missing Signed-off-by: line(s)\n");
> > -             } elsif (!$authorsignoff) {
> > -                     WARN("NO_AUTHOR_SIGN_OFF",
> > -                          "Missing Signed-off-by: line by nominal patch author '$author'\n");
> > +             } elsif ($authorsignoff != 1) {
> > +                     # authorsignoff values:
> > +                     # 0 -> missing sign off
> > +                     # 1 -> sign off present
>
> sign off identical
>
> > +                     # 2 -> address matches, name different
> > +                     # 3 -> name matches, address different
> > +                     # 4 -> name matches, address matches without extension
>
> extension here isn't obvious

Yeah I was thinking of that. I was a bit confused about the message.
Will it be better as "address excluding mail extensions matches"?

>
> > +
> > +                     my $ctx_msg = "'Signed-off-by: $authorsignoff_ctx' should be:\n'Signed-off-by: $author'";
>
> New line not necessary or useful really.
>
> And for mismatches, it's really not known that
> it should be one way or the or the other is it?
>

I think that's true. But since the mail in the
From: part is the one which with others are being
compared, I think maybe it should have the higher
priority, and be treated as the expected one.

Otherwise I could change the message accordingly.

> > +
> > +                     if($authorsignoff == 0) {
> > +                             WARN("NO_AUTHOR_SIGN_OFF",
> > +                                     "Missing Signed-off-by: line by nominal patch author '$author'\n");
> > +                     }
> > +                     elsif($authorsignoff == 2) {
> > +                             WARN("NO_AUTHOR_SIGN_OFF",
> > +                                     "Author name mismatch:\n$ctx_msg\n");
> > +                     }
> > +                     elsif($authorsignoff == 3) {
> > +                             WARN("NO_AUTHOR_SIGN_OFF",
> > +                                     "Author address mismatch:\n$ctx_msg\n");
> > +                     }
> > +                     elsif($authorsignoff == 4) {
> > +                             CHK("NO_AUTHOR_SIGN_OFF",
> > +                                     "Author mail extension mismatch:\n$ctx_msg\n");
> > +                     }
> >               }
> >       }
> >
>
Thanks,
Dwaipayan.
