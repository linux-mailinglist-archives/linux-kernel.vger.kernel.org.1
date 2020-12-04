Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99CBC2CF3AB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 19:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbgLDSLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 13:11:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbgLDSLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 13:11:23 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E82C0613D1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 10:10:42 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id a16so10009004ejj.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 10:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7TbFtICM9MnAP10o9hujRLIgAYJwsDBNhsbYS5a5Dto=;
        b=SX1y7EcHXJayxKB8wtz/I8F9ALqJlaLjkODLmZJcstDxiZmULC5nPLi9CQSh9J+d1s
         Ub4CCvLajGP8zKEzRIFEDx+9badI+tboymw1jJLi/0zFO511ABr2TD/mKEGoSm6gpZST
         HgwsLdK10Rn26FMa6ma74KmX5TLQn+kc4PecOAtajNx7M8qtV512thjDI6NvD/Iuro3K
         b6fDTClObrh4LdUWHhFRlbF12ULvTZWEGWBY+sCJ8j+v4QTPPvZylwOJ6P65jfmI2Rrk
         NWSCE8jfmwVgt1Te99bn6n+tWhzCITNbEeQpX6rLPnEN0/JmBQ5INlXGZOTwMSTtcgSO
         KKFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7TbFtICM9MnAP10o9hujRLIgAYJwsDBNhsbYS5a5Dto=;
        b=ZToUTXpqL6twK9L/ohWIYRHeChYIu6Ph2mQN/5RmHVHlVrknXa/LX7o5+Z/c6FbZJU
         6aG4VvPkL9VORiSxzEIkifb2Kj5KuR8+1rLiD+8pTuKEgcfBkaWf7FQtOFCzTsxXxAII
         9DJs2eYLqkfKkfbFxd1Hnzuxnd0oArL8jVgQ8EEbdaIXiR2SflOe7r3/8nM8rcS4VI3W
         rp7KXAhqyOpBGAUvU8CVCoUwC+gTp1SkJdRBoFzpyIb8SYRH2webrA1H+ouA1iZIkE5D
         N2ZjaM9qg3FJVEHn6rcvkok+rUXi/AUAzqxPb7xzIESbVqOuQkCUePIedj0apz+DL84z
         YNdg==
X-Gm-Message-State: AOAM532BnBiiasmjAuW+C3onZsvPD6V0Nm+vKjyu6XeiVpOHFEpYEc5c
        XKS/+n4MwM0nRiKSgORrVAndVuzzjEb6Gx91e63EGg==
X-Google-Smtp-Source: ABdhPJwyUfWpho6yeil7W1EbhJnZVgB2REj45sCW4XZOBjgooF8hN9QNnxzvInK3hs8HyzZtXisHnOWp+/7+p9LG8y0=
X-Received: by 2002:a17:906:d41:: with SMTP id r1mr8080974ejh.383.1607105441362;
 Fri, 04 Dec 2020 10:10:41 -0800 (PST)
MIME-Version: 1.0
References: <20201202052330.474592-1-pasha.tatashin@soleen.com>
 <20201204035953.GA17056@js1304-desktop> <CA+CK2bCD7XYyJB9TNZZeUMAuntotZopVYNjDXnyVZyzKe2_A1Q@mail.gmail.com>
 <20201204161005.GD5487@ziepe.ca> <CA+CK2bCGGoBXg7FbhGMDdWRnePKFgvtsM_PJmA2qtMNsvPMZbg@mail.gmail.com>
 <593822e5-4e1a-fdca-5500-4138d0f2b728@redhat.com>
In-Reply-To: <593822e5-4e1a-fdca-5500-4138d0f2b728@redhat.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 4 Dec 2020 13:10:05 -0500
Message-ID: <CA+CK2bA8GBWNMGR_5urNJm7KtX6Jo=bwjPgQvVXe9Q-RW-6Y8g@mail.gmail.com>
Subject: Re: [PATCH 0/6] prohibit pinning pages in ZONE_MOVABLE
To:     David Hildenbrand <david@redhat.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Joonsoo Kim <js1304@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        mike.kravetz@oracle.com, Steven Rostedt <rostedt@goodmis.org>,
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

> > ZONE_MOVABLE can be configured via kernel parameter, or when memory
> > nodes are onlined after hot-add; so this is something that admins
> > configure. ZONE_MOVABLE is designed to gurantee memory hot-plug
> > functionality, and not availability of THP, however, I did not know
> > about the use case where some admins might configure ZONE_MOVABLE to
> > increase availability of THP because pages are always migratable in
> > them. The thing is, if we fragment ZONE_MOVABLE by pinning pages in
> > it, the availability of THP also suffers.  We can migrate pages in
> > ZONE_NORMAL, just not guaranteed, so we can create THP in ZONE_NORMAL
> > as well, which is the usual case.
>
> Right, we should document this at some place to make admins aware of
> this. Something like
>
> "Techniques that rely on long-term pinnings of memory (especially, RDMA
> and vfio) are fundamentally problematic with ZONE_MOVABLE and,
> therefore, memory hotunplug. Pinned pages cannot reside on ZONE_MOVABLE,
> to guarantee that memory can still get hotunplugged - be aware that
> pinning can fail even if there is plenty of free memory in ZONE_MOVABLE.
> In addition, using ZONE_MOVABLE might make page pinning more expensive,
> because pages have to be migrated off that zone first."

Thanks, I will add this.

>
> BTW, you might also want to update the comment for ZONE_MOVABLE in
> include/linux/mmzone.h at the end of this series, removing the special
> case of pinned pages (1.) and maybe adding what happens when trying to
> pin pages on ZONE_MOVABLE.

Will do it.

Thank you,
Pasha
