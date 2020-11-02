Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F17F2A2D29
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 15:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgKBOm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 09:42:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgKBOm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 09:42:57 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFEBC061A04
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 06:42:57 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id x20so11643226qkn.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 06:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EFQY01EyQEOZuxyO/m/7TxD1TS0aUUa0gmanbTdmHu4=;
        b=Wz2IE1DQU+bCAzYFTSbwl/3Wdg8BO9G9iu5/96MzFSytj8SJW4UwXqN4SfmYHKcLOx
         nM7CFATxwP5AzIsJgj8OQjBdfw/OxeCZVvGXUBn1yyZyqAOxxH09/1QHD6qIvv1JBVSH
         D/PW0demiOmu01+v6nS60rKe2GrY9KDnsNqmI0kFgatG6ap1JznKEEFmPL8oNHaRXyoX
         DKdhKpLRg/vG8Q+wr1G6mF+IWnI4SbUsqpGlOwvoZZwWAJa5An0gnBPWj80C0qSGVQNn
         uHTTWyqvbSO6YmINQgzFwu9Xs09qPxjAJ4JEzdHCyrZlfA8vOM+NtagPK1hXbqgk9+fR
         TO1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EFQY01EyQEOZuxyO/m/7TxD1TS0aUUa0gmanbTdmHu4=;
        b=KRiXU4x2dXhNvws9jF5Tjf2GVIDngG0Y/b8rsKNpPkSg0YCWzonK25eM6OXkO2ezMz
         6YMZQIEBjEJzpRbd73akc4z3Fp/BHAmGL46JRTuGqamkptSm1o0MyxtoGTl7ZCZ/MZwm
         at6pwCOlCDwS22oNYmSCBqWE7wg71HtRw1aJIjxQ9JNH4dHJ5RggERnzdT8HbxS9dXSV
         yUQq8TYDDuwxUg/BzkHg/7GsqDDH7D2wwm+mBzfFUCFAOxna+Lv0UX6UpQujdOwUEgL3
         TjbdkigweqjjVm+Jm+4R004DFyEOV0reH7wxTupogtN48IULKcGJSJ83Lj5iSorFvtl0
         +yLA==
X-Gm-Message-State: AOAM530lZ0NYr1ybwXmITzuxf2TSrHA53P0tdX4rMdiHS8KRsmMJTEBt
        BZUPa+RwP7T997s3uia2PZTp/6inCL8ZEg==
X-Google-Smtp-Source: ABdhPJzVIOtyxBd1JfsG64NnUJSfOUPA/rAbTYVv6ogFFxP3hJVUSNat4vorqzDivYHk1kMe5T5Y1g==
X-Received: by 2002:a05:620a:b97:: with SMTP id k23mr5141104qkh.214.1604328176845;
        Mon, 02 Nov 2020 06:42:56 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:2f6e])
        by smtp.gmail.com with ESMTPSA id t60sm2608907qtd.65.2020.11.02.06.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 06:42:55 -0800 (PST)
Date:   Mon, 2 Nov 2020 09:41:10 -0500
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
        shy828301@gmail.com, Vlastimil Babka <vbabka@suse.cz>,
        Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH v20 08/20] mm: page_idle_get_page() does not need lru_lock
Message-ID: <20201102144110.GB724984@cmpxchg.org>
References: <1603968305-8026-1-git-send-email-alex.shi@linux.alibaba.com>
 <1603968305-8026-9-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1603968305-8026-9-git-send-email-alex.shi@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 06:44:53PM +0800, Alex Shi wrote:
> From: Hugh Dickins <hughd@google.com>
> 
> It is necessary for page_idle_get_page() to recheck PageLRU() after
> get_page_unless_zero(), but holding lru_lock around that serves no
> useful purpose, and adds to lru_lock contention: delete it.
> 
> See https://lore.kernel.org/lkml/20150504031722.GA2768@blaptop for the
> discussion that led to lru_lock there; but __page_set_anon_rmap() now
> uses WRITE_ONCE(),

That doesn't seem to be the case in Linus's or Andrew's tree. Am I
missing a dependent patch series?

> and I see no other risk in page_idle_clear_pte_refs() using
> rmap_walk() (beyond the risk of racing PageAnon->PageKsm, mostly but
> not entirely prevented by page_count() check in ksm.c's
> write_protect_page(): that risk being shared with page_referenced()
> and not helped by lru_lock).

Isn't it possible, as per Minchan's description, for page->mapping to
point to a struct anon_vma without PAGE_MAPPING_ANON set, and rmap
thinking it's looking at a struct address_space?
