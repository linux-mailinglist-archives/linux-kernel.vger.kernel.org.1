Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A73672ADEDE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 19:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731534AbgKJS4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 13:56:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730618AbgKJS4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 13:56:13 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2BCC0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 10:56:13 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id r7so12522916qkf.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 10:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/t4qmwU8gtuB0mOErW3ybsjmE66Khyr55gvm/nUMiEo=;
        b=FjxVS80ALjbcXnrjko2K/KZQcsv8d1KTprjdA2bLKBKFw2Qky9XWG/ZXVjW72SeI9x
         ga38XY+XdDDaWXMuAd5W/LULK6Mu/WBjvAKO/2qrbJTzwFmdhKwNQblygh7CuTaXngPo
         Z7Z+mqdinSqw3HrGsPASxEq9RL8tKGQMaAPBpk7R3Yy3CTuWRGbwJED19YOJVH0HWKTD
         T+4EGg6CJpte/rGOeXVdmpHqFpMYaB//cqqtNzH1sHkJkQZDaHzUuU401Dz3eNN2Mb5B
         i9c1TmLW7nNY0/wrv6RGfYfwRexLEoV+P0kuvVpBsTDMrBBRE9qkOUu4UuHnwMIlcEhK
         gH+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/t4qmwU8gtuB0mOErW3ybsjmE66Khyr55gvm/nUMiEo=;
        b=SUPna5d3c66l0w8K16/9rWkEbdc7e97EC5DiBXdX7DiU/nKfI6Rb8Ko5XNvbAIVzBo
         XvE4+ymftiU2yvNxxrmapi620MiOr7d/fsKsF7YNqULQ6M0WkqJAC8JWTlhoByN8lyT4
         b2JoHzRZxozMNj6cXrgswWPR6AIwzakHVMNJOh2KEigVqmqgyl48oJ3dik3I7P0P4TeE
         Rb0xC1EbLXwRtlFiKvwwWx/g7h6RJgDjjzyvPF9RLrlCs94tckv78lfSBVA7ogtGaCAh
         lVc6CxLjmT80psuAE+nDkpE4DbvwO9GoE3VcMDZXUgzovKDaVAHskkUEOqG/fUWwPWC7
         dwUQ==
X-Gm-Message-State: AOAM5318o7/6QyA16zFgKp4fC0utRV29T+JqTDhaYNHQvNEr6qbbnX0F
        39ANcRtj4m3v3HtTZ6F9UxRm3Q==
X-Google-Smtp-Source: ABdhPJzSPXhtgtZgD1pAoq/PFLmxJ/OgrE3zaATzVkgYzStiPmKlqHUK5gl3lHmmdxFOHKjysN5U4A==
X-Received: by 2002:a37:8c82:: with SMTP id o124mr5051944qkd.410.1605034572483;
        Tue, 10 Nov 2020 10:56:12 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:64f7])
        by smtp.gmail.com with ESMTPSA id p48sm9096538qtp.67.2020.11.10.10.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 10:56:11 -0800 (PST)
Date:   Tue, 10 Nov 2020 13:54:24 -0500
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
        shy828301@gmail.com, Michal Hocko <mhocko@kernel.org>,
        Yang Shi <yang.shi@linux.alibaba.com>
Subject: Re: [PATCH v21 17/19] mm/lru: replace pgdat lru_lock with lruvec lock
Message-ID: <20201110185424.GB850433@cmpxchg.org>
References: <1604566549-62481-1-git-send-email-alex.shi@linux.alibaba.com>
 <1604566549-62481-18-git-send-email-alex.shi@linux.alibaba.com>
 <5b085715-292a-4b43-50b3-d73dc90d1de5@linux.alibaba.com>
 <5a4c2b72-7ee8-2478-fc0e-85eb83aafec4@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a4c2b72-7ee8-2478-fc0e-85eb83aafec4@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 03:48:16PM +0800, Alex Shi wrote:
> From 84e69f892119d99612e9668e3fe47a3922bafff1 Mon Sep 17 00:00:00 2001
> From: Alex Shi <alex.shi@linux.alibaba.com>
> Date: Tue, 18 Aug 2020 16:44:21 +0800
> Subject: [PATCH v21 17/19] mm/lru: replace pgdat lru_lock with lruvec lock
> 
> This patch moves per node lru_lock into lruvec, thus bring a lru_lock for
> each of memcg per node. So on a large machine, each of memcg don't
> have to suffer from per node pgdat->lru_lock competition. They could go
> fast with their self lru_lock.
> 
> After move memcg charge before lru inserting, page isolation could
> serialize page's memcg, then per memcg lruvec lock is stable and could
> replace per node lru lock.
> 
> In func isolate_migratepages_block, compact_unlock_should_abort and
> lock_page_lruvec_irqsave are open coded to work with compact_control.
> Also add a debug func in locking which may give some clues if there are
> sth out of hands.
> 
> Daniel Jordan's testing show 62% improvement on modified readtwice case
> on his 2P * 10 core * 2 HT broadwell box.
> https://lore.kernel.org/lkml/20200915165807.kpp7uhiw7l3loofu@ca-dmjordan1.us.oracle.com/
> 
> On a large machine with memcg enabled but not used, the page's lruvec
> seeking pass a few pointers, that may lead to lru_lock holding time
> increase and a bit regression.
> 
> Hugh Dickins helped on the patch polish, thanks!
> 
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Acked-by: Hugh Dickins <hughd@google.com>
> Cc: Rong Chen <rong.a.chen@intel.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> Cc: Yang Shi <yang.shi@linux.alibaba.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: cgroups@vger.kernel.org

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
