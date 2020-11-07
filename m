Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 872FC2AA26A
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 05:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbgKGElk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 23:41:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727146AbgKGElj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 23:41:39 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637B6C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 20:41:39 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id q19so1967917ljc.10
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 20:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z9FkVnNdE3X+MQNax0vO+HWVuHxylsA9O+a/7uBPt24=;
        b=GYeGhjrD6mZRRKLbSLxHz+c5Sbl2zXRzbdK6eJyv26goIqelUysR0ccTPZClsX5GqH
         j3B8MWPKPb9jgPBtIiFDKobo3cFqazE0RwbuLwc8J3ouR7wHptzRw5XkCOCngiGoAgRU
         GbNDV37hfuK34xwlIE6Qfw8qPueP0/NMs0nXLc69qRDVlvBWC7FhwPKSFzUhnY3UWCxy
         W+OipAxBKn1qGhaBGXaHGfTrkBrg/ijUwLYu1+JVHKN/YzkonDoV0C+/NizUGDsInOnT
         u56yr+ZF+vfurQMrnwqF+tX671TW3YSJX7KdDdjBxOciP+JF1NJ46zKMuHcbBAaFg9mm
         adMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z9FkVnNdE3X+MQNax0vO+HWVuHxylsA9O+a/7uBPt24=;
        b=WTk8vlF8Yi8nkRgS5G4gwgLNpEIpgD209HRSDz+06lH6b+yFlEC/3ehEGuFY7mRcH4
         KiAMIn9n2GQ7uPNNBIaleyUARBjfuT7JbHizKma5xkKRmRese0mbK0m7N0Iz/2fWlOhy
         SbIbudCh6uN6Lvv6v2+fwcNG6+o2Dz/GYNc/w4IJNollWsNpgjy0LKBbWI791zWVpcYa
         b0s/yoYcxd4tiX1Oc5M7dVsGT+69v8zJZ6tj6OJsE9BmDarS+GRAQOnGdAg+0LtluyJh
         89mw/0FFG1MNo+6yLALiP0LlprRNmbpeiZdlo1awsBSIClHVfaHBdkwmtH2n9CkZ342R
         aOWw==
X-Gm-Message-State: AOAM531RoFo3nSkE1STlKFl7zCbE4jPPQdUGlAMRH7mXEGlp4h6phBGw
        85xSm8eCm5hCoeCTp+Kav+BTSjnt8D03Eo7xIKcESvy32sQ=
X-Google-Smtp-Source: ABdhPJz+oCoqOrW4p9s/8M/N4SaexLXsT2Mq4h6CG6Xj+x51vDC5wngGi3cT3MDcgswHf6IqW/ph/oNEFyUYJ+2dtDI=
X-Received: by 2002:a05:651c:cb:: with SMTP id 11mr2043437ljr.159.1604724097606;
 Fri, 06 Nov 2020 20:41:37 -0800 (PST)
MIME-Version: 1.0
References: <20201106214530.367247-1-dwaipayanray1@gmail.com> <38c2889ad15c0f34ce8c223518f1f6dbc9945286.camel@perches.com>
In-Reply-To: <38c2889ad15c0f34ce8c223518f1f6dbc9945286.camel@perches.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Sat, 7 Nov 2020 10:11:07 +0530
Message-ID: <CABJPP5Dyc4iK-3f-N1eKF9sPZhpr6A92PA1rFo1rx+9qvO10zQ@mail.gmail.com>
Subject: Re: [PATCH v4] checkpatch: improve email parsing
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Aditya Srivastava <yashsri421@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 7, 2020 at 3:34 AM Joe Perches <joe@perches.com> wrote:
>
> On Sat, 2020-11-07 at 03:15 +0530, Dwaipayan Ray wrote:
> > checkpatch doesn't report warnings for many common mistakes
> > in emails. Some of which are trailing commas and incorrect
> > use of email comments.
>
> Assuming it all works, this looks good.  I haven't tested it.
>
> How did you test the $fix bits?
>
Hi,
I actually dumped about 17k unique emails from git log, put it in one of
my previous patches, and ran checkpatch with --fix on it.
I checked the diff and most of the cases looked pretty good to me.
I could send the diff output if you like?

> Trivial notes:
>
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
> > +                             # stable@vger.kernel.org or stable@kernel.org shouldn't
> > +                             # have an email name. In addition commments should strictly
> > +                             # begin with a #
> > +                             if ($email =~ /^.*stable\@(?:vger\.)?kernel\.org/) {
>
> Likely better to test with a case insensitive match so
> STABLE@vger.kernel.org and such are still warned.

Sure, I will do that.
>
>                                 if ($email =~ /\bstable\@(?:vger\.)?kernel\.org\b/i) {
>
> > +                                     if ($sign_off =~ /cc:$/i && (($comment ne "" && $comment !~ /^#.+/) ||
> > +                                         ($email_name ne ""))) {
>
> || $sign_off !~ /^cc:/i ?

I actually had a doubt about that one. Only the stable address with
Cc: should be checked right? Or something else?

What about those stable addresses with tags other than Cc: ? Should
a change be suggested?

Thanks,
Dwaipayan.
