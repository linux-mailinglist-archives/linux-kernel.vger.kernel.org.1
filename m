Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9B1E2CF35F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 18:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbgLDRwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 12:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgLDRwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 12:52:13 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8E7C0613D1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 09:51:33 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id a16so9925594ejj.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 09:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=31hFFArVFLayAbe984Eq857Ijkymag2EX547dIYCVVI=;
        b=BrJgrP7Vo3LsmjP4/uK2WLmNtvnlKQyJEgcHA5V4T3luCMqNP3fshfXe3HuzodHt6N
         JSLH3JnZlJTHfVDwCtHwD2/CTz2RYeTVdOrgd2tziEliPzMWNRwdbC+1cYlekpPqoDCP
         Im+3pT9EMLVmgyto13Vn0baiJoH2KNA9WJHLqX+0JKEkZNiVhHVuyFjkhVCyeio42C6V
         1mIpkLUflzsJLCB/dzLd1YjC9x4tYWkJejs/98rtk762W2VNuIvdWnwZh2qZbNGF6khU
         ASF4BNQnqx/5CYt4fw5dzqAKRDmqMpkNDMBFs9ZvXvqHELGFEyjqBJxY2cp4a6VIhqGj
         g7WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=31hFFArVFLayAbe984Eq857Ijkymag2EX547dIYCVVI=;
        b=XemS3x9UUz9idsNbUGnd45UwnBQLnZ8p+68UowW9NTPXHxOCoR1okQANWfHNtw5U/S
         eLZFZMQKHO60hnDn7HKsba9HZA1IoNdNhEsW2MK0dn+QMwjXo4eamK+Zz7VgiZNmNbtl
         fUMYZ/5TsH3TjXYbgo2Mrv9k9Ikt45gl7h2eiwmVa6Lh51UJYQMHXiDwo2tt6Xl6JoXB
         WZrjLmfDFH+XaxIv25GL2bzVYPPqfREa0ZWVOTxZoUVA0gMys/cqFWeS9HUFnTb5kNz1
         R6HUVKlf4RfOCIA4Ofunm3mVzIHL6Y/hNM6ZJXx3ZpyzqjdC68Qitqi+1rY81282BHNj
         SJnQ==
X-Gm-Message-State: AOAM533gPK9BJrSVA9psAY+tESpty/CQjvgL5TBcNdc+tU02UsLBbaKJ
        l70OC4HKnRxMhFCiCoyozcEGA/hDwlcRlQHOepCOzg==
X-Google-Smtp-Source: ABdhPJzQ5DmWTJPAXFIAqFmYUlq/WxtfwZmY+wOrx2ijrmExTi6caux3QODt6HEXqCy/qW7swrllDjZ5kKs2VzYYJBM=
X-Received: by 2002:a17:906:fb9b:: with SMTP id lr27mr8443175ejb.175.1607104291943;
 Fri, 04 Dec 2020 09:51:31 -0800 (PST)
MIME-Version: 1.0
References: <20201202052330.474592-1-pasha.tatashin@soleen.com>
 <20201204035953.GA17056@js1304-desktop> <CA+CK2bCD7XYyJB9TNZZeUMAuntotZopVYNjDXnyVZyzKe2_A1Q@mail.gmail.com>
 <20201204161005.GD5487@ziepe.ca>
In-Reply-To: <20201204161005.GD5487@ziepe.ca>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 4 Dec 2020 12:50:56 -0500
Message-ID: <CA+CK2bCGGoBXg7FbhGMDdWRnePKFgvtsM_PJmA2qtMNsvPMZbg@mail.gmail.com>
Subject: Re: [PATCH 0/6] prohibit pinning pages in ZONE_MOVABLE
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Joonsoo Kim <js1304@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
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

> > Yes, this indeed could be a problem for some configurations. I will
> > add your comment to the commit log of one of the patches.
>
> It sounds like there is some inherent tension here, breaking THP's
> when doing pin_user_pages() is a really nasty thing to do. DMA
> benefits greatly from THP.
>
> I know nothing about ZONE_MOVABLE, is this auto-setup or an admin
> option? If the result of this patch is standard systems can no longer
> pin > 80% of their memory I have some regression concerns..

ZONE_MOVABLE can be configured via kernel parameter, or when memory
nodes are onlined after hot-add; so this is something that admins
configure. ZONE_MOVABLE is designed to gurantee memory hot-plug
functionality, and not availability of THP, however, I did not know
about the use case where some admins might configure ZONE_MOVABLE to
increase availability of THP because pages are always migratable in
them. The thing is, if we fragment ZONE_MOVABLE by pinning pages in
it, the availability of THP also suffers.  We can migrate pages in
ZONE_NORMAL, just not guaranteed, so we can create THP in ZONE_NORMAL
as well, which is the usual case.
