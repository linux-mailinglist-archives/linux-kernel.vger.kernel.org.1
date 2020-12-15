Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A20802DAA22
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 10:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbgLOJcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 04:32:41 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:55771 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbgLOJc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 04:32:27 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kp6gH-0000jT-3T; Tue, 15 Dec 2020 09:31:41 +0000
Date:   Tue, 15 Dec 2020 10:31:40 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Some fixes for v5.11
Message-ID: <20201215093140.uin7tveoa6hg3ulb@wittgenstein>
References: <20201214132745.3323776-1-christian.brauner@ubuntu.com>
 <CAHk-=wic8QjSuwjwpk8oLvtgWWCGfAC72ojuAU3PwYr7CWHqHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wic8QjSuwjwpk8oLvtgWWCGfAC72ojuAU3PwYr7CWHqHg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14, 2020 at 04:45:50PM -0800, Linus Torvalds wrote:
> On Mon, Dec 14, 2020 at 5:27 AM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> >
> > /* Conflicts */
> > At the time of creating this PR no merge conflicts were reported from
> > linux-next and no merge conflict with 2c85ebc57b3e ("Linux 5.10") when
> > pulling the tag.
> 
> Really? It conflicted with your own time namespace fixes.. Was one or
> the other not in linux-next?

Oh sorry, I guess you didn't see that. The simple time namespace fixes
didn't make it into -next because I missed to merge them into my
for-next branch when I took them. I did mention it in the
time-namespace-v5.11 pull-request in the /* Testing */ section but
apparently this wasn't prominent enough.

"Please note that I missed to merge these fixes into my for-next branch and so
linux-next has not contained the commits in this pr.
I'm still sending this pr because these are fairly trivial bugfixes and have
seen vetting from multiple people. I have also now merged this tag into my
for-next branch so these commits will show up in linux-next soon. If you feel
more comfortable with this sitting in linux-next for a while please just ignore
this pr and I'll resend after rc1 has been released."

> 
> Not that the conflicts were big or bad (free_time_ns() prototype
> changed right next to timens_on_fork() prototype), I'm just surprised
> you saw no conflicts..

Hm, I did pull linux-next 20201214 and then did a pull from my tag. And
as usual I always do a test-pull based on v5.* releaste tag and they
didn't show any merge conflicts.

> 
> It may be that Stephen didn't even bother reporting them as trivial.

No, this was definitely my fault. I'll try to make sure this won't
repeat. Thanks for still pulling.

Christian
