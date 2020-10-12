Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0742A28C416
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 23:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729993AbgJLVa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 17:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbgJLVa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 17:30:29 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380B2C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 14:30:29 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id v19so18595127edx.9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 14:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WhdARHn7ekpE/B6g7hvohtBN+vrCDHD817Ns5WlYqDg=;
        b=rY2+TsxLiz6pvvr3ngQb0t80ciUoaEE7i0zO5vITri28qzFvp84GEw9YRpxStpMl2d
         2cQg5nTQGQZuC1pGc7H5QlQypme3ga5nM3do23Wme/98JRQc70wopxGq97eSVh4n+w2v
         MlfznvOSBWoLy9KaSipAnSA2oARr5EK/YuAfDkGXmL7pqyA3iAk05Qc1bA+ZY0Bi49Qh
         FrMUn7KYEI2mrN6zRgZc2qQgaJn8GUwAKF4t6Q2KRUEwAxyDabCRYCoVhqKY/uV8mrT4
         +Lrd9Q3j84rDBpzy03XiKNjdHheE12NV/QAz88eMRtAtBVGrUWfjhtEywNbROhLKbAer
         b9MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WhdARHn7ekpE/B6g7hvohtBN+vrCDHD817Ns5WlYqDg=;
        b=IJLanjuTwAHN5Iyf1SUcbUkQJPEZRVpufIPt6unyjngjVheCIvgBDAMEdvgTmjoV2g
         e0RRWFPkP/6o33jCRIPMYq/wxYydES/6vMjoHjR5n5CCXw2ci5T5tVIXGYS54sOXXqC6
         hTCIq6nvwt9ageHoB1WD+epcWmuSBpOZP9Xk0WNQ9vsPFqPGFFk9LV98WAFaAQwHAWKV
         OwpT2atLCL9XAZybAAPS0tcL7AnEPz2RSH6bRjs11/PDArXBxuMSfAd9qELbKE1nHO7s
         u+FQJSM/sJVKlrP8XzT5eOUVi06Sm3F1/8U3uXjoKCRNkCisSnUfLxHyujT0lWCGwGQE
         qPkg==
X-Gm-Message-State: AOAM531j7EpVe//lAKpPLTIKYv79reiVcAzYh4jJ+fwuX6MujSo8wDDB
        2oMlBBeKnM10h0IaYuscZFfC0hV7kouvHp/p5twFMuRlhDU=
X-Google-Smtp-Source: ABdhPJyjrxrzuiVrLGd/YJ9A+ajKo3jWKJciHFwu0QPQQGx0yC4bCQqAaTr9TSIfPZCggVwtVjiLQ76wJTtu9dVjy40=
X-Received: by 2002:a50:c05b:: with SMTP id u27mr16114957edd.290.1602538227750;
 Mon, 12 Oct 2020 14:30:27 -0700 (PDT)
MIME-Version: 1.0
References: <20201007161736.ACC6E387@viggo.jf.intel.com>
In-Reply-To: <20201007161736.ACC6E387@viggo.jf.intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 12 Oct 2020 14:30:16 -0700
Message-ID: <CAHbLzkrAmZzxNiZgHsCv0ug1q9cwNZ6aF=01MZs+h0whTfgxBg@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/9] [v4][RESEND] Migrate Pages in lieu of discard
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 7, 2020 at 9:17 AM Dave Hansen <dave.hansen@linux.intel.com> wrote:
>
>
> Changes since (automigrate-20200818):
>  * Fall back to normal reclaim when demotion fails
>
> The full series is also available here:
>
>         https://github.com/hansendc/linux/tree/automigrate-20201007
>
> I really just want folks to look at:
>
>         [RFC][PATCH 5/9] mm/migrate: demote pages during reclaim
>
> I've reworked that so that it can both use the high-level migration
> API, and fall back to normal reclaim if migration fails.  I think
> that gives us the best of both worlds.

Thanks for doing this. Although I was inclined to think the kswapds on
PMEM nodes could make enough space for retrying migration later
instead of doing swap right away, this approach might be
over-engineering and over-killing. The simple immediate "retry regular
reclaim" approach also looks fine to me for the time being. We always
could optimize it later with more test results backed by real life
workloads.

>
> I'm posting the series in case folks want to run the whole thing.
>
> --
>
> We're starting to see systems with more and more kinds of memory such
> as Intel's implementation of persistent memory.
>
> Let's say you have a system with some DRAM and some persistent memory.
> Today, once DRAM fills up, reclaim will start and some of the DRAM
> contents will be thrown out.  Allocations will, at some point, start
> falling over to the slower persistent memory.
>
> That has two nasty properties.  First, the newer allocations can end
> up in the slower persistent memory.  Second, reclaimed data in DRAM
> are just discarded even if there are gobs of space in persistent
> memory that could be used.
>
> This set implements a solution to these problems.  At the end of the
> reclaim process in shrink_page_list() just before the last page
> refcount is dropped, the page is migrated to persistent memory instead
> of being dropped.
>
> While I've talked about a DRAM/PMEM pairing, this approach would
> function in any environment where memory tiers exist.
>
> This is not perfect.  It "strands" pages in slower memory and never
> brings them back to fast DRAM.  Other things need to be built to
> promote hot pages back to DRAM.
>
> This is also all based on an upstream mechanism that allows
> persistent memory to be onlined and used as if it were volatile:
>
>         http://lkml.kernel.org/r/20190124231441.37A4A305@viggo.jf.intel.com
>
> == Open Issues ==
>
>  * For cpusets and memory policies that restrict allocations
>    to PMEM, is it OK to demote to PMEM?  Do we need a cgroup-
>    level API to opt-in or opt-out of these migrations?
>
> --
>
> Changes since (https://lwn.net/Articles/824830/):
>  * Use higher-level migrate_pages() API approach from Yang Shi's
>    earlier patches.
>  * made sure to actually check node_reclaim_mode's new bit
>  * disabled migration entirely before introducing RECLAIM_MIGRATE
>  * Replace GFP_NOWAIT with explicit __GFP_KSWAPD_RECLAIM and
>    comment why we want that.
>  * Comment on effects of that keep multiple source nodes from
>    sharing target nodes
>
> Cc: Yang Shi <yang.shi@linux.alibaba.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: David Hildenbrand <david@redhat.com>
>
