Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 597642AD7F3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 14:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730439AbgKJNqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 08:46:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730074AbgKJNqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 08:46:32 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19EAC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 05:46:32 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id m13so14335849oih.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 05:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KSBi0cYcjL14hFjS1VAuiIs1ge6Q0TvGqc9wyqKWxHU=;
        b=KxuHLtsg4+HcSlPWK50gx/phNUgDf2ThbSkQ0CvIKqVqDXDWiOfJFapkmTC+NbQ5JB
         K4Lhqy06jvz+cYx+9bOre8LpBa0uzPT6Y4W0Bw0/QCuBi6hCWzKPknd789z+5/2kENxe
         Bb9zMaOyo5IMlrKKcAqWka1ecPC9DB1wrlXgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KSBi0cYcjL14hFjS1VAuiIs1ge6Q0TvGqc9wyqKWxHU=;
        b=BlPs7aXfwO0PvI515U5G0yMsYiWtu/NOwdQJWBebhv+tFFhG2jHbxwW29IzA8/+H7G
         mhAhUn+ig47In8q4Zp9H7G3fZAnFXfB3gXDKn2PmWHmYHYfR5KrcXVt3xL7q2DlKY/9l
         D4nK8GwhL53Eue2EpTCmXiPhgPG+t52Laq985hdKbYO5u2MAdOW6lar0UelbOoehEGNj
         UbtCMXUhU7MA/WCJsER4Dt3/5fCVwOeaU867UuXZZYkJzP45fAPEhbQEGbWJepNMu+Yy
         20l/akAJvb/B+TdTy2UKnuW6Uydj/UXe2lYvHKPr+gVqBFSwWYCe23lEvxYJkb+wArWj
         fL6w==
X-Gm-Message-State: AOAM530SJ33xGmcY4PjUZIjgGgI+JXz3ctZsrxNFFI/86I4r4kbGVAnU
        SkTKe9C5kyh9zOd1vU7AbPkE1s0k3R8tQHMKJaE/8oip2dhpEw==
X-Google-Smtp-Source: ABdhPJyzdDByyzNbzdz/0OYKTLWy3l6toxa9onFy7mPNpemKtfLkC9dXi+UGbqU1YjK1W1TIvOZMjHKrFai3k7UKmkY=
X-Received: by 2002:aca:b141:: with SMTP id a62mr2579473oif.101.1605015991893;
 Tue, 10 Nov 2020 05:46:31 -0800 (PST)
MIME-Version: 1.0
References: <c5563eeea36aae7bd72ea2e985bc610d585ece40.1604128639.git.yepeilin.cs@gmail.com>
 <20201106105058.GA2801856@kroah.com> <20201110124946.GF401619@phenom.ffwll.local>
 <20201110132445.GA2483842@PWN>
In-Reply-To: <20201110132445.GA2483842@PWN>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 10 Nov 2020 14:46:20 +0100
Message-ID: <CAKMK7uFiCTu9bz1uJqmCvwBSUK4XmuVyRf2C-U=zoArZMb0Pgg@mail.gmail.com>
Subject: Re: [PATCH 1/2] console: Remove dummy con_font_op() callback implementations
To:     Peilin Ye <yepeilin.cs@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Thomas Winischhofer <thomas@winischhofer.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        George Kennedy <george.kennedy@oracle.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Peter Rosin <peda@axentia.se>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 2:24 PM Peilin Ye <yepeilin.cs@gmail.com> wrote:
>
> On Tue, Nov 10, 2020 at 01:49:46PM +0100, Daniel Vetter wrote:
> > Peilin, can you pls resend this together with all the other pending
> > patches from you? I think that's better than me trying to cherry-pick the
> > bits we decided to keep from random places.
>
> Oh, are we doing an -rc3 backmerge soon? At the moment I can base these
> patches on neither drm-misc (due to the font_copy removal), nor mainline
> (due to the signedness issue in font_desc we've talked about), so I'm
> waiting for a backmerge to rebase everything properly. Sorry that I
> didn't mention earlier.

linux-next has all the trees, so you can always use that. And yes I'm
pushing the backmerge through, so in a few days at most I can pull in
all your patches. Meanwhile you can base your work of linux-next.

> > Greg, ok if I just pull these in through drm-misc-next? It's a pretty bad
> > hairball anyway and that avoids the tree coordination issues. Only thing
> > that might get in the way is the vt font_copy removal, but that's in -rc3
> > so easy to backmerge.
>
> I will rebase and send everything (including the font_copy
> garbage-collecting) in a v3 series after the backmerge. Thanks,

No need to be blocked on a backmerge, this is only needed for merging
the patches. Development should not be blocked like this.
-Daniel

>
> Peilin Ye
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
