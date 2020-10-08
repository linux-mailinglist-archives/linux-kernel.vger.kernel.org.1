Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFD7F286D03
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 05:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbgJHDI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 23:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbgJHDI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 23:08:57 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F7DC061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 20:08:57 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id 33so4251525edq.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 20:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=epOsPM+GfGFNG1tX0bdsLvVn3NVsyOem8V1fi1iQRnE=;
        b=Aw304WKc6ervMoS1h9Fu4jp6bkZ0f6JWCrTe7S5mfXx1YnKsMGMr3UUj6z09IAAIoW
         sZgcvKVtrELccBGzFsczFyqUWI31XiDmyie+Wg4fnNyHechr40V7NsqcGDGWLHsJ5y4C
         iRPXHkoBfKmZskjWxaxAYn5yTBMyOpuIuCh1XdNlgHjMtiqs6O2hisExvGv7tUj5jUNY
         YRSCpWc5Sxe+mrdrJfifJE1b7Mp6BePRRB7QMzg3knjiJERgXbvw9e9jZP4TbIRMb+7Y
         diKaHQY5Z2+eUb54oF3+gSUJbWHkLOnCZoGD+4kiQLrMsmGjw6+Flz/raY8qzcjevYRD
         TLYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=epOsPM+GfGFNG1tX0bdsLvVn3NVsyOem8V1fi1iQRnE=;
        b=uI4MpRF2THQnd268P3d8UohCGap8ZdzA2eqZVJXubtdAGFXfEpD/I/e1IouHgbBoym
         iGScOdCHFbXoj89KU3nPrsR5C3+vWYUR0q2os+quwl0obvsOnLFIELEJtB3bGagTQkwb
         1ZAqbasjHV4bIn/5Ux33pDIhxmg/wzBOES5SRKzOftmulL8rehtqbHCrwAAUcv9cb7Bs
         meOX56mLlt/gScTk2uFIx4AnI/7zeb2/rgClisqmPyGdZGBbX4/D/sDJRlVqKdi8SoCB
         Hed+5V1NqR8B6OuvyrMIkzflmvKCyhlrx36aDYUvPrnXJVnrMfnao24c1dwfJ666qL+J
         3SCw==
X-Gm-Message-State: AOAM531wmCen1I/thJQIxf9xwfQ0fw1YPi2IvqMs4rPSR6zBAEKl+qg1
        2noyibGB2pBj3ggpdFGqsoICk3DUaFVWg2uULpw=
X-Google-Smtp-Source: ABdhPJxafJI4+rfTDFIFwsyF2xmyVQjL+u6VZy6yFRuySkAHWAFqOttnymXqxlA1mbbcjZSYjxeRyZi4qaxXZ3TyPd0=
X-Received: by 2002:a05:6402:14cd:: with SMTP id f13mr6672382edx.75.1602126535675;
 Wed, 07 Oct 2020 20:08:55 -0700 (PDT)
MIME-Version: 1.0
References: <1602125965-31698-1-git-send-email-zhouzhouyi@gmail.com> <1e7d9b9a-b90b-48c5-1fd9-51244b843507@infradead.org>
In-Reply-To: <1e7d9b9a-b90b-48c5-1fd9-51244b843507@infradead.org>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Thu, 8 Oct 2020 11:08:44 +0800
Message-ID: <CAABZP2xysbJGq=8iccoie2EauTo4TWdu7Ay3tKjTq74N715bqQ@mail.gmail.com>
Subject: Re: [PATCH] kprobes: Correct a type error in function kprobes_module_callback
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        David Miller <davem@davemloft.net>, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the tip!

On Thu, Oct 8, 2020 at 11:06 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Hi,
>
> On 10/7/20 7:59 PM, Zhouyi Zhou wrote:
> > There is a tiny type error in comment of function kprobes_module_callback.
>
> Preferable
>                   typo
> and same in $Subject.
>
> 'type' usually means data type or maybe typedef, or even
> font or typeface.
>
> I suppose you could say a "typing" error (as in using a typewriter
> or keyboard).
>
> >
> > Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> > ---
> >  kernel/kprobes.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > index e995541..9d2042b 100644
> > --- a/kernel/kprobes.c
> > +++ b/kernel/kprobes.c
> > @@ -2432,7 +2432,7 @@ static int kprobes_module_callback(struct notifier_block *nb,
> >                            within_module_core((unsigned long)p->addr, mod))) {
> >                               /*
> >                                * The vaddr this probe is installed will soon
> > -                              * be vfreed buy not synced to disk. Hence,
> > +                              * be vfreed but not synced to disk. Hence,
> >                                * disarming the breakpoint isn't needed.
> >                                *
> >                                * Note, this will also move any optimized probes
> >
>
> thanks.
> --
> ~Randy
>
