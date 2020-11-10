Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 808892ADF01
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 20:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731472AbgKJTBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 14:01:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgKJTBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 14:01:48 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FCAC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:01:47 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id 63so6386570qva.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JVcNggoHnnZHnilf65d3Odr5BSO3kl6mZ2aAWXQzRAo=;
        b=pk0sA6n4GDC9Xw1ArnL9O5vFNkTR5jEvlt0tkXEf4OOrdrRf0iF57WkXkq+aZYt5md
         SOSYGeOwJSxgei8KKg5Yo31SLqDaLSsHfymGg1j+h3i5xP9aG3N3Ponj3RSQUSa3S+Da
         MAJrkym3VnKjHe2aMbbHNw47MDcHZDhsY95JowUiHyKM48Bt4wQnhEQcVMcrdx1F0wQ4
         cqL0zycLg4WR6wrxM8A0O8Pahsaxszc2AP39S+/sfFz72xb9uTzEVB8x6wGdrjSFMGIg
         oWkRlt3BsWF82RX0mGXyCgQrt1W2lsZfBe7aYt7B3k8TF536jzWY+531OJzHc1fJTPDz
         nsCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JVcNggoHnnZHnilf65d3Odr5BSO3kl6mZ2aAWXQzRAo=;
        b=XjsHcBG+wlHKgjdYivfmfy2GRCr2bVFMkCngzFm/NuoCDvflZ3np9uihkiW5XkMl6r
         tIwtx0dv5WywjQ3RxUVcZB+M4d38Ju7jt8xlspjIv8+xDFJ4xsP3U60IBl6rNjgAJ0T3
         4qAi4pi2LlrrDDRuejC7UX1Doo8UudBbxUTNh6JQJDiLhjGbG3Zz2drig7Ey3qxkAJSI
         l2Md6eLYHRa0vWO7HgUEktxiCpotQRudfOrCup9Y7+NCpQXaiBIlISORu0Gxk4ZXftCW
         vYTBR67ogGvdCdbKJlfkSfaKagrB+VAIg7PuK+LlUbwhHF2nUbfk4+0WhMpRls4YBThB
         re3Q==
X-Gm-Message-State: AOAM531Ju99HqlgKGYRLinid0OH8ZUIXa9Bur8BInDyTr5prjyHbHWks
        DvfUJF8a5wJ5d74Zzbr4vghxtw==
X-Google-Smtp-Source: ABdhPJzqHu0u+YcHQbPCJo8kW9MtBEu4OpLULJDqXdjGYlwoVtkU7rGpiwrGxOD0A9HDtqP73E/74Q==
X-Received: by 2002:a0c:9bac:: with SMTP id o44mr20889059qve.43.1605034907200;
        Tue, 10 Nov 2020 11:01:47 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:64f7])
        by smtp.gmail.com with ESMTPSA id n41sm9027909qtb.18.2020.11.10.11.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 11:01:46 -0800 (PST)
Date:   Tue, 10 Nov 2020 13:59:58 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, willy@infradead.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        kirill@shutemov.name, alexander.duyck@gmail.com,
        rong.a.chen@intel.com, mhocko@suse.com, vdavydov.dev@gmail.com,
        shy828301@gmail.com,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: Re: [PATCH v21 18/19] mm/lru: introduce the relock_page_lruvec
 function
Message-ID: <20201110185958.GC850433@cmpxchg.org>
References: <1604566549-62481-1-git-send-email-alex.shi@linux.alibaba.com>
 <1604566549-62481-19-git-send-email-alex.shi@linux.alibaba.com>
 <66d8e79d-7ec6-bfbc-1c82-bf32db3ae5b7@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66d8e79d-7ec6-bfbc-1c82-bf32db3ae5b7@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 03:50:22PM +0800, Alex Shi wrote:
> From 6c142eb582e7d0dbf473572ad092eca07ab75221 Mon Sep 17 00:00:00 2001
> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Date: Tue, 26 May 2020 17:31:15 +0800
> Subject: [PATCH v21 18/19] mm/lru: introduce the relock_page_lruvec function
> 
> Use this new function to replace repeated same code, no func change.
> 
> When testing for relock we can avoid the need for RCU locking if we simply
> compare the page pgdat and memcg pointers versus those that the lruvec is
> holding. By doing this we can avoid the extra pointer walks and accesses of
> the memory cgroup.
> 
> In addition we can avoid the checks entirely if lruvec is currently NULL.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Acked-by: Hugh Dickins <hughd@google.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: cgroups@vger.kernel.org
> Cc: linux-mm@kvack.org

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
