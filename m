Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2EA2CAB19
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 19:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730045AbgLASxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 13:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgLASxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 13:53:39 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F53C0613D4
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 10:52:58 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id z21so6345574lfe.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 10:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FEYVCv8TnmCI7uv6OUfQ32ulBDRxFGwRjOItlKb1Mjo=;
        b=XwmRrxBnOMIWhJIc2+fPMDzSTCHg/fEFQTGguBgxsiCQ0UzqJZPLZ00Z+lehvtjTGv
         ew/sGWeY7G5MXO/JQgcbXZGPTGsTqyETV2aNP5ypjsF1KZ0FBkUEqbYEs7eOYMpcDkvc
         i58dHrYOY0vKBJhvotJTtyG4OR8OsM4bnPZRTa6LTvOlWlZnsZVC/Xdv9qF9wEFQWJg0
         +T8ad/LIh7xbCdmAw/w3OJMoPDrwV6cpOoAHBGLDBy0OFNRSQDB3fQyAq+F0Z2K6f3yR
         AoVnmP/L/X0F5d+PEIEfWMOeAs0EKg+ODnJocfurpDXMJbm7iHvKd2tR1S4Ag954aSMg
         slEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FEYVCv8TnmCI7uv6OUfQ32ulBDRxFGwRjOItlKb1Mjo=;
        b=YfYGhdzbWw1r5PSymxKgY8TaDzSMNHUcOsny44rs+9fubuVPHXhxZtILTBYP4/3IcX
         s1u+4W7jPUSI7ObtCJcCRBUTQIQDj97qxdGg4U1rGydC4wQrBCCROYxzF23l9ZsGvYY0
         qJdjhqCOAj6rP/BGSFWIf94vr0Kuy/mM2R/VXO+GCL8rnT5EnY5RjEqluziUYe6Cn2DR
         QLU8XJQuApI7Cw4DI4r9sExVUoYLl7KKJgD0bI04PJnARS9fFQGk1DRdv2ycAPK06iQ9
         80BcuAAFRgalkcAuP5y6Tp83Wq3++aHMANQYYyJyZRw8JsredZ8gnYxLeD1GLgwb2kCR
         yTdA==
X-Gm-Message-State: AOAM532jklOODJYWBUt4NJhOK0wybHWlFfJ9v0HN2Xh3oxdKbr/KlIcE
        UlIhPdJuXnk80MDcq8O+3mr3Ncngp4Y5ytOL7RY=
X-Google-Smtp-Source: ABdhPJw/N7Vw2HhO/nR45c8ublKgv3J1A+5miWn0r44o/UaJ+p2Dn8HImSzfg/sVswTMnj8gNHMu2KdEG7KkLR+YrsM=
X-Received: by 2002:a19:5003:: with SMTP id e3mr1876048lfb.148.1606848777264;
 Tue, 01 Dec 2020 10:52:57 -0800 (PST)
MIME-Version: 1.0
References: <20201201072320.44544-1-dwaipayanray1@gmail.com>
 <2d507d3042a97613078554b1b5f1169ab8c41b42.camel@perches.com>
 <CABJPP5A75ufynVGn37XteQ=KBrTenr2dGHPPdz83n1=qg6vztA@mail.gmail.com> <f5c7211fc8521248fcb7409f95afadda932a7fe7.camel@perches.com>
In-Reply-To: <f5c7211fc8521248fcb7409f95afadda932a7fe7.camel@perches.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Wed, 2 Dec 2020 00:22:28 +0530
Message-ID: <CABJPP5DpDUCjcW3ic+w-h8aQjTCyrY2kHe1QJ1O_=kf57o6hXg@mail.gmail.com>
Subject: Re: [PATCH v2] checkpatch: fix TYPO_SPELLING check for words with apostrophe
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Peilin Ye <yepeilin.cs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 1, 2020 at 11:59 PM Joe Perches <joe@perches.com> wrote:
>
> On Tue, 2020-12-01 at 23:39 +0530, Dwaipayan Ray wrote:
> > On Tue, Dec 1, 2020 at 11:32 PM Joe Perches <joe@perches.com> wrote:
> > > On Tue, 2020-12-01 at 12:53 +0530, Dwaipayan Ray wrote:
> > > > checkpatch reports a false TYPO_SPELLING warning for some words
> > > > containing an apostrophe when run with --codespell option.
> > > >
> > > > A false positive is "doesn't". Occurrence of the word causes
> > > > checkpatch to emit the following warning:
> > > >
> > > > "WARNING: 'doesn'' may be misspelled - perhaps 'doesn't'?"
> > > >
> > > > Modify the regex pattern to be more in line with the codespell
> > > > default word matching regex. This fixes the word capture and
> > > > avoids the false warning.
> > > >
> > > > Suggested-by: Joe Perches <joe@perches.com>
> > > > Reported-by: Peilin Ye <yepeilin.cs@gmail.com>
> > > > Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
> > > > ---
> > > > Changes in v2:
> > > > - Use the default codespell word regex.
> > > > - Modify commit message to specify --codespell usage
> > > >
> > > >  scripts/checkpatch.pl | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > > []
> > > > @@ -3106,7 +3106,7 @@ sub process {
> > > >  # Check for various typo / spelling mistakes
> > > >               if (defined($misspellings) &&
> > > >                   ($in_commit_log || $line =~ /^(?:\+|Subject:)/i)) {
> > > > -                     while ($rawline =~ /(?:^|[^a-z@])($misspellings)(?:\b|$|[^a-z@])/gi) {
> > > > +                     while ($rawline =~ /(?:^|[^\w\-'`])($misspellings)(?:[^\w\-'`]|$)/gi) {
> > >
> > > This regex seems to work well, thanks.
> > >
> > > >                               my $typo = $1;
> > >
> > > A trivial improvement might be to highlight the location of the
> > > misspelled word with a caret using
> > >
> > >                                 my $blank = copy_spacing($rawline);
> > >                                 my $ptr = substr($blank, 0, $-[0] + 1) . "^";
> > >                                 my $hereptr = "$hereline$ptr\n";
> > >
> > > >                               my $typo_fix = $spelling_fix{lc($typo)};
> > > >                               $typo_fix = ucfirst($typo_fix) if ($typo =~ /^[A-Z]/);
> > >
> > > and using $hereptr and not $hereline when emitting the message.
> > >
> > Sure I will do that.
> > Is the color highlighting also supported in most systems?
>
> I believe so, yes.
>
> Color is only used when the output is to stdout and not redirected
> and not otherwise specified on the checkpatch command line.
>
> > Maybe a red colored word would be nice to notice as well.
>
> Maybe, but that might make the code around the message output of
> $hereptr a bit obscure.  Presumably the code would not use $hereline
> but something else new and specific for this message.
>
> The output is done via the report() function so adding optional color
> for only a portion of the new $hereptr string might be a lot of code.
>
> If you try it, maybe make the misspelled word color match the message
> level and not just be red.  Also the caret line wouldn't have much
> value with that added color highlighting.
>
> Try it and see what you prefer.
>

Thanks for your view.
Colors seem to obscure the word even more. The carat one seemed nicer
to me visually. I will send in a new version for that.

Regards,
Dwaipayan.
