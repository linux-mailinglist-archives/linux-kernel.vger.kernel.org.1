Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9292CF357
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 18:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbgLDRrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 12:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbgLDRru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 12:47:50 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F138C061A53
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 09:47:10 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id v3so3492015plz.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 09:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YRl4xaWPv7d+f+XRgORxuMpHebNtXiM6WlyURXxB4l4=;
        b=EwITWSd3NyGz01qhAhX9VCQTFEHJcet65JIE+86ZwqIcKRmclA67uCt4bUJt7MbVxI
         /9SndBkwFsLI346sBttx9KU4tpfcep2/tCg04NApiiMhRyV6XYiOu2BxJ+VJFN9u+6k2
         gr7T8qOpGnYqkZ4QGn6TdrgeeKqVmAmb/GsvhsAgnYcCGnqXZSY7uujDKzmlaFAl1aRl
         Co5J+/K9fY+rsV9Q6RX6MxJWMmfXuYnm3l9fs7xe5FdgMPWzyfh+chMg61OkUw9wN7vE
         zodmxdGHseiPAKyTVjx+k1oLGlxR4I2KFwJcwE+UggFxVySBjssijUgGUoJytYJPEe27
         66Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YRl4xaWPv7d+f+XRgORxuMpHebNtXiM6WlyURXxB4l4=;
        b=hpMKd95S9A3wi2pk3QQFUirQG3ViKYV6vykwAFSvFzRUeyYTpuBkjapPc/hlCJ3mBa
         xMh/mJCEAHdNRbDulNDNfiQfZuWdo/3Y9RvAwx7/2GtE8QdMV+cYG/RjWV1csGUh7iF9
         LqYa87MXrEc5VaFNGfiZat7ujjrLPHlGvTPDk4FuM0KWeAgqp0XfXytJpFnatNF6AYSF
         K873HUTVonCPAtNFIom2Oa/aYmkpVwumu7ZrZtQ6jy/nB9ku6bTV4qiGKpCJ/mtaeJ4Z
         CMNEoPRdh7iYaMCpQRMBUoY9kvf98AT8+kRS6C6H/cSgiPY7AJ+1RdNDNlu1iDRfRTTG
         /kbA==
X-Gm-Message-State: AOAM532LHNTAOSlXahwLdjhlKdMPb65KeAjAEQjKuNqW12/ZO9Zt/4+y
        wzOz9TVnFan4Zfo1MzRMjYup0o4eKXwe5colD3UI6A==
X-Google-Smtp-Source: ABdhPJyjzl/QPPAowJCuEkNFLALdZaDvYL4FurWcvSIVnN4uaZY5O1XjpO5DVYiFSfrCCdfk/z94YhQ6D3TP8DrUM3k=
X-Received: by 2002:a17:90b:1287:: with SMTP id fw7mr5184713pjb.52.1607104029937;
 Fri, 04 Dec 2020 09:47:09 -0800 (PST)
MIME-Version: 1.0
References: <20201130233504.3725241-1-axelrasmussen@google.com>
 <CALvZod42+o7naLOkpo9Jngmhru-aR4K6RCuTk7TukCikAYrDbQ@mail.gmail.com>
 <CAJHvVcgtoyJ_C0L=KByb8UbZm6x_RtCTnznYA1HwmdzX4Y=mHw@mail.gmail.com>
 <xr93lfehl8al.fsf@gthelen.svl.corp.google.com> <CALvZod4j9fFpGRfkios1ef0D5qhyw3XA_VSVm0k__RuMG1Qhwg@mail.gmail.com>
 <CAJHvVchcm_HLd1RaibCZDZi27_2CVCwUWDX515dvnPPyTpHBHw@mail.gmail.com>
 <CALvZod5CpPhvzB99VZTc33Sb5YCbJNHFe3k33k+HwNfJvJbpJQ@mail.gmail.com>
 <CAJHvVcjBErccEwNjuDqzsrbuzSmJva7uknZKhtBwWfs9_t4zTg@mail.gmail.com>
 <CALvZod6qpbEX+kp_gh5O4U1-kc+DfoG4DnGoWMvVnuXUOTLBBg@mail.gmail.com>
 <20201201200715.6171d39b@oasis.local.home> <CALvZod5mAtes0T5DFCgjU+CKVBVOdYc=jPFHXvAU+LzDqGXomg@mail.gmail.com>
 <1eb44e95-1fae-5d64-d114-d305c9b8ef63@suse.cz>
In-Reply-To: <1eb44e95-1fae-5d64-d114-d305c9b8ef63@suse.cz>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Fri, 4 Dec 2020 09:46:33 -0800
Message-ID: <CAJHvVchKvuB4ez-43+CQAcuyinCceGuJNxHuRkO6=E7hW5uXVQ@mail.gmail.com>
Subject: Re: [PATCH] mm: mmap_lock: fix use-after-free race and css ref leak
 in tracepoints
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>, Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Rientjes <rientjes@google.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Michel Lespinasse <walken@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Yafang Shao <laoar.shao@gmail.com>,
        "David S . Miller" <davem@davemloft.net>, dsahern@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakub Kicinski <kuba@kernel.org>, liuhangbin@gmail.com,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 4, 2020 at 8:36 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 12/2/20 2:11 AM, Shakeel Butt wrote:
> > On Tue, Dec 1, 2020 at 5:07 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >>
> >> On Tue, 1 Dec 2020 16:36:32 -0800
> >> Shakeel Butt <shakeelb@google.com> wrote:
> >>
> >> > SGTM but note that usually Andrew squash all the patches into one
> >> > before sending to Linus. If you plan to replace the path buffer with
> >> > integer IDs then no need to spend time fixing buffer related bug.
> >>
> >> I don't think Andrew squashes all the patches. I believe he sends Linus
> >> a patch series.
> >
> > I am talking about the patch and the following fixes to that patch.
> > Those are usually squashed into one patch.
>
> Yeah, if there's a way forward that doesn't need to construct full path on each
> event and the associated complexity and just use an ID, let's convert to the ID
> and squash it, for less churn. Especially if there are other existing
> tracepoints that use the ID.

The thing I worry about is that it being inconvenient will prevent
folks from using it to send us data on how mmap_lock behaves under
their workloads. Anecdotally, I talked to a few teams within Google,
and it seems those using containers use paths instead of IDs to refer
to them, and they don't have existing infrastructure to keep track of
the mapping. So to collect data from those workloads, we'd have to
wait for them to build such a thing, vs. just asking them to run a
bash one-liner. I haven't done a wider survey, but I suspect the same
is true for users of e.g. Docker or Kubernetes.

>
> If there's further (somewhat orthogonal) work to make the IDs easier for
> userspace, it can be added on top later, but really shouldn't need to add the
> current complex solution only to remove it later?

I'm on board with Shakeel's idea to export this on cgroup
creation/deletion instead, since it lets us keep the complexity in
exactly one place. I think such a thing would use the same code I'm
proposing now, though, so we wouldn't just be deleting it if we merge
it. Also, before doing that I think it's worth identifying a second
user within the kernel (maybe the writeback tracepoint mentioned
earlier in the thread?), so doing it incrementally seems reasonable to
me.

This plan is also in-line with existing stuff we provide. Histogram
triggers provide utilities like ".execname" (PID -> execname) or
".sym" (address -> symbol) for convenience. Sure, userspace could
figure these things out for itself, but it's convenient to provide
them directly, and it's not so bad since we have exactly one place in
the tracing infrastructure that knows how to do these translations.

Actually, maybe a ".cgpath" variant would be better than a separate
tracepoint. I haven't looked at what either approach would require in
detail; maybe another reason to do this iteratively. :)

>
> Thanks,
> Vlastimil
