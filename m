Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE7682A3557
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 21:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbgKBUqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 15:46:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbgKBUqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 15:46:02 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EFEBC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 12:46:00 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id h12so10159887qtc.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 12:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gB2e508EdlwqwocPMg7gSFq3mG+QyX2QZ372rPOjJ/0=;
        b=GkYdoJDP3SQawBGQzX6f6vlVSfuqoKuZi6YHT2czkvxud7XGR/gxb7pT8E9JRX0BM7
         AvNke3kr4copQpUNeKato3NWktKZn1lTJDOtigAcUl2jZbZ9bjT/vOoyEMuOLG1qDpg8
         GOM7xz+0GZBVO+TPEwNSNzSbvcfbflDoxFA4zLtKuH3uO3oqHajPdTEAVlB9bHCruMNX
         fW4rf3TPJJhY2i/p0WdoPnGZRHioMKc53ApqR1SLSSKZHh4ZR76W9xVQ7P9PiCjF1iFw
         S+fOHmuwKkLPOZ9wtu80sukk1jYcLnFOjCAIj8TxGvfQlIb/LfI7K0YOmmFMR6D97BOw
         7iJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gB2e508EdlwqwocPMg7gSFq3mG+QyX2QZ372rPOjJ/0=;
        b=gQX1X8zbWbZbHds8VTgNWT33neypeTqdlYM79Ol9zcrr7it2MZQLo8FU4fogxMPCw5
         R1vRe5P7us0JI8cBqnBlqjwPkHpVjTYTmdFaS2Wbw+SpTuTm9DXg7sNL707OD3eKnldY
         LsgEf9e+nEUtoxX9W6/mEScPjgmgnEEFGnBDeMFmmRTI6wlGM3yvNdLBNKcrFpzYAkzm
         agd68GE/QpqEypRFyIGdOOj2FQXvCmHWuhomh70nCEweefd7ByG05hed9sxJAZxtQEbb
         23NDAD8s4mBvQcjfM/711HhERBEIuZmlSq3Fud5c2Fpn9dR5wP/Y54lTLZvVJQ2cYHfW
         EXqw==
X-Gm-Message-State: AOAM5310ppSNiQ7UXM/jPw2SuyJsFaw9ryRAJeVrhkCC5dQX9xiAXjBz
        dLGz+asOVY7Q9qIjO4tLoAK6Ow==
X-Google-Smtp-Source: ABdhPJxudlJHRrYzOFWNo8jeGkzWZZdZucQ6P+YEDzHlTPpQ1eFVaOSr7/XsAs+QhppEnZoVEhob5g==
X-Received: by 2002:ac8:6045:: with SMTP id k5mr15221157qtm.216.1604349959591;
        Mon, 02 Nov 2020 12:45:59 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:2f6e])
        by smtp.gmail.com with ESMTPSA id 67sm8636195qkd.14.2020.11.02.12.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 12:45:58 -0800 (PST)
Date:   Mon, 2 Nov 2020 15:44:13 -0500
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
Subject: Re: [PATCH v20 19/20] mm/lru: introduce the relock_page_lruvec
 function
Message-ID: <20201102204413.GC740958@cmpxchg.org>
References: <1603968305-8026-1-git-send-email-alex.shi@linux.alibaba.com>
 <1603968305-8026-20-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1603968305-8026-20-git-send-email-alex.shi@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 06:45:04PM +0800, Alex Shi wrote:
> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
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
