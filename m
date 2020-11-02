Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2012A2DFF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 16:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgKBPTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 10:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgKBPTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 10:19:54 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81730C061A04
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 07:19:53 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id 12so7842173qkl.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 07:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=A7azf0b6L3Ni0+kWxhbDe/aVVrrIHnecUUge6+Ge8lA=;
        b=Nb21RwzjjoHwgcCRnJW1DYf7eJoR32b1MqtBGslTFLn/e8GgtInbyDQYC+nYumNmv4
         d/xV0YK1F4tPpdIl/ZecTav+F2G6Q/LJvmV6X3FPJIY7tkqJ+BXt7NXTD7Q2yJcF8MUX
         5jA+vbiysm50Woe6xvq9XafPtlKHvoGBZQq4qkyfBF1D77R1kl+BwdMFU9WGgyvA5qXc
         9CmpAx6Rq79YWITccoqYewpoxxG162YRQ85qbJkhDMGz4qHpaVxwhGLwfAS8vxWGlomm
         z/7x7YoUNtBYJk5ZAwVAUdWoC4JMEUUUSXvjufaAjA+DzyYKmw/rk0YExgOYrMhlcpvH
         AjZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A7azf0b6L3Ni0+kWxhbDe/aVVrrIHnecUUge6+Ge8lA=;
        b=BYbxUSkqcFJFYigavkaCnOwG+HqG6Ya+UBGYZF+uJdJSWJnWXn+uo82S4gZeUNzgzB
         2LDP8fXm6AAbm0szGWT17YnPtgl474krme3Pq/tD9C4RrlSZhRrh/RSK2i1uDNNjPJTT
         oi8GBXqxnfASBHQRuNgN+SbKTNJ15CumAIO97q/cKTdacorf2fPMn71BG6nh/xMThHEZ
         eHDbrQxxEV32C9e7+beyQm1pSjXC4wWb2HykuAOS7y8DD30OyYiu5enT/HFGc9+/7j6V
         fdxprrBLpKsipLmXxNFPhVMSJ+f/NGn2sNjP25ohVi6lMnTnRKQe3srz4D0gbXy47J9S
         9yDw==
X-Gm-Message-State: AOAM531yOY3CjM1ZSQCFTMrDiwgiMBZok9JywSeJ0cragE/zSM2E+AUY
        dVSeicqDpsarWW1dfw5yMgg5xQ==
X-Google-Smtp-Source: ABdhPJzVBHUKjjrMXG4VpTx2UbsLQUvS0o0fqC4fierNozFF1Lesa0lxUtR56DK7XfMrHu3tRkHVSg==
X-Received: by 2002:a05:620a:408f:: with SMTP id f15mr1600176qko.276.1604330392791;
        Mon, 02 Nov 2020 07:19:52 -0800 (PST)
Received: from localhost ([163.114.130.6])
        by smtp.gmail.com with ESMTPSA id 6sm8183809qks.51.2020.11.02.07.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 07:19:52 -0800 (PST)
Date:   Mon, 2 Nov 2020 10:18:07 -0500
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
Subject: Re: [PATCH v20 16/20] mm/compaction: do page isolation first in
 compaction
Message-ID: <20201102151807.GI724984@cmpxchg.org>
References: <1603968305-8026-1-git-send-email-alex.shi@linux.alibaba.com>
 <1603968305-8026-17-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1603968305-8026-17-git-send-email-alex.shi@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 06:45:01PM +0800, Alex Shi wrote:
> Currently, compaction would get the lru_lock and then do page isolation
> which works fine with pgdat->lru_lock, since any page isoltion would
> compete for the lru_lock. If we want to change to memcg lru_lock, we
> have to isolate the page before getting lru_lock, thus isoltion would
> block page's memcg change which relay on page isoltion too. Then we
> could safely use per memcg lru_lock later.
> 
> The new page isolation use previous introduced TestClearPageLRU() +
> pgdat lru locking which will be changed to memcg lru lock later.
> 
> Hugh Dickins <hughd@google.com> fixed following bugs in this patch's
> early version:
> 
> Fix lots of crashes under compaction load: isolate_migratepages_block()
> must clean up appropriately when rejecting a page, setting PageLRU again
> if it had been cleared; and a put_page() after get_page_unless_zero()
> cannot safely be done while holding locked_lruvec - it may turn out to
> be the final put_page(), which will take an lruvec lock when PageLRU.
> And move __isolate_lru_page_prepare back after get_page_unless_zero to
> make trylock_page() safe:
> trylock_page() is not safe to use at this time: its setting PG_locked
> can race with the page being freed or allocated ("Bad page"), and can
> also erase flags being set by one of those "sole owners" of a freshly
> allocated page who use non-atomic __SetPageFlag().
> 
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Acked-by: Hugh Dickins <hughd@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
