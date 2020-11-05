Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE482A84BF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 18:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731642AbgKERV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 12:21:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730975AbgKERV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 12:21:26 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B2CC0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 09:21:26 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id 23so1563015wmg.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 09:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jVksYP+m1csAgSVkfxG7oivUT+KEbcTMSnmWbNLe2cc=;
        b=MUimO6Mb7ah6cGTZAmJxgooDhnJYtCO+v11DToWUnLcnKBgIS9B522rXKjCeF//gj2
         P76Jx9NUMKepJIh5rbuSlFCSgBBpc9RjIE8OkFffh8b3OYLIXYZkS2dGcEQC+LREixDB
         8ZU0UMvyXJvyy9VP5x4hFCURmF4K4JWeGoKG87nvzf22wQUHBUkFFSsQUhPlTD3fCb/3
         +wgtioTDDpSjPOc/SpMBfrsfQGo+vFANxMb3Z8CAE9MAkWCWSFbB5eOC34x4BYcwvi5b
         y4G/hLMtTcGr3et8Dc6KcQdALXq3+Pz/huUYBFc3y/Mc+65JJ7y4JPT4wEoGkz3TXOu2
         HFhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jVksYP+m1csAgSVkfxG7oivUT+KEbcTMSnmWbNLe2cc=;
        b=g/vXTWb9Udxj+TQgNI13v6wR8Dn4lVi7rHzHPIEfd/F3WBVQlQCSsByPC/c9RZcKeT
         ShHfUyRjRoXArUUA6a+psE4ZqnvpbEj81wm4oXc2DqkjSFrzN9Dz02mQOUJ76DGhQjB+
         9CUpZY9iqJ/kQTD7or3QNwMAJzgNOZTEILOLctz7eKvy4G7wdfkH3aXchVxwBbGQH8Zq
         6thVBk3294MgZJGxiM3+O7ls3HLVQghXzfW0IB5/tEOtyjbck/B8E33878lULBUNC+Ev
         qxO5ALfF0XOlscplPo1VrPkLRepD3H3xI8VGWlfPLiv2TJeXSXklPG6Qjo/ucaNxQ0zZ
         WhIw==
X-Gm-Message-State: AOAM53222VjcC6fnfEAx/BNcM0Gz7y9anvy+f/F42PA+tlLBymsS+hvA
        H25B81FGNYY7oXIPZBqs5ic9HgX0P7qF7PGCxH3juA==
X-Google-Smtp-Source: ABdhPJwHMg6G//mLKaUG+ayZ/oBbHYiilTcQrDw6mInR9JdkQpyrnKlQ8b/n+2t4gyudsR/O/qG576iUthD6ZFtCukg=
X-Received: by 2002:a1c:7c0e:: with SMTP id x14mr3869550wmc.88.1604596884421;
 Thu, 05 Nov 2020 09:21:24 -0800 (PST)
MIME-Version: 1.0
References: <CAJuCfpEQ_ADYsMrF_zjfAeQ3d-FALSP+CeYsvgH2H1-FSoGGqg@mail.gmail.com>
 <20201015092030.GB22589@dhcp22.suse.cz> <CAJuCfpHwXcq1PfzHgqyYBR3N53TtV2WMt_Oubz0JZkvJHbFKGw@mail.gmail.com>
 <CAJuCfpH9iUt0cs1GBQppgdcD8chojCNXk22S+PeSgQ-bA7iitQ@mail.gmail.com>
 <20201103093550.GE21990@dhcp22.suse.cz> <20201103213228.GB1631979@google.com>
 <20201104065844.GM21990@dhcp22.suse.cz> <20201104204051.GA3544305@google.com>
 <20201105122012.GD21348@dhcp22.suse.cz> <CAJuCfpF5zAif97-uK8M+-fJhd0pab4fMPDMUNkAXYOB3MC7aXg@mail.gmail.com>
 <20201105171611.GO21348@dhcp22.suse.cz>
In-Reply-To: <20201105171611.GO21348@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 5 Nov 2020 09:21:13 -0800
Message-ID: <CAJuCfpHAxxoD6GG6t9_VthSa00znTHvLx60K-=cBee4ia1S5ew@mail.gmail.com>
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

On Thu, Nov 5, 2020 at 9:16 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Thu 05-11-20 08:50:58, Suren Baghdasaryan wrote:
> > On Thu, Nov 5, 2020 at 4:20 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Wed 04-11-20 12:40:51, Minchan Kim wrote:
> > > > On Wed, Nov 04, 2020 at 07:58:44AM +0100, Michal Hocko wrote:
> > > > > On Tue 03-11-20 13:32:28, Minchan Kim wrote:
> > > > > > On Tue, Nov 03, 2020 at 10:35:50AM +0100, Michal Hocko wrote:
> > > > > > > On Mon 02-11-20 12:29:24, Suren Baghdasaryan wrote:
> > > > > > > [...]
> > > > > > > > To follow up on this. Should I post an RFC implementing SIGKILL_SYNC
> > > > > > > > which in addition to sending a kill signal would also reap the
> > > > > > > > victim's mm in the context of the caller? Maybe having some code will
> > > > > > > > get the discussion moving forward?
> > > > > > >
> > > > > > > Yeah, having a code, even preliminary, might help here. This definitely
> > > > > > > needs a good to go from process management people as that proper is land
> > > > > > > full of surprises...
> > > > > >
> > > > > > Just to remind a idea I suggested to reuse existing concept
> > > > > >
> > > > > >     fd = pidfd_open(victim process)
> > > > > >     fdatasync(fd);
> > > > > >     close(fd);
> > > > >
> > > > > I must have missed this proposal. Anyway, are you suggesting fdatasync
> > > > > to act as a destructive operation?
> > > >
> > > > write(fd) && fdatasync(fd) are already destructive operation if the file
> > > > is shared.
> > >
> > > I am likely missing something because fdatasync will not destroy any
> > > underlying data. It will sync
> > >
> > > > You don't need to reaping as destruptive operation. Rather than, just
> > > > commit on the asynchrnous status "write file into page cache and commit
> > > > with fsync" and "killing process and commit with fsync".
> > >
> > > I am sorry but I do not follow. The result of the memory reaping is a
> > > data loss. Any private mapping will simply lose it's content. The caller
> > > will get EFAULT when trying to access it but there is no way to
> > > reconstruct the data. This is everything but not resembling what I see
> > > f{data}sync is used for.
> >
> > I think Minchan considers f{data}sync as a "commit" operation.
>
> But there is nothing like commit in that operation. It is simply a
> destroy operation. ftruncate as Minchan mentions in another reply would
> be a closer fit but how do you interpret the length argument? What about
> memory regions which cannot be reaped?
>
> I do understand that reusing an existing mechanism is usually preferable
> but the semantic should be reasonable and easy to reason about.

Maybe then we can consider a flag for pidfd_send_signal() to indicate
that we want a synchronous mm cleanup when SIGKILL is being sent?
Similar to my original RFC but cleanup would happen in the context of
the caller. That seems to me like the simplest and most obvious way of
expressing what we want to accomplish. WDYT?

>
> --
> Michal Hocko
> SUSE Labs
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
