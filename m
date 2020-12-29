Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16F1B2E6E4D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 06:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbgL2F2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 00:28:31 -0500
Received: from mail-qt1-f178.google.com ([209.85.160.178]:40132 "EHLO
        mail-qt1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgL2F2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 00:28:30 -0500
Received: by mail-qt1-f178.google.com with SMTP id v5so8326684qtv.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 21:28:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eXjWu/zitfPX31anoPTlB8mGevTypYdxXLLBsNM4LMI=;
        b=nD0lfm88lGNkyCaDlPSkeDggWtrXn44TBfq6744qUBauJvZFi5RwZkLvCTVUwpf9Tl
         DXBsl/e+DgcbIHU9L2svdoJ+YTUaSZN8FMNGnYJVQvmtCix8EAM5Tub8nqQigcXBopTL
         k7eoFVsy6mkh6dHIJRraa66bD/ORAe1VP2oo2p0f6N0UAp6lMGWhQV7qdpUG4qtwHFLm
         cnr9tmyS1Y0tAlyXkOQhqMPz3ea4oHEt6sYo3mo3fFsV79YACrj4/h6sSK1/4AI3u7Fr
         UL5hbtFwslvrn//jeemhvZ7CirNU9v3HjpFbwcpadHixIqPMOtnXOwSeu2cI6d2QhDAP
         iclQ==
X-Gm-Message-State: AOAM5320LBQI9cjj90CzG6N4E4bfI7hiW79dvRxdQswlszhyFTRPsky1
        qEzCApCTsQ2WgGBYuypJGTNVP8DNTEx5rGYqfcU=
X-Google-Smtp-Source: ABdhPJwtUtVs0pB6fEiNDsdDmgJ809MhMDxOUezmoB+poCHH/T0I099xl719HJvky15rdZ/3bwV+rp+p6g+yLEzAhCk=
X-Received: by 2002:ac8:4d4d:: with SMTP id x13mr47165747qtv.385.1609219669276;
 Mon, 28 Dec 2020 21:27:49 -0800 (PST)
MIME-Version: 1.0
References: <20201216090556.813996-1-namhyung@kernel.org> <20201216090556.813996-2-namhyung@kernel.org>
 <20201228083120.GA450923@krava>
In-Reply-To: <20201228083120.GA450923@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 29 Dec 2020 14:27:36 +0900
Message-ID: <CAM9d7cicPSLeMa25=GOsrzMBzk-Oz6XfA1NP=nOsH3fkvgkrmg@mail.gmail.com>
Subject: Re: [PATCH 2/3] tools/lib/fs: Diet cgroupfs_find_mountpoint()
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
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

Hi Jiri,

On Mon, Dec 28, 2020 at 5:31 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Wed, Dec 16, 2020 at 06:05:55PM +0900, Namhyung Kim wrote:
>
> SNIP
>
> > +             *p++ = '\0';
> >
> > -                     while (token != NULL) {
> > -                             if (subsys && !strcmp(token, subsys)) {
> > -                                     /* found */
> > -                                     fclose(fp);
> > +             /* check filesystem type */
> > +             if (strncmp(p, "cgroup", 6))
> > +                     continue;
> >
> > -                                     if (strlen(mountpoint) < maxlen) {
> > -                                             strcpy(buf, mountpoint);
> > -                                             return 0;
> > -                                     }
> > -                                     return -1;
> > -                             }
> > -                             token = strtok_r(NULL, ",", &saved_ptr);
> > -                     }
> > +             if (p[6] == '2') {
> > +                     /* save cgroup v2 path */
> > +                     strcpy(mountpoint, path);
> > +                     continue;
> >               }
> >
> > -             if (!strcmp(type, "cgroup2"))
> > -                     strcpy(path_v2, mountpoint);
> > +             /* now we have cgroup v1, check the options for subsystem */
> > +             p += 7;
> > +
> > +             p = strstr(p, subsys);
>
> not sure this is a real problem, but this would mixe up for
> cpu/cpuacct/cpuset no? we are using the function for perf_event
> subsys only, but it's globaly availble

Yeah, that's why I added the sanity check below. :)

>
> > +             if (p == NULL)
> > +                     continue;
> > +
> > +             /* sanity check: it should be separated by a space or a comma */
> > +             if (!strchr(" ,", p[-1]) || !strchr(" ,", p[strlen(subsys)]))
> > +                     continue;

Here.

Thanks,
Namhyung


> > +
> > +             strcpy(mountpoint, path);
> > +             break;
> >       }
> > +     free(line);
> >       fclose(fp);
> >
> > -     if (path_v2[0] && strlen(path_v2) < maxlen) {
> > -             strcpy(buf, path_v2);
> > +     if (mountpoint[0] && strlen(mountpoint) < maxlen) {
> > +             strcpy(buf, mountpoint);
> >               return 0;
> >       }
> >       return -1;
> > --
> > 2.29.2.684.gfbc64c5ab5-goog
> >
>
