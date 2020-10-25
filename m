Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 149B6298300
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 19:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1417958AbgJYSLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 14:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1417947AbgJYSLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 14:11:24 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E68FC061755
        for <linux-kernel@vger.kernel.org>; Sun, 25 Oct 2020 11:11:24 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id y186so1139407oia.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Oct 2020 11:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ed8KRRrEZsM2HNUKQHpYxYL+wtB5fsFk05An48o7JFg=;
        b=G9YFW5N3nv+fWtb0RfTa4V7P6DMgOr1IkGSWbi59smcQpNo5dGFJf9PPdEaITKJzC3
         bO4O1ivoIiO23X/F47h8VcMBrSHmLc1XGE2rRcS3HcbxGV7qew6jkVq8L+AIGzWA4u7l
         KsnDUaBQAsih9emZ70zSW6D+i6ibbifFgYtHCIyORTncbLa2t3sf6s1JvZkeVwW/yhVS
         FkKufEq3151a7zsd139pYSp6OB1NA27ICSbKNwE/j2gi3cYuM7bBHRegSdRRh5b8XvQT
         Fl3cUjeoKH5Xi+/0iYMY11MgFo3eEFK5yq0CHegZkDCKG/AkvGjx8mN0GGaBJjsgOZAQ
         AMMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ed8KRRrEZsM2HNUKQHpYxYL+wtB5fsFk05An48o7JFg=;
        b=Jq0eBpS67hK24xgVOBJSO1n4c3NOqXL4oQBf94VNVqMMYrUd9KjwU2VLzT+5iVNpwu
         rkMjyfKA1AiKucqw1Tz6xoZ/S8+erbvIHFLSn49iQhoiHwiGJTz005/Lu/1lJt0VmPAR
         nswivqmJRzOIFItSIj3D6x1ZKTxllYEhG9JMqQTM3Wvdcpjcbe47lYh7EmrbZCbYXzG1
         UqMza1rX47mAUFITCMgwv56AGtAMQ0s6Cu2j9vptzqn53sJzLXojHXI9s5VKu9L0ddAc
         bMgWvMjnlviBbkyarKmvPOMG6cuFnBzt9nCRXBpWTdj3ej5KYAz28+VrM3TUOGETlCZY
         fsvg==
X-Gm-Message-State: AOAM530Lm15MQ09lLVy1IqiSz127sPbdVAFdGaLnV2a7aVbILphIVknQ
        4tr4FAoymlexRgVt4QkVMBlRkRKLkK8OcshyE4uGQ3NAnQxvAhR7
X-Google-Smtp-Source: ABdhPJxP0fvcw0qSr81JHp5Cbznf8QCPLDFhYAnuCgTNLfAIFDcntT8oSDBcZ+DU1cqGecUiPra9hcEdq/lIerH+1KM=
X-Received: by 2002:aca:d5d2:: with SMTP id m201mr9917896oig.74.1603649483265;
 Sun, 25 Oct 2020 11:11:23 -0700 (PDT)
MIME-Version: 1.0
References: <20201025101537.59133-1-dwaipayanray1@gmail.com> <52f88d0bb938c5063ede693a05bf64961af5a496.camel@perches.com>
In-Reply-To: <52f88d0bb938c5063ede693a05bf64961af5a496.camel@perches.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Sun, 25 Oct 2020 23:40:54 +0530
Message-ID: <CABJPP5Cec7jKfaygRaxm-z5gzhg-7cBX1GP46NRQDM6rfhg3Ww@mail.gmail.com>
Subject: Re: [PATCH v5] checkpatch: extend attributes check to handle more patterns
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 25, 2020 at 11:29 PM Joe Perches <joe@perches.com> wrote:
>
> On Sun, 2020-10-25 at 15:45 +0530, Dwaipayan Ray wrote:
> > It is generally preferred that the macros from
> > include/linux/compiler_attributes.h are used, unless there
> > is a reason not to.
> >
> > checkpatch currently checks __attribute__ for each of
> > packed, aligned, section, printf, scanf, and weak. Other
> > declarations in compiler_attributes.h are not handled.
> >
> > Add a generic test to check the presence of such attributes.
> > Some attributes require more specific handling and are kept
> > separate.
> []
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
> > @@ -6155,50 +6155,95 @@ sub process {
> >                       }
> >               }
> >
> >
> > -# Check for __attribute__ packed, prefer __packed
> > +# Check for compiler attributes
> >               if ($realfile !~ m@\binclude/uapi/@ &&
> > -                 $line =~ /\b__attribute__\s*\(\s*\(.*\bpacked\b/) {
> > -                     WARN("PREFER_PACKED",
> > -                          "__packed is preferred over __attribute__((packed))\n" . $herecurr);
> > -             }
> > +                 $rawline =~ /\b__attribute__\s*\(\s*($balanced_parens)\s*\)/) {
>
> Using $rawline would also change comments and that seems wrong.
> Any reason to use $rawline instead of $line?
>
Hi,
Yes I used $line initially but changed it because quoted
strings were being replaced.

Like:
__attribute__((__section__("_ftrace_events")))

$line in this case was:
__attribute__((__section__("XXXXXXXXXXXXXX")))

While $rawline was:
__attribute__((__section__("_ftrace_events")))

So to avoid this problem I changed to $rawline.

Is there any other alternative available perhaps?
Or should I change back to $rawline?

> []
>
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
Yes I will do that sure.

Thanks,
Dwaipayan.
