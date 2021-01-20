Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC332FD1D7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 14:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389975AbhATNbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 08:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731723AbhATNXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 08:23:06 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FD9C061757
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 05:22:25 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id 22so25234028qkf.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 05:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TxOJ2i1obQZTYWUjOO4AH/QKsmg0DUJ9EGaechEIo20=;
        b=IvzX1RMAtfsiwGFzzn5FfORQgcXPhllACg7D+ANj7TlWPd5qMsoyPmKGn1XhVA8NwM
         tafb4+W9ckHIwIC2JBfwYCAPgXVbUIzt+6pL2UDYN50uqUst7fkRN9pWNY9xSsstQzUA
         bb1vo+9Prb3OaiUP7mgZO7sGWE3g0yX548ApY/8loBpncFwLJA4OaUHs+Xei5i/ul45A
         Poyg8uDGFCtY7vtgdHVF74Rvl9Rq59pDg4A1B9F/2weKRBdIUNb8ORuYNQnaTBdjr5Y+
         abTearQ0KBLILW07vILaeT4ncQ5ARwtQ3rEQoueKnAru9qTf91hl1CGFQlLXQ2yJXPYo
         ZxbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TxOJ2i1obQZTYWUjOO4AH/QKsmg0DUJ9EGaechEIo20=;
        b=udU9nnzhUoR2Lz0Cmy4SnZJvpUigFMp/iYNb+qKKYBnP7fLDU8qor5Z042ld0qdU42
         iRFR3z2wvL0u7BqczM6PcgcJraoa8RJNNLoxU79/ioj7kfF4UeW+B24ysg0K7iwGRn9N
         2Dd5gN47vygov5XFZdD/E8HqQ6evixnMKcYMdAdPySAldPOV8nCK/oEt1gVptHUa4EHc
         jsFOh7gQejhfGMpo3ZsLu/cddIou24ZQODm8uBtZammbF4ljUDdcg3fiQmwE6m8wSuNU
         XNmZWhVZ1d8Sebdn/wQHey9ypyXuhV6+CFhMwWcRtmegRxZSlFICgGIQBBz93lnxFCEw
         Jv2Q==
X-Gm-Message-State: AOAM530JiumUL6vI7ak3MWQHNQpGOjL6d7maoHGmRQ+bqwX0+sMUk2/4
        XASfXKjy2Cy6xQ1lHJjth0I6IQ==
X-Google-Smtp-Source: ABdhPJxVh5jUl4y5I89LvXDP0n+KjibmY3MDSvd+QOMJtVbYZtAlkbEyk4UcJVKl2qWGnRtxmq5muA==
X-Received: by 2002:a05:620a:125c:: with SMTP id a28mr9451371qkl.112.1611148945095;
        Wed, 20 Jan 2021 05:22:25 -0800 (PST)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id r190sm1313094qka.54.2021.01.20.05.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 05:22:24 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1l2DRH-004Tyo-Ee; Wed, 20 Jan 2021 09:22:23 -0400
Date:   Wed, 20 Jan 2021 09:22:23 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, vbabka@suse.cz, mhocko@suse.com,
        david@redhat.com, osalvador@suse.de, dan.j.williams@intel.com,
        sashal@kernel.org, tyhicks@linux.microsoft.com,
        iamjoonsoo.kim@lge.com, mike.kravetz@oracle.com,
        rostedt@goodmis.org, mingo@redhat.com, peterz@infradead.org,
        mgorman@suse.de, willy@infradead.org, rientjes@google.com,
        jhubbard@nvidia.com, linux-doc@vger.kernel.org,
        ira.weiny@intel.com, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 10/14] memory-hotplug.rst: add a note about
 ZONE_MOVABLE and page pinning
Message-ID: <20210120132223.GH4605@ziepe.ca>
References: <20210120014333.222547-1-pasha.tatashin@soleen.com>
 <20210120014333.222547-11-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120014333.222547-11-pasha.tatashin@soleen.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 08:43:29PM -0500, Pavel Tatashin wrote:
> +.. note::
> +   Techniques that rely on long-term pinnings of memory (especially, RDMA and
> +   vfio) are fundamentally problematic with ZONE_MOVABLE and, therefore, memory
> +   hot remove. Pinned pages cannot reside on ZONE_MOVABLE, to guarantee that
> +   memory can still get hot removed - be aware that pinning can fail even if
> +   there is plenty of free memory in ZONE_MOVABLE. In addition, using
> +   ZONE_MOVABLE might make page pinning more expensive, because pages have to be
> +   migrated off that zone first.

Just to point out, if anyone is using RDMA/etc with hotplug memory,
this series is likekly going to be a major regression for those users.

Jason
