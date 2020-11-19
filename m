Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9213E2B8969
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 02:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbgKSBQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 20:16:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbgKSBQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 20:16:26 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5281C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 17:16:24 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id q16so4046313edv.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 17:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9f9f6o6lpgdv8ZMI6nf3AW/mVAB1Cq7QnLtCyTveD0k=;
        b=DVHwKJ5dYMuqFTTiWpZnRhiM10utp3nM2Lt1dzI8KbeeqlKB9j1IW+Bc4XKs/VvYKQ
         rIhQwkFEpZ5mLtlhIcEFVTaDhGRk9iTS8QMzWlSNw0Up6PpZ3SO1t8V+8RUZIEoVBc85
         RVXc5zgBxFERHD8MsS62vurs+1b7228TqlHrPX5QD1rRGP1mlTleHtbrKvvmWv4qoNIV
         2hMrdPWdMWoV1/NhjhXeeAkXwgQFRXHa7sTibnC0dBK5OS+w3pB4bTKrNrudn76gT9sh
         +acC0ExKYJID9n+LGez1PIUbbMWWWgGB3nbzbW4l9UUmKo/k86t1mMAd862Tbm8/xZn9
         eXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9f9f6o6lpgdv8ZMI6nf3AW/mVAB1Cq7QnLtCyTveD0k=;
        b=CsFDWYA5EA56JhLLdlrVXuhRWDEX79G32jvjQc7TtsUt+ZeIpGEzfyiNWIq3oQKkW1
         AcGCo+tYNzeq5xSvYKMryMt25kXHKkv3NulwO2jdzSWjsvlaMbfYM5mVrLCO6DQKAfya
         3DOA6Xz6HP0JEVmgo+gTrXIVha0Dtls4Cv+XHX1BgDQ6kWwobWQL5veeYmGz9pqR0gMs
         8yUxAm7WefQ4sKf+PpKZK2DcVTuvxjOZOS90A5/fMGc5or0TWrvoDo2/3QnJGft9VtAl
         43TYkoiTAlRQKRZ+ISxf2/xENVb9WnyqpdTQOWhPAe66XdnedhwLsWnUc9oZQycp71Cn
         Obag==
X-Gm-Message-State: AOAM532in1e8DJ22wGxUVgKD+Ek2aFzi+MP1Yp1CJzoDA4DEkuA1gzqy
        Kt/0xz7moMJ5PLklicWcciFUM++p7N8vDqKNLqs=
X-Google-Smtp-Source: ABdhPJyrcQqV38Ou7gU9H78B8J530YlnqoX4AeM+JLoKskuu7TPFJ1CpWaZ63Aa50L0EYPKnAshnpWN6GU/K1VLsrTk=
X-Received: by 2002:a05:6402:150d:: with SMTP id f13mr27755566edw.119.1605748583525;
 Wed, 18 Nov 2020 17:16:23 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wjFfAktnadOPb_iV5nKh=V5Am1sG-gciYveswRtuEkrLQ@mail.gmail.com>
 <692820a49ded436591b5fe3a18c68a5e@AcuMS.aculab.com> <CAHk-=wgQY7k_3NVCbaSmiJyLiAV_1TgwLk-d4QRMHMWqM5Oo_w@mail.gmail.com>
 <0a10da3d-085f-c7a7-0053-dc1e9ea871ed@suse.de> <f7be660da595411ab60aaa4b76008769@AcuMS.aculab.com>
 <CAKMK7uFZhVqEzjfHszQ=1KeoRecXSDa0+tdH_rT8yENY9zasyQ@mail.gmail.com> <CAPM=9tw7_BU1_mUVa8ZeqsXfsN_cODsTzTAXiQkDGT+i1v0JaQ@mail.gmail.com>
In-Reply-To: <CAPM=9tw7_BU1_mUVa8ZeqsXfsN_cODsTzTAXiQkDGT+i1v0JaQ@mail.gmail.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Thu, 19 Nov 2020 11:16:12 +1000
Message-ID: <CAPM=9twMArmaJ9rqxDzhZh+dwgVuTdAXrtzFK+TpSe_9xSKDOA@mail.gmail.com>
Subject: Re: Linux 5.10-rc4
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     David Laight <David.Laight@aculab.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "Huang, Ray" <ray.huang@amd.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Dave Airlie <airlied@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Nov 2020 at 08:25, Dave Airlie <airlied@gmail.com> wrote:
>
> On Thu, 19 Nov 2020 at 08:15, Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
> >
> > On Wed, Nov 18, 2020 at 11:01 PM David Laight <David.Laight@aculab.com> wrote:
> > >
> > > From: Thomas Zimmermann
> > > > Sent: 18 November 2020 19:37
> > > >
> > > > Hi
> > > >
> > > > Am 18.11.20 um 19:10 schrieb Linus Torvalds:
> > > > > On Wed, Nov 18, 2020 at 4:12 AM David Laight <David.Laight@aculab.com> wrote:
> > > > >>
> > > > >> I've got the 'splat' below during boot.
> > > > >> This is an 8-core C2758 Atom cpu using the on-board/cpu graphics.
> > > > >> User space is Ubuntu 20.04.
> > > > >>
> > > > >> Additionally the X display has all the colours and alignment slightly
> > > > >> messed up.
> > > > >> 5.9.0 was ok.
> > > > >> I'm just guessing the two issues are related.
> > > > >
> > > > > Sounds likely.  But it would be lovely if you could bisect when
> > > > > exactly the problem(s) started to both verify that, and just to
> > > > > pinpoint the exact change..
> > >
> > > I don't quite understand what 'git bisect' did.
> > > I was bisecting between v5.9 and v5.10-rc1 but it suddenly started
> > > generating v5.9.0-rc5+ kernels.
> >
> > We queue up patches for -rc1 way before the previous kernel is
> > released, so this is normal.
> >
> > > The identified commit was 13a8f46d803 drm/ttm: move ghost object created.
> > > (retyped - hope it is right).
> > > But the diff to that last 'good' commit is massive.
> >
> > Yeah that's also normal for non-linear history. If you want to
> > double-check, re-test the parent of that commit (which is 2ee476f77ffe
> > ("drm/ttm: add a simple assign mem to bo wrapper")), which should
> > work, and then the bad commit.
> >
> > Also is this the first bad commit for both the splat and the screen
> > corruption issues?
> >
> > > So I don't know if that is anywhere near right.
> >
> > Thomas guessed it could be a ttm change, you hit one, and it looks
> > like it could be the culprit. Now I guess it's up to Dave. Also adding
> > Christian, in case he has an idea.
>
> I'd be mildly surprised if it's that commit, since it just refactors
> what looks to me to be two identical code pieces into one instance
> (within the scope of me screwing that up, but reading it I can't see
> it).
>
> I'll dig into this today.

https://patchwork.freedesktop.org/patch/401559/

should fix it.

We had a report in the rc1 thread but it got lost in the nouveau stuff
as well, I've cc that reporter as well.

please test.
Dave.
