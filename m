Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01B5F2E6F69
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 10:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbgL2JlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 04:41:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54781 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725866AbgL2JlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 04:41:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609234789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nKuFqtuxYJnfDnnAZDeggezjGbN11aTOA5VNekQyLCs=;
        b=PpsxxCYvJ0YyRJuGHL8Km5lsW5qDxknrzB9q31qijhF2NfG0XXbSXQbyE4vV0poduMi6yO
        LN1uetFO0fvtyPmg/SQHYv13R9UL6FEDflwo1nJa8aXkF+1cpkEVt6IIX89F6WhA+N9p79
        RaI/zUhsYkB4f/tS2ceA/mJSSF8LiFs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-KwbAPhO5NXW5CpUAPe8oSA-1; Tue, 29 Dec 2020 04:39:47 -0500
X-MC-Unique: KwbAPhO5NXW5CpUAPe8oSA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A07B801817;
        Tue, 29 Dec 2020 09:39:45 +0000 (UTC)
Received: from krava (unknown [10.40.192.119])
        by smtp.corp.redhat.com (Postfix) with SMTP id A797771D54;
        Tue, 29 Dec 2020 09:39:42 +0000 (UTC)
Date:   Tue, 29 Dec 2020 10:39:40 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 2/3] tools/lib/fs: Diet cgroupfs_find_mountpoint()
Message-ID: <20201229093940.GF450923@krava>
References: <20201216090556.813996-1-namhyung@kernel.org>
 <20201216090556.813996-2-namhyung@kernel.org>
 <20201228083120.GA450923@krava>
 <CAM9d7cicPSLeMa25=GOsrzMBzk-Oz6XfA1NP=nOsH3fkvgkrmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cicPSLeMa25=GOsrzMBzk-Oz6XfA1NP=nOsH3fkvgkrmg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 29, 2020 at 02:27:36PM +0900, Namhyung Kim wrote:
> Hi Jiri,
> 
> On Mon, Dec 28, 2020 at 5:31 PM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Wed, Dec 16, 2020 at 06:05:55PM +0900, Namhyung Kim wrote:
> >
> > SNIP
> >
> > > +             *p++ = '\0';
> > >
> > > -                     while (token != NULL) {
> > > -                             if (subsys && !strcmp(token, subsys)) {
> > > -                                     /* found */
> > > -                                     fclose(fp);
> > > +             /* check filesystem type */
> > > +             if (strncmp(p, "cgroup", 6))
> > > +                     continue;
> > >
> > > -                                     if (strlen(mountpoint) < maxlen) {
> > > -                                             strcpy(buf, mountpoint);
> > > -                                             return 0;
> > > -                                     }
> > > -                                     return -1;
> > > -                             }
> > > -                             token = strtok_r(NULL, ",", &saved_ptr);
> > > -                     }
> > > +             if (p[6] == '2') {
> > > +                     /* save cgroup v2 path */
> > > +                     strcpy(mountpoint, path);
> > > +                     continue;
> > >               }
> > >
> > > -             if (!strcmp(type, "cgroup2"))
> > > -                     strcpy(path_v2, mountpoint);
> > > +             /* now we have cgroup v1, check the options for subsystem */
> > > +             p += 7;
> > > +
> > > +             p = strstr(p, subsys);
> >
> > not sure this is a real problem, but this would mixe up for
> > cpu/cpuacct/cpuset no? we are using the function for perf_event
> > subsys only, but it's globaly availble
> 
> Yeah, that's why I added the sanity check below. :)
> 
> >
> > > +             if (p == NULL)
> > > +                     continue;
> > > +
> > > +             /* sanity check: it should be separated by a space or a comma */
> > > +             if (!strchr(" ,", p[-1]) || !strchr(" ,", p[strlen(subsys)]))
> > > +                     continue;
> 
> Here.

aah right, sry ;-) looks ok

jirka

