Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 718652B2081
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 17:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgKMQeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 11:34:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgKMQeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 11:34:31 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE206C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 08:34:30 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id o21so14349078ejb.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 08:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XcyskGQX7sfCcXJ2/MS6gOYcHl6ogix2mC7AwPR/oSQ=;
        b=JH+ohS03bkb6TlASfCOFQ/pRdt7Xm2mVZXl4Wjj5zCI+4CFILklt0uQw0QyUxMoVgB
         vDFk1T6fJIdyzwu/EYlTyBfXgLUdLbiVje+I+rkT0pu0GuOticyHvnuWuRLFwlfRICra
         BVltv7QhGkaOBlcsD8OOZ/i6z3pSEsE9NC+vg4o07pbdesEUJkSFfZM/73Sn9+6rMlrO
         yOFpwh1Gy3W+FTRLTAhg3cHzu+t/XmoyOqfmUn4gBUglBmoF6c4b3dmsDMZu5yP67nBT
         x0hN1H/K935KjGdx0FqjN7TS5ReF24rXviAJTEUZwE1KXO7UtA0UAinlWTiYPvC8AAjr
         5Cgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XcyskGQX7sfCcXJ2/MS6gOYcHl6ogix2mC7AwPR/oSQ=;
        b=KmD9Y5DJqz9fO0EfH1EvSLGLkRYe6ExVk2MuUbYMwTNWCc5Ca+v2fjoquE0I7GHKAF
         8Yearr9Mxaq7GCmI7GeApSBzQAP8LudPHozXmbLt5zeyrMnQlQPGPVeHPl1qNIqlVbJQ
         6tqt9jIoTd0JYSC0lhbufQ/7gTl2BMMvcKNm/LW4qFLWFg1LhBmTwCD5QbtzfG1gySXT
         PEDMP2lqAxguFhcTwTKenHv3hZu3Kv2ZqLJ3Z6qoYxWgAGVA6WeR+xr08eR1ky+RAylv
         1t6DOnHkXQkwcNqAF3AuMxhn8dj9Nt3wRvPmaetKzoyX6+oZanbrlcMwNg+qQDkwiv24
         U7zg==
X-Gm-Message-State: AOAM531qu0y0PW8sJ++Mph2MTBZUuQonyabue92fFt99pGFlem4mnEky
        tdUQfQMyzCl61Uwmm9TcaH7EjQ+KHY2F27qwWDIxh6nPO7HJ9Q==
X-Google-Smtp-Source: ABdhPJxBUUtKkL2Qa4b2tRWQOgZnPW+SQJaMEOmf37rIFSt3XRdV/fhW8Nz78hdcSNcSI7E8/nyIMd5s0bkotGQQq7U=
X-Received: by 2002:a17:906:16d6:: with SMTP id t22mr2903596ejd.376.1605285264596;
 Fri, 13 Nov 2020 08:34:24 -0800 (PST)
MIME-Version: 1.0
References: <20201113122328.22942-1-jcmvbkbc@gmail.com> <87zh3ll6hw.fsf@nanos.tec.linutronix.de>
 <CAMo8BfKEr-89awEnV072uWR=4fniDRJ0drWmZrtnyvj-mANk0A@mail.gmail.com> <87sg9dl3xk.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87sg9dl3xk.fsf@nanos.tec.linutronix.de>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Fri, 13 Nov 2020 08:34:12 -0800
Message-ID: <CAMo8Bf+2kGmg_SvJz8R=qXgPWbYWmf-PSeG71xKe5AB2LeyZ4Q@mail.gmail.com>
Subject: Re: [PATCH] highmem: fix highmem for xtensa
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, Chris Zankel <chris@zankel.net>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 6:36 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> On Fri, Nov 13 2020 at 05:50, Max Filippov wrote:
> > On Fri, Nov 13, 2020 at 5:40 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >> What's wrong with just doing the obvious and making the fixmap defines
> >> the other way round?
> >
> > It becomes really awkward when we get to support high memory with
> > aliasing data cache: we must think about the actual virtual addresses
> > assigned to pages and it feels much simpler when it's done this way.
>
> Feeling are not really a technical argument. Is there any functional
> difference which matters?

arch_kmap_local_map_idx must produce index based on type and
pfn that will be translated to virtual address with the same color this
page would've had if it was in the low memory. With positive fixmap
the formula is: (type * (number of cache colors)) + (color of the pfn).
With negative fixmap there must be additional +1 and -1 in it.

-- 
Thanks.
-- Max
