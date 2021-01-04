Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1222E8F2B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 02:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbhADBZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 20:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbhADBZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 20:25:00 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5353C061574
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jan 2021 17:24:19 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id g3so13585962plp.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jan 2021 17:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ReCyuB6iT6jEYrceFC7R53dNfUpjsZRHDJqV6HxAgxg=;
        b=QFupxU8pLGaGgSleLM/HvnYu/truly/dP2d8owcgD6JNHlG90yHOaC6VGAqZ9uBvgT
         coW3EWJtGLDs8ERGbtiWavXbxPR5jSWpYCPjMarlavq5RiOXx+cPhlylltZqqV/wNs9Z
         2HZdCNfOrj0VUZLV59OR8SZFEjkB+zQPYVCr7pp2ltBOApWxiSjW0cB2FzkQqLX3cXAO
         CqwF/j2NPHHhJ2fMMfodf64jlUPtujMkhjt0YObGipgMC9HedvlvL1zlqx9PhjVCAT3y
         w6yjRcISTaNwXjxG/RI/4sTh2DhIBCgB+HaNAO+kpOKlf+kjvMaGgmEKf5z130CX9VXZ
         GaOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ReCyuB6iT6jEYrceFC7R53dNfUpjsZRHDJqV6HxAgxg=;
        b=ck+sgW/y5qJtWH7D/SyCbtbPF5dapRc1aDJXnwZsnqI6rv9He1kYaToFKIj0UAT2oX
         n5VN8YoKrSSpRxDVe+ZBRmse4XaxoaNPxChH+UOmf6Cgf6qI+YY6nwVSG+KXqTaOU9yJ
         wKhys4CagJ/+GtXU3JCdi58foINP2gBCia2p+V2GNANN9QeFNB0MxDkL//YqEZt1npT3
         xh0yQPOa6IVhcZV+HD1q2yGxbrn+FOmaE/FTx0sL0A0ORFUUsdNpltx+C6BRYA8T7hGi
         ue4grD+aeG2TII0/X8i40nK+8n3/FjAlFFH5pI89rJ3LxxDfe635HHFmcwV4oO6NkazH
         sXKA==
X-Gm-Message-State: AOAM533ETVb5+vWt0SnQUS4pL8vyfV2bJQ7SOnlZwiE5MSB8IZY3jbWB
        uPUYIme4SRZyx4kNWDRuI1IW8I1TCOsYAw==
X-Google-Smtp-Source: ABdhPJyAQg451uM4KB2/JZAHzGWxSCbqFO7QyDWp1DEKwRwQfM4P28BEkyaMMH9xJxj19wfgdnDs9Q==
X-Received: by 2002:a17:902:7d88:b029:db:7aa4:864c with SMTP id a8-20020a1709027d88b02900db7aa4864cmr47955011plm.34.1609723458988;
        Sun, 03 Jan 2021 17:24:18 -0800 (PST)
Received: from js1304-desktop ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id o14sm55101680pgr.44.2021.01.03.17.24.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Jan 2021 17:24:18 -0800 (PST)
Date:   Mon, 4 Jan 2021 10:24:10 +0900
From:   Joonsoo Kim <js1304@gmail.com>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com
Subject: Re: [mm/swap]  aae466b005:  vm-scalability.throughput -2.7%
 regression
Message-ID: <20210104012356.GA5941@js1304-desktop>
References: <20201230062412.GD22185@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201230062412.GD22185@xsang-OptiPlex-9020>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 30, 2020 at 02:24:12PM +0800, kernel test robot wrote:
> 
> Greeting,
> 
> FYI, we noticed a -2.7% regression of vm-scalability.throughput due to commit:
> 
> 
> commit: aae466b0052e1888edd1d7f473d4310d64936196 ("mm/swap: implement workingset detection for anonymous LRU")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

Hello,

Thanks for reporting.

This is a known issue to me. As you can see below, slight regression
is found on only the random access workload. For pure random pattern,
detecting workingset would not guarantee a good result since these
pages doesn't accessed in the near future. Even worse, it causes small
overhead to the system since we need to demote these activated page to
the inactive list to reclaim. So, below result is natural to me.

For other access pattern, this patchset would result in positive
effect.

Thanks.

