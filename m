Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9990B2B7423
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 03:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbgKRCVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 21:21:11 -0500
Received: from relay64.bu.edu ([128.197.228.104]:41387 "EHLO relay64.bu.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgKRCVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 21:21:11 -0500
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated bits=0)
        by relay64.bu.edu (8.14.3/8.14.3) with ESMTP id 0AI2KagB026976
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 17 Nov 2020 21:20:41 -0500
Date:   Tue, 17 Nov 2020 21:20:36 -0500
From:   Alexander Bulekov <alxndr@bu.edu>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Collecting both remote and "local" coverage with KCOV
Message-ID: <20201118022036.dpi36duvtnwnuj2o@mozz.bu.edu>
References: <20201116023846.awjtbzh2o2yj4fvn@mozz.bu.edu>
 <CACT4Y+bh_QfSNVKVE=zODNKL5_8RLdcLf-j2ky0FJE_1hUi_hw@mail.gmail.com>
 <CAAeHK+wxupr3kqnr69QphciLLp13+A_7CgU+o_J7xBBxnRdbMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAeHK+wxupr3kqnr69QphciLLp13+A_7CgU+o_J7xBBxnRdbMg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 201116 1805, Andrey Konovalov wrote:
> On Mon, Nov 16, 2020 at 9:35 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Mon, Nov 16, 2020 at 3:39 AM Alexander Bulekov <alxndr@bu.edu> wrote:
> > >
> > > Hello,
> > > I'm trying to collect coverage over the syscalls issued by my process,
> > > as well as the kthreads spawned as a result of these syscalls
> > > (eg coverage over vhost ioctls and the worker kthread). Is there a way
> > > to collect coverage with both KCOV_REMOTE_ENABLE(with common_handle) and
> > > KCOV_ENABLE, simultaneously?
> > >
> > > Based on the code it seems that these two modes are mutually
> > > exclusive within a single task, but I don't think this is mentioned in
> > > the Documentation, so I want to make sure I'm not missing something.
> >
> > Hi Alex,
> >
> > Yes, it's probably not supported within a single task. The easiest way
> > to verify is to try it ;)
> >
> > It is possible to collect both coverages, but you will need 2 threads
> > (one just to set up remote KCOV).
> >
> > Unless I am missing any fundamental limitations, I would say it would
> > be reasonable to support this within a single task as well.
> 
> I think the reason we did that initially, is because we don't care
> about normal coverage for USB emitting pseudo-syscalls. Filed a bug
> for this: https://bugzilla.kernel.org/show_bug.cgi?id=210225

I'm interested in adding support for this. Looking through the code, I
can think of ~two approaches: 

1.) Allow the same kcov fd to be used to track coverage with both
KCOV_REMOTE_ENABLE and KCOV_ENABLE. If we try to use the same coverage
bitmap for both the remote and the local coverage, I think the local
part would have to deal with the kcov_remote_lock. If the local part
continues to write directly into the user-space coverage-area, as it
does now, it seems it would require locking for each __sanitizer_cov
call.  Alternatively, the local and the remote parts could write into
different coverage-bitmaps, but I'm not sure if there is a neat way to
do this.

2.) Allow multiple kcov fds to be used by the same task. In the task,
keep a linked-list of pointers to kcov objects (remote or local). For
each __sanitizer_... call, walk the linked list and check if any of the
kcov objects match the requirements (trace_cmp/trace_pc/remote). This
would also have the side-effect of enabling simultaneous PC and CMP
tracing. Of course, it seems that this would add some overhead (in the
case of a single open fd, there would be extra pointer dereferences to
get the area[], size, etc).

Am I missing a better alternative?
Thanks
