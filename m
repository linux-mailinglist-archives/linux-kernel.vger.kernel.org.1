Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42905259E26
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 20:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730168AbgIASho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 14:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbgIAShn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 14:37:43 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9C0C061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 11:37:43 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id y6so970711plk.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 11:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=I8N41/CU/UJKwzDdO6eiLqWZrVtaxJQ+jfTpQTJbaiI=;
        b=tp5xOwZuUelM6L6Qza2mwA17OKXylorWkBsO7id6/0u45E6x8vQ7xxsq5adkvPtIGo
         fpwamKcKa9lrh2LQVkRbmKW52mS6sHDF22Tr/johvUXWDni2WajSRhd/IEK/qSlcAJca
         hgOYyEOsZy2HBPXg2Um5xvLaJRMqm5smtlneVU0deXjsCzUwtcf1wJNrY+9uAMRYgR/Q
         dRqQOsyudNmwIZK/iQ3lxix1J2flS4SJ4Yjc1eZZjP1jcHjR/jgTOR4kdMGD2oHjM+j1
         YJaC0JgZGgtvZFCG591hvSCq/ILOspDNNSj92aheBugH7Lwb3Wj2qn13bo7DiIfzf1j1
         NGLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=I8N41/CU/UJKwzDdO6eiLqWZrVtaxJQ+jfTpQTJbaiI=;
        b=O50L5vQHRkr/FFwpUHSCvVQwLFIICf5wAQvVjum7hqWvxuu37rUZe9aHt4IH47VJkQ
         Bjctc5kd1WJ/NyLtSNXkLn1toP94KDhUrRQi94KdqXpTNdBSW6Ov89tEP+p6M96E74wK
         /k4yHC7giuy3J2VRZsGUaQO/LB6gtzaq4TgwzkLY41CMBFULmqCBuLSftuDWyrd37FK0
         tG3iqhk8YWChDPoEdZTBJ/R81xHK3avngB88wwB7L9rjBi31Us0fJjG0/iPViHVD5f5H
         ViZXP61tv8+yWPehlD0OgA6q7TJo8EZVoXaWfB/VIkeEsQwdvblungSdNSAFseQvyt2d
         5RhA==
X-Gm-Message-State: AOAM532S7bFQllZ3yCfhgs95K/B9212O1FoYXLQNX5erwlcNhCNW2fUC
        khEBiLhwy9RmFMWsm3QLTgEo6HLPiiRpjg==
X-Google-Smtp-Source: ABdhPJzlh6DjfGAGdKbF8fcEecSYdLNj3yQ/KM5NLfDYHF1prcHhj94K9XJdOprcChKHMNWd3Jnl2Q==
X-Received: by 2002:a17:902:9a95:: with SMTP id w21mr150213plp.296.1598985462348;
        Tue, 01 Sep 2020 11:37:42 -0700 (PDT)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id lb1sm2017325pjb.26.2020.09.01.11.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 11:37:41 -0700 (PDT)
Date:   Tue, 1 Sep 2020 11:37:41 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mhocko@suse.com, linux-mm@kvack.org
Subject: Re: [PATCH] mm/memory_hotplug: drain per-cpu pages again during
 memory offline
In-Reply-To: <20200901124615.137200-1-pasha.tatashin@soleen.com>
Message-ID: <alpine.DEB.2.23.453.2009011137280.503484@chino.kir.corp.google.com>
References: <20200901124615.137200-1-pasha.tatashin@soleen.com>
User-Agent: Alpine 2.23 (DEB 453 2020-06-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Sep 2020, Pavel Tatashin wrote:

> There is a race during page offline that can lead to infinite loop:
> a page never ends up on a buddy list and __offline_pages() keeps
> retrying infinitely or until a termination signal is received.
> 
> Thread#1 - a new process:
> 
> load_elf_binary
>  begin_new_exec
>   exec_mmap
>    mmput
>     exit_mmap
>      tlb_finish_mmu
>       tlb_flush_mmu
>        release_pages
>         free_unref_page_list
>          free_unref_page_prepare
>           set_pcppage_migratetype(page, migratetype);
>              // Set page->index migration type below  MIGRATE_PCPTYPES
> 
> Thread#2 - hot-removes memory
> __offline_pages
>   start_isolate_page_range
>     set_migratetype_isolate
>       set_pageblock_migratetype(page, MIGRATE_ISOLATE);
>         Set migration type to MIGRATE_ISOLATE-> set
>         drain_all_pages(zone);
>              // drain per-cpu page lists to buddy allocator.
> 
> Thread#1 - continue
>          free_unref_page_commit
>            migratetype = get_pcppage_migratetype(page);
>               // get old migration type
>            list_add(&page->lru, &pcp->lists[migratetype]);
>               // add new page to already drained pcp list
> 
> Thread#2
> Never drains pcp again, and therefore gets stuck in the loop.
> 
> The fix is to try to drain per-cpu lists again after
> check_pages_isolated_cb() fails.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: stable@vger.kernel.org

Acked-by: David Rientjes <rientjes@google.com>
