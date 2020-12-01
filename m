Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 005AD2CAE5A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 22:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729183AbgLAV1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 16:27:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbgLAV1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 16:27:48 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B30C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 13:27:07 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id b12so2149558pjl.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 13:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=V+/ciNKNBVSxZCplHKMLdjwlLpX/qeh2rzRXvgYylIk=;
        b=hNjrfGwqBx3QzKDk1BMPJpys6yHH/Ow5wyuyQ/AnZdv6K4HhchhmrzvV26qLHqGZEk
         hcoZy6FKT+T+lGt6UxsSAFjKCCYVOtcbKna6Vf29AUHEHI5JN1scjAOQLovekc+D7FJv
         k06PHX3gBciak5OZ0UxfDdlYCz5SHcDuB4olk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=V+/ciNKNBVSxZCplHKMLdjwlLpX/qeh2rzRXvgYylIk=;
        b=seIt4Qtpc0PEro6D2D55R0+PyofeXu5W1AS/Kxkmf87JzuKbMJeHM0gyj5ogIWmPwA
         JnnEDctcLecDaazyqhypsrvoXgm8bBLcu3ka0w96eEBBJDYEUPpbSvkJPLTXyc2w+YnP
         MvOSnmCqeIKDYIXjFYVdOAj/qsJ0EAOjdQagGese22UOcwlyfIfmSAqIrnPP0bAW9UKn
         +q2+dWhFhgTRnZQ3xxbYPr+AbsgPakfmuoa7TuWJUnBF25HZ5uoi5SnwQH+ML/70/Xfh
         r0eMkyEilE2nLUXKiT7AUyUUPw0hxeChdpfa3cvi4Uezm1ngbyCalHZ5T3JTMH7bjIO9
         +5Lw==
X-Gm-Message-State: AOAM532Jkfxvt/Q1Ty3ekRDd6VIUUqMGoCnN+0g+EPuJDnuf7i7NS+Fo
        0w2ZiiQW1du4X856Zh+N+YT1jw==
X-Google-Smtp-Source: ABdhPJw5yj53ZR3QLDDz51zvJ0bcJIWvdtfK6BBYzjYoKCTvtuzo5lWYGIzOYfal2816cj8aj14jUQ==
X-Received: by 2002:a17:902:ee03:b029:da:689f:337e with SMTP id z3-20020a170902ee03b02900da689f337emr4443914plb.52.1606858027455;
        Tue, 01 Dec 2020 13:27:07 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f17sm661590pfk.70.2020.12.01.13.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 13:27:06 -0800 (PST)
Date:   Tue, 1 Dec 2020 13:27:05 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Tycho Andersen <tycho@tycho.pizza>
Cc:     Sargun Dhillon <sargun@sargun.me>, Alban Crequy <alban@kinvolk.io>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, jannh@google.com
Subject: Re: SECCOMP_IOCTL_NOTIF_ADDFD race condition
Message-ID: <202012011322.26DCBC64F2@keescook>
References: <CADZs7q4sw71iNHmV8EOOXhUKJMORPzF7thraxZYddTZsxta-KQ@mail.gmail.com>
 <20201130232009.GC38675@cisco>
 <20201201124105.GB103125@cisco>
 <20201201130824.GA27822@ircssh-2.c.rugged-nimbus-611.internal>
 <20201201131334.GC103125@cisco>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201201131334.GC103125@cisco>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 08:13:34AM -0500, Tycho Andersen wrote:
> On Tue, Dec 01, 2020 at 01:08:25PM +0000, Sargun Dhillon wrote:
> > On Tue, Dec 01, 2020 at 07:41:05AM -0500, Tycho Andersen wrote:
> > > On Mon, Nov 30, 2020 at 06:20:09PM -0500, Tycho Andersen wrote:
> > > > Idea 1 sounds best to me, but maybe that's because it's the way I
> > > > originally did the fd support that never landed :)
> > > > 
> > > > But here's an Idea 4: we add a way to remotely close an fd (I don't
> > > > see that the current infra can do this, but perhaps I didn't look hard
> > > > enough), and then when you get ENOENT you have to close the fd. Of
> > > > course, this can't be via seccomp, so maybe it's even more racy.
> > > 
> > > Or better yet: what if the kernel closed everything it had added via
> > > ADDFD if it didn't get a valid response from the supervisor? Then
> > > everyone gets this bug fixed for free.
> > > 
> > > Tycho
> > > _______________________________________________
> > > Containers mailing list
> > > Containers@lists.linux-foundation.org
> > > https://lists.linuxfoundation.org/mailman/listinfo/containers
> > 
> > This doesn't solve the problem universally because of the (Go) preemption 
> > problem. Unless we can guarantee that the supervisor can always handle the 
> > request in fewer than 10ms, or if it implements resumption behaviour. I know 
> > that resumption behaviour is a requirement no matter what, but the easier we can 
> > make it to implement resumption, the better chance we are giving users to get 
> > this right.
> 
> Doesn't automatic cleanup of fds make things easier? I'm not sure I
> understand the argument.

I doubt Al would ever allow the "cleanup" approach: his observation was
that the instant a file has been added to the fdtable, it's not possible
to "unwind" that ever, since it could be cloned away, etc, etc.

> I agree it doesn't fix the problem of uncooperative userspace.

IIUC, I see two issues:

- a slow monitor might cause a child to loop forever retrying the same
  interrupted syscall.

- a syscall-interrupted process may have had an fd added that it has no
  idea about.

The former problem seems like a userspace issue. :P But, to help, yeah, is
signal blocking best? Either explicit (at filter apply time) or implicit
(all user_notif-triggering syscalls get all signals blocks automatically)?

For the latter problem, I think we need to get back to Tycho's original
method: add fd and finish syscall in a single action. I can't see any
other way to get around the need for atomicity...

-- 
Kees Cook
