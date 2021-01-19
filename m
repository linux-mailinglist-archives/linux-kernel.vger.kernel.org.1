Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0A72FBF33
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 19:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731578AbhASSdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 13:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387906AbhASS3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 13:29:16 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D8EC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 10:28:26 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id v5so14405172qtv.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 10:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ke7qD8F84c1d4EOseUsfShNOeUs7V6JI/1ybkVdZuas=;
        b=XmQ0R0kZqyfx6kYtmKEuaQdnV3pA/Gk5AOzBRpiTYl4tlHVj1r8AGgHQ4HlCBrkqJq
         d3htfUs3a6Vo7BoCaKhfTS/pKV/wBzzmfP1qsXIQg8CQxxbNzgZLm/tv7iPsO1sHRvpU
         TCZW7i1jjllBwoa546R0ibB0zkSMqcrkOGwMgnllWMEUgURDH4T3uEK++bfZv7/+4pbj
         kS8q1ESLc1z39UecPfNCeUXmJIGhwHZBA/TwP+5YpJBnaym8fbHoGkHnHv5RdAWXulup
         dtDZh1pKug65yM1CA0ASf5OqBnSDmxdk7ota2wSPE6R9R/dxgH45I+bA7mqqlvFaweeD
         jp4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ke7qD8F84c1d4EOseUsfShNOeUs7V6JI/1ybkVdZuas=;
        b=PRE/BHRnefNT3WGkFG/i54RsTGgfekI+ODZSCkXvTmHOQ0gawCw7PjiJ5itSQ8y1ic
         PJqFOQc3in7uqdvxBbEcZxaBIn9qANSsdovmSm512p/GFH0FmXA62pocc96ltD8jS2B+
         nvCezEH4h+1KDnJ5ZpjeG/oAB55wj6uVhF0rsqKgdgazcIAdjPPr2Tm8Ww2BbQN2P2S9
         9GyQ2zBBgNWJfWRLeDWyv9BRF+8qHj8fJbg9ZQKw/RqDZiGZqHKv49gzBt81g0hmqVuj
         l0/UFJxI5R873fx0B9Vxd4kwXDXQ+hJhw/1kZX+/42QG4KObACLNM76BMSy6HIB86p/x
         nmAQ==
X-Gm-Message-State: AOAM532Lgrtg1GiJJLr22yMqRzz9RSLzyHNUAiNYMov/sTq+tqU4IzxM
        ZcJqQhjpkcQiEHvRNjT99pNh8g==
X-Google-Smtp-Source: ABdhPJzA1g7p43l6AtNResDMMVS5o5wIwQMrXjddyfwRGWf3w+KrQJOMwx++nssqWWJKy8HjuEBVXA==
X-Received: by 2002:ac8:2adb:: with SMTP id c27mr2484368qta.145.1611080906055;
        Tue, 19 Jan 2021 10:28:26 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id u5sm13640579qka.86.2021.01.19.10.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 10:28:25 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1l1vjt-003pdK-4n; Tue, 19 Jan 2021 14:28:25 -0400
Date:   Tue, 19 Jan 2021 14:28:25 -0400
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
Subject: Re: [PATCH v5 03/14] mm/gup: return an error on migration failure
Message-ID: <20210119182825.GA4605@ziepe.ca>
References: <20210119043920.155044-1-pasha.tatashin@soleen.com>
 <20210119043920.155044-4-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119043920.155044-4-pasha.tatashin@soleen.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 11:39:09PM -0500, Pavel Tatashin wrote:
> When migration failure occurs, we still pin pages, which means
> that we may pin CMA movable pages which should never be the case.
> 
> Instead return an error without pinning pages when migration failure
> happens.
> 
> No need to retry migrating, because migrate_pages() already retries
> 10 times.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
>  mm/gup.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
