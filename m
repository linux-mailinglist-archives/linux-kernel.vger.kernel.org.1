Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 437CD2EC92A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 04:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbhAGDjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 22:39:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbhAGDi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 22:38:59 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE9AC0612F0
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 19:38:19 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id h205so11477697lfd.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 19:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GeCAMJy8inmpz/GCwmjQawIMiRibYQ20oruKL3WVOQU=;
        b=cw4Bdq5nTnPNot1yCo/h8oQHt+51YPGP1aPpZZT+CqfcRRErCBOTnNpjb1Uyd2kNIJ
         i5O7srvOz8xRlgmk0t9Zaw4onIgDHRhVL4RQ4sCI6+zUujatqNpjgwjZwbiusI2TtqXT
         TdvLmHJmu1EbJJbAX5k8Yx6fqAakKdUwuKVDNW/fSACelpCaNyBiAQBq0J8eNZ0SCjMQ
         S3mmDNKCOYieYGUus+TuSDCuTvNIZUBZD5/48DL0vjt9mTwQ8qUdi88nUOSZXLbs7LFw
         1n0HBF0nr3eknA2DCy0TGHQR6k3T9lSxBauX5cbs/3RHmBAYLdD9VndAN6j9W21qXY2i
         m7ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GeCAMJy8inmpz/GCwmjQawIMiRibYQ20oruKL3WVOQU=;
        b=beSQnVuqqcCK8DfYLLfBnP1dyNdjuromTmfRizQLXo55dH/MPEIQWREFlO82DVdT++
         b1TLqDDxlHfRdzSOIDjWhxPEIz09C+isXD2zbXuVFvxDRnGHTcMfCLcDVeOdEh+f7ksw
         +boCPYVKUS9FVu07e0Q1NvYIa+PQO3VCxGia8LJmDqDj9RcP1pZ7V1ukish89/fXUuzj
         2PU0Yjz7JXuyYMnm+10CATT1wgELFH+Yo4luxFxe2jI33viuE39pAgETV+taqsBYC93W
         k7NspLBykEKag2Vu7fn7hga4YUT6lcnh01jsxts3CIdtJE9RKC3FLndRXJphvvmCyyRO
         ZbQQ==
X-Gm-Message-State: AOAM530LX9jXvW+EbR2mgU2sjEFV7UIj0W3c3C72erZ1/YKw9Q4CmTw6
        Qxb4LGDmfdg+j2JAIfjsrYOdWQsCv4inhVlwevqdSWfR
X-Google-Smtp-Source: ABdhPJzWCNHzKk3QYDw/TyUEN+OiKbE6bgxe7SHbaTeKlZi5Ajw24jfR/9vttlDP13gJwdaMFsNj4Sm9oId7tlJ+HTw=
X-Received: by 2002:a05:651c:1068:: with SMTP id y8mr3115838ljm.76.1609990697757;
 Wed, 06 Jan 2021 19:38:17 -0800 (PST)
MIME-Version: 1.0
References: <20210106034918.GA1154@open-light-1.localdomain> <20210106160827.GO13207@dhcp22.suse.cz>
In-Reply-To: <20210106160827.GO13207@dhcp22.suse.cz>
From:   Liang Li <liliang324@gmail.com>
Date:   Thu, 7 Jan 2021 11:38:04 +0800
Message-ID: <CA+2MQi-pxRkaftawN=tMxDT7wWyXuS6ZjofcqK+2fwQ9LHvwfQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] hugetlb: add free page reporting support
To:     Michal Hocko <mhocko@suse.com>
Cc:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Liang Li <liliangleo@didiglobal.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 7, 2021 at 12:08 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Tue 05-01-21 22:49:21, Liang Li wrote:
> > hugetlb manages its page in hstate's free page list, not in buddy
> > system, this patch try to make it works for hugetlbfs. It canbe
> > used for memory overcommit in virtualization and hugetlb pre zero
> > out.
>
> David has layed down some more fundamental questions in the reply to the
> cover letter (btw. can you fix your scripts to send patches and make all
> the patches to be in reply to the cover letter please?). But I would

Do you mean attach the patches in the email for the cover letter ?

> like to point out that this changelog would need to change a lot as
> well. It doesn't explain really what, why and how. E.g. what would any
> guest gain by being able to report free huge pages? What would guarantee
> that the pool is replenished when there is a demand? Can this make the
> fault fail or it just takes more time to be satisfied? Why did you
> decide that the reporting infrastructure should be abused to do the
> zeroying? I do remember Alexander pushing back against that and so you
> should better have a very strong arguments to proceed that way.
>
> I am pretty sure there are more questions to come when more details are
> uncovered.
> --
> Michal Hocko
> SUSE Labs

I will try to add more detail about the aspect you referred to. Thanks!

Liang
