Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8FB2AE71F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 04:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725902AbgKKDhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 22:37:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgKKDhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 22:37:43 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A3AC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 19:37:42 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id c16so1037150wmd.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 19:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eGaAdgdApS4HYvChRftRm2Fyxp1vTzt+MP8sr/RnDdQ=;
        b=KXxv1CQyyCnFXk/wyFTZcv+f2JusG3suwkVHvkS/bo+ClNaczXQcYHRkYVtDi3HJnb
         tKGXNFUJupETAi6dKzy8+c7G+GnpCnxqMGqPx9TS7PjiUcIJLBxZH5E8q+5kN8PI9qUM
         9GfiGV2jtIiL4njBnOqvlF8HqV3Zli4qRBWjzWzDFlQazm0kt3bt+xwcAjaIS+jSrDNh
         UUqJuSlQGQ3bN+OLfxlu4IIJ4d4T+6nEiL/Km1Xg1Uq3972Rk8pJV8V9ZWU1cS1t/Xk/
         6ZWx5d+ZDZSrKKHIKBX6qP4l0+rXOS9PnhIbx1u/8gZjCSOBsexdNDuVtnDLVie4zZNm
         YD+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eGaAdgdApS4HYvChRftRm2Fyxp1vTzt+MP8sr/RnDdQ=;
        b=XzqsXcbNdMORZkBAaU0cVdUnCEg47hBUQMmnZquR7E4V0gR28vVB1Pw2dASUHjk9go
         Chzg6912axOlPNOICcwZc4/wJ/Ae0MXoqVlMZ+N26BhYk5eK9JIy1PT76Rje26h8cWtV
         epFNe4EcfYjmjZ5OYgbBLXH6aQSSFSq8Q8cJldHEPIIJTk6vd5IeiHa/pYxUIXPbavoN
         ApVRBmeSqRhHsy8fpqw/POnfeAATFxZmxkPNZWSYDC9wsj3ip4Mu6SgbJ7s6g5WNmbRp
         YT3wGUxmX8n3kfoLo7nfNGChs4HsPGqWwQx0Kc5i2JJq+FfyRc/G/dhqXRpngwUW3HEG
         6LNg==
X-Gm-Message-State: AOAM5335fl9dUEJRL3ddnGALUuzscWq6Eup8Lf4VwuUKMlE1/hvf5Gfg
        vQEh7q8vEO2Ju77LFk8V87V7vIW/D4TzGV30+uRB5w==
X-Google-Smtp-Source: ABdhPJweWRmE2XVEjBJZJ9Mf6mzjXll9pG3tTTH9KDVv/tkvfHPhHQhFahDIlVGkNW8iWKy4uh/yTqq8iBIqjSbofwU=
X-Received: by 2002:a1c:1f06:: with SMTP id f6mr1389809wmf.108.1605065860580;
 Tue, 10 Nov 2020 19:37:40 -0800 (PST)
MIME-Version: 1.0
References: <20201106231635.3528496-1-soheil.kdev@gmail.com>
 <20201107174343.d94369d044c821fb8673bafd@linux-foundation.org>
 <CACSApva7rcbvtSyV6XY0q3eFQqmPXV=0zY9X1FPKkUk-hSodpA@mail.gmail.com> <20201110140506.528d8eeb4eb62f26dfdb1c71@linux-foundation.org>
In-Reply-To: <20201110140506.528d8eeb4eb62f26dfdb1c71@linux-foundation.org>
From:   Soheil Hassas Yeganeh <soheil@google.com>
Date:   Tue, 10 Nov 2020 22:37:04 -0500
Message-ID: <CACSApvZV46r02W0NV16zj1r9TJfNHyO+4kbBvzWZzGJgqfoZAw@mail.gmail.com>
Subject: Re: [PATCH 0/8] simplify ep_poll
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Eric Dumazet <edumazet@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        Guantao Liu <guantaol@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 5:05 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Sat, 7 Nov 2020 23:45:30 -0500 Soheil Hassas Yeganeh <soheil@google.com> wrote:
>
> > On Sat, Nov 7, 2020 at 8:43 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > >
> > > On Fri,  6 Nov 2020 18:16:27 -0500 Soheil Hassas Yeganeh <soheil.kdev@gmail.com> wrote:
> > >
> > > > From: Soheil Hassas Yeganeh <soheil@google.com>
> > > >
> > > > This patch series is a follow up based on the suggestions and feedback by Linus:
> > > > https://lkml.kernel.org/r/CAHk-=wizk=OxUyQPbO8MS41w2Pag1kniUV5WdD5qWL-gq1kjDA@mail.gmail.com
> > >
> > > Al Viro has been playing in here as well - see the below, from
> > > linux-next.
> > >
> > > I think I'll leave it to you folks to sort this out, please.
> >
> > Thank you Andrew for pointing that out!  Sorry that I didn't notice Al
> > Viro's nice clean ups.
> >
> > The changes are all orthogonal and apply cleanly except "epoll: pull
> > fatal signal checks into ep_send_events()".   The conflict is trivial
> > and the following patch should cleanly apply to linux-next/master (I
> > didn't move the initialization of `res = 0` after the new branch to
> > keep it simple).
> >
> > FWIW, I also stress-tested the patch series applied on top of
> > linux-next/master for a couple of hours.
> >
> > Could you please let me know whether I should send a V2 of the patch
> > series for linux-next? Thanks!
>
> That worked, thanks.  I'll include all this in the next drop for
> linux-next.

Awesome! Thanks very much, Andrew!
