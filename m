Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45A7429778C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 21:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754593AbgJWTPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 15:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750025AbgJWTPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 15:15:01 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E34EC0613D2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 12:15:00 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id o18so2576708edq.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 12:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=icMK60GhKKKQhTV5Pyj9suVv+bBVVFbJ7wD/aCD2HK4=;
        b=jmIOXw9USFhftMZ9bsMglijHYHwg5XRQXt4roQQd8+vPY1RSnDZML19fjAPKGNz6A3
         fHLQsmrSMMWqY4FD8z9wGvG3fru1zS1ZvcDENI8ua3pA7lVDQo5PUsCNoAlYmfZpF6L4
         4rrGMJyavlk8/4PqBf9ZXjpdqSB/vcD7S0lRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=icMK60GhKKKQhTV5Pyj9suVv+bBVVFbJ7wD/aCD2HK4=;
        b=EJ073fdsPMP4rEKB73dgRFq4XvBysIfqFFoNwQFq5/glNOcE6AXLmFpg+RCtDjrpWq
         Df0yeJRUvnC5lDZmZXoFe3LH2j8q5UduvAaO+aiW71fArl7ptkMfwfRT/+ASbS6D5dpj
         sJyl0GFMyzuqCrTfS13jKc0DgjsADuGMcRVRCh9ERT2p9iR0P9JwaQiN7lID9ltQ46lN
         WVN8xIo/Ih9thF/AltORJxPNRzVQzWsNbSPifZgHfT8z37CIkYYb9qjj1npOb3asbtuo
         IKarrJy6pOIBZ+OEffYIkZi+F8nsL/5zqGXOahK/MEGkR1fOpWLX3YCGHjBDmHoq67N8
         KtAg==
X-Gm-Message-State: AOAM533X8pjYyUccjbOkU6SxqniGjmBL4TwjMMZHlL/Br3ZDRUwFT5Y0
        Wb9sWVNcdxYhg2phiYy5Q2GjDjxFd26bHCD5WsRUuZO86Rw=
X-Google-Smtp-Source: ABdhPJzpws9M76h1oM8kMw86Lv4HFd4d+oXrZ6W+m0fuw9WVnlApbCE8QbzRooWTTpTP222JHLdK6pzRn41ISnC4AZY=
X-Received: by 2002:aa7:cf93:: with SMTP id z19mr3690893edx.26.1603480499235;
 Fri, 23 Oct 2020 12:14:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ-EccOQxDjSgUL0AsCywoKDbOUNWDyxCKHQc+s6+ZemUh9Uzw@mail.gmail.com>
 <CAHk-=wg3kHxMP67XmQyCg7J+KfFgAsQqj1goUa3dKR-A812ZbA@mail.gmail.com>
 <CAJ-EccPLAD5TGg=KQ-m54ymrVdd++Dg7A_UR+v535iOVRsDe4w@mail.gmail.com> <CAHk-=wi_BD0OVHgj09kKgiuwyrth3ora_ZgLznW_q-+z-BR=3w@mail.gmail.com>
In-Reply-To: <CAHk-=wi_BD0OVHgj09kKgiuwyrth3ora_ZgLznW_q-+z-BR=3w@mail.gmail.com>
From:   Micah Morton <mortonm@chromium.org>
Date:   Fri, 23 Oct 2020 12:14:47 -0700
Message-ID: <CAJ-EccMu_AGfOYASyteGosdOc1SMHeVTLax5aoZSQf7_n0Xq2Q@mail.gmail.com>
Subject: Re: [GIT PULL] SafeSetID changes for v5.10
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 10:57 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Oct 15, 2020 at 5:01 PM Micah Morton <mortonm@chromium.org> wrote:
> >
> > I just rebased to v5.9 to make sure the 1-line changes that touch
> > kernel/capability.c, kernel/groups.c and kernel/sys.c still applied
> > cleanly without conflicts. Should I have rebased onto one of the -rc's
> > for v5.9 instead?
>
> No. You shouldn't have rebased at all.

Ok so before the rebase ("reparent"), the commits were based on top of
some commit that was months old at this point (can't quite remember
now, I think one of the -rc's for v5.8).

I guess the lesson here is never rebase or fast-forward merge my
upstream-bound -next branch until it has emptied entirely into the
mainline? And if that doesn't happen for whatever reason during one
merge window and I have to wait for the next one, I just send you
un-reparented/un-fastforwarded possibly outdated commits and you will
resolve conflicts if any?

The reason for the rebase making sense to me here was that the changes
to common kernel code are very simple (a few one line changes) and
easy to quickly verify after the rebase -- and the vast majority of
the complexity of the code in the pull request was confined to the
SafeSetID code base, which had no changes over the time span from
original base to the reparented base. So I had basically considered it
a no-op rebase. I probably should have explained this in the pull
request.

Thanks

>
> Making sure something applies cleanly is simply not a reason to rebase.
>
> See
>
>   Documentation/maintainer/rebasing-and-merging.rst
>
> for some common rules.
>
>              Linus
