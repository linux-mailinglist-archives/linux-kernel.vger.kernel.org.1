Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C39653029DC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 19:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731297AbhAYSRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 13:17:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730916AbhAYSQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 13:16:40 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5CCC061574
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 10:16:00 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id q7so9476712pgm.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 10:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZCe2/FF+DvZDaRPvAZh3BnHgq5iKGe4t/Q1fBpszZFI=;
        b=Gi+ZKU1fgDCC43LVWcDLZi1V+dwx/rGL4iwHTgjDq1/GzDKWVBq6+7M102wga4p9gm
         cUwDbRj2TBu4MeTHxmEQKFYLadgFOXz2euunjPwMOz/RPdraM6RFRyCQiRh0Brzlz9Tw
         FN/axQhY4MULtWEHP32q6YfgdwNPq5ytkQ+6oHFmwae9MqDVo1+eIbugfHC51vLDeqnK
         hyay/bTK2QwtHHdhEKN5sysPYR/pmw0tRrXerU59neaWXaamTJY52lLTvPGMlBEOJJS0
         dNz6h76WyO+Fwq3T8K8HK1P4BizLK/8S6xHqfYOy/I1s1juPAyzkDbnyUmL89t6W0WFL
         ellw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZCe2/FF+DvZDaRPvAZh3BnHgq5iKGe4t/Q1fBpszZFI=;
        b=mmO3O8Hjf2B6OC8IqnPJrxlqOFP9gGzHXX5ADPsY8HsQBRBC3PIkIgodoUPQVyUNd8
         pbuY+r4nvVQCLKZUkEMvT9Ocv0wLxWn2o89NcaRCAnKeQ5EgdQ4PdlQBw+rAEyxMUN+9
         4rrTRSAGB7GBnzSXuVSnWr85ptEhNtwrtfR5yexKM0MyQ6mxksXB9oWEC7vfBT33W7lD
         BwICfXVvAG6Lxvdadlo5oVvG12pM5nPOs44/tsBxhSO9bpIyvH9CfPo7D7GkrcG98Kvx
         J0QXcHPxRTtWp/rlc+H11BLjSornrpL95kxQ7NYGsnVkJtBFhb4oRL1Ob5/KnxNYPWXQ
         pnfg==
X-Gm-Message-State: AOAM530GGt2TTHyE/XF11jKC+ElSdFSSI3HOp2ZF9T37kODfhIfM9WRT
        p3CRMmbqacGaUghI1rnHOc9GmTbRTbpb1EsixynIOw==
X-Google-Smtp-Source: ABdhPJwM4jcYIy9qZyhngA4TyoNbXq1yWRIwl283sE9sMGQlNDftJP0R9B92LOZv2Y/jakyTdjE67K5jac7l8BuJckw=
X-Received: by 2002:a63:1f47:: with SMTP id q7mr1786622pgm.10.1611598560014;
 Mon, 25 Jan 2021 10:16:00 -0800 (PST)
MIME-Version: 1.0
References: <f23f4003-0017-d52a-39b9-2737e60182bb@gmail.com>
 <20210123190459.9701-1-yashsri421@gmail.com> <a7329e5d5661ed6478a7eb33db854a6357447c16.camel@perches.com>
In-Reply-To: <a7329e5d5661ed6478a7eb33db854a6357447c16.camel@perches.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 25 Jan 2021 10:15:49 -0800
Message-ID: <CAKwvOdm+qyD-ycaP=x+JGEtFDvoW7SGwB0HJ1UJXm5cwqkR9PQ@mail.gmail.com>
Subject: Re: [PATCH v3] checkpatch: add warning for avoiding .L prefix symbols
 in assembly files
To:     Joe Perches <joe@perches.com>
Cc:     Aditya Srivastava <yashsri421@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        dwaipayanray1@gmail.com, Mark Brown <broonie@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 23, 2021 at 1:01 PM Joe Perches <joe@perches.com> wrote:
>
> On Sun, 2021-01-24 at 00:34 +0530, Aditya Srivastava wrote:
> > objtool requires that all code must be contained in an ELF symbol.
> > Symbol names that have a '.L' prefix do not emit symbol table entries, as
> > they have special meaning for the assembler.
> >
> > '.L' prefixed symbols can be used within a code region, but should be
> > avoided for denoting a range of code via 'SYM_*_START/END' annotations.
> >
> > Add a new check to emit a warning on finding the usage of '.L' symbols
> > for '.S' files, if it denotes range of code via SYM_*_START/END
> > annotation pair.
> >
> > Suggested-by: Mark Brown <broonie@kernel.org>
> > Link: https://lore.kernel.org/lkml/20210112210154.GI4646@sirena.org.uk
> > Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
>
> Acked-by: Joe Perches <joe@perches.com>

Acked-by: Nick Desaulniers <ndesaulniers@google.com>

Thanks for the patch Aditya!

>
> > ---
> > * Applies perfectly on next-20210122
> >
> > Changes in v3:
> > - Modify regex for SYM_*_START/END pair
> > - remove check for arch/x86/entry/* and arch/x86/lib/*
> > - change 'Link:' in commit message to lkml
> > - Modify commit description accordingly
> >
> > Changes in v2:
> > - Reduce the check to only SYM_*_START/END lines
> > - Reduce the check for only .S files in arch/x86/entry/* and arch/x86/lib/* as suggested by Josh and Nick
> > - Modify commit message
> >
> >  scripts/checkpatch.pl | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index 7030c4d6d126..4a03326c87b6 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -3590,6 +3590,13 @@ sub process {
> >                       }
> >               }
> >
> >
> > +# check for .L prefix local symbols in .S files
> > +             if ($realfile =~ /\.S$/ &&
> > +                 $line =~ /^\+\s*(?:[A-Z]+_)?SYM_[A-Z]+_(?:START|END)(?:_[A-Z_]+)?\s*\(\s*\.L/) {
> > +                     WARN("AVOID_L_PREFIX",
> > +                          "Avoid using '.L' prefixed local symbol names for denoting a range of code via 'SYM_*_START/END' annotations; see Documentation/asm-annotations.rst\n" . $herecurr);
> > +             }
> > +
> >  # check we are in a valid source file C or perl if not then ignore this hunk
> >               next if ($realfile !~ /\.(h|c|pl|dtsi|dts)$/);
> >
> >
>
>


-- 
Thanks,
~Nick Desaulniers
