Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A84BD2977C2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 21:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754013AbgJWT3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 15:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753879AbgJWT3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 15:29:03 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D7BC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 12:29:03 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id 1so1473794ple.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 12:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:content-id;
        bh=Ht9BKFglKWwx9V8O4cpGYaHYegYy2q/TklC9j3VH7e8=;
        b=Kn6H6LbRvoW9Kgkcb1FkKc38czFd5R+J+DU4pE4S5dGQNA4IOqXIQXTvdcNCP/FwsC
         l4Xw4gq8q5kblhUggqxXTUn64mPVeHRrv1IK5UViv6egZjYtvekap5202lcVf+D0uuK8
         V6IYZk4Yr/janF70nxfZBtAD2B3WWh7plzKnAfXoRi2L+NCQWbraQ0HIxCVAKvfdfMm+
         Us6hhNgy6pG4czD+ocLsNYJTaZ/qgXcRz7IJ4HO3wmEG6zDwblDVlL3arCQuCeoiMjfm
         lz+AZmUC+s4VHWI9SFp1ntB9V1MYSSLU5LQwgPtnLtp34QhlR9r6kyuyzrYILTpC91/D
         f7Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-id;
        bh=Ht9BKFglKWwx9V8O4cpGYaHYegYy2q/TklC9j3VH7e8=;
        b=rgdcBtdrQgTUYXlTv00M1vpybYquqUpd/q/WennRvoRm6gVIxnHSq8KyqzzGf1TAGQ
         unal9wKUdS6dNpxyeV1P3DlqThkTpDdLKyWMEnBPVqua68TnUmlgxvTn9iwxybO+Z+tM
         mwdcd9p1p5SAbVBJKVHmtJJlQghRQSUdqnyuCaM/4GUxiJ7A7UELXgSUKT+cVFs+RlUe
         dO3G9dY3z+Xaq6B6dYdmWHcyZZIvqchVxAz+oTIKtg0oCjPpYjvZeyqoC8MF3CynRECO
         hCY6pmTV6za3z8ipQ8owb6A6b1HxodwoIAisy3+BhyZDeyn+5cHpPEiAM4oYC7BCkFef
         mjyA==
X-Gm-Message-State: AOAM531Xz0C4hCHLkM28Xuc4jZp0YgXCvWpf8RXoY5nxWk4bDIKTMh7E
        0VHhgyG2E12sCsSnoht/WdbOqg==
X-Google-Smtp-Source: ABdhPJwFgHM8eOx1L7iJqpP/Z0i76NT224Lmtie2/hw/XpQvqykmtkrXRbEI4J1ZERve6YFtpvOX7Q==
X-Received: by 2002:a17:902:6545:b029:d3:d1fc:ff28 with SMTP id d5-20020a1709026545b02900d3d1fcff28mr437096pln.34.1603481342465;
        Fri, 23 Oct 2020 12:29:02 -0700 (PDT)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id j11sm2789689pfh.143.2020.10.23.12.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 12:29:01 -0700 (PDT)
Date:   Fri, 23 Oct 2020 12:29:00 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     kernel test robot <rong.a.chen@intel.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Kevin Ko <kevko@google.com>
cc:     David Hildenbrand <david@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@kernel.org>,
        Scott Cheloha <cheloha@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com
Subject: Re: [mm/page_alloc] 7fef431be9: vm-scalability.throughput 87.8%
 improvement
In-Reply-To: <20201021092417.GP11647@shao2-debian>
Message-ID: <alpine.DEB.2.23.453.2010231226310.1686635@chino.kir.corp.google.com>
References: <20201021092417.GP11647@shao2-debian>
User-Agent: Alpine 2.23 (DEB 453 2020-06-18)
MIME-Version: 1.0
Content-Type: text/plain; CHARSET=US-ASCII
Content-ID: <alpine.DEB.2.23.453.2010231227371.1686635@chino.kir.corp.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Oct 2020, kernel test robot wrote:

> Greeting,
> 
> FYI, we noticed a 87.8% improvement of vm-scalability.throughput due to commit:
> 
> 
> commit: 7fef431be9c9ac255838a9578331567b9dba4477 ("mm/page_alloc: place pages to tail in __free_pages_core()")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> 
> in testcase: vm-scalability
> on test machine: 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory
> with following parameters:
> 
> 	runtime: 300s
> 	size: 512G
> 	test: anon-wx-rand-mt
> 	cpufreq_governor: performance
> 	ucode: 0x5002f01
> 
> test-description: The motivation behind this suite is to exercise functions and regions of the mm/ of the Linux kernel which are of interest to us.
> test-url: https://git.kernel.org/cgit/linux/kernel/git/wfg/vm-scalability.git/
> 

I'm curious why we are not able to reproduce this improvement on Skylake 
and actually see a slight performance degradation, at least for 
300s_128G_truncate_throughput.

Axel Rasmussen <axelrasmussen@google.com> can provide more details on our 
results.
