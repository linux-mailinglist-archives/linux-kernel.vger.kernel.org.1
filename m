Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D03862DA3D1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 00:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441323AbgLNW5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 17:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731662AbgLNW4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 17:56:41 -0500
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF8FC061793
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 14:56:01 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id x203so4364294ooa.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 14:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tNau0dbi4wX2OHDWsJ2tCzSDPVLgYMIigq5L3bsc4IM=;
        b=hcZq/jeJbG+jFKN0wf5cZQX8wLrcXucGkUHnaHHWeZkoXGdMkDEfWIIIWCzwmAzeVI
         3vjSkcZk7XoSutwHWNBS8PWhxl47K4ZBFRjcz6K6C4NRuqZCdq1bGqrYigwx2HVUrkVG
         vd0f6pCHZ2opFzDboxv+pzkdkfRJoNe8EMgONgQsKeqiissl1iGqfZqI2X847yn+84TS
         NZmordXIRLClHLCjINtXRwOQHy4PqwIgP17eh8HPKj8OASXqw539KajCMThqSZkDH+7j
         3pUcY6rxFbUvjUb7Q6v31zG93ML6se5UYAulUzoYfT9zgIf8cSnn1RgkSxxMVFbLqeU2
         F71g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tNau0dbi4wX2OHDWsJ2tCzSDPVLgYMIigq5L3bsc4IM=;
        b=EUXrXpZtXDl8UqSkgxqzHZgx63cS9LV11vL92Z1tkVoOQwi2+suvY8aX7USmQayf6I
         pnWe3Dwl93lCR2gvK2nAMw+2bLzrwji8pRkEwYJx0X7lw1boWe5IAnkqmg6/QsndupdK
         951F6gzd129legOCeJ7i1h5BOA0mRc8IOmQC15to0IYRoaKkdsyunQzNetGSP4LREO8i
         9EFDZaDgkcl0dQbbLf7LUR+Bg6lS6+W8XRvt1dWy5fKkT12va6APU7tqzdjde3+PQ+XH
         dJRLhAyOq0esLxQlh3/rcH5MqgIbs0mViKCS5E+/UIwu97nmzR4zTtD90jhC0ILUmJC7
         XC9Q==
X-Gm-Message-State: AOAM533TV5vq6TKyEXZDLKbLdTJZxmq6PN8oeHZx3Q3U5Ag9oqnm9pFU
        97DdWt/9L6UbN0Edz2KeR4jeFm+RutmygJXgd9I=
X-Google-Smtp-Source: ABdhPJyXJPbohMAfZ08TLI7HABFoYsQBf66s4eNe4tSNa6zhO+7/c8xdBPW0S2evG8DXLzhOCXJCYUFOyz3Hy+zsNFA=
X-Received: by 2002:a4a:330b:: with SMTP id q11mr20518037ooq.90.1607986560917;
 Mon, 14 Dec 2020 14:56:00 -0800 (PST)
MIME-Version: 1.0
References: <CAPM=9tyNrbap4FG6qstkC5YTznqVebD=ye+4+Z+t42yQnL325A@mail.gmail.com>
 <CAHk-=wjue4aOyQQq+C6SEurwe6XABhMyNtsfn1goU==Hf_QUqA@mail.gmail.com>
 <CADnq5_MyMm+FmmbKHccDDOBryEdgbQHdw3rtuhUv=cvJrirHFg@mail.gmail.com> <CAHk-=wgLKJ6S0V0YgVWdcXVH9Zh8CEV5xPBUSFkJ7fywNLtqeg@mail.gmail.com>
In-Reply-To: <CAHk-=wgLKJ6S0V0YgVWdcXVH9Zh8CEV5xPBUSFkJ7fywNLtqeg@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 14 Dec 2020 17:55:49 -0500
Message-ID: <CADnq5_OV4UqGLTsPnWij=eQYYxGf57mY8Nr34s5Y=jQiG9ZYLw@mail.gmail.com>
Subject: Re: [git pull] drm for 5.11-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Dave Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14, 2020 at 5:45 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Dec 14, 2020 at 2:29 PM Alex Deucher <alexdeucher@gmail.com> wrote:
> >
> > The relevant fixes are:
>
> Ok, I can confirm that applying those two patches gets my workstation
> working properly again.
>
> Would it be possible to get those submitted properly (or I can just
> take them as-is, but would like to get a "please just pick them
> directly")?
>
> I don't like to continue to do merges during the merge windows with a
> known broken base - it makes for a nightmare of bisection when you
> have multiple independent problems, and I assume this hits not just me
> but a lot of people with radeon/amdgpu graphics?

Yes, anyone using AMD GPUs will be affected.  The patches are already
in drm-misc, so they should show up in the next drm -fixes PR, but I
think it would be fine to pick them directly to fix support for
everyone using your tree.

Alex
