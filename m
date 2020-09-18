Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE4726EDA0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 04:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729763AbgIRCWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 22:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729758AbgIRCWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 22:22:13 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6D7C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 19:22:12 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id x69so4405281lff.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 19:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GynuqWulEknA1mhH4YKRCUIobXlFSbNtaQspNwu0ec0=;
        b=uMYgYh/dUJdxdRcwRpxO1AaKxWiTwBzbh/6dW1UGJSX5hv33pC+Jvqanqy/v7BdRnP
         sc+GB14Mnd4DKmYE8Vh5bLwmrovIzzrmcJyGIA2xb5idzHOtndXhr55+lD5CMYy31QYD
         GTcdj6PI8uKTGOea0XIkWNIKs4IaXmB8KPXTA0W+pahzSq0+4OGzblnsyYyYFzTPaPyC
         Zeu4XXk3u7eaiOfWYlIIN8fG9DUnDIrlEnmXuX4/CB+dqBGP0PrkkKgREO0rqyccjtJ4
         jfr0qI8O9xN9K4qwhw1Gwevpb/AS6SM+TP1vg0d7cnHCHxUnTzhCVWFKpe7SZCXwy+Yc
         C/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GynuqWulEknA1mhH4YKRCUIobXlFSbNtaQspNwu0ec0=;
        b=qxHp4+BvqNTzyAFRcvK4rsEKNyA8xDyIqicb4F5lFkHFB97U6Tg/PsjP95dMaCaYzE
         LveMQxG61AU+gN4KsbKHgvjy+K82rjWOKYXaBAZQuDHw6fC2GGtaAUaWlrCN+X9woeA2
         IzoUqNQ02q+48kCR3Ijt+hc11Gx6D6jnijnL3uX3Qyw079/fi/L5Lv26QqelyzyO3WtC
         Boo5hxvzsKIWl/fnX58kWMWbLMad4hnhPxN7XuPkE7KcQKIWjcsvrF4Z9MAvGjXF9GD6
         owADHi82izkZckSlliSApTjHQdlh5qQ9I6TheRrWqTzwvs6mjt0XRl5GTl2KOeCPPrVW
         O4Dg==
X-Gm-Message-State: AOAM530KIdDUkcicZJLWnGRG4MIhsrJaaIOBMJOk3hSL3CEOgJmVnbQN
        Yk8cX1PlHajd/NxNWGeROYMZ4xwzNulC8Nn2OyM=
X-Google-Smtp-Source: ABdhPJzzsoisBX5gG95zQ4+sPuPNYYUINOGswWmlgW4Xq82pforaCqH62nyCrTo+Tm2Uddnr31Mfvyiazj+XGk+kD/s=
X-Received: by 2002:a19:c002:: with SMTP id q2mr2062446lff.372.1600395731311;
 Thu, 17 Sep 2020 19:22:11 -0700 (PDT)
MIME-Version: 1.0
References: <1600227737-20785-1-git-send-email-jrdr.linux@gmail.com>
 <20200916100232.GF18329@kadam> <20200917123951.GP18329@kadam>
 <20200917173424.GB2540965@iweiny-DESK2.sc.intel.com> <42c317bc-6212-caef-687e-84e8f009d8b5@nvidia.com>
In-Reply-To: <42c317bc-6212-caef-687e-84e8f009d8b5@nvidia.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Fri, 18 Sep 2020 07:51:59 +0530
Message-ID: <CAFqt6zYT83JrkdnYx03+KbRzZ1wMcV0mNOUNmmtWg7hdr-B+1g@mail.gmail.com>
Subject: Re: [linux-next PATCH] rapidio: Fix error handling path
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        mporter@kernel.crashing.org, alex.bou9@gmail.com,
        Andrew Morton <akpm@linux-foundation.org>,
        gustavoars@kernel.org, madhuparnabhowmik10@gmail.com,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 11:17 PM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 9/17/20 10:34 AM, Ira Weiny wrote:
> > On Thu, Sep 17, 2020 at 03:39:51PM +0300, Dan Carpenter wrote:
> >> On Wed, Sep 16, 2020 at 01:02:32PM +0300, Dan Carpenter wrote:
> >>> On Wed, Sep 16, 2020 at 09:12:17AM +0530, Souptick Joarder wrote:
> >>>> There is an error when pin_user_pages_fast() returns -ERRNO and
> >>>> inside error handling path driver end up calling unpin_user_pages()
> >>>> with -ERRNO which is not correct.
> >>>>
> >>>> This patch will fix the problem.
> >>>
> >>> There are a few ways we could prevent bug in the future.
> >>>
> >>> 1) This could have been caught with existing static analysis tools
> >>>     which warn about when a value is set but not used.
> >>>
> >>> 2) I've created a Smatch check which warngs about:
> >>>
> >>>     drivers/rapidio/devices/rio_mport_cdev.c:955 rio_dma_transfer() warn: unpinning negative pages 'nr_pages'
> >>>
> >>>     I'll test it out tonight and see how well it works.  I don't
> >>>     immediately see any other bugs allthough Smatch doesn't like the code
> >>>     in siw_umem_release().  It uses "min_t(int" which suggests that
> >>>     negative pages are okay.
> >>>
> >>>        int to_free = min_t(int, PAGES_PER_CHUNK, num_pages);
> >>>
> >>
> >> I only found one bug but I'm going to add unpin_user_pages_dirty_lock()
> >> to the mix a retest.  There were a few other false positives.  In
> >> reviewing the code, I noticed that orangefs_bufmap_map() is also buggy.
> >>
> >> I sort of feel like returning partial successes is not working.  We
> >> could easily make a wrapper which either pins everything or it returns
> >> an error code.
>
> Yes we could. And I have the same feeling about this API. It's generated a
> remarkable amount of bug fixes, several of which ended up being partial or
> wrong in themselves. And mostly this is due to the complicated tristate
> return code: instead of 0 or -ERRNO, it also can return "N pages that is
> less than what you requested", and there are no standard helpers in the kernel
> to make that easier to deal with

There was some discussion on removing return value 0 from one of the
gup variants [1].
I think it might be partially relevant to the current discussion.

[1] https://patchwork.kernel.org/patch/11529795/

>
> >
> > I guess the question is are there drivers which will keep working (or limp
> > along?) on partial pins?  A quick search of a driver I thought did this does
> > not apparently any more...  So it sounds good to me from 30,000 feet!  :-D
>
> It sounds good to me too--and from just a *few hundred feet* (having touched most
> of the call sites at some point)! haha :)
>
> I think the wrapper should be short-term, though, just until all the callers
> are converted to the simpler API. Then change the core gup/pup calls to the simpler
> API. There are more than enough gup/pup API entry points as it is, that's for sure.
>
>
> thanks,
> --
> John Hubbard
> NVIDIA
