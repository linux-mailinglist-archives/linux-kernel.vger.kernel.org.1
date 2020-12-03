Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 427D82CDF18
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 20:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbgLCTgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 14:36:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbgLCTgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 14:36:50 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2747BC061A4E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 11:36:10 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id d9so3241620qke.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 11:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RqhxuUAWxbYZSw8sYvp2fumpu+s+7MnPGjbntXrF3WA=;
        b=RCQTki4Xd/Qb3GhbSR3sRvVmqBu3csotRQTOzEzSjm0eAbpCbHLcAb0W4Grb18P0fK
         sgbmvGrtwfFysooQrR98bzsGP5sWlv6PrlWpqaj9i9LMkj8Z3lU1nxVPM30XzuMiVSd3
         3bw8WWEKYrpFSDZ3B6lTSSAeACAp5g/Pdj8ge6CM3D5f1gDCOk7EuzjwMG46vw+QWpXe
         W+IfQJ/glGKWr6U7ldsLd+TJP4UTgslRJHxv43mW2J4ap9brurs73Gr+bTNpD5ZzoOWP
         qS540QDpKslxcBKsVx9uq1R0L/0IX8NsXrniI08BKPSqkwue/Or5PXrOPZfVyYlZspkb
         HUkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RqhxuUAWxbYZSw8sYvp2fumpu+s+7MnPGjbntXrF3WA=;
        b=Azwq8LoumxsYLx/dnrrIKph9KEpE6TPpH5yHtMc/Sf7fo/n7BtkOzzMjC/+p9CZIY7
         0KuG7szyy3dokNnRTbib9opjOSR9WbAnNMUTwtX+NwlOWHAXhArMgkqKNCFXFPxI4PE9
         lNOdkSF4PbzbQoobEYd0EjUU6U+Y+GjQ2Bn4kK2Gsb8r+EfWwpnxuh7TPJ/deQ1mWH73
         FMyEl3hVwwd9YUKYqG3mDIJTY8EWeMoD0nv0cG8VbYrAkRSvChiwkNuZXk360K6U2FVM
         ta6XrNzITIHFbXW/p9QX1zTmi/srbVFS6xhapMxDz/0rST20ienKsQh3XBYi3OdeuefH
         k8PA==
X-Gm-Message-State: AOAM533ZFhy2xRnzyBT3/AJncarWKcbkOxWpSx3jpOO6d57I/x+G0hzz
        6ZtV6x8BVAMZPy1/wX6DsupAwQ==
X-Google-Smtp-Source: ABdhPJzTw30UYowxVAv1La2ggQqZSxEIvOi/C1vjSqqYMtGmE+HeZjSfg3f2X2E1jyKyjfUJvbmdEw==
X-Received: by 2002:a37:9205:: with SMTP id u5mr4740419qkd.345.1607024169296;
        Thu, 03 Dec 2020 11:36:09 -0800 (PST)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id u72sm2616337qka.15.2020.12.03.11.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 11:36:08 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kkuOd-005bGF-BE; Thu, 03 Dec 2020 15:36:07 -0400
Date:   Thu, 3 Dec 2020 15:36:07 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
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
Subject: Re: [PATCH 6/6] mm/gup: migrate pinned pages out of movable zone
Message-ID: <20201203193607.GV5487@ziepe.ca>
References: <20201202052330.474592-7-pasha.tatashin@soleen.com>
 <20201202163507.GL5487@ziepe.ca>
 <CA+CK2bBT=U+xhbzXTDFwsL5wTvPHgNJ0DRpaeseiUq=w4EOe9w@mail.gmail.com>
 <20201203010809.GQ5487@ziepe.ca>
 <CA+CK2bBRgcCc5Nm0RcsEgVFpGBFC-_icA6UDRiqQxeRJE5U-Aw@mail.gmail.com>
 <20201203141729.GS5487@ziepe.ca>
 <CA+CK2bA=Ahd4E=ebdJ7uwxPyQ1AEy_hxA+Tx+yAi92JcZsQsfA@mail.gmail.com>
 <20201203165937.GU5487@ziepe.ca>
 <CA+CK2bBRqK6_ZOkTbz8qe4Gz6T5pwt-KjJQ0+NzYOC1qO1sPMg@mail.gmail.com>
 <CA+CK2bAErUyg26UNKQJwaZ7wsv4+qv4Ws58Vdmv+QZfLDyrkeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bAErUyg26UNKQJwaZ7wsv4+qv4Ws58Vdmv+QZfLDyrkeQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03, 2020 at 02:15:36PM -0500, Pavel Tatashin wrote:

> I studied some more, and I think this is not a race:
> list_add_tail(&head->lru, &cma_page_list) is called only when
> isolate_lru_page(head) succeeds.
> isolate_lru_page(head) succeeds only when PageLRU(head) is true.
> However, in this function we also clear LRU flag before returning
> success.
> This means, that if we race with another thread, the other thread
> won't get to unprotected list_add_tail(&head->lru, &cma_page_list)
> until head is is back on LRU list.

Oh interesting, I totally didn't see how that LRU stuff is
working. So.. this creates a ridiculously expensive spin lock? Not
broken, but yikes :|

Jason
