Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E36652F34E4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 17:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405367AbhALP61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 10:58:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732573AbhALP60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 10:58:26 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE850C061794
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 07:57:45 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id b24so2722857otj.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 07:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ipPU2vUc+BFfUi92jCI9tLYRCUYmdD6X+lgC1SjK0wc=;
        b=N/kJEm00glSMDkxyusQwQrXuK/TuEczkrU13epKkLv4ZujV7CmBMz7zExMyAmD/c8V
         fn4UuIte+aoF6LalD6gqyintU4Sx+9Y/524JjdnFYzLFIXD1OIRHQoZuytPVhhhbEBOD
         cC7OkVGttZF6yeiEnyVnJ+Dirk1yKpLg3XsWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ipPU2vUc+BFfUi92jCI9tLYRCUYmdD6X+lgC1SjK0wc=;
        b=L/b2LecvUTVaGCh0idgzGJrEpDnTs5Kduk3SjTWRn06DrXg1BGzC55biAfB5kg699q
         FpH4Buza7AQPnpJT4xed/kHPU56dp6nfifSBrx9xdl/3lMIBM1asAg+ICH0R0WoFhVMM
         NG3aILNps2L4Fund24SS5fkWeAFPaicrVpXj23XDb0d8wB8rZsrBqEPWpOrdBa7PXRgX
         nf3MS7Pf/irYuipKoMOAAN2Oqzn6qxf04Nni3h+D1FMLRP6WfcygPXwoHj2zKjlzb9vW
         5IHlwMQurrLe7IXMXi2R2G3kmcCz9R8oyIvZRZboVyJHF5DI4gZhke355hSAP/86K41I
         RkJw==
X-Gm-Message-State: AOAM532/VmMXer5DJkkHns5WZQQwauzbsknwZ9oDaT9DtxSX+qq+DVOf
        ZVxEf9fZsCWMq/KS3WOkrMkzwO21+zyWOL5nftXycg==
X-Google-Smtp-Source: ABdhPJzXSshJQKExSJsT5ioLk9EsBQSNfGxfM3kxQUxKh+G7AoddxywtMTAUCL44UVcbxALZuyaFQc/OpgMmBHp1mPc=
X-Received: by 2002:a05:6830:1bef:: with SMTP id k15mr8948otb.303.1610467065202;
 Tue, 12 Jan 2021 07:57:45 -0800 (PST)
MIME-Version: 1.0
References: <20200916205434.GA10389@duo.ucw.cz> <87czyf5jjp.fsf@vps.thesusis.net>
 <CAHk-=wjsjC1h7fskwYaaRLykN1ms6ZtxGvucQgmL-zZTfxPdBA@mail.gmail.com>
In-Reply-To: <CAHk-=wjsjC1h7fskwYaaRLykN1ms6ZtxGvucQgmL-zZTfxPdBA@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 12 Jan 2021 16:57:34 +0100
Message-ID: <CAKMK7uEGXOC_ci=Drm=Hz+xPGdcoxv8YZ-gcOckoPmu2XijiSA@mail.gmail.com>
Subject: Re: fbcon: remove soft scrollback code (missing Doc. patch)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Phillip Susi <phill@thesusis.net>, Pavel Machek <pavel@ucw.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 9, 2021 at 12:11 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Jan 8, 2021 at 11:13 AM Phillip Susi <phill@thesusis.net> wrote:
> >
> > > Could we pause this madness? Scrollback is still useful. I needed it
> > > today... it was too small, so command results I was looking for
> > > already scrolled away, but... life will be really painful with 0
> > > scrollback.
> >
> > > You'll need it, too... as soon as you get oops and will want to see
> > > errors just prior to that oops.
> >
> > > If it means I get to maintain it... I'm not happy about it but that's
> > > better than no scrollback.
> >
> > Amen!  What self respecting admin installs a gui on servers?  What do we
> > have to do to get this back in?  What was so buggy with this code that
> > it needed to be removed?  Why was it such a burden to just leave it be?
>
> It really was buggy, with security implications. And we have no maintainers.
>
> So the scroll-back code can't come back until we have a maintainer and
> a cleaner and simpler implementation.
>
> And no, maintaining it really doesn't mean "just get it back to the
> old broken state".
>
> So far I haven't actually seen any patches, which means that it's not
> coming back.
>
> The good news? If you have an actual text VGA console, that should
> still work just fine.

Also on anything that is remotely modern (i.e. runs a drm kernel
modesetting driver undearneath the fbdev/fbcon stack) there's a pile
more issues on top of just the scrollback/fbcon code being a mess.
Specifically the locking is somewhere between yolo and outright
deadlocks. This holds even more so if the use case here is "I want
scrollback for an oops". There's rough sketches for how it could be
solved, but it's all very tricky work.

Also, we need testcases for this, both in-kernel unit-test style stuff
and uapi testcases. Especially the full interaction on a modern stack
between /dev/fb/0, /dev/drm/card0, vt ioctls and the console is a pure
nightmare.

Altogether this is a few years of full time hacking to get this back
into shape, and until that's happening and clearly getting somewhere
the only reasonable thing to do is to delete features in response to
syzkaller crashes.

Also adding dri-devel since defacto that's the only place where
display people hang out nowadays.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
