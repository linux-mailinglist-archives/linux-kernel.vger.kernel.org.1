Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA4B2274CE5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 00:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgIVWzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 18:55:38 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53225 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbgIVWzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 18:55:38 -0400
Received: by mail-wm1-f65.google.com with SMTP id q9so5026601wmj.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 15:55:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4NROQY74ZndOZ+p5fr+GaaolzsVSn9rBnu2dnFCtdNs=;
        b=AMPrFTgSF7GhwrmdjL09mTahY1GtGdM32f5t/ASVPZwTRGbHsEYZeFV4eFhSDZJCBM
         ZPKnac2a4qJAdKmB9qT+Vyjg41VkVAfP9SAg+bKzWnYWiWSKV5C6yJNZeyqgQQUpUTvp
         DpYDagwRl3QhlT7nfrf3PlEVPAzBwMguD6jTBzQ2JiSiG/uiJWCUpxF9RPmBANpdbl5q
         Jt+wlkeR7dyNAIK5JVj09aJO2/y2eNGK6x4HvepgQ1OgcUrPs1+uWqN3dK6oike4Nj1n
         RMa1x4Le7NE+koRv/g9P2z4YLopHpBT/lH20Cb2naBT/cOS/H2JruUqp4VFZ7oELNEBi
         ZbQw==
X-Gm-Message-State: AOAM533ve/pFPuLkRn/FAjFOL3Z+FFowo9uoBsQjre9ALih+bfli4evt
        KQEdnVlZAFZzPPTFqdgiQYIbjen7FZ1LL2kmT7Y=
X-Google-Smtp-Source: ABdhPJx+XgPPbUdpz/htYqF6AzbbWV+sLJ9PO9qoUqYH60AH+nAxtKhuVWe+pxV5wri6q9Qt7zwf25E7zNonFsVGWKI=
X-Received: by 2002:a05:600c:4142:: with SMTP id h2mr3205019wmm.128.1600815337118;
 Tue, 22 Sep 2020 15:55:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200921094610.83736-1-namhyung@kernel.org> <20200921094610.83736-3-namhyung@kernel.org>
 <CABPqkBRnzGbfk0_K_eK47XDU9Fu4CTJC=4RXTXYc=cFLE-xtkg@mail.gmail.com>
In-Reply-To: <CABPqkBRnzGbfk0_K_eK47XDU9Fu4CTJC=4RXTXYc=cFLE-xtkg@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 23 Sep 2020 07:55:26 +0900
Message-ID: <CAM9d7ch5ZejOpDgj6fAGcGHAcbgEV6dZ4SfArw7xDMPKkTphvQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] perf stat: Add --for-each-cgroup option
To:     Stephane Eranian <eranian@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephane,

On Wed, Sep 23, 2020 at 6:52 AM Stephane Eranian <eranian@google.com> wrote:
>
> Hi,
>
> On Mon, Sep 21, 2020 at 2:46 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > The --for-each-cgroup option is a syntax sugar to monitor large number
> > of cgroups easily.  Current command line requires to list all the
> > events and cgroups even if users want to monitor same events for each
> > cgroup.  This patch addresses that usage by copying given events for
> > each cgroup on user's behalf.
> >
> > For instance, if they want to monitor 6 events for 200 cgroups each
> > they should write 1200 event names (with -e) AND 1200 cgroup names
> > (with -G) on the command line.  But with this change, they can just
> > specify 6 events and 200 cgroups with a new option.
> >
> > A simpler example below: It wants to measure 3 events for 2 cgroups
> > ('A' and 'B').  The result is that total 6 events are counted like
> > below.
> >
> >   $ ./perf stat -a -e cpu-clock,cycles,instructions --for-each-cgroup A,B sleep 1
> >
> You could also do it by keeping the -G option and providing
> --for-each-cgroup as a modifier
> of the behavior of -G:
>
> $ ./perf stat -a -e cpu-clock,cycles,instructions --for-each-cgroup -G
>  A,B sleep 1
>
> That way, you do not have to handle the case where both are used.
> And it makes transitioning to the new style simpler, i.e., the -G
> option remains, just need
> to trim the number of cgroups to 200 in your example.
>
> Just a suggestion.

Thanks for the suggestion.  Actually that's the approach I took
in my v1 submission.  And Jiri suggested the current way.
Personally I'm fine with either.

Thanks
Namhyung
