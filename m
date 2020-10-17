Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68091290F3E
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 07:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411723AbgJQFaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 01:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411620AbgJQF3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 01:29:43 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A7BC05BD2A
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 21:49:53 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id l4so687513oii.13
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 21:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n+CAC6QErPLf9i90utTnHWx2LE43OJexOR43hTX12Wo=;
        b=IQ+x2XLIiqEwfIcgD8PNYjXDGuWVHiz028wzFWB+j6hVSe7pn6mp9obVw9Xm5/RvLS
         mryePmzSHpT4Mr2ML5Ep95JF107vWA0YufqsUMQ0ikL/eA1bVrPrIKdO/0eFEIG8lsdR
         HyKrI40IeVdpq6mbBrqG2Ws190rCUTrHGAA4JMxyPCHprtsXWPAqb/S6RYh2/8ElFBNL
         ivPIPNEE3vhVpzbYK1zHP6DeVpkWLsgYZjdA4DWvMsGHdu8DqTKO2X6EhILHC1bKDCGz
         LjoS0+x1WzUh2IirsI/BTCNxj/7+KMIwvaZWa8l8UQEE/xSq5qsb1JOQffASHEfWGh/D
         5Q7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n+CAC6QErPLf9i90utTnHWx2LE43OJexOR43hTX12Wo=;
        b=KYplZddt/3LZZzf2Z9HgTgXcZx9UtIsvzWapvFQiJr+l/vGPx0Fax/yhaYgnGUlo5H
         okNjJlCsta82j3ut17C5FyCidTHvklnwBk7I+pwF0CxDeMyHZXuZEuBpBj4PYQBhBVfP
         nV335njl+1v0HR9VGz99B53IFpLtaFkq2tmNX8TJ8aL84wkPSiBh0m/bC9xLDUh5zYZ4
         TibifD18Z6F+CfBwL6ROzT2ZFMEnSY2O4YicNc4NKT3S4jL3oUAKb9vWbbwZhBue0c1I
         QjOwZcxYRUYXme05fA553JzhqDotDW+up3DpH0j51G09HOZoEQPAEjoIZussnTO8ckrd
         lEBQ==
X-Gm-Message-State: AOAM531cx+ci1p1oHmx4gGYWD8oPevI53qoIAvv6Z2yN4AXCagalk3mu
        UFBb429lEUgJBARZJTRFsvm36bpNlC5InBJSyv0=
X-Google-Smtp-Source: ABdhPJzMasfpNnWEqbu3BgzrBVqm6WMnvOah7PSP9ofV2KRnJxZbXWJMlTvjOEiEp2OEM/yBfLJPmADmFOk5b4u3Iec=
X-Received: by 2002:aca:2101:: with SMTP id 1mr4846172oiz.110.1602910192426;
 Fri, 16 Oct 2020 21:49:52 -0700 (PDT)
MIME-Version: 1.0
References: <20201014163738.117332-1-dwaipayanray1@gmail.com>
 <ea011df1e30ce445d51e128287e2c6c38de20949.camel@perches.com>
 <CABJPP5DrSL7GoZUWc7P02CfLHfTBmfpLxrVOVQ08KH3pPontoA@mail.gmail.com>
 <7d8c7d80aa7b0524cca49a6dfe24e878bea6ab12.camel@perches.com>
 <81b6a0bb2c7b9256361573f7a13201ebcd4876f1.camel@perches.com>
 <CABJPP5DjmY8N18XOhikHymiwkF9h213Rwi-ffQiBvKSrw2WqyA@mail.gmail.com> <9465f2a318bee7e723c250ff39cf56d6b23780cd.camel@perches.com>
In-Reply-To: <9465f2a318bee7e723c250ff39cf56d6b23780cd.camel@perches.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Sat, 17 Oct 2020 10:19:26 +0530
Message-ID: <CABJPP5D63jPoubCeV3EN-wpG=MhEPELWFY_YkzKztvNHEGULiw@mail.gmail.com>
Subject: Re: [PATCH v2] checkpatch: add new exception to repeated word check
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 17, 2020 at 10:12 AM Joe Perches <joe@perches.com> wrote:
>
> On Sat, 2020-10-17 at 10:02 +0530, Dwaipayan Ray wrote:
> > On Sat, Oct 17, 2020 at 8:26 AM Joe Perches <joe@perches.com> wrote:
> > > On Wed, 2020-10-14 at 11:35 -0700, Joe Perches wrote:
> > > > On Wed, 2020-10-14 at 23:42 +0530, Dwaipayan Ray wrote:
> > > > > On Wed, Oct 14, 2020 at 11:33 PM Joe Perches <joe@perches.com> wrote:
> > > > > > On Wed, 2020-10-14 at 22:07 +0530, Dwaipayan Ray wrote:
> > > > > > > Recently, commit 4f6ad8aa1eac ("checkpatch: move repeated word test")
> > > > > > > moved the repeated word test to check for more file types. But after
> > > > > > > this, if checkpatch.pl is run on MAINTAINERS, it generates several
> > > > > > > new warnings of the type:
> > > > > >
> > > > > > Perhaps instead of adding more content checks so that
> > > > > > word boundaries are not something like \S but also
> > > > > > not punctuation so that content like
> > > > > >
> > > > > >         git git://
> > > > > >         @size size
> > > > > >
> > > > > > does not match?
> > > > > >
> > > > > >
> > > > > Hi,
> > > > > So currently the words are trimmed of non alphabets before the check:
> > > > >
> > > > > while ($rawline =~ /\b($word_pattern) (?=($word_pattern))/g) {
> > > > > my $first = $1;
> > > > > my $second = $2;
> > > > >
> > > > > where, the word_pattern is:
> > > > > my $word_pattern = '\b[A-Z]?[a-z]{2,}\b';
> > > >
> > > > I'm familiar.
> > > >
> > > > > So do you perhaps recommend modifying this word pattern to
> > > > > include the punctuation as well rather than trimming them off?
> > > >
> > > > Not really, perhaps use the capture group position
> > > > markers @- @+ or $-[1] $+[1] and $-[2] $+[2] with the
> > > > substr could be used to see what characters are
> > > > before and after the word matches.
> > >
> > > Perhaps something like:
> > > ---
> > >  scripts/checkpatch.pl | 12 +++++++++++-
> > >  1 file changed, 11 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > > index fab38b493cef..a65eb40a5539 100755
> > > --- a/scripts/checkpatch.pl
> > > +++ b/scripts/checkpatch.pl
> > > @@ -3054,15 +3054,25 @@ sub process {
> > >
> > >                                 my $first = $1;
> > >                                 my $second = $2;
> > > +                               my $start_pos = $-[1];
> > > +                               my $end_pos = $+[2];
> > >
> > >                                 if ($first =~ /(?:struct|union|enum)/) {
> > >                                         pos($rawline) += length($first) + length($second) + 1;
> > >                                         next;
> > >                                 }
> > >
> > > -                               next if ($first ne $second);
> > > +                               next if (lc($first) ne lc($second));
> > >                                 next if ($first eq 'long');
> > >
> > > +                               my $start_char = "";
> > > +                               my $end_char = "";
> > > +                               $start_char = substr($rawline, $start_pos - 1, 1) if ($start_pos > 0);
> > > +                               $end_char = substr($rawline, $end_pos, 1) if (length($rawline) > $end_pos);
> > > +
> > > +                               next if ($start_char =~ /^\S$/);
> > > +                               next if ($end_char !~ /^[\.\,\s]?$/);
> > > +
> > >                                 if (WARN("REPEATED_WORD",
> > >                                          "Possible repeated word: '$first'\n" . $herecurr) &&
> > >                                     $fix) {
> > >
> > >
> >
> > Hi Joe,
> > Thank you for the insight. I was also doing something similar:
> >
> > ---
> >  scripts/checkpatch.pl | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index f1a4e61917eb..82497a71ac96 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -595,6 +595,7 @@ our @mode_permission_funcs = (
> >  );
> >
> >  my $word_pattern = '\b[A-Z]?[a-z]{2,}\b';
> > +my $punctuation_chars = '[,:;@\.\-]';
> >
> >  #Create a search pattern for all these functions to speed up a loop below
> >  our $mode_perms_search = "";
> > @@ -3065,6 +3066,21 @@ sub process {
> >   next if ($first ne $second);
> >   next if ($first eq 'long');
> >
> > + # check for character before and after the word matches
> > + my $ca_first = substr($rawline, $-[1]-1, 1);
> > + my $cb_first = substr($rawline, $+[1], 1);
> > + my $ca_second = substr($rawline, $-[2]-1, 1);
> > + my $cb_second = substr($rawline, $+[2], 1);
> > +
> > + if ($ca_first ne $ca_second || $cb_first ne $cb_second) {
> > + if ($ca_first =~ /$punctuation_chars/ ||
> > +     $ca_second =~ /$punctuation_chars/ ||
> > +     $cb_first =~ /$punctuation_chars/ ||
> > +     $cb_second =~ /$punctuation_chars/) {
> > + next;
> > + }
> > + }
> > +
> >   if (WARN("REPEATED_WORD",
> >   "Possible repeated word: '$first'\n" . $herecurr) &&
> >       $fix) {
> >
> > Does it look okay to you??
>
> Not really, as ca_second and cb_first are both known
> to be the same position and known to be a single space.
>
>
Oh right, my bad. I will adjust it with your suggestions and
send in a V2 then.

Thanks for your time.

Dwaipayan.
