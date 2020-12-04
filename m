Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB3DB2CE6DA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 05:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbgLDEDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 23:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbgLDEDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 23:03:53 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF38C061A4F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 20:03:07 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id q3so2742426pgr.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 20:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7DSsMY7O9iqF1kwVjLuD2Y4xlHlq3Q1GYWL81Z4udlU=;
        b=Ill+Sh/d5qdK475EE+dKWx9gpK+E5fU5RzwnC82K6d7BmIGRdKNIqlwyvRmoDBxa5u
         g+YnvuqUTUEHcyJ3ydhc9E+p6+X06vjsGQQOav7zR1e+KPwytoMrneDRsYWBfauxnrMf
         I8wjSYAvgVgCsMrm6opvOV/hhurCGHjN4dmwKWyzhX47SIDjOae4DviuHqjEnemSNjmq
         YvzQz5J/nS9SS4iLgaz6d7xuk74fOv0cIakUM3fC3rHbCNT9YveV4kR0O1lMS8DVHCDU
         QXcVCmClKWGWWIQy4kYkPWZfOTWnXcszTKevrsIq42+pI4oYiMD0CpAmBV+lOZ70gqKC
         T/4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7DSsMY7O9iqF1kwVjLuD2Y4xlHlq3Q1GYWL81Z4udlU=;
        b=r3fDNC+745W4JY8Yfl/xQ1HRm4TF6OzIB3npJx3b0NuRwAZIxzTuT8L/1ZpfiHh5vz
         sw8uf+2HEju2e8onPqJYr9nfHirYsTdgebCiMKVY8v3hZN/u62WriS9Zi2EkPwBpR7pY
         NSP9ZmCJ59MxuWT901NjmGOP7UrPGQPFiCDgz3FlClxxS4cDU6mREw26U7+nbS9nUM3P
         sFHe5WS8KiHtuiWlus3cLNB6IXdZHQnYyuyTPs4OlPjz/UR9l4Q0uWUZo3m8J5w3I/hC
         +tEJ3Y6KOBGdg2/XO+B12G6+tluWkiCcmphDB9uBkAsfr8zrMW2waTM65tbM1YFnN3M6
         kE3A==
X-Gm-Message-State: AOAM533LvGCNiju3OnySA86WVp2PjU1wOojHgseYvUucigAp7V6y3blU
        N2pEG00tjUGa+CRyzMz4FGA=
X-Google-Smtp-Source: ABdhPJwvgZz8ZoalwA2Ooqk1m9C80RXGOy3Lbb5UQ++hStPSxSVQGys9Ky9d9HHZJyUGDZajWnRipw==
X-Received: by 2002:a65:4c87:: with SMTP id m7mr5844727pgt.75.1607054586944;
        Thu, 03 Dec 2020 20:03:06 -0800 (PST)
Received: from js1304-desktop ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id w11sm3205211pfj.212.2020.12.03.20.03.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Dec 2020 20:03:06 -0800 (PST)
Date:   Fri, 4 Dec 2020 13:02:56 +0900
From:   Joonsoo Kim <js1304@gmail.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, vbabka@suse.cz, mhocko@suse.com,
        david@redhat.com, osalvador@suse.de, dan.j.williams@intel.com,
        sashal@kernel.org, tyhicks@linux.microsoft.com,
        mike.kravetz@oracle.com, rostedt@goodmis.org, mingo@redhat.com,
        jgg@ziepe.ca, peterz@infradead.org, mgorman@suse.de,
        willy@infradead.org, rientjes@google.com, jhubbard@nvidia.com
Subject: Re: [PATCH 0/6] prohibit pinning pages in ZONE_MOVABLE
Message-ID: <20201204035953.GA17056@js1304-desktop>
References: <20201202052330.474592-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202052330.474592-1-pasha.tatashin@soleen.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Dec 02, 2020 at 12:23:24AM -0500, Pavel Tatashin wrote:
> When page is pinned it cannot be moved and its physical address stays
> the same until pages is unpinned.
> 
> This is useful functionality to allows userland to implementation DMA
> access. For example, it is used by vfio in vfio_pin_pages().
> 
> However, this functionality breaks memory hotplug/hotremove assumptions
> that pages in ZONE_MOVABLE can always be migrated.
> 
> This patch series fixes this issue by forcing new allocations during
> page pinning to omit ZONE_MOVABLE, and also to migrate any existing
> pages from ZONE_MOVABLE during pinning.

I love what this patchset does, but, at least, it's better to consider
the side-effect of this patchset and inform it in somewhere. IIUC,
ZONE_MOVABLE exists for two purposes.

1) increasing availability of THP
2) memory hot-unplug

Potential issue would come from the case 1). They uses ZONE_MOVABLE
for THP availability and hard guarantee for migration isn't required
until now. So, there would be a system with following congifuration.

- memory layout: ZONE_NORMAL-512MB, ZONE_MOVABLE-512MB
- memory usage: unmovable-256MB, movable pinned-256MB, movable
  unpinned-512MB

With this patchset, movable pinned should be placed in ZONE_NORMAL so
512MB is required for ZONE_NORMAL. ZONE_NORMAL would be exhausted and
system performance would be highly afftect according to memory usage
pattern.

I'm not sure whether such configuration exists or not, but, at least,
it's better to write down this risk on commit message or something
else.

Thanks.
