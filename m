Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2212FE0CC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 05:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731107AbhAUEfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 23:35:31 -0500
Received: from mail-lf1-f43.google.com ([209.85.167.43]:33828 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728563AbhAUEeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 23:34:31 -0500
Received: by mail-lf1-f43.google.com with SMTP id o19so730535lfo.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 20:34:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8ovp6uu8GZU/72kGxqTfPjkW2rvPcfWPOhm7bRXegKI=;
        b=KCgabE9AxNqPeBXT8gnPfFlDg43VDtcwUE0zbH6gdGHpD878gx058ylXjh/L7ZVAR5
         gj0RzmNX+P3eVeBcOa2f74ugn8TrdkAjTe/4MZj5A3z+D9tgrOueLgKvsnLNtLnAbja+
         DnG0Jv15EcY6XnJStyvvl50UY1meL1WMiMeH17EUYG4naNbjCoggJtlWPIqqCdLjXXtx
         GxO+3REAqYETKdgZCuYUFzWqhMd1n4fNAaibqCzOmHxhAWyY9ovcrPm9CY0Mns8wy6M5
         +8zel3rzD/vla58TKHEXPYFXvUbZCZBxKnWVb6tBOtyUEwLNYe6cXo553mv/ZsCKw5cL
         waRQ==
X-Gm-Message-State: AOAM5316kAyv4IoCZxG9gmBIeijtlc5i20hOB3/aI0LcTbpfgiR0Jluk
        sFuN7mH8ApPMiXnYACgIcO1Rxlmm2ybbgKBEDrU=
X-Google-Smtp-Source: ABdhPJzABLfvJQtVsXhTz35dJokFcI7bTeriXRdo3qP69tixcnhJoKjsUkauG4RBi5PXr9T0kTxz0nQE/H+KH1yMBAA=
X-Received: by 2002:a19:8584:: with SMTP id h126mr5709146lfd.152.1611203629557;
 Wed, 20 Jan 2021 20:33:49 -0800 (PST)
MIME-Version: 1.0
References: <20201216090556.813996-1-namhyung@kernel.org> <20201216090556.813996-3-namhyung@kernel.org>
 <20201229115158.GH521329@kernel.org> <CAM9d7cidFuM5gmjq8=uy+mJjHHEVE=q6qESkc_OeTeGEQkGbnA@mail.gmail.com>
 <CAM9d7chBmkG6S1QzF+gDU8=5ce8zQo2xM5Jr1t_iptsh_+t7NQ@mail.gmail.com>
In-Reply-To: <CAM9d7chBmkG6S1QzF+gDU8=5ce8zQo2xM5Jr1t_iptsh_+t7NQ@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 21 Jan 2021 13:33:37 +0900
Message-ID: <CAM9d7ci5W06UNthEBBs=-wJLjusO=bpFg2sFj=M0W3h20+oaHA@mail.gmail.com>
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

Hi Arnaldo,

Can you share your thoughts on this?

On Fri, Jan 8, 2021 at 2:51 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Wed, Jan 6, 2021 at 10:33 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hi Arnaldo,
> >
> > On Tue, Dec 29, 2020 at 8:51 PM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > Em Wed, Dec 16, 2020 at 06:05:56PM +0900, Namhyung Kim escreveu:
> > > > Currently it parses the /proc file everytime it opens a file in the
> > > > cgroupfs.  Save the last result to avoid it (assuming it won't be
> > > > changed between the accesses).
> > >
> > > Which is the most likely case, but can't we use something like inotify
> > > to detect that and bail out or warn the user?
> >
> > Hmm.. looks doable.  Will check.
>
> So I've played with inotify a little bit, and it seems it needs to monitor
> changes on the file or the directory.  I didn't get any notification from
> the /proc/mounts file even if I did some mount/umount.
>
> Instead, I could get IN_UNMOUNT when the cgroup filesystem was
> unmounted.  But for the monitoring, we need to do one of a) select-like
> syscall to wait for the events, b) signal-driven IO notification or c) read
> the inotify file with non-block mode everytime.
>
> In a library code, I don't think we can do a) or b) since it can affect
> user program behaviors.  Then we should go with c) but I think
> it's opposite to the purpose of this patch. :)
>
> As you said, I think mostly we don't care as the accesses will happen
> in a short period of time.  But if you really care, maybe for the upcoming
> perf daemon changes, I think we can add an API to invalidate the cache
> or internal time-based invalidation logic (like remove it after 10 sec.).
>
> Thoughts?
>
> Thanks,
> Namhyung
