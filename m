Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B39F2A8400
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 17:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731451AbgKEQvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 11:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbgKEQvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 11:51:12 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F07C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 08:51:11 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id 33so2562143wrl.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 08:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NsSOwfObqGKsJeYo0q+XP7I+q7AninZaPo0NYvAlFtQ=;
        b=o2IQSq6j0VwM/R0btmZWJs6b/Dvi7FQ4ZjT/EqcStYteFkVoyRHt6bna2M/7j4qTnW
         Vqj4Qf/3QOTS/8S7tK0i43lcZYek73AJhSS00CgrGsWdo2pxBHO6sU4CNh121KSZIbKz
         mIsMSJd7bgeQ27dRD5AYZ6IeHnp/jnVmXqnraUK5v7jn8shiPT1FEsCY0ofpg3PRInMd
         H2dvHP56WhaCUutrNhrajdyJaSuCvH9K5niYE8izVbWNESACNrrxJYM6wEjbyuBkvHNj
         WiwRczsIimGlJiaVCxiJfkDjh6soN6OhIhemK36MpqegPsYw2BSqEXLRN3ecxaLyVfah
         gaEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NsSOwfObqGKsJeYo0q+XP7I+q7AninZaPo0NYvAlFtQ=;
        b=K2cIviqpa7BfgMKWnd9Jd1NFLIIaNgb0jZwGH0gRTbWTccWFpAEcqVGwt4feHeBOe8
         DQluyn9UqzWjzg/7IJz/X3WyYRzmX4wzn7IZuhwpwDaIvTgjxMA7K1pP9imWtSRy/xsB
         bT+W8KDI5Ff11DchAXh+0YFnFx8S6BFIRVWT/jXAvQyZt2aJN/IN4c8UTuFG1bVBsCp5
         dcXoRdipsMT9Nw5bUzF/03cxsyZ3Pq1VQ+Y5yVJ8/6S8jzwwgFsSnv79sjWiVQeKqyZh
         7n4xnDpMw14W7G74nhuxLgRmbo4mbXkNiUGtK+PbIYff9b882DuirGLjBrZNi/BveAGm
         ledA==
X-Gm-Message-State: AOAM53138dCeomtgj00NDiXafZ6Kr3AKqnQH2qQ0X0aUttC78FdacWH3
        59VbdV9LbRLPPfHOKEQQWJ1bYOhygU2xCGV5KpAX+A==
X-Google-Smtp-Source: ABdhPJyuVTnDPeoDRYnoWA33u1B4m/Z9lIYxfxsDJheI/gv/bI4+1YjMh4wd6cJdVBO5r5ZxVfj8c+K0O2WrjIe0XjI=
X-Received: by 2002:a5d:688c:: with SMTP id h12mr4185593wru.92.1604595069693;
 Thu, 05 Nov 2020 08:51:09 -0800 (PST)
MIME-Version: 1.0
References: <CAJuCfpGjuUz5FPpR5iQ7oURJAhnP1ffBAnERuTUp9uPxQCRhDg@mail.gmail.com>
 <20201014120937.GC4440@dhcp22.suse.cz> <CAJuCfpEQ_ADYsMrF_zjfAeQ3d-FALSP+CeYsvgH2H1-FSoGGqg@mail.gmail.com>
 <20201015092030.GB22589@dhcp22.suse.cz> <CAJuCfpHwXcq1PfzHgqyYBR3N53TtV2WMt_Oubz0JZkvJHbFKGw@mail.gmail.com>
 <CAJuCfpH9iUt0cs1GBQppgdcD8chojCNXk22S+PeSgQ-bA7iitQ@mail.gmail.com>
 <20201103093550.GE21990@dhcp22.suse.cz> <20201103213228.GB1631979@google.com>
 <20201104065844.GM21990@dhcp22.suse.cz> <20201104204051.GA3544305@google.com> <20201105122012.GD21348@dhcp22.suse.cz>
In-Reply-To: <20201105122012.GD21348@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 5 Nov 2020 08:50:58 -0800
Message-ID: <CAJuCfpF5zAif97-uK8M+-fJhd0pab4fMPDMUNkAXYOB3MC7aXg@mail.gmail.com>
Subject: Re: [RFC]: userspace memory reaping
To:     Michal Hocko <mhocko@suse.com>
Cc:     Minchan Kim <minchan@kernel.org>, linux-api@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Christian Brauner <christian@brauner.io>,
        Oleg Nesterov <oleg@redhat.com>,
        Tim Murray <timmurray@google.com>,
        kernel-team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 5, 2020 at 4:20 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Wed 04-11-20 12:40:51, Minchan Kim wrote:
> > On Wed, Nov 04, 2020 at 07:58:44AM +0100, Michal Hocko wrote:
> > > On Tue 03-11-20 13:32:28, Minchan Kim wrote:
> > > > On Tue, Nov 03, 2020 at 10:35:50AM +0100, Michal Hocko wrote:
> > > > > On Mon 02-11-20 12:29:24, Suren Baghdasaryan wrote:
> > > > > [...]
> > > > > > To follow up on this. Should I post an RFC implementing SIGKILL_SYNC
> > > > > > which in addition to sending a kill signal would also reap the
> > > > > > victim's mm in the context of the caller? Maybe having some code will
> > > > > > get the discussion moving forward?
> > > > >
> > > > > Yeah, having a code, even preliminary, might help here. This definitely
> > > > > needs a good to go from process management people as that proper is land
> > > > > full of surprises...
> > > >
> > > > Just to remind a idea I suggested to reuse existing concept
> > > >
> > > >     fd = pidfd_open(victim process)
> > > >     fdatasync(fd);
> > > >     close(fd);
> > >
> > > I must have missed this proposal. Anyway, are you suggesting fdatasync
> > > to act as a destructive operation?
> >
> > write(fd) && fdatasync(fd) are already destructive operation if the file
> > is shared.
>
> I am likely missing something because fdatasync will not destroy any
> underlying data. It will sync
>
> > You don't need to reaping as destruptive operation. Rather than, just
> > commit on the asynchrnous status "write file into page cache and commit
> > with fsync" and "killing process and commit with fsync".
>
> I am sorry but I do not follow. The result of the memory reaping is a
> data loss. Any private mapping will simply lose it's content. The caller
> will get EFAULT when trying to access it but there is no way to
> reconstruct the data. This is everything but not resembling what I see
> f{data}sync is used for.

I think Minchan considers f{data}sync as a "commit" operation. So
write+f{data}sync would mean we write and commit written data,
kill+f{data}sync would mean we kill and commit that kill (reclaim the
resources).

>
> --
> Michal Hocko
> SUSE Labs
