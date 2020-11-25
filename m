Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6352C4922
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 21:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730119AbgKYUen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 15:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730093AbgKYUen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 15:34:43 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22000C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 12:34:43 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id y10so3652558ljc.7
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 12:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PTSj273m5dfHVb/AgHhQ3VD6GzY1CwNYoQKrgTLxVPM=;
        b=eZs/hq/mrBtZxX+zN7fatgTYgzWy27jm2uvhung6pwbgO2U+q/OAqrKWMze5pe7dhp
         kEgY8rbwL1n8UkILZUdZmxQJGvNU1ZCtRemnm6FVvllW0W33bODVbrvviH7j3//2XSVn
         yCX/W96vtdRvkrGtS+ch0RmwSDSebovjhL7h07l0tMBZnIFgw/OnL5DTHHht44XPWfPQ
         8LvGEcCXn7hkvFSooqP7qdqxQLghWt+J6dwy7x3rwAfMvYsTP62zMMPDI7K8tB7VxYV2
         WRQCmzqHJupqRDH90eBZaI9rGNOJwSQYuigFA0IRTcVHZDUngO+ST9d5YljwrjPC58b0
         ksbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PTSj273m5dfHVb/AgHhQ3VD6GzY1CwNYoQKrgTLxVPM=;
        b=Sc9gaV1MS5W1/APpE151sNFBT/50ibxCsoCC7qVVRKqBoVQkiEiVCkOfOSIL8b+1Qz
         MPDoE1g7EfsiVs43UAs1hLMFRO/1M5iRDlGSW4Ep7SS9YK1A0u88CXcAiUvlXjeTbRGv
         lKSHYW1rjpvzmIMhau/hZXnxjPKKJlwfgNTe/kFO3nzqGXv2sgF2YJDmNlQjdouf0Vel
         DvgQdTOE6RtAccmZ/cyrqKWsv1WqwqqaRutzw8ZJKEC2Szbkf5KBHVnMqWjRkJSnVTnp
         MSXdLG/qdDtKwcomBQ1noXFFMBgXxMhGgYIUXuV9PtKUGyLZ8c/eealLJh1TaHSvBRad
         gVBg==
X-Gm-Message-State: AOAM530QgiEL4kPaEzuLNodAtrJ91DILd9Sbz6Rof/nERj1+kdrN7u+V
        lUCsLnjWOe86MvFwQz+nKYR9WscNwMZPCg==
X-Google-Smtp-Source: ABdhPJz+3qUQvl5yV1OtuKWUwzV/OcUmkCcF6YaD/kHyZpHnx394KXxN3tuPa2iSMgB+LCaMxVC3eQ==
X-Received: by 2002:a2e:9617:: with SMTP id v23mr2109450ljh.135.1606336481467;
        Wed, 25 Nov 2020 12:34:41 -0800 (PST)
Received: from pc636 (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id 133sm45527lfe.300.2020.11.25.12.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 12:34:40 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 25 Nov 2020 21:34:38 +0100
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        huang ying <huang.ying.caritas@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/2] mm/vmalloc: rework the drain logic
Message-ID: <20201125203438.GA7278@pc636>
References: <20201117130434.GA10769@pc636>
 <CAC=cRTN-JyZKyFkRgC0BrBjnu4mMTJ_hXBYszJ9HLXaLqeMfgQ@mail.gmail.com>
 <20201118161623.GA21171@pc636>
 <87mtzeunsi.fsf@yhuang-dev.intel.com>
 <20201119173604.GA991@pc636>
 <87zh3cu578.fsf@yhuang-dev.intel.com>
 <20201123135919.GA12236@pc636>
 <875z5vtrsc.fsf@yhuang-dev.intel.com>
 <20201124164053.GA23686@pc636>
 <87o8jms1ed.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o8jms1ed.fsf@yhuang-dev.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 08:52:58AM +0800, Huang, Ying wrote:
> Uladzislau Rezki <urezki@gmail.com> writes:
> >> >> > - lazy_max_pages() can slightly be decreased. If there are existing
> >> >> > workloads which suffer from such long value. It would be good to get
> >> >> > real complains and evidence.
> >> >> >
> >> >> >> > Apart of it and in regard to CONFIG_KASAN_VMALLOC, it seems that we are not
> >> >> >> > allowed to drop the free_vmap_area_lock at all. Because any simultaneous
> >> >> >> > allocations are not allowed within a drain region, so it should occur in
> >> >> >> > disjoint regions. But i need to double check it.
> >> >> >> >
> >> >> >> >>
> >> >> >> >> And, can we reduce lazy_max_pages() to control the length of the
> >> >> >> >> purging list?  It could be > 8K if the vmalloc/vfree size is small.
> >> >> >> >>
> >> >> >> > We can adjust it for sure. But it will influence on number of global
> >> >> >> > TLB flushes that must be performed.
> >> >> >> 
> >> >> >> Em...  For example, if we set it to 100, then the number of the TLB
> >> >> >> flushes can be reduced to 1% of the un-optimized implementation
> >> >> >> already.  Do you think so?
> >> >> >> 
> >> >> > If we set lazy_max_pages() to vague value such as 100, the performance
> >> >> > will be just destroyed.
> >> >> 
> >> >> Sorry, my original words weren't clear enough.  What I really want to
> >> >> suggest is to control the length of the purging list instead of reduce
> >> >> lazy_max_pages() directly.  That is, we can have a "atomic_t
> >> >> nr_purge_item" to record the length of the purging list and start
> >> >> purging if (vmap_lazy_nr > lazy_max_pages && nr_purge_item >
> >> >> max_purge_item).  vmap_lazy_nr is to control the virtual address space,
> >> >> nr_purge_item is to control the batching purging latency.  "100" is just
> >> >> an example, the real value should be determined according to the test
> >> >> results.
> >> >> 
> >> > OK. Now i see what you meant. Please note, the merging is in place, so
> >> > the list size gets reduced.
> >> 
> >> Yes.  In theory, even with merging, the length of the purging list may
> >> become too long in some cases.  And the code/algorithm changes that are
> >> needed by controlling the length of the purging list is much less than
> >> that are needed by merging.  So I suggest to do length controlling
> >> firstly, then merging.  Again, just my 2 cents.
> >> 
> > All such kind of tuning parameters work for one case and does not for
> > others. Therefore i prefer to have something more generic that tends
> > to improve the things, instead of thinking how to tune parameters to
> > cover all test cases and workloads.
> 
> It's a new mechanism to control the length of the purging list directly.
> So, I don't think that's just parameter tuning.  It's just a simple and
> direct method.  It can work together with merging method to control the
> purging latency even if the vmap areas cannot be merged in some cases.
> But these cases may not exist in practice, so I will not insist to use
> this method.
> 
No problem. I see your point about an extra thing to control the list length.
Let's see if there are still complains from users. If we have such feedback, 
we will rework it further.

Thanks!

--
Vlad Rezki
