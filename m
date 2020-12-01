Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDF32CAA8B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 19:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731167AbgLASLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 13:11:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgLASLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 13:11:02 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FADC0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 10:10:16 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id j10so4512895lja.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 10:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A5abX7MmZ8u7dm9lClNeO6iU0UD2UQZWPold2l0WgmI=;
        b=jd8NCTLOi/t7oIgpm4GVcEhDJdcWcrvyD8R2dORLa016CDb32ZI3mx960CIJjQUx33
         bSnMYi6x/CtMfngRFTgs+rZJSSIXuEC5aMTY8XeUO6RLJJfK0A0zOL1ZIKpzh9OebYnF
         hHt0bpVddFF24/P0T1cINe82Qvjjtpb1NVYMaJvHqgTZj+8VMMINqKbx2ddsAw4dcnrk
         DX30ChvJIqTxPiBrDQiGkGw/HvlpcS+W8U8u/rforInXq58klZPL0Ed7R/vrkC7w410R
         /pmvrEb6OS+YLcQZXuHKmWtYg2pmfu34xbbE9busXp6UwBgog9hMqTJFdCDQG8pfzZ7b
         USmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A5abX7MmZ8u7dm9lClNeO6iU0UD2UQZWPold2l0WgmI=;
        b=QQOnWKg/r4xmch1TU+E1UV2L9xnaqEobsRgBP51gwITNsFWZOnwidKaP3mcuzVkycD
         l3A5VciCYzTIhGg3eHPpsWhuRrN3+jP8JDprEyStRltMOXpkT9ZftThIaiFPwO6S7bjl
         yAqi2KxY8K0qKAYnPCXeq2+BCimezeuaSOtwxIGR+w9QaRyfe2hc0PJiWwc+vAZIrvve
         VMOD6jq71c9I/dH2XiwflABwZsIeLAukJsiVmElArOc92xwt/P+zNgcNP64AufXrhMyd
         Ldtw4ZwOdNXHPphrT2mVKt7kcObuZgAdr4cK8Rt+S5dGHS5osp3KIMbJGDQo+rBJbVOP
         j5uw==
X-Gm-Message-State: AOAM5313Tv/5hlw/uzgBFQ3t6DzCLGaFCsBQ2WhKN/LB+SgvZdZW6/n0
        P6pAzbqNzpgvXHdwAR01GrM7l4Zah3x7oBGph9mFDd9rIWTWAA==
X-Google-Smtp-Source: ABdhPJz/nYzMJPiXpXkp7KIwgYj5vUEFPbUG6EBnzhSK8i2kXlmfSuaqWGsIrypp//JvdE+zZsUDaZERdfnDSaUvziE=
X-Received: by 2002:a05:651c:cb:: with SMTP id 11mr1964692ljr.159.1606846213318;
 Tue, 01 Dec 2020 10:10:13 -0800 (PST)
MIME-Version: 1.0
References: <20201201072320.44544-1-dwaipayanray1@gmail.com> <2d507d3042a97613078554b1b5f1169ab8c41b42.camel@perches.com>
In-Reply-To: <2d507d3042a97613078554b1b5f1169ab8c41b42.camel@perches.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Tue, 1 Dec 2020 23:39:44 +0530
Message-ID: <CABJPP5A75ufynVGn37XteQ=KBrTenr2dGHPPdz83n1=qg6vztA@mail.gmail.com>
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

On Tue, Dec 1, 2020 at 11:32 PM Joe Perches <joe@perches.com> wrote:
>
> On Tue, 2020-12-01 at 12:53 +0530, Dwaipayan Ray wrote:
> > checkpatch reports a false TYPO_SPELLING warning for some words
> > containing an apostrophe when run with --codespell option.
> >
> > A false positive is "doesn't". Occurrence of the word causes
> > checkpatch to emit the following warning:
> >
> > "WARNING: 'doesn'' may be misspelled - perhaps 'doesn't'?"
> >
> > Modify the regex pattern to be more in line with the codespell
> > default word matching regex. This fixes the word capture and
> > avoids the false warning.
> >
> > Suggested-by: Joe Perches <joe@perches.com>
> > Reported-by: Peilin Ye <yepeilin.cs@gmail.com>
> > Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
> > ---
> > Changes in v2:
> > - Use the default codespell word regex.
> > - Modify commit message to specify --codespell usage
> >
> >  scripts/checkpatch.pl | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
> > @@ -3106,7 +3106,7 @@ sub process {
> >  # Check for various typo / spelling mistakes
> >               if (defined($misspellings) &&
> >                   ($in_commit_log || $line =~ /^(?:\+|Subject:)/i)) {
> > -                     while ($rawline =~ /(?:^|[^a-z@])($misspellings)(?:\b|$|[^a-z@])/gi) {
> > +                     while ($rawline =~ /(?:^|[^\w\-'`])($misspellings)(?:[^\w\-'`]|$)/gi) {
>
> This regex seems to work well, thanks.
>
> >                               my $typo = $1;
>
> A trivial improvement might be to highlight the location of the
> misspelled word with a caret using
>
>                                 my $blank = copy_spacing($rawline);
>                                 my $ptr = substr($blank, 0, $-[0] + 1) . "^";
>                                 my $hereptr = "$hereline$ptr\n";
>
> >                               my $typo_fix = $spelling_fix{lc($typo)};
> >                               $typo_fix = ucfirst($typo_fix) if ($typo =~ /^[A-Z]/);
>
> and using $hereptr and not $hereline when emitting the message.
>
>
Sure I will do that.
Is the color highlighting also supported in most systems? Maybe a red colored
word would be nice to notice as well.

Thanks,
Dwaipayan.
