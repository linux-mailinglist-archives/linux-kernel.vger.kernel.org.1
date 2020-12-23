Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D97AC2E2299
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 23:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbgLWW5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 17:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727141AbgLWW5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 17:57:03 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B987EC061794
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 14:56:22 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id s26so951291lfc.8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 14:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DhR9g6GISx+3RIJSrNoTktJAD8JqDRQmJMtw4uaGJsY=;
        b=wRdmlgV8vdm/6G9QgvJneWx8kAFhz2u+kJWZjg5Ut6glF0olLdK7qL+Tu3mDgLpqVI
         3VZejIMoM4rNmLWxdsG0Tbtv6UrvsUaS0z6L+gZ9I8wW+xD1W0q6X+xza/WewluIRA/y
         RseS1q2rkxaZmgL+mMUDrB+HkiYwbq6n85vTXBc4KNSP1U519L10WxI8n8zv+bJygb8O
         z98YGG39NFtconBm6oX63ItClE/OcsTrIT79+bwjjEuEWoitHNJbvRgf134QOqWpFlLP
         mwkBbGBR1eZj0PYt2EJT1KTl9o2Dd9ou32u2Tr8VyFiJbsjYB9Z58N1e34WzA3SbqtSV
         CH7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DhR9g6GISx+3RIJSrNoTktJAD8JqDRQmJMtw4uaGJsY=;
        b=B+l2ylezQlXCA76uX4nqVO6CVjs8HXdrm9Ing0nhhN+bC9CqOdRrfcfIyYr41clqO5
         cRPrdKFv3drQuM/1IRtWpmQrdQaMCitUlz+3YYGCSIlzmYsRwrzqG+K5S3xxw8lSEFau
         jlkXY2/+yAzrhHDF/s2i1NbiK+iXx74lQIXbFjSSkUWZutv9kqjePu745Z4Kb5RADGT3
         qg+egjq0Rzr86xkMikg1SHH7+ib82GkmzuT57Bv4voD/XWfuxkW6wEtVaN1zQ1o7PmWa
         nE4psQji/HGN/FZoDtprQrDz+C71ADOhnbkjuInX01Rk/fQyukEK6w8ljALJmgFfbag4
         sOJQ==
X-Gm-Message-State: AOAM530M0VEcuMZEpYc0tNDpoYZnwKKVRklmxjJjQ4+wsNFzud4HEFoW
        EBtovjg1VtrN0BvF/18U6+I7XxvS5OFnV3jN/fyAuA==
X-Google-Smtp-Source: ABdhPJxv1e3/W5GCN0xsKQTeeBsZi/Yh4mkxtO4TeDf6EejDKtjr0Gvi+BshysmBZUN39882t7NWdwHy7c2TwPMebgY=
X-Received: by 2002:a2e:9605:: with SMTP id v5mr12220313ljh.81.1608764181058;
 Wed, 23 Dec 2020 14:56:21 -0800 (PST)
MIME-Version: 1.0
References: <20201215115448.25633-12-sjpark@amazon.com> <20201223183721.8898-1-sjpark@amazon.com>
In-Reply-To: <20201223183721.8898-1-sjpark@amazon.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 23 Dec 2020 14:56:10 -0800
Message-ID: <CALvZod5dxOJMNP3HhwYc0ePN+0V8YXruXDtQQRuy+eKsJTYhcw@mail.gmail.com>
Subject: Re: [PATCH v23 11/15] tools: Introduce a minimal user-space tool for DAMON
To:     SeongJae Park <sjpark@amazon.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan.Cameron@huawei.com,
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

On Wed, Dec 23, 2020 at 10:38 AM SeongJae Park <sjpark@amazon.com> wrote:
>
[snip]
>
> I will drop this patch from the next version of this patchset, because this is
> not the essential part but could only make the code review time consuming.  I
> will post another DAMON RFC patchset for convenient user space usages including
> this and the perf integration.

You can just add the link to your github repo with commit/tag
containing the usage examples in the cover letter.
