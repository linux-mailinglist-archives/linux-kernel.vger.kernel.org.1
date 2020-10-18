Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07AD72918CC
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 20:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbgJRSQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 14:16:03 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43805 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbgJRSQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 14:16:02 -0400
Received: by mail-ot1-f67.google.com with SMTP id k68so3886696otk.10
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 11:16:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ehs9Mj6iRxjpqWN9PdX7MR174XtTZXauay85kgjUgF8=;
        b=VE1NtLHamK8kX3v/uNAfO+4xlnlrUjSPaXcOSEHCGOFKSuM+yrEQT/z+Xz/aoXsv77
         G0a2W34NWupJobjCU0sflnPwUliNmoAE5avt5RO7tExz6z49EOBvRJq7ufky9gxS0EZ6
         IWiyhazaMG9BypinpAWPgc5qqP+iFqNj6zXiMItj7wc646qux+yqoP/C5ihxh2m6JTf6
         ruoLh8yBGf+G49c6broSsAQID2x6nd6pA/1hwP8ku039Qva2bRpb/1fjudNHzbXYAbnK
         dyKW2e5WBRVYzNMnb/eG30dgthKL8Ukh5r1U7Re07jhxcMbla6KnXfp9+PskEe4+0YSw
         +cfQ==
X-Gm-Message-State: AOAM530sr40q9aGsDME7q8kSS/WhyGtJvDIwGJ9KbY+5g+afP8g7oeQV
        GMUmvxL3+xPtG1cr7u/jACNPz3fYmLpsS6Ha8xnJzlJituc=
X-Google-Smtp-Source: ABdhPJw0ZKL7lHK6jB1BD34cUyU5V+aaHMsnA1n1VSgnNWSBoZ82/kfrhiFSu7juJTFg07Y9I8PWmrhL33Q7qIxyfJA=
X-Received: by 2002:a05:6830:210a:: with SMTP id i10mr9495437otc.145.1603044961332;
 Sun, 18 Oct 2020 11:16:01 -0700 (PDT)
MIME-Version: 1.0
References: <45b81a48e1568bd0126a96f5046eb7aaae9b83c9.camel@perches.com>
 <CAMuHMdV8FEPhTp653RN00LK4UcQZHkuLByJzqiM85r2qoqhDvQ@mail.gmail.com> <fce55e74e4331c6e19c4030a4e02fb35ca5ee4f7.camel@perches.com>
In-Reply-To: <fce55e74e4331c6e19c4030a4e02fb35ca5ee4f7.camel@perches.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 18 Oct 2020 20:15:49 +0200
Message-ID: <CAMuHMdUp5U0nnp9LfWgY0VnkRppMVXZU9NSpWqcMKYM_zRXRuA@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: Allow not using -f with files that are in git
To:     Joe Perches <joe@perches.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@shadowen.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On Sun, Oct 18, 2020 at 6:07 PM Joe Perches <joe@perches.com> wrote:
> On Sun, 2020-10-18 at 16:03 +0200, Geert Uytterhoeven wrote:
> > On Tue, Aug 25, 2020 at 2:12 AM Joe Perches <joe@perches.com> wrote:
> > > If a file exists in git and checkpatch is used without the -f
> > > flag for scanning a file, then checkpatch will scan the file
> > > assuming it's a patch and emit:
> > >
> > > ERROR: Does not appear to be a unified-diff format patch
> > >
> > > Change the behavior to assume the -f flag if the file exists
> > > in git.
> > >
> > > Signed-off-by: Joe Perches <joe@perches.com>
> >
> > Thanks for your patch!
> >
> > > --- a/scripts/checkpatch.pl
> > > +++ b/scripts/checkpatch.pl
> > > @@ -976,6 +976,16 @@ sub seed_camelcase_includes {
> > >         }
> > >  }
> > >
> > > +sub git_is_single_file {
> > > +       my ($filename) = @_;
> > > +
> > > +       return 0 if ((which("git") eq "") || !(-e "$gitroot"));
> > > +
> > > +       my $output = `${git_command} ls-files -- $filename`;
> > > +       my $count = $output =~ tr/\n//;
> > > +       return $count eq 1 && $output =~ m{^${filename}$};
> > > +}
> > > +
> > >  sub git_commit_info {
> > >         my ($commit, $id, $desc) = @_;
> > >
> >
> > This is now commit f5f613259f3fea81 ("checkpatch: allow not using -f
> > with files that are in git"), causing:
> >
> >     Global symbol "$gitroot" requires explicit package name (did you
> > forget to declare "my $gitroot"?) at scripts/checkpatch.pl line 980.
> >     Execution of scripts/checkpatch.pl aborted due to compilation errors.
> >
> > FWIW, host system is running Ubuntu 18.04.5 LTS (upgrade to 20.04 LTS
> > planned soon ;-).
>
> I believe there is a dependency on another patch
> in -next that wasn't pushed to Linus' tree.
>
> commit 5ec1f7de97b26a3fa364bbb31fdd2e42c8e6fa22
> Author: Joe Perches <joe@perches.com>
> Date:   Thu Oct 8 11:53:44 2020 +1100
>
>     checkpatch: test $GIT_DIR changes
>
> So it'd be better to revert right now until
> this other patch is accepted or pushed.

Thanks, after cherry-picking that one from next, checkpatch works again.
However, there are some issues with that commit:
  1. ERROR: Missing Signed-off-by: line by nominal patch author 'Joe
Perches <joe@perches.com>',
  2. The Link: is bogus, and gives 404.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
