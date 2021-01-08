Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 599F62EED4C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 06:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbhAHFwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 00:52:39 -0500
Received: from mail-lf1-f42.google.com ([209.85.167.42]:43125 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbhAHFwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 00:52:38 -0500
Received: by mail-lf1-f42.google.com with SMTP id 23so20235438lfg.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 21:52:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T6uUflP+A07+vXTj9Bxxy+BapRrAweXSFEy3fWBrl1o=;
        b=C1gW4SoAqa1x+OYlHWiOtgwyUO96YIsjY69kkDlj5Ypiu5LHj9S5FllBOh4RvMR12F
         4LQe/yvKLfOfIszOuhVLuWqy+i7AvLxOdfpBMP1GEz5krPCTZXMVkKDivZYrrs9Fp/GU
         9NiRv1on14vlCjSlkou4Yj9KMYTA0YIVvDTrF4d+H+XXuN51cHawXbOvNWaTlrEBVHnT
         kvnf45Itn+hzJhi1fzSmgqEsHF5s3mJ0QhSC6ASeIOmhWjzwfUd5Agkvm4BABcSFHYvP
         IRGN9OkAzu+Fju6bYpKch7jtJGzixFWp3jUZeBDRPTnHhekYvhtxYtqDLQ8lTZYd7rca
         ACYA==
X-Gm-Message-State: AOAM5336q93cw8a6MIwO24yJIy2YJ1ED6/MU0zUALM97GEJtv6bKdHZz
        1pSEQj4qbfR7vHQlkOi+j3WJrihtuo/lOs/IJCM=
X-Google-Smtp-Source: ABdhPJwzCzhfyp3OVF7+NKxCclp8rhJZ/ImMA05urDguX7S5IhTfJ9CP+YSzsSY8nCKe+Uvyp/+A1UmSVZ15JrHlojs=
X-Received: by 2002:a19:23cf:: with SMTP id j198mr904831lfj.509.1610085116161;
 Thu, 07 Jan 2021 21:51:56 -0800 (PST)
MIME-Version: 1.0
References: <20201216090556.813996-1-namhyung@kernel.org> <20201216090556.813996-3-namhyung@kernel.org>
 <20201229115158.GH521329@kernel.org> <CAM9d7cidFuM5gmjq8=uy+mJjHHEVE=q6qESkc_OeTeGEQkGbnA@mail.gmail.com>
In-Reply-To: <CAM9d7cidFuM5gmjq8=uy+mJjHHEVE=q6qESkc_OeTeGEQkGbnA@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 8 Jan 2021 14:51:44 +0900
Message-ID: <CAM9d7chBmkG6S1QzF+gDU8=5ce8zQo2xM5Jr1t_iptsh_+t7NQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] tools/lib/fs: Cache cgroupfs mount point
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 6, 2021 at 10:33 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hi Arnaldo,
>
> On Tue, Dec 29, 2020 at 8:51 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Wed, Dec 16, 2020 at 06:05:56PM +0900, Namhyung Kim escreveu:
> > > Currently it parses the /proc file everytime it opens a file in the
> > > cgroupfs.  Save the last result to avoid it (assuming it won't be
> > > changed between the accesses).
> >
> > Which is the most likely case, but can't we use something like inotify
> > to detect that and bail out or warn the user?
>
> Hmm.. looks doable.  Will check.

So I've played with inotify a little bit, and it seems it needs to monitor
changes on the file or the directory.  I didn't get any notification from
the /proc/mounts file even if I did some mount/umount.

Instead, I could get IN_UNMOUNT when the cgroup filesystem was
unmounted.  But for the monitoring, we need to do one of a) select-like
syscall to wait for the events, b) signal-driven IO notification or c) read
the inotify file with non-block mode everytime.

In a library code, I don't think we can do a) or b) since it can affect
user program behaviors.  Then we should go with c) but I think
it's opposite to the purpose of this patch. :)

As you said, I think mostly we don't care as the accesses will happen
in a short period of time.  But if you really care, maybe for the upcoming
perf daemon changes, I think we can add an API to invalidate the cache
or internal time-based invalidation logic (like remove it after 10 sec.).

Thoughts?

Thanks,
Namhyung
