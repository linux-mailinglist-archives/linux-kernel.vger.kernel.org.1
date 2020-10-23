Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8B1E29788C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 22:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756457AbgJWU5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 16:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755568AbgJWU5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 16:57:35 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1206BC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 13:57:35 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id m11so2544418otk.13
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 13:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0Q8U+/L+NAiRMdEBVnPpKYlruFlFQNzfDyRSymCS36c=;
        b=CItn4+dM+cWWmNiowOMFXvq9LN4GMPvAPD7XH8de04+O2R8pu8O3HFIeVGOE8PqtUc
         ZspxhlmfaEwDafnVzByaj/vrEY1JudiGizG+mcmam/4dx5G/zXbG3L456Y7nyFPEVDQq
         CFkYNkOPLHg8+H1O6NuugtrNZ1H+gArqi8waCIVeECZ+1gc5rcxlJDOa30OmdG7yo6Uz
         4xdt/agS32663/X+bhNEKix2ifHHJE+I1HPf220V7NeUTcq7dA10qavuyMML9TPSAJFF
         gOTG7EBIyuHei5muqksmsVTk0YBNfI1yCWrEJU8UDRs2SStbXozawXW1zCRjace47zWH
         tRwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Q8U+/L+NAiRMdEBVnPpKYlruFlFQNzfDyRSymCS36c=;
        b=kAHKWRTSOmCAN9/Qp23UWlaclJkEZVEGdXw/Mf49U4IFCgm5oxkrzX1iVQefMKHNda
         ZZyCZMx80oXQMXMl1VISk0yhis4Locivrttq6wDV9n3ABJbJ1+VJivkyO/Z95gqSbcxL
         hjAbsz/OenSTjHR4V5119REseaJYyKrLap+NT4baACPkQfh6uLCzE+HqTDi1Ls30MP/x
         3uawTI2Q2n1IKtVdZI5Ygy8aoqQNTj9m7wDZWZ3G6brht4l4fTPz3+AKB5nXJNaNoEKG
         sMAsyk7t7zQMLdelwZqvc5xXoYypuAkvwFUhhB3kENgHEKEH2EWg4f3PJYlRGw0XVGYR
         Ok6w==
X-Gm-Message-State: AOAM5336/0di2TQSFHKiNHZ9aUgRztUqUcmD0OZPcfLnDi3o18f+DR/p
        3T+fFTlhACPyHlTSW6KI5StVSjg+U/7I4yLFuXwK4YUkDz3nu5Ug
X-Google-Smtp-Source: ABdhPJyOLkHkxb4WQxUBzquEtUfl5S2mbcqKFZaUqbtDYYpTb7DpMjuz1m7knFJj9r+KXaBZtOc20iTkNUQ0vZOOldo=
X-Received: by 2002:a05:6830:1db1:: with SMTP id z17mr3510344oti.30.1603486654226;
 Fri, 23 Oct 2020 13:57:34 -0700 (PDT)
MIME-Version: 1.0
References: <20201023094307.20820-1-dwaipayanray1@gmail.com>
 <d2b05b45adbcf3f1d16692b054862a7aa7353f6d.camel@perches.com>
 <CABJPP5Dx4qj-_0gOx0bmaWvJj3okB-tNGJg5-8Y3KF2LnCjowQ@mail.gmail.com>
 <2e8279841d604dde8a3335c092db921007f6744e.camel@perches.com>
 <2a3b90ee-b9bd-2586-9d68-45cbf7e499a9@gmail.com> <8710630d8c01bf6f3749e3d11d193a805f2d2048.camel@perches.com>
In-Reply-To: <8710630d8c01bf6f3749e3d11d193a805f2d2048.camel@perches.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Sat, 24 Oct 2020 02:27:05 +0530
Message-ID: <CABJPP5AcjAq0kg0MMggd2D6YUwVhq96otm-qQB3Snddt77VxAA@mail.gmail.com>
Subject: Re: [PATCH RFC v2] checkpatch: extend attributes check to handle more patterns
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 24, 2020 at 2:12 AM Joe Perches <joe@perches.com> wrote:
>
> On Sat, 2020-10-24 at 00:44 +0530, Dwaipayan Ray wrote:
> > Hi,
>
> Hi again.
>
> > I modified the check to check the attributes from the map.
> > There are two checks - one for the normal attributes and
> > one for the ones with arguments, which needs just a bit more
> > processing.
> >
> > So attributes like __packed__ as well as those like
> > __aligned__(x) are handled.
> >
> > What do you think?
> >
> > ---
> > +            $line =~ /__attribute__\s*\(\s*($balanced_parens)\s*\)/)
> > {
> > +            my $attr = trim($1);
> > +            $attr =~ s/\(\s*_*(.*)\)/$1/;
> > +            while($attr =~ s/(.*)_$/$1/) {}  # Remove trailing
> > underscores
>
>         I think this could be a single test like:
>
>                 while ($attr =~ /\s*(\w+)\s*(${balanced_parens})?/g) {
>                         my $curr_attr = $1;
>                         my $parens = $2;
>                         $curr_attr = s/^_*(.*)_*$/$1/;
>

Thanks, I will do that.

Also I tried the pattern  attr =~ s/^_*(.*)_*$/$1/
for trimming the _ earlier. I think it doesn't trim the
trailing underscores in the suffix as (.*) captures everything greedily.

Is the iterative one perhaps okay instead?
while($attr =~ s/(.*)_$/$1/) {}

> > +            my %attr_list = (
> > +                "alias"            => "__alias",
> > +                "aligned"        => "__aligned",
>
> These might be better using tab alignment.
>
> And you might special case format(printf/scanf here too

Yes I think they are special cases now too. I didn't post the
entire context, so my mistake.

Thanks,
Dwaipayan.
