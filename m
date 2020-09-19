Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2C41271055
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 21:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgISTjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 15:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbgISTjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 15:39:05 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45399C0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 19 Sep 2020 12:39:05 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id z26so11633707oih.12
        for <linux-kernel@vger.kernel.org>; Sat, 19 Sep 2020 12:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SQtf4hjR8BiFGOzI+LyzpiVdQaOuYwnz9vzlK18ZLec=;
        b=Nia8DYZI/mMqQxifpx74lDImmy9AUam8ADyQOcXm9+e6QD9ucUMk6XThT1tPNESTRC
         f8p5NJ19KUWd8MQK6xciVegqGl8xpvAcfIAbNuANrdQw1H9VDABAvqsr76fSDG+giQB4
         3IWOWi3k89CW9Uo95nc4PRpHcDAf9eYNyEvOKGPyXrd9McxsPczGz+6IOLPa0SCzvukp
         J0ldT+f1JAGPFp8B5lUGjc6qRkejgLKpPbAEsFO8e8DDupalBdie/lz090kbm1mA5iV9
         DSVjwV0BfJb4IUmo22SMGk8UiEPsj8gR+V6sGVX5UfMc4AFRwv9aKsNug69rptP5ctn3
         TjZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SQtf4hjR8BiFGOzI+LyzpiVdQaOuYwnz9vzlK18ZLec=;
        b=RV8tjvidaBh92Kp/Jx/hdMgnx4gXPbe+ERrVUECww2dU0LrVKeQdsH6/FU0su6X6zX
         Tkuc9LbTJ3OE2eN8MAN7YR/dassizvLp5Oxekbj8eBbiHWIqtz9aZ5D5+E9evuwzpVks
         uZXGyIZ0S1xWHY0lC2UK1GUeEtECHW4RVLkXdXS+jmMW0HC6TbRcQE2Yt6MVY0jFZvvB
         UP+Y33nTG+v/KLQdkBBvllhe/0sfxQf5aCKVzZ8l6zskk5reZZw36qykAaJ3q6dyLts2
         zeYZF7sBFSf43IC3i8NOTPsk1Ua6kKMa0JRe8VRF4lYOlS7LTiD9ubki1JJYAFti+h1c
         LBlg==
X-Gm-Message-State: AOAM5306sj1KWpHP476QWrkhoUppSX4vUzsdqV3PniRCbkDL6rRKt/KZ
        4BNV6HBr9D3+v0Yy6/Xl5BUmGWIzP+jJQ0OnaBw=
X-Google-Smtp-Source: ABdhPJymaWNqXDl6382z1kJUQko1Vwg1BhFOsL7L7HSpu1Oz5OwlsxXbFgI4X9WyjtZUjHZ4Sa6LFInrF6ClkxP5Q8U=
X-Received: by 2002:aca:5050:: with SMTP id e77mr13203643oib.74.1600544344351;
 Sat, 19 Sep 2020 12:39:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200919081225.28624-1-dwaipayanray1@gmail.com>
 <ad937bba6ebd306f6e467add90cfd857bb4f2391.camel@perches.com>
 <alpine.DEB.2.21.2009191950460.7901@felia> <f5d8124e54a50480b0a9fa638787bc29b6e09854.camel@perches.com>
 <alpine.DEB.2.21.2009192033030.7901@felia>
In-Reply-To: <alpine.DEB.2.21.2009192033030.7901@felia>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Sun, 20 Sep 2020 01:08:45 +0530
Message-ID: <CABJPP5Daf0UiKjeQp71_bViAkQQh7znWrArKAS1FqnjGU1nX4A@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: extend author Signed-off-by check for split
 From: header
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Joe Perches <joe@perches.com>,
        linux-kernel-mentees@lists.linuxfoundation.org, apw@canonical.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 20, 2020 at 12:06 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
>
>
> On Sat, 19 Sep 2020, Joe Perches wrote:
>
> > On Sat, 2020-09-19 at 20:12 +0200, Lukas Bulwahn wrote:
> > >
> > > On Sat, 19 Sep 2020, Joe Perches wrote:
> > >
> > > > On Sat, 2020-09-19 at 13:42 +0530, Dwaipayan Ray wrote:
> > > > > Checkpatch did not handle cases where the author From: header
> > > > > was split into two lines. The author string went empty and
> > > > > checkpatch generated a false NO_AUTHOR_SIGN_OFF warning.
> > > >
> > > > It's good to provide an example where the current code
> > > > doesn't work.
> > > >
> > >
> > > Joe, as this is a linux-kernel-mentees patch, we discussed that before
> > > reaching out to you; you can find Dwaipayan's own evaluation here:
> > >
> > > https://lore.kernel.org/linux-kernel-mentees/CABJPP5BOTG0QLFSaRJTb2vAZ_hJf229OAQihHKG4sYd35i_WMw@mail.gmail.com/
> > >
> > > Dwaipayan, Joe's comment is still valid; it would be good to describe
> > > the reasons why patches might have split lines (as far as see, long
> > > encodings for non-ascii names).
> > >
> > > I will run my own evaluation of checkpatch.pl before and after patch
> > > application on Monday and then check if I can confirm Dwaipayan's results.
> > >
> > > > It likely would be better to do this by searching forward for
> > > > any extension lines after a "^From:' rather than searching
> > > > backwards as there can be any number of extension lines.
> > > >
> > >
> > > Just to sure what you are talking about...
> > >
> > > You mean just to access the next line through the lines array, rather
> > > than using prevheader and trying to decode that one line twice.
> > >
> > > I agree the logic is a bit redundant and complicated at the moment.
> > >
> > > Once prevheader is non-empty, it already clear that author is '' and
> > > prevheader decodes with that match, because that is the only way to
> > > make prevheader non-empty in the first place; at least as far I see it
> > > right now.
> >
> > Yeah, something like this (completely untested):
> > ---
> >  scripts/checkpatch.pl | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index 3e474072aa90..2c710d05b184 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -2679,9 +2679,13 @@ sub process {
> >               }
> >
> >  # Check the patch for a From:
> > -             if (decode("MIME-Header", $line) =~ /^From:\s*(.*)/) {
> > +             if ($line =~ /^From:\s*(.*)/i) {
> >                       $author = $1;
> > -                     $author = encode("utf8", $author) if ($line =~ /=\?utf-8\?/i);
> > +                     my $curline = $linenr;
> > +                     while (defined($rawlines[$curline] && $rawlines[$curline++] =~ /^ \s*(.*)/) {
> > +                             $author .= $1;
> > +                     }
> > +                     $author = encode("utf8", $author) if ($author =~ /=\?utf-8\?/i);
> >                       $author =~ s/"//g;
> >                       $author = reformat_email($author);
> >               }
> >
>

Hi,

Yeah I think the backwards checking was pretty redundant after all. If the
extended encoding went too long, the From: header would be split into
more than two lines and my proposed solution would fail.

Thanks for the heads up, Joe!

> Yeah, I get how you would like to see that being implemented. I will work
> with Dwaipayan to get that properly implemented, properly described and
> tested.
>
> But let us keep the fun of that task to Dwaipayan... that is what a
> mentorship is all about :)
>
> Lukas

Yes definitely, the task is interesting for me, and I would like to solve
it in a proper way.

As for the fix, shouldn't we stop the author string concatenation once
an email address is found? something like:

  last if  $rawlines[$curline] = ~/^\s*(\S+\@\S+)\s*/

I will update the patch and sync up with Lukas on this.

Thanks,
Dwaipayan.
