Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E011E280115
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 16:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732473AbgJAOPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 10:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732147AbgJAOPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 10:15:01 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC4FC0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 07:15:01 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id r10so1508814oor.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 07:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cIliy11i/6b1jwkKYZrsCI0wV8C3PVY/39kWlf3FSSg=;
        b=EWjDPbwRiL1zC9Ta21DE+7v7XnSXoA2jotzSIjmoLNTSwz4BQNEQPRXjT4H3fX0O2X
         uMQqfhC/8Q3v0urNglGowdw1jkEhpbKY4zaNx4gnl1Z+nIC4hlgqw5BF0g8mdXDDSBhM
         SptZ/Ez1pQsNPIEXKLq4hecGkkjkyUwqE/XFQNEobK5Ah87OrSoCNfBMa82+NjA+aN3X
         kkNiGvltdsgGbgs/SOYNcBZJBYGGjRH8nqUczQZ3TkrcPzBRdnUe7pKLcVCygrV6+veS
         B0yuTyZdnro6dkAc7u8Sri4odUonqHIrke4t3gJZ+af3/S1Kww+Kfvp9CmMAawIN5Cdw
         qm5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cIliy11i/6b1jwkKYZrsCI0wV8C3PVY/39kWlf3FSSg=;
        b=kRR3FSXi99/D4ZZJOwNubrXLBfuFgsQCwv1dYinvqxzrqBw550UQBcjJad+p49m5Gz
         z/whkFBFfzmDII1CnHR32hW7PsmaEeWPbrkRfcXaW8CYAha+xVy/zOMar7Jf0D0FkYgk
         9eBQV6s0GYVoIY8uixrE95poS1sN07Ff7/eOaE+Uo3fVgwFlR3yiDx28ytCfnE9Rttm8
         Y8V0X4OuOAV3yPvqxTRxCFrp8vOZDZfVe6bhXHhTamQqI8AsfgeQOQAr5VgBbFTqqmpZ
         BvV9l+z0Rrqs+oeyrKVngvEM1Ew6zb9HeZsGIeMYDnNHwriAYXVgKyaq4qNKFJTgAqxc
         /R1g==
X-Gm-Message-State: AOAM532qucCAYOKjshk+bTkRLvLpCdeOLRc414fy4V1qyPNxDSnJtbaO
        O/pdARbFEC3PxoatzJrdd4Wu/J4UGyiA2bqpYXsxOVJKHw+vI/kx
X-Google-Smtp-Source: ABdhPJx55+7QmRWj7eDHlBi/wiRSQvurvakxS8awujgHqjDJjExP6gEsQ5GwDXySFadM62kCjk9oekBCA3dG3RpyM7k=
X-Received: by 2002:a4a:dc99:: with SMTP id g25mr5751186oou.64.1601561700406;
 Thu, 01 Oct 2020 07:15:00 -0700 (PDT)
MIME-Version: 1.0
References: <20201001103314.136645-1-dwaipayanray1@gmail.com>
 <8e110121c89414ab1601071868dbcf410195a209.camel@perches.com>
 <CABJPP5CFE3KXzMzuvVxtJt5tOg8Ye6y1V7-mqT5pqazHjVWvJw@mail.gmail.com> <f3dadda8af7eef6613d7a4105170058f2759507d.camel@perches.com>
In-Reply-To: <f3dadda8af7eef6613d7a4105170058f2759507d.camel@perches.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Thu, 1 Oct 2020 19:44:38 +0530
Message-ID: <CABJPP5AM01voDwARL4G0vMhFw4hMY+=dEQ7=obiKPzNtunyb7Q@mail.gmail.com>
Subject: Re: [PATCH RFC] checkpatch: fix multi-statement macro checks
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 1, 2020 at 7:12 PM Joe Perches <joe@perches.com> wrote:
>
> On Thu, 2020-10-01 at 18:57 +0530, Dwaipayan Ray wrote:
> > On Thu, Oct 1, 2020 at 6:47 PM Joe Perches <joe@perches.com> wrote:
> > > On Thu, 2020-10-01 at 16:03 +0530, Dwaipayan Ray wrote:
> > > > Checkpatch.pl doesn't have a check for excluding while (...) {...}
> > > > blocks from MULTISTATEMENT_MACRO_USE_DO_WHILE error.
> > > >
> > > > For example, running checkpatch.pl on the file mm/access.c in the
> > > > kernel generates the following error:
> > > >
> > > > ERROR: Macros with complex values should be enclosed in parentheses
> > > > +#define copy_from_kernel_nofault_loop(dst, src, len, type, err_label)        \
> > > > +     while (len >= sizeof(type)) {                                   \
> > > > +             __get_kernel_nofault(dst, src, type, err_label);        \
> > > > +             dst += sizeof(type);                                    \
> > > > +             src += sizeof(type);                                    \
> > > > +             len -= sizeof(type);                                    \
> > > > +     }
> > > >
> > > > The error is misleading for this case. Enclosing it in parantheses
> > > > doesn't make any sense.
> > >
> > > OK
> > >
> > > > Checkpatch already has an exception list for such common macro types.
> > > > Added a new exception for while (...) {...} style blocks to the same.
> > > > This effectively fixed the wrong error message.
> > > []
> > > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > > []
> > > > @@ -5342,6 +5342,7 @@ sub process {
> > > >                           $dstat !~ /^\.$Ident\s*=/ &&                                # .foo =
> > > >                           $dstat !~ /^(?:\#\s*$Ident|\#\s*$Constant)\s*$/ &&          # stringification #foo
> > > >                           $dstat !~ /^do\s*$Constant\s*while\s*$Constant;?$/ &&       # do {...} while (...); // do {...} while (...)
> > > > +                         $dstat !~ /^while\s*$Constant\s*$Constant\s*$/ &&           # while (...) {...}
>
> Note the \s*
>                                                               ^
>
> > > Did you try to output $dstat for some matching cases?
> > > What was the $dstat value for the cases you tried?
> > >
> > >
> > Hi,
> > I did check $dstat values.
> >
> > For example on file mm/maccess.c, there were two such macros:
> >
> > Case 1:
> >
> > $ctx:
> > +#define copy_from_kernel_nofault_loop(dst, src, len, type, err_label) \
> > + while (len >= sizeof(type)) { \
> > + __get_kernel_nofault(dst, src, type, err_label); \
> > + dst += sizeof(type); \
> > + src += sizeof(type); \
> > + len -= sizeof(type); \
> > + }
> >
> > $dstat:
> > while 1 1
>
> And perhaps this test should use \s+ instead.
> What is $dstat with a #define like:
>
> #define foo(bar,baz)while(bar){bar--;baz++;}
>
> (no spaces anywhere bot the required one after define
>

In this case, $dstat is: while11

So, if \s+ is used, it won't match with this. I ran checkpatch
on it and some other condition seems to match, so it is
excluded from the error.

However, if the macro is like:

#define foo(bar,baz)while(bar) {bar--;baz++;}
(one space after condition)

$dstat is: while1 1
(space after first 1)
and the same error is again emitted.

So I think \s* works better since there can be
0 or more whitespaces between them.

Thanks,
Dwaipayan.
