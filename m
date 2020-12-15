Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7BDD2DB29D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 18:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730679AbgLOR3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 12:29:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730557AbgLOR3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 12:29:45 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62239C0617A7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 09:29:05 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id q16so21874029edv.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 09:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VeOwIZnD1d1CtAtOQLOWOLhM2A2wCecJ+qK1dyLboTU=;
        b=I96T4pSs/iDVCNO7aKjW2AuZwWdxEU4n91uXkED0FYIBHx0CVqEOOvQXv4kyHisS+A
         gnUtMYosW3bZnF2XVpR+v4DZTcvdLJC3svqRUoIJYTCHB5iE37EAGzkWAWhYaQpy3/Sv
         m96dzGoXG6KSM79QFPjc6zvwIu6CJA7IXqKG0ZnS0D/3pUm8IbEWu46Zs+kc1ktqd4Bw
         gbaxJoc/+fwc7jzPPY1ZRrYpVboVgiSrJ2HG0KqeEI6jSQhXxYxow+OQSOeJVd3wBwza
         h1uBgBabe/R5P5ARfZ9aOAcrr7JWNJOcSYdiOSlzuB7XwH7wZjoKzJKfbwV7tYH66HKG
         uVcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VeOwIZnD1d1CtAtOQLOWOLhM2A2wCecJ+qK1dyLboTU=;
        b=BOgkRwnBnPFGLQuxt3sz2z68s4l9hoqWaQYS7fxmuhXx/YDPg1VB4jpIfIItYBa/3f
         EwohoVleIQvuUrH4BsiEgauZyfXgeLBpXd0XTn7fmZSAFmBYBZlWcnB18pu3OqL4Gy6K
         kR9UAdY0x6r+2zrUSwOL5ufLLzJWLzVoJOCZW8sqWZMNkNMeyg14Nqfzg90ACxxeSTBM
         XjL2FLhEHtwwHMwM50DmJDL6i0BSxdGi6u1BvC+3IJNnPlutKSxzqkwCvFK+PgLnrkqV
         XzpsUCXlfbwJd3mx26JWXVLOJw5t9bgeKRFtnJFrIp9Lb5913l4/Ml9xLNfCk11rN7O4
         NpLw==
X-Gm-Message-State: AOAM530CrKbGv2STHz5kwJO21jWAT4V1GrY7YjcVesruB3Bf7kwosM9R
        7RddZm13mXwO0qMyDLIYvZiwzxdQ4uDFcJjji6wfuA==
X-Google-Smtp-Source: ABdhPJwO7x4LC0rkTRzmFQ3G3z7COZCV+iAl/I4ipG0U3kkQDJA750UT3AF9UiLPI5TShsk8sR9viFmJkSFFwZNTOsM=
X-Received: by 2002:a50:f404:: with SMTP id r4mr3451244edm.62.1608053343982;
 Tue, 15 Dec 2020 09:29:03 -0800 (PST)
MIME-Version: 1.0
References: <20201211202140.396852-1-pasha.tatashin@soleen.com>
 <20201211202140.396852-5-pasha.tatashin@soleen.com> <20201214141715.GF32193@dhcp22.suse.cz>
 <CA+CK2bCWkPDw-Aif6iXHq15Dpa+50hmrcAk_LpMCMk30zY5aFw@mail.gmail.com> <20201215082748.GL32193@dhcp22.suse.cz>
In-Reply-To: <20201215082748.GL32193@dhcp22.suse.cz>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Tue, 15 Dec 2020 12:28:28 -0500
Message-ID: <CA+CK2bA3B=Awh2BK=jwZX39PTeQ9=O5tD0ohNCyL_Lf3LQwfog@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] mm: honor PF_MEMALLOC_PIN for all movable pages
To:     Michal Hocko <mhocko@suse.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
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
        David Rientjes <rientjes@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Fair enough. I still dislike cma being called out explicitly because
> that is slightly misleading as well. gpf_to_alloc_flags would be more
> explicit I believe. But I do not want to bikeshed this to death.

Sounds good, I renamed it to gpf_to_alloc_flags.

Thank you,
Pasha
