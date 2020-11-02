Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E289B2A2C9C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 15:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726056AbgKBOWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 09:22:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgKBOWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 09:22:17 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25995C061A04
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 06:22:16 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id o205so4761794qke.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 06:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RdeHhYw8BZ2CJOSRk/K/2wBpUG/X7Q+JV4i2mCHJHis=;
        b=Bl4aWTuuhh3ejAZOCKHG4CfQeBEfB/JUzCAQAwwU1q27w9LRBHw40b1lYkRV2Z8hA4
         QCcwpiYoEuOFgqnb3iNq28m4KIyBBN5fOyI6VldOmXUxhedZDDNy42rJSFNdtD/CuZJX
         MV7RIrcafzrFPkz0mmz15xMivH5uzP8iAADoZEqaH7kPWlrxOMUuc8BeKWXpHibe0r3p
         fcaA3Qy5+TJ500b6ulilRT0xQoPC9fKNBdxAs1799SKZHJt3n+apv+8+3YA4xNakrj4u
         jL48OgCHNOr5IHRvjp5AZ5+wKcv4WXsDSKH3XjKhupMWKYXAbpQ7cCFP9/THuYXWkqCz
         l7pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RdeHhYw8BZ2CJOSRk/K/2wBpUG/X7Q+JV4i2mCHJHis=;
        b=fGlmCZuqCmOQJwFbVjyKI8bsD0h2xwUwYvWJOLIPnAr0rk8278Ku5YOV8rkYBD/QaE
         sXCau1DPLhme4b6A8qoLG4hlB6UidE5UPVvwFVgsL2HMsJYX1Hj0Qi5Nvl+kGC3+vcPW
         xqotcTrRNqLzW/4VZh8APdUeWBWdHSFpBRkLv6p3cfPGxC0gS9TG5IHeJJ0IAqYt34C9
         pKucl43R1LSiNbi08SnnKY1GsWu5LnH+UsbHbbReBduQ7ft82My7Y3SPnM9+ekX9Fj5Q
         twMesv2hgXMwqNcd+5IrCmY7GpKmreb35EWwC5Jv/wKR7Kp0osyYhJMXgFVtIt4mc4fy
         DKyQ==
X-Gm-Message-State: AOAM530SVYG++Lvs/95Ju8GrKn7Wt5t7ulG8p3Ngb5HMKbL/x7izmMaY
        NNx30RcB0YTEf/ZuVsj7hyu5lg==
X-Google-Smtp-Source: ABdhPJzZIStCA2Jj3cn0I/zoy13oct/CrY3KLukEVxstOKKufQU/+QSWdefmHTYBrA5eoxuzNcC7lg==
X-Received: by 2002:a37:8d45:: with SMTP id p66mr14133765qkd.461.1604326935223;
        Mon, 02 Nov 2020 06:22:15 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:2f6e])
        by smtp.gmail.com with ESMTPSA id 137sm6172331qkk.63.2020.11.02.06.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 06:22:14 -0800 (PST)
Date:   Mon, 2 Nov 2020 09:20:29 -0500
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
        shy828301@gmail.com
Subject: Re: [PATCH v20 07/20] mm/vmscan: remove unnecessary lruvec adding
Message-ID: <20201102142029.GA724984@cmpxchg.org>
References: <1603968305-8026-1-git-send-email-alex.shi@linux.alibaba.com>
 <1603968305-8026-8-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1603968305-8026-8-git-send-email-alex.shi@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 06:44:52PM +0800, Alex Shi wrote:
> We don't have to add a freeable page into lru and then remove from it.
> This change saves a couple of actions and makes the moving more clear.
> 
> The SetPageLRU needs to be kept before put_page_testzero for list
> integrity, otherwise:
> 
>   #0 move_pages_to_lru             #1 release_pages
>   if !put_page_testzero
>      			           if (put_page_testzero())
>      			              !PageLRU //skip lru_lock
>      SetPageLRU()
>      list_add(&page->lru,)
>                                          list_add(&page->lru,)
> 
> [akpm@linux-foundation.org: coding style fixes]
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Acked-by: Hugh Dickins <hughd@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
