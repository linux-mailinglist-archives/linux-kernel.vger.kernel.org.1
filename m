Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 667972CD9C7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 16:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387586AbgLCPEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 10:04:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730964AbgLCPEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 10:04:10 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79885C061A4F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 07:03:30 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id ck29so2407323edb.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 07:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mqqo1C9O1FnmAwdYyWyvBGdYpTtzbOV8ODrOB0yXk+g=;
        b=T605GlGikJYfi2YqiZmwbK2WpsY3HdBMZfeaQJg+lovObgcTo54N3k2bkU7r33MnaC
         AdH7GvX+1H4z7ZYaAQM42cwjF3fEazeBJNQNBWMZ7tD+/8KLqEtTbgLL4LtLm0OTDWQL
         ke7flAiybZd0X7S4ST60oM518q/fnDUQfC3mkkp9vUKiYyn9XNOoLf+zdISo2TvZiFRr
         RoLOAeSrIc9oUYti3k52SPiRNKZ4jAl/nEy0hzJ0byT7uf9KGHD3n2t4UOuOBU3pF+f9
         f6BbTX+zHSKIQ97gd1LOYYWHdfRq6Sc+UkJsxdGLtxcuxXkQ1poTGI3kiKmzAfgwVp0E
         JsGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mqqo1C9O1FnmAwdYyWyvBGdYpTtzbOV8ODrOB0yXk+g=;
        b=ELaWZjw5VTvGahxdpF4wVFG48rC2w+JiihG5PZbp5q04KO6aDd2qMAw/aB75QlMCsv
         c6qREfZu767NihhIZzsTTj9f2xJvf+Sa2L89eja9Arr0N193MOPrBy7Rtm0o53JKJGGm
         DUxNYEnPB7k/AUUcRdknkNHqRU4R0NQUau6xelnp3jCfAHihHClA2+4JLFUJ0IWc7zbc
         WL9MTmhwtQk1c+sqPD5hG4yFiQ43IbRuxBhoAfk66vuGRcS9AnawZJrojU/GrnE8vF0h
         p25ou4aK/GiydH9thfkO5PYDzMMlNkMDkrzx99bdu+HGoJ2iz9oHeyOW08Bc7k2iQs9O
         Rszg==
X-Gm-Message-State: AOAM531+KgFGzZGSyGsOh8n2YFMX9frr2+sD1NpYJmLUw1h3SNo33FN5
        WvZlg4m+8xQSJ7t2sIBl6Ygfab9oTQIP+5N1z3tlkA==
X-Google-Smtp-Source: ABdhPJyQ9SlnOVRhN/HFSQ+LkcqoLecHfU8fncS0IDVqz+1Awrp3gzM7YwztAGht8eNoZplZYHjBPRCW4pRvSHl1Jvc=
X-Received: by 2002:aa7:d54b:: with SMTP id u11mr3174994edr.341.1607007809237;
 Thu, 03 Dec 2020 07:03:29 -0800 (PST)
MIME-Version: 1.0
References: <20201202052330.474592-1-pasha.tatashin@soleen.com>
 <20201202052330.474592-4-pasha.tatashin@soleen.com> <ad473039-d5be-c0a5-3f68-dd87b0dd77ec@nvidia.com>
In-Reply-To: <ad473039-d5be-c0a5-3f68-dd87b0dd77ec@nvidia.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 3 Dec 2020 10:02:53 -0500
Message-ID: <CA+CK2bCah4igdEHj3ORfgoSW+X6EYDpO6StBgh76JVxYtN6sow@mail.gmail.com>
Subject: Re: [PATCH 3/6] mm/gup: make __gup_longterm_locked common
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, mike.kravetz@oracle.com,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Reviewed-by: John Hubbard <jhubbard@nvidia.com>

Thank you,
Pasha
