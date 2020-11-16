Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8FEB2B5108
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 20:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729462AbgKPTZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 14:25:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729366AbgKPTZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 14:25:36 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B0EC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 11:25:36 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id j7so20024834wrp.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 11:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=06PNoz2MN9NL0Ap0YfgBDy6wfkksYH6ttzHim7ihGJI=;
        b=hoK3SqGKcWqwAzDDj4Y/qZBCnvG3rPUj+5DcN1iEqKMEljGIgMf2MMSeRVcQfAPNmY
         eyHOFFBm3ipNxxc8AKIbQ24MaKmYa8oR+dAl12JPRqaUk3TEt2nxFbt9g+b51Zm94Qc/
         LFuRWyRu7prr/t+QJGXADttAsqS1iWM4eh7O03F4RhtcIxeiH7qowaRiuSRKp4JImvnw
         Fil+QjLOCEr6uYdTe/R+pcieDquLMWTXu5RGgBpI7CWFiAjBD+WqjU2Fo8l+MYEl52Ul
         shj8aS4VkZN9XsZmwM3ED9LJlOhX7uCyXruDH3+byfmQ09UptUysyIV+9uyub1FjRCf6
         uG/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=06PNoz2MN9NL0Ap0YfgBDy6wfkksYH6ttzHim7ihGJI=;
        b=RmV4VwY4xbxMgrbfgREaJG/9Sfo5J2ZqhDQj3uVM1gMsidpBwx2AcEKao3V7rO26sP
         OQplVyELs/CVhAlnnueSNOBZljzqg3G9ncsPEG6O6RBkyc6EmONm+1tkMPQtW6O1CBY6
         K+baDg06Hs+0Aga6zl9i0CfTK0iAXs1W1uDJvwFLCptuSI28uwSA2gpSRnNW5cqW42gf
         V4omitb8juGTIo+Gd8lpWF00OF17dq6eq9DyPkqVNLSxpi4u8WLSclelnJcWhumdSLHg
         FwyvXyFS+CMNo/AoahuzYbzqi9UhSv8CLeXTcUumDXOAFnl1eiLWaB6VTeWVCI1ox0Iy
         KXiQ==
X-Gm-Message-State: AOAM530hCzG76NUEqhNiAUgXEWNc5dysGR3xkog7VhSq2jz5o14pJJoa
        nC3Ik5ZRqtym6C29/f68872H/kF99DhLe0ZIQNgLRzkY110=
X-Google-Smtp-Source: ABdhPJwjM1C7W8G9WB/ODyDwl5zVHnjYSWS1TKarFzu60Cg33izm479TVnzaNh91JhNJdgsfRkD/zHHn0icH5vVUD90=
X-Received: by 2002:adf:9163:: with SMTP id j90mr20138671wrj.323.1605554733830;
 Mon, 16 Nov 2020 11:25:33 -0800 (PST)
MIME-Version: 1.0
References: <CAPM=9txyMmW1DWhS--SuYQu4qDK1GPzgHJwxbAfhHT=hUsPODA@mail.gmail.com>
 <20201103222013.hypmzlq7uuqufe76@box> <CAHk-=whPqB1PUVCCcQMjm-YTBnTP7UD_ey2rbXzcJhQufJwcUQ@mail.gmail.com>
In-Reply-To: <CAHk-=whPqB1PUVCCcQMjm-YTBnTP7UD_ey2rbXzcJhQufJwcUQ@mail.gmail.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Tue, 17 Nov 2020 05:25:21 +1000
Message-ID: <CAPM=9tycx27H9tG3zSRjzz8kUW6FWSASMn3ywCbz9D+yFtzWCQ@mail.gmail.com>
Subject: Re: [git pull] drm next pull for 5.10-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Lyude Paul <lyude@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Christ. It's been two weeks. I'm doing -rc4 today, and I still don't
> have the fix.
>
> The problem seems entirely obvious, as reported by Kirill: the nv50
> code unconditionally calls the "atomic_{dis,en}able()" functions, even
> when not everybody was converted.
>
> The fix seems to be to either just do the conversion of the remaining
> cases (which looks like just adding an argument to the remaining
> functions, and using that for the "atomic" callback), or the trivial
> suggestion by Kirill from two weeks ago:
>
> > I hacked up patch to use help->disable/help->enable if atomic_ versions
> > are NULL. It worked.
>
> Kirill, since the nouveau people aren't fixing this, can you just send
> me your tested patch?
>
> Lyude/Ben - let me just say that I think this is all a huge disgrace.
>
> You had a problem report with a bisected commit, a suggested fix, and
> two weeks later there's absolutely _nothing_.

I would like to say when you sent this, there was patches on the
mailing lists with Kirill cc'ed, a pull request outstanding to me on
the mailing list from Ben, with the patches reviewed in it.

Maybe you weren't cc'ed on it, but stuff has certainly happened, in
the timeframe, and I was keeping track of it from falling down a hole.

_nothing_ is a lot more a reflection on your research than the ongoing
process, there was some delays here and maybe we need to communicate
when we are flat out dealing with other more urgent tasks that pay the
actual wages.

Dave.
