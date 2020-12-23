Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6282E1DC9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 16:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbgLWPMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 10:12:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgLWPMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 10:12:13 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD29C061794
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 07:11:32 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id o17so40863957lfg.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 07:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=egw/xLacmMD2e5f/vTJE3VtQ/EXWGuBWWN+BXr+Sh0k=;
        b=N2E8GJRqhSTPKnuAjN8SBP/d6LsyNb+QVP3ubBEHmLKnHoHszm1ziwTh4FVJ5uGZMH
         O5QYdARFclQJ5DY9DKbHo8Tt9HhJpnnKWXf6kanYzdeXM1cGf0xKn/5uBnoRqEbpKaz4
         h+DkMk/BkuRvrKxYjnukcZVyUqOJgwidlqx+Zwbbvwp0rNFu53YKWdZDbzjcXcUMOPSq
         WHtL0v2N/FpXSAjCFOr+XpzkKSh3iGGZ/UwSziBM6HZIK1Lozv+JM+msX4SPcwVZIsDz
         HQp1a3Px81H9Gu72xrHGXj/Ji+TspU3qa/WL3TKbew/TnjEPyFEcK3dbaKdHOOQ0xeLG
         T4hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=egw/xLacmMD2e5f/vTJE3VtQ/EXWGuBWWN+BXr+Sh0k=;
        b=VZHHeg0vZ/OgE21r3pR+8aogOeUEbj/IODoTnVgYzdk2wevGb4I09oPCoAfron47C3
         HNlzt4D/IpAwC+BeKz9O1Yr2fdVqTl3+s4U96OiUAkJzVM2maGspBdZ1QuAHMU90W2Cn
         6hjOwUaQ4M+AaOKJyHlGnPk6uUMOKy+LtrUtVvuwGBee2YOE5U7c1O3Akl4Ux84W6R3W
         xipPRJu7L2516qkUjJw0cWUPJSFIkQ1WfaBFRVC0b8XqAZlvXtHCZruQ6N8Kk77baLZ1
         6pWlNHSHXpXvQtSD0InYxBbFXL3BEOp7zMI7HQiMBdD5w9LX4FSVohC3JrvY6uA39Z3e
         dnAw==
X-Gm-Message-State: AOAM532XCBFrf7qk+2ktah77TYQWz8p0R3+PLg9if7rNjnP18goWOcdJ
        +9FOU0m2zDOBmxjOIN7nSXvVSY2BhPqbUI+X7Jy5mw==
X-Google-Smtp-Source: ABdhPJwR5CYgLfIjGQWp8Hkg+C6401rdK+2U3UYtjausgns/0Q+26AokHwtlZUkC/U4DcAuM9/TLGSFpYc+lVAeKgHg=
X-Received: by 2002:ac2:46d4:: with SMTP id p20mr10513632lfo.299.1608736291077;
 Wed, 23 Dec 2020 07:11:31 -0800 (PST)
MIME-Version: 1.0
References: <20201215115448.25633-1-sjpark@amazon.com> <20201215115448.25633-5-sjpark@amazon.com>
In-Reply-To: <20201215115448.25633-5-sjpark@amazon.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 23 Dec 2020 07:11:19 -0800
Message-ID: <CALvZod5Z2RCNymCDV7GTSdrKS=3FzK+HSMrKWb4Qo_nVh7sdwQ@mail.gmail.com>
Subject: Re: [PATCH v23 04/15] mm/idle_page_tracking: Make PG_idle reusable
To:     SeongJae Park <sjpark@amazon.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@huawei.com,
        Andrea Arcangeli <aarcange@redhat.com>, acme@kernel.org,
        alexander.shishkin@linux.intel.com, amit@kernel.org,
        benh@kernel.crashing.org, brendan.d.gregg@gmail.com,
        Brendan Higgins <brendanhiggins@google.com>,
        Qian Cai <cai@lca.pw>,
        Colin Ian King <colin.king@canonical.com>,
        Jonathan Corbet <corbet@lwn.net>,
        David Hildenbrand <david@redhat.com>, dwmw@amazon.com,
        Marco Elver <elver@google.com>, "Du, Fan" <fan.du@intel.com>,
        foersleo@amazon.de, Greg Thelen <gthelen@google.com>,
        Ian Rogers <irogers@google.com>, jolsa@redhat.com,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Mark Rutland <mark.rutland@arm.com>,
        Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, namhyung@kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mike Rapoport <rppt@kernel.org>, sblbir@amazon.com,
        Shuah Khan <shuah@kernel.org>, sj38.park@gmail.com,
        snu@amazon.de, Vlastimil Babka <vbabka@suse.cz>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Huang Ying <ying.huang@intel.com>, zgf574564920@gmail.com,
        linux-damon@amazon.com, Linux MM <linux-mm@kvack.org>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 3:57 AM SeongJae Park <sjpark@amazon.com> wrote:
>
> From: SeongJae Park <sjpark@amazon.de>
>
> PG_idle and PG_young allow the two PTE Accessed bit users, Idle Page
> Tracking and the reclaim logic concurrently work while don't interfere
> each other.  That is, when they need to clear the Accessed bit, they set
> PG_young to represent the previous state of the bit, respectively.  And
> when they need to read the bit, if the bit is cleared, they further read
> the PG_young to know whether the other has cleared the bit meanwhile or
> not.
>
> We could add another page flag and extend the mechanism to use the flag
> if we need to add another concurrent PTE Accessed bit user subsystem.
> However, the space is limited.  Meanwhile, if the new subsystem is
> mutually exclusive with IDLE_PAGE_TRACKING or interfering with it is not
> a real problem, it would be ok to simply reuse the PG_idle flag.
> However, it's impossible because the flags are dependent on
> IDLE_PAGE_TRACKING.
>
> To allow such reuse of the flags, this commit separates the PG_young and
> PG_idle flag logic from IDLE_PAGE_TRACKING and introduces new kernel
> config, 'PAGE_IDLE_FLAG'.  Hence, a new subsystem would be able to reuse
> PG_idle without depending on IDLE_PAGE_TRACKING.
>
> In the next commit, DAMON's reference implementation of the virtual
> memory address space monitoring primitives will use it.
>
> Signed-off-by: SeongJae Park <sjpark@amazon.de>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
