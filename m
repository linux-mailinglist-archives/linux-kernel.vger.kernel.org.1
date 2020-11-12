Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6342B01D0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 10:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbgKLJMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 04:12:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgKLJMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 04:12:49 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB7CC0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 01:12:48 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id a15so5352025edy.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 01:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4+AJ0MtKTSuiOVnktbsY1wSBOvhhxyrrl0Zdi0eqZQE=;
        b=Yr5OqyCrJgAhEpc244v7Qvka/xIThXVLxwqQH87toI+hJbeTqlurMsFdGFvUw3s/GE
         nqYMQcH+u6VGg5zAFrW/hRvVhQncHSjGjEGoE9D/ZD2hvuD22lb0MVv8JkmRThHCorwO
         cJ0yGb3Fk8IPGOyHGxxQ9SvM+lKMW1ZNv1uUNTI+yIBj7UXaoq/Z4YeQV/++CJ+3aBs1
         XwSR/9YuPq2i+f3SZXbjMuTeovS/wb9tgzXx0q6ZmtDzA46rbKolQDWIYWyGGNQYyD6b
         2OuIW5oDvO8eX4t21EXznq+ir0skVPvRuh7h/aE+QS46KXkdKR0NJmKHEtPQJNj6+SnZ
         08AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4+AJ0MtKTSuiOVnktbsY1wSBOvhhxyrrl0Zdi0eqZQE=;
        b=ualtbStTGiI2fvyKDjTVbNAdve6XeleHg8b7q5MRJt4UQjfEWaJC5L5IUv3TsB6Ww6
         S29TJsFEFgr8CHOCCPe0I0hrr+s6J8A2ndlKetvxKS78jEEk7ZCuHe4lGO2sH3xBd4c4
         6BYLrqHW2m02q3QEG7R4RqTNfeqZA8Q3RQg6cuUjMriPQW+Mzy/yU2K68Y88x6+DCigZ
         gwv+3j1TbsY44DYbMIRrMa/OOaqH97YcHvYY55m4b9Lx21Mi+2XV1eT8EL0ISHsVWQz0
         L/WKAkfk7FyiV/ikgMfoeOSkUwQs9VwVBS1s6wlWZ+2CfX/PMTfR19gRDzS+QbPYmprQ
         sXkw==
X-Gm-Message-State: AOAM531DIfkV3N4oH+bdHWqrmopKLUo3jbjEngxDi+vrNLPVsFlA/FLJ
        o5BUYpyvCkCN+NoJIRKe5TGb9qwR87ZzWJc3OYtY6b30Vls=
X-Google-Smtp-Source: ABdhPJwU31YdUs2P629F5+pkbucgCCB6zNWXzH23kbsffjednjzEsVbxTr/5VrGbr5AS9hIaI6idJ6xj4Xxm2k7RsSA=
X-Received: by 2002:a05:6402:755:: with SMTP id p21mr4105242edy.349.1605172367553;
 Thu, 12 Nov 2020 01:12:47 -0800 (PST)
MIME-Version: 1.0
References: <20201111205349.24815-1-jcmvbkbc@gmail.com> <faf78325-3aef-e4aa-ddc6-c21e84a8c7ef@kernel.dk>
In-Reply-To: <faf78325-3aef-e4aa-ddc6-c21e84a8c7ef@kernel.dk>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Thu, 12 Nov 2020 01:12:36 -0800
Message-ID: <CAMo8BfL=3PEi3GWd6LR9kiKViN=t1KbgbkjEEwT8GAb-Uvnp0A@mail.gmail.com>
Subject: Re: [PATCH v2] xtensa: fix broken TIF_NOTIFY_SIGNAL assembly
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, Chris Zankel <chris@zankel.net>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 1:05 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 11/11/20 1:53 PM, Max Filippov wrote:
> > TIF_NOTIFY_SIGNAL handling in xtensa assembly is implemented
> > incorrectly: there should be a call to do_notify_resume when either
> > TIF_SIGPENDING, TIF_NOTIFY_RESUME or TIF_NOTIFY_SIGNAL bit is set in the
> > thread_info::flags. The straightforward way to do it would be
> >
> >     _bbsi.l a4, TIF_NEED_RESCHED, 3f
> >     _bbsi.l a4, TIF_NOTIFY_RESUME, 2f
> >     _bbsi.l a4, TIF_NOTIFY_SIGNAL, 2f
> >     _bbci.l a4, TIF_SIGPENDING, 5f
> >
> > Optimize it a little bit and use bit mask and bnone opcode to skip
> > do_notify_resume invocation. Shuffle _TIF_* flags a bit so that used bit
> > mask fits into the immediate field of movi opcode.
>
> Thanks - do you mind if I fold this in with a reference to your
> changes? Seems like that'd be a better option than leaving it
> broken for a bit.

Sure Jens, by all means!

-- 
Thanks.
-- Max
