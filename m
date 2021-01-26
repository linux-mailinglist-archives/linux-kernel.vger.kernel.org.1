Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB7B4304F9C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235380AbhA0DQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:16:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727893AbhAZU2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 15:28:22 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A205EC061786
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 12:27:41 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id t8so13863783ljk.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 12:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G7BC90CD0PTIY5W4UOf1348/2Sa1Lnw1RkYhz1sW+sA=;
        b=NPg1HEvtCwWlJa993kKYIe+SG+enh875iXr3N0aD5t555WhYrGKysxVnXd3vA98soC
         PwvyIdUVKStnvrWaMl9LeolGj2KkqA9E0K7rlUTNdltYfKtHAY1Ygeg1kreGQPwKLRD/
         +tAgK8/6wxVyNx34CBJOURbgFmEpzEhoQf6ivV3NMGqljBqmGSHOYwTyV4FNkkKjQ/J4
         /higQVrTmor3NGlbv5rd37kp72cAcHb1aeglcLstefkAKug20su5P4PKDHCGQSRW3cdn
         xNKCDMxAZC5gQEHgPI51gNAdW3piWobR8vVgnuU+nj851o/qPdtc9fcOpLGHd+XmmJ93
         whPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G7BC90CD0PTIY5W4UOf1348/2Sa1Lnw1RkYhz1sW+sA=;
        b=HFo2BcBPadiLCPfiyQoMmKSvK8L/c4ZKkvgiqfuA0TPTonIau0TpR6HNJldgKL6xvg
         RMX/P+v2ObWXNoZY1qSs9OINvawY2rOzcOjN9SRPbyQNCu2RGnWIQboC90MKfxT+qLqM
         VjiwUoCFGkKfPyr6exqpDOfuW9iAbXg0HV5NKMJY+XhtER85PLctRhZx1fbJDLVF/ur6
         +0lkV9wO+7ADtPVi8D1WYSj0ehXPUh99CAkP9d6WYADa2ES19IvHic5FAwvCzU6c1Zk9
         D0sR0zrOWCJgNPO6p5F83FuflA5fArgkI9dQdQFF9gDN05XvUecsDCh33a7K2HK5230r
         Q4ZA==
X-Gm-Message-State: AOAM533lx6GhnJJFsf51oarz8v3CNdijoy5jMLfLLGSPuTsXxqNVPPly
        VFmDTa9CU8GNxvrnSjiPhunhKTCYMlYrG13SL3ii26Bb1SykCg==
X-Google-Smtp-Source: ABdhPJzkVErijr+p+Mfq1XpcjOKKxt+JDm3KkQj0vMJ0bn3CLcDezRmve4eDY2+hbvIc/lBLGK95uMBqtC2cr6zsvzA=
X-Received: by 2002:a2e:9086:: with SMTP id l6mr3827824ljg.510.1611692859787;
 Tue, 26 Jan 2021 12:27:39 -0800 (PST)
MIME-Version: 1.0
References: <20210126183521.26535-1-dwaipayanray1@gmail.com>
 <20210126183521.26535-2-dwaipayanray1@gmail.com> <9bfc9c21d93bb55419954114ed3a7e5cbdc84ddb.camel@perches.com>
In-Reply-To: <9bfc9c21d93bb55419954114ed3a7e5cbdc84ddb.camel@perches.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Wed, 27 Jan 2021 01:57:36 +0530
Message-ID: <CABJPP5Ap2=-suEZv+6OVONBPZjLEJEszG=O5ikDxHPiCcBRbFA@mail.gmail.com>
Subject: Re: [PATCH RFC 1/3] checkpatch: add verbose mode
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 1:41 AM Joe Perches <joe@perches.com> wrote:
>
> On Wed, 2021-01-27 at 00:05 +0530, Dwaipayan Ray wrote:
> > Add a new verbose mode to checkpatch.pl to emit additional verbose
> > test descriptions.
> >
> > The verbose mode is optional and can be enabled by the flag
> > --verbose.
> >
> > The test descriptions are itself loaded from the checkpatch
>
> descriptions are themselves, but themselves is unnecessary.
>
> The verbose descriptions are read from Documentation/dev-tools/checkpatch.rst
>
> > documentation file at Documentation/dev-tools/checkpatch.rst.
> > The descriptions in the documentation are in a specified format
> > enclosed within .. CHECKPATCH_START and .. CHECKPATCH_END labels.
> >
> > This serves a dual purpose as an external documentation to checkpatch
> > as well as enables flawless integration of the verbose mode.
>
> Using 'flawless' when describing code or documentation generally isn't true.
>
> > A subtle example of the format is as follows:
>
> What is subtle about an example?
>
> If there is something subtle about an example, there's also something
> wrong with the example.
>
> > Documentation/dev-tools/checkpatch.rst:
> >
> > .. CHECKPATCH_START
>
> Nak on the keyword uses.
>
> This should really just parse the input file whenever TYPE is found
> via some fixed format and save the verbose description after that.
>
> Use .rst Field Lists instead, and ideally, keep the list in alphabetic
> order or group by similar use.
>
> https://docutils.sourceforge.io/docs/user/rst/quickref.html#field-lists
>
> e.g.:
>
> :LINE_SPACING:
>         Vertical space is wasted given the limited number of lines an
>         editor window can display when multiple blank lines are used.
>
> :SPACING:
>         Whitespace style used in the kernel sources is described in
>         ref:`Documentation/process/Coding-Style.rst section 3.1.
>
> :TRAILING_WHITESPACE:
>         Trailing whitespace should always be removed.
>         Some editors highlight the trailing whitespace and cause visual
>         distractions when editing files.
>
> etc...
>
> > @@ -2185,6 +2235,11 @@ sub report {
> >               splice(@lines, 1, 1);
> >               $output = join("\n", @lines);
> >       }
> > +
> > +     if ($verbose && !$terse &&
> > +         exists $verbose_messages{$type}) {
> > +             $output .= $verbose_messages{$type} . "\n\n";
> > +     }
> >       $output = (split('\n', $output))[0] . "\n" if ($terse);
>
> Don't use unnecessary multiple tests of the same object, just reorder
> the code instead.  And also please use c-style function parentheses
> rather than bare tests.
>
>         if ($terse) {
>                 $output = ...
>         } elsif ($verbose && exists($verbose_messages{$type})) {
>                 $output .= ...
>         }
>

Thanks for the pointers!
Also for the output part can we do something to make the text
look a bit more nice? I think some of the verbose descriptions
can go a bit long.

Also will the verbose descriptions be limited to say single
paragraphs? If there are multiple paragraphs then the output
does appear a bit messy.

Thanks,
Dwaipayan.
