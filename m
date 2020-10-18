Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C04DE291648
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 08:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgJRGke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 02:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbgJRGke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 02:40:34 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA5AC061755
        for <linux-kernel@vger.kernel.org>; Sat, 17 Oct 2020 23:40:33 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id n11so1999927ota.2
        for <linux-kernel@vger.kernel.org>; Sat, 17 Oct 2020 23:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gRbfK/w/58D7qQC029pKGSVGRS/jDpu6/Ih6yqOrFPw=;
        b=pgbBFNxmzAveeohnIeVe72J6Fj9OmClKe5Onk/chFEEwwGPAAxITS6RYPA+IdoWxBR
         fxdKCYXov+Hl5vYxrnH5sxbNa5oA7F3P0Jlei2LEz70yjNXWv7VzDRZvDVM509G3LQ1x
         dqbbw3oMe1FxvaHMvQ554xOS/orM6/X/jdFdaBrYh45H+Ymy/C8jmdAotaFcR7NHIq6y
         Nq9sqHR0HMyzGqWQh1c0SwTsGAAqdy5y3fSFu90LXDPhE//99S4G6ZY9d2REhvwSfUkP
         Luro/6LxBmyrRhvU1A0VJK7H48WCsH7AbAaaAAxsnnRred0Yn6ejzVazFrqXhohu2R6j
         S09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gRbfK/w/58D7qQC029pKGSVGRS/jDpu6/Ih6yqOrFPw=;
        b=IUCnTi0FkCVvycKuHE6n5HriQvsHtBqnd5TBomU8ddV2VVeAcManvgcRRFqA77GqAK
         jMYiY+rWIR49cmbep4lFZ3B8ly0KN5YRLchlCUcDGZJtaIj5hcwS289d5C76Sq1UsZSM
         3t7fUlT1NHELqZIEhRd9FFneI6vtypoIyfv5u/xnlz49/3P7Tc3r30lbHCff4XmLq2r4
         yiUaPEg8sMCWhZmJ4FAjFhRANTd8IbsKCcdug620zKWiHv2AMlhlgwb93PWUI92g2/D5
         jhKGWN9VZuP5gp7NZVsXqBYYPs9kyW9pZ0uzMkgZLe6ovWivvzSNfKM82GMScDYimep3
         AaPA==
X-Gm-Message-State: AOAM531Xd82NsLWr7uurRT5LY986lEpDAxhy3IPGEQ2nNWnUhWGy9HQN
        MrIiQq0+xVdFy4sdhyUTa/atZ6tOPgUoOuaK+PPBfDNxAEjqdOly
X-Google-Smtp-Source: ABdhPJzv+aywb1TLkB0Yr+2VkEg95gln7XVwiV7WFMjyYd0QnPl1yTkfJaIA8BLBC6ru8TwO5kfNXq8r5KFIrXHAbH8=
X-Received: by 2002:a9d:53cc:: with SMTP id i12mr8061129oth.215.1603003232248;
 Sat, 17 Oct 2020 23:40:32 -0700 (PDT)
MIME-Version: 1.0
References: <20201017162732.152351-1-dwaipayanray1@gmail.com>
 <1ad9c5f49e10a192f0c6efb1116f3f0d31adce74.camel@perches.com>
 <CABJPP5DuQ_Y0LLS5BzNXUWyxjzp9ts5kgEH-3+7Pn7PPjq0Ljg@mail.gmail.com> <eda7a64b4af42ba1fb66a5b3704780cf3f761951.camel@perches.com>
In-Reply-To: <eda7a64b4af42ba1fb66a5b3704780cf3f761951.camel@perches.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Sun, 18 Oct 2020 12:10:05 +0530
Message-ID: <CABJPP5Cr3giDJkJvBDd62iwx6y6r1dFhaVXp9jYXS8Y6k9b09A@mail.gmail.com>
Subject: Re: [PATCH v5] checkpatch: add new exception to repeated word check
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 18, 2020 at 11:50 AM Joe Perches <joe@perches.com> wrote:
>
> On Sat, 2020-10-17 at 22:19 +0530, Dwaipayan Ray wrote:
> > On Sat, Oct 17, 2020 at 10:03 PM Joe Perches <joe@perches.com> wrote:
> > > On Sat, 2020-10-17 at 21:57 +0530, Dwaipayan Ray wrote:
> > > > Recently, commit 4f6ad8aa1eac ("checkpatch: move repeated word test")
> > > > moved the repeated word test to check for more file types. But after
> > > > this, if checkpatch.pl is run on MAINTAINERS, it generates several
> > > > new warnings of the type:
> > >
> > > NAK.
> > >
> > > Slow down and test before you send more patch versions.
> > >
> > > > +                             next if (index(" \t.,;?!", $end_char) == -1);
> > >
> > > what does this do?
> >
> > Um, it checks if end_char is not present in " \t.,;?!".
> > If end_char doesn't belong to this list, then the check shall
> > skip. That is the test will skip for "word word:", but will produce
> > a warning for "word word." or "word word?", etc.
> >
> > Shouldn't this itself be the case or am I perhaps going wrong
> > somewhere?
>
> No, you were right, I was being a numbskull.
>
> btw: I think this should set
>         my $end_char = ' ';
> not ''
>
> so that if the last word on a line is a
> repeat the test still works.
>
Hi,
Umm, index() function seems to return 0 when an empty string is
passed. I tried this:

print index(" \t.,;?!", '');

It output 0 in my case. So last words on a line seems to work.
I don't know if this changes with the perl version though.

So given this, will it be necessary to change end_char to ' ' ?
or perhaps change both start_char and end_char to a ' ' to maintain
uniformity?

Thanks,
Dwaipayan.
