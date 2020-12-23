Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 640F12E1C1E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 13:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbgLWMMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 07:12:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728409AbgLWMMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 07:12:51 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70016C061793
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 04:12:10 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id m12so39599279lfo.7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 04:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/wIYMsJQZ3iQsBLuaM3BKXb1BHAX1SBVB27T+5mB2YE=;
        b=by/eFrNKLecUUvgYEmFr+diz0SlI/quL8lPzJ/YxvQYp0kjYupCwPospTA7Y5qNJmN
         6yb30XMZLcQ/iyxdEruILIxjEbFW4gQ31OflZaJASF4XAKAW+iIhrR7XMC51F3QDvv0z
         X9yaOlhOzwmn2oWlCVY4U4t42uWkdbaqFty0ACEP9FpkONaYC2qqKNxyg+lS/3OI/EQ+
         rUa5KdN6jxJdkSTGUet0xlCWKk8UdFGcWosIHmEOymSkWDnOyUE32CPiUt6N6odjv43A
         Yzh2xQEHvF4sWXB+vjOhxPVsW/gx9lGnmEHaWiD2qhN5o5xZQIj4Als/dT1zOjVL4O9s
         oZUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/wIYMsJQZ3iQsBLuaM3BKXb1BHAX1SBVB27T+5mB2YE=;
        b=Nl7X34j+lstpThwnkCHIQc4EgC1SsV7Xrof6X1QK3z1jwjKSMrFAyejPOoo6cInB0z
         Zac/frvXed+dfV1O1BqpPXZOgrqs7IBQz8fMOPRRxexRJKdJGlQd4C5sB2tjvq/EwcOC
         pqM55kLOvnulkc8Fcbm5esBUXtYeUkFJncY5O13OTLkWAjogt95kD9TaKal/JCWF+XXY
         xE4+eaM62nXiQ/mLSdkSk3NWUxBI6NEaE2tS+qwz31Zh9/slrM/XpdChQdQE0Dyb6P9R
         JrKoKloO0mX0ruH9UMaAUJPPbcHaVG9mdzK7zVfFcm5Ptxj5bhAtoeUdSCPkzTIOtSuf
         XXeQ==
X-Gm-Message-State: AOAM530Uxiint3HTyFy43ykmuaD5hhuhHKKc5ZydnsgzwMUi0AXnIjgB
        cU+pBaScBqGyarlE7UsBaszMDot3MEjxLMf67UE=
X-Google-Smtp-Source: ABdhPJxu0iGpRpL6oyLN/jLqLsq4DbkuVOieU+xjWhjSOyJi5zSINrSFL3JcdP4Hj/0Gdo7ocnDeRvnWTdQ+ZU0iWyI=
X-Received: by 2002:a05:6512:1112:: with SMTP id l18mr10219334lfg.538.1608725528976;
 Wed, 23 Dec 2020 04:12:08 -0800 (PST)
MIME-Version: 1.0
References: <20201221162519.GA22504@open-light-1.localdomain>
 <7bf0e895-52d6-9e2d-294b-980c33cf08e4@redhat.com> <CA+2MQi89v=DZJZ7b-QaMsU2f42j4SRW47XcZvLtBj10YeqRGgQ@mail.gmail.com>
 <840ff69d-20d5-970a-1635-298000196f3e@redhat.com> <CA+2MQi87+N87x+gLuJPurst38AfFQhnc9eyHr8On55d1+WY5zQ@mail.gmail.com>
 <55052a91-64f9-b343-a1c4-f059ca50ecf3@redhat.com>
In-Reply-To: <55052a91-64f9-b343-a1c4-f059ca50ecf3@redhat.com>
From:   Liang Li <liliang324@gmail.com>
Date:   Wed, 23 Dec 2020 20:11:57 +0800
Message-ID: <CA+2MQi_C-PTqyrqBprhtGBAiDBnPQBzwu6hvyuk+QiKy0L3sHw@mail.gmail.com>
Subject: Re: [RFC v2 PATCH 0/4] speed up page allocation for __GFP_ZERO
To:     David Hildenbrand <david@redhat.com>
Cc:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Liang Li <liliangleo@didiglobal.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 23, 2020 at 4:41 PM David Hildenbrand <david@redhat.com> wrote:
>
> [...]
>
> >> I was rather saying that for security it's of little use IMHO.
> >> Application/VM start up time might be improved by using huge pages (and
> >> pre-zeroing these). Free page reporting might be improved by using
> >> MADV_FREE instead of MADV_DONTNEED in the hypervisor.
> >>
> >>> this feature, above all of them, which one is likely to become the
> >>> most strong one?  From the implementation, you will find it is
> >>> configurable, users don't want to use it can turn it off.  This is not
> >>> an option?
> >>
> >> Well, we have to maintain the feature and sacrifice a page flag. For
> >> example, do we expect someone explicitly enabling the feature just to
> >> speed up startup time of an app that consumes a lot of memory? I highly
> >> doubt it.
> >
> > In our production environment, there are three main applications have such
> > requirement, one is QEMU [creating a VM with SR-IOV passthrough device],
> > anther other two are DPDK related applications, DPDK OVS and SPDK vhost,
> > for best performance, they populate memory when starting up. For SPDK vhost,
> > we make use of the VHOST_USER_GET/SET_INFLIGHT_FD feature for
> > vhost 'live' upgrade, which is done by killing the old process and
> > starting a new
> > one with the new binary. In this case, we want the new process started as quick
> > as possible to shorten the service downtime. We really enable this feature
> > to speed up startup time for them  :)
>
> Thanks for info on the use case!
>
> All of these use cases either already use, or could use, huge pages
> IMHO. It's not your ordinary proprietary gaming app :) This is where
> pre-zeroing of huge pages could already help.

You are welcome.  For some historical reason, some of our services are
not using hugetlbfs, that is why I didn't start with hugetlbfs.

> Just wondering, wouldn't it be possible to use tmpfs/hugetlbfs ...
> creating a file and pre-zeroing it from another process, or am I missing
> something important? At least for QEMU this should work AFAIK, where you
> can just pass the file to be use using memory-backend-file.
>
If using another process to create a file, we can offload the overhead to
another process, and there is no need to pre-zeroing it's content, just
populating the memory is enough.
If we do it that way, then how to determine the size of the file? it depends
on the RAM size of the VM the customer buys. Maybe we can create a file
large enough in advance and truncate it to the right size just before the
VM is created. Then, how many large files should be created on a host?
You will find there are a lot of things that have to be handled properly.
I think it's possible to make it work well, but we will transfer the
management complexity to up layer components. It's a bad practice to let
upper layer components process such low level details which should be
handled in the OS layer.

> >
> >> I'd love to hear opinions of other people. (a lot of people are offline
> >> until beginning of January, including, well, actually me :) )
> >
> > OK. I will wait some time for others' feedback. Happy holidays!
>
> To you too, cheers!
>

I have to work at least two months before the vacation. :(

Liang
