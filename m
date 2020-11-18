Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 324B42B87A5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 23:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgKRWZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 17:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbgKRWZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 17:25:38 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD80C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 14:25:38 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id t9so3712946edq.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 14:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WhgF/IA0ylKv3857epiQSft8PVt9PvfZJmPTqKtYUWk=;
        b=lHVpf+IiHwYzA5b2OP4M6pDap5B/AtrWq259lzuNt/iFOBJckQFbHahg2TbM7C3fUk
         jt8tAZRAlM4e8jW12z22NXCGWzGcrwj+UxW7c730jXr9p/3+EoLaB+Td9qGgUSld9KvA
         4QvZnmpycwpZhkePUWXdnlRI8zI9+0/sVZrWPti9U4JARlXj0FZqPeDN+SpTVmdIhVm+
         I+GR2gcZYaLcHFVPKysWhJ5cDdaxY2aXrDZqtX3Xq/x3QplSUYwLxbydVXO8Pf2+OTZw
         rWKO8B6ZBGrj/rRD2eJdbz3jGsFP9VInz//nuvEW0Q3NZaO+hABVkaPXCfV6awF/Gvy+
         Agbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WhgF/IA0ylKv3857epiQSft8PVt9PvfZJmPTqKtYUWk=;
        b=bhPQvxoJI+jE7+cOLs2aSyltN0Bzro9yAagweY7+RPxPS7Fy1gUZYcKCnvRvrIH3E9
         qk+uzegyKUcFy3aD0c5q+22umuaQtfHtTFRiHqRoL5pwPeDN4s5Maa4uBOniZ3ozO3Mx
         uvzuKBWWZi4eh4n2nr/alNlaUoUAOTmxVRtWpqOFDXxKK5ckw9FAX+aCn2TW4GodZs3Y
         ilgH+j2O7T+I15q9N6FOtjILdnofmnEtb5UWEkeg8GmtehB1OahMK7Z0forHsJCrDpor
         wOFb+FNhBv2gih5P8mYfSv7ZyjKfDun/GSPS8YpHX7gc16v1jo+Iv6vUiyUiaFAtXqQP
         o1sg==
X-Gm-Message-State: AOAM532S2NVZ07xvlkogfbTBjl/dnmmS1wCTGZQq6pZgbUgo68uYSOoy
        QZ2zuidJjVNh+TMf+vK/93RbVu2RxqiOVwD/rGw=
X-Google-Smtp-Source: ABdhPJzOwvJ+BSFzbS/tue9emcVc7TGxC//Fwu5s5V11amStH73YCO5SCGLGsDa69pJbMqqzH8QEG07gTGWiefYj9FQ=
X-Received: by 2002:a50:d516:: with SMTP id u22mr7772043edi.127.1605738336474;
 Wed, 18 Nov 2020 14:25:36 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wjFfAktnadOPb_iV5nKh=V5Am1sG-gciYveswRtuEkrLQ@mail.gmail.com>
 <692820a49ded436591b5fe3a18c68a5e@AcuMS.aculab.com> <CAHk-=wgQY7k_3NVCbaSmiJyLiAV_1TgwLk-d4QRMHMWqM5Oo_w@mail.gmail.com>
 <0a10da3d-085f-c7a7-0053-dc1e9ea871ed@suse.de> <f7be660da595411ab60aaa4b76008769@AcuMS.aculab.com>
 <CAKMK7uFZhVqEzjfHszQ=1KeoRecXSDa0+tdH_rT8yENY9zasyQ@mail.gmail.com>
In-Reply-To: <CAKMK7uFZhVqEzjfHszQ=1KeoRecXSDa0+tdH_rT8yENY9zasyQ@mail.gmail.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Thu, 19 Nov 2020 08:25:24 +1000
Message-ID: <CAPM=9tw7_BU1_mUVa8ZeqsXfsN_cODsTzTAXiQkDGT+i1v0JaQ@mail.gmail.com>
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

On Thu, 19 Nov 2020 at 08:15, Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
>
> On Wed, Nov 18, 2020 at 11:01 PM David Laight <David.Laight@aculab.com> wrote:
> >
> > From: Thomas Zimmermann
> > > Sent: 18 November 2020 19:37
> > >
> > > Hi
> > >
> > > Am 18.11.20 um 19:10 schrieb Linus Torvalds:
> > > > On Wed, Nov 18, 2020 at 4:12 AM David Laight <David.Laight@aculab.com> wrote:
> > > >>
> > > >> I've got the 'splat' below during boot.
> > > >> This is an 8-core C2758 Atom cpu using the on-board/cpu graphics.
> > > >> User space is Ubuntu 20.04.
> > > >>
> > > >> Additionally the X display has all the colours and alignment slightly
> > > >> messed up.
> > > >> 5.9.0 was ok.
> > > >> I'm just guessing the two issues are related.
> > > >
> > > > Sounds likely.  But it would be lovely if you could bisect when
> > > > exactly the problem(s) started to both verify that, and just to
> > > > pinpoint the exact change..
> >
> > I don't quite understand what 'git bisect' did.
> > I was bisecting between v5.9 and v5.10-rc1 but it suddenly started
> > generating v5.9.0-rc5+ kernels.
>
> We queue up patches for -rc1 way before the previous kernel is
> released, so this is normal.
>
> > The identified commit was 13a8f46d803 drm/ttm: move ghost object created.
> > (retyped - hope it is right).
> > But the diff to that last 'good' commit is massive.
>
> Yeah that's also normal for non-linear history. If you want to
> double-check, re-test the parent of that commit (which is 2ee476f77ffe
> ("drm/ttm: add a simple assign mem to bo wrapper")), which should
> work, and then the bad commit.
>
> Also is this the first bad commit for both the splat and the screen
> corruption issues?
>
> > So I don't know if that is anywhere near right.
>
> Thomas guessed it could be a ttm change, you hit one, and it looks
> like it could be the culprit. Now I guess it's up to Dave. Also adding
> Christian, in case he has an idea.

I'd be mildly surprised if it's that commit, since it just refactors
what looks to me to be two identical code pieces into one instance
(within the scope of me screwing that up, but reading it I can't see
it).

I'll dig into this today.

Dave.
