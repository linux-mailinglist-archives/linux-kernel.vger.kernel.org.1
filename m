Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8042C42E2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 16:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730240AbgKYPaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 10:30:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730112AbgKYPaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 10:30:04 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4B2C061A4F
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 07:29:54 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id t6so3641645lfl.13
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 07:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xQqMteze+xCEHenPxthBOcsc/0tSfwlYlu1DqoC4HPs=;
        b=HDVu0SypUkrIgHq8Lxae6Be+CHBAkJmeBVmQ+herklMZWndUiYC8kMvy8Q6IAlaiGL
         UtYPndNlAzpDW/qVIl/oySemQRx0RhBQSdpniMuQ9w6UZWBwH8qCpY+VcXlj+2IMMBUV
         Ij/YRDh+SLKR/PeJ3IcLiRriCfMXSZeYulfuwycCVrjDIFvqoC96hG1To++cN69AfztD
         CYR+CklbRvZXkxHMGASiN0d/X96QnSMupdlDimuo3r4Vs52Pn5CUrgrpDSacBnFgmtmc
         Kkjk+rP/0VLT178E31JGhUaAg58LQlz5I7xBYGuHr8EsqKJsldnoK8Wv6Yz96ro1GmpC
         Song==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xQqMteze+xCEHenPxthBOcsc/0tSfwlYlu1DqoC4HPs=;
        b=TJB57l3HRbMQdTnkOxw4Y/h2waoywAJrnXrd2jPkiLZsH9Rm6Pyifgo4fMo7mYq5zd
         tDRQLKdHAiQHCVJFHB5N570EaAi8Y557CPbovXY0NivBJNZxYaL9WxAwBdt/wBw3Dmu1
         fyjnWpCV5YhmtAknpvzJPeQnqwlAHIzWbvCI2FlBvPv/8xKzDwSvBKjy5UCaE9EBAbUF
         PA4iSRoTE3+E40MNVUUfDmLDVl2PvvYYlRsDI2+8fVYfFvbXoMxjiYP1b6cABWL9HqPN
         f+kR4AkDhLS03eG70cv4ndMKElBRuQ+XZEB4uynV7U0HGwAITDi3rqT4xc+TLjNRUhxY
         aU3g==
X-Gm-Message-State: AOAM533tvZkWv14qyGb/aMQrqiGRuK+Z7BpBgJZ3P97d/meTY0Rh5Ujv
        VYPgz2d7DrPZ2krm1aomXsepP9cczHuQfeNvoXwbzA==
X-Google-Smtp-Source: ABdhPJx85SPYIbloEx1FWJOrMCYVt4KwN1kTSlFJCN8071jaUDxsqRIq/NSp0TvyLXUzcHPWGeF46kjbfQryo9a5bFM=
X-Received: by 2002:a19:be4a:: with SMTP id o71mr1491208lff.494.1606318192153;
 Wed, 25 Nov 2020 07:29:52 -0800 (PST)
MIME-Version: 1.0
References: <20201020085940.13875-1-sjpark@amazon.com> <20201020085940.13875-4-sjpark@amazon.com>
In-Reply-To: <20201020085940.13875-4-sjpark@amazon.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 25 Nov 2020 07:29:41 -0800
Message-ID: <CALvZod6nhJyOh943+EqttG+33ugrkNYxpLM3Gq7U7TFw70dOAA@mail.gmail.com>
Subject: Re: [PATCH v22 03/18] mm/damon: Adaptively adjust regions
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

On Tue, Oct 20, 2020 at 2:01 AM SeongJae Park <sjpark@amazon.com> wrote:
>
> From: SeongJae Park <sjpark@amazon.de>
>
> Even somehow the initial monitoring target regions are well constructed
> to fulfill the assumption (pages in same region have similar access
> frequencies), the data access pattern can be dynamically changed.  This
> will result in low monitoring quality.  To keep the assumption as much
> as possible, DAMON adaptively merges and splits each region based on
> their access frequency.
>
> For each ``aggregation interval``, it compares the access frequencies of
> adjacent regions and merges those if the frequency difference is small.
> Then, after it reports and clears the aggregated access frequency of
> each region, it splits each region into two or three regions if the
> total number of regions will not exceed the user-specified maximum
> number of regions after the split.
>
> In this way, DAMON provides its best-effort quality and minimal overhead
> while keeping the upper-bound overhead that users set.
>
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> Reviewed-by: Leonard Foerster <foersleo@amazon.de>

The high level comment I have is that kdamond_[merge|split]_regions
should be part of the abstraction of the target instead of the damon
context.
