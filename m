Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3372CF1DA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 17:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbgLDQ0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 11:26:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727639AbgLDQ0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 11:26:13 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884DDC0613D1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 08:25:33 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id lt17so9536454ejb.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 08:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RcTmsxVbOJXkWM5Hd5SB+R3sckednkoKgaMSdIRGnRE=;
        b=BcNTUMTtlQkxrPmb8zwbLGhYkGaL1vhWr2vSKVnV5wLvzJwwaI1BabmFIU88VcHUXP
         M6t4GH6Nr1FMOhQIMKR2x8CTrozIO4CbJ1z2EX3szggx4QAxb4NYfdm6woogfEitJ8kb
         M8vxO/HdApAQk7WajLexNjGmNkTeNiYGh1dee2+5Cjs5GA4Ecdtb1Ul06fa63h/MyE1g
         nq+zwU8QfUFUpTOYUw900hLOx6aURLnXhuceee2TZHEk3rXFEquI5n7WL7qo58pdvIFd
         NOADsGKMx0moo034Two+05D1x2sEL0SdZgQhlVJ/Jl6FR3qBUZQnmk25q/ub5YICUhfv
         jJBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RcTmsxVbOJXkWM5Hd5SB+R3sckednkoKgaMSdIRGnRE=;
        b=oM0TITRLcb0B+eTz3m+OqytqFBxxRUZK1d30Eu36tvWICILj5Ojtc2IAKuwsMKAJVk
         UJLdudQlrJLClW2OBAFkcFa/ozNaxPYr5mGNjF6RcVtTH8CPo29y1Hy2jbgZK8LGQh6F
         PxIFrE7N7LeT8GrbfXnQSTomVww5afeY8jS8VJLvC5EPCyOsaCTndE/pvvWhC5060R7M
         QDBjMhKb2iEaXmCnzZLH3P9kps/vsD4xYWVIPeCcDf4Ng24ayK0fiWfCIYNAOZGzWMP2
         SDcokF36myY6qA5hxu1shRnZn0WkZNP6omKwh8rds9W8iWSWlamE3RzxoFYavzboU9uz
         GD3g==
X-Gm-Message-State: AOAM530K5C/PRG0rI4Uc87h9n1c429dXkzPePevZHIQoZ3xwqWg51KHO
        5CZ1d+OW7RUe2Ecj1A9BD4S5so6wNsgcffhYuRcL+Q==
X-Google-Smtp-Source: ABdhPJyivwFLyiwC19rebyhYcjkL7E31HaDvHjPDfUxYj8m6f5YO1jMlPyOLhiC8FL25D7PTrVIZ5D53xiUskv/I7yA=
X-Received: by 2002:a17:906:fb9b:: with SMTP id lr27mr8076906ejb.175.1607099132312;
 Fri, 04 Dec 2020 08:25:32 -0800 (PST)
MIME-Version: 1.0
References: <20201202052330.474592-7-pasha.tatashin@soleen.com>
 <20201202163507.GL5487@ziepe.ca> <CA+CK2bBT=U+xhbzXTDFwsL5wTvPHgNJ0DRpaeseiUq=w4EOe9w@mail.gmail.com>
 <20201203010809.GQ5487@ziepe.ca> <CA+CK2bBRgcCc5Nm0RcsEgVFpGBFC-_icA6UDRiqQxeRJE5U-Aw@mail.gmail.com>
 <20201203141729.GS5487@ziepe.ca> <CA+CK2bA=Ahd4E=ebdJ7uwxPyQ1AEy_hxA+Tx+yAi92JcZsQsfA@mail.gmail.com>
 <20201203165937.GU5487@ziepe.ca> <CA+CK2bBRqK6_ZOkTbz8qe4Gz6T5pwt-KjJQ0+NzYOC1qO1sPMg@mail.gmail.com>
 <CA+CK2bAErUyg26UNKQJwaZ7wsv4+qv4Ws58Vdmv+QZfLDyrkeQ@mail.gmail.com> <20201203193607.GV5487@ziepe.ca>
In-Reply-To: <20201203193607.GV5487@ziepe.ca>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 4 Dec 2020 11:24:56 -0500
Message-ID: <CA+CK2bA18wXtETPpz4eeX02oagg1fyW=yNuN4UZVpBW0V4A1CQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] mm/gup: migrate pinned pages out of movable zone
To:     Jason Gunthorpe <jgg@ziepe.ca>
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
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 3, 2020 at 2:36 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Thu, Dec 03, 2020 at 02:15:36PM -0500, Pavel Tatashin wrote:
>
> > I studied some more, and I think this is not a race:
> > list_add_tail(&head->lru, &cma_page_list) is called only when
> > isolate_lru_page(head) succeeds.
> > isolate_lru_page(head) succeeds only when PageLRU(head) is true.
> > However, in this function we also clear LRU flag before returning
> > success.
> > This means, that if we race with another thread, the other thread
> > won't get to unprotected list_add_tail(&head->lru, &cma_page_list)
> > until head is is back on LRU list.
>
> Oh interesting, I totally didn't see how that LRU stuff is
> working. So.. this creates a ridiculously expensive spin lock? Not
> broken, but yikes :|

Not really a spin lock, the second thread won't be able to isolate
this page, and will skip migration of this page.

>
> Jason
