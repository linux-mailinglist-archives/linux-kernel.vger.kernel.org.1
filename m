Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0891C27F360
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 22:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729958AbgI3UeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 16:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3UeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 16:34:04 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22A8C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 13:34:04 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id j3so1648096qvi.7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 13:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NOz/C/veux6IDW8xnyrTY9317NZDYs4ROap3pLYtiDY=;
        b=B3TCeppzm2KajExG+nOqWodkLCrq0tV84NN2a9tJNpJCmdsdl0pBTjyIsZICH4RBox
         QaOyi1GQM+LnyomneAcmZO5N8ZUi1gkYZqdWQ8VN1hx/lBIDp6qZIvs9i3vzctr3eagv
         G1Z53gHK0RXpKb76E5fyeQVAO1zHgmof1G7ei4MTXzVunVgxzEiEZidXWq3XUyxzYhZA
         JaFjt9pASSdbIF6cVPKEThxcHRsNabv1Ti0nzS1uL70AEewNTvSAwSOD+cRdN5nrROeh
         XIXmm+gkwYz4gmPMTJafGW59t9eJDy1vxBK4/vaJip3Ei4eZ56Z2JMjIZC1orVklN/nU
         6DSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NOz/C/veux6IDW8xnyrTY9317NZDYs4ROap3pLYtiDY=;
        b=bMAUExzIMYUZ5G1gwDXEXzcKo5lw62gHuLn7Mz36KAYXFcRd9Xjz15hynJXaVV7lNH
         6hqc1L35BBPUQpKXNlGRl6UBtOyU+Gas2YsQIPEvS4zplChBV2afo17+SdjcXqM+mdyW
         vaOVMjeY+WdyLux/Z1Pmg0f1WaRFQOCke7Yr47zp7TAnUlRcve/BeSN2HRZfm335rZjk
         dNNIjZB80nWkaoHedhDqoC3XcFjTwuLxJ90ZjKxOPadg7R88MBjeGHg9L/DKM+UybgM2
         Rkk0h8mfssHgu4GeSeeBE/++rHGjqbNXPQ3OLZFUj1RWdyjuV+S5mt0mIIvMvmt6+nWz
         Ex2g==
X-Gm-Message-State: AOAM531IzIv6HmjBsM57E5vUG55RRBnjUJCckF/6fFDaM45y98tkcRHv
        +Fi7CMLxrGb6ggW8tYdZxy0bDg==
X-Google-Smtp-Source: ABdhPJwpX7uHEiQjEZDULf/uZMBiLVe9dzCV1lgBNr2eLO/cGT9833U5P67tNkz0F2JDXkMqK527XQ==
X-Received: by 2002:ad4:4891:: with SMTP id bv17mr4262509qvb.20.1601498043876;
        Wed, 30 Sep 2020 13:34:03 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:4e22])
        by smtp.gmail.com with ESMTPSA id t10sm3286260qkt.55.2020.09.30.13.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 13:34:02 -0700 (PDT)
Date:   Wed, 30 Sep 2020 16:32:23 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH v3 1/4] mm: memcontrol: use helpers to access page's
 memcg data
Message-ID: <20200930203223.GA469663@cmpxchg.org>
References: <20200929235920.537849-1-guro@fb.com>
 <20200929235920.537849-2-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929235920.537849-2-guro@fb.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 04:59:17PM -0700, Roman Gushchin wrote:
> Currently there are many open-coded reads and writes of the
> page->mem_cgroup pointer, as well as a couple of read helpers,
> which are barely used.
> 
> It creates an obstacle on a way to reuse some bits of the pointer
> for storing additional bits of information. In fact, we already do
> this for slab pages, where the last bit indicates that a pointer has
> an attached vector of objcg pointers instead of a regular memcg
> pointer.
> 
> This commits uses 2 existing helpers and introduces 3 new helpers to
> converts all raw accesses to page->mem_cgroup to calls of these helpers:
>   struct mem_cgroup *page_memcg(struct page *page);
>   struct mem_cgroup *page_memcg_rcu(struct page *page);
>   struct mem_cgroup *page_memcg_check(struct page *page);
>   void set_page_memcg(struct page *page, struct mem_cgroup *memcg);
>   void clear_page_memcg(struct page *page);
> 
> page_memcg_check() is intended to be used in cases when the page
> can be a slab page and have a memcg pointer pointing at objcg vector.
> It does check the lowest bit, and if set, returns NULL.
> page_memcg() contains a VM_BUG_ON_PAGE() check for the page not
> being a slab page. So do set_page_memcg() and clear_page_memcg().
> 
> To make sure nobody uses a direct access, struct page's
> mem_cgroup/obj_cgroups is converted to unsigned long memcg_data.
> Only new helpers and a couple of slab-accounting related functions
> access this field directly.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
