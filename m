Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65AF128007C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 15:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732343AbgJANuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 09:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732018AbgJANug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 09:50:36 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE0BC0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 06:50:36 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id y11so4378347qtn.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 06:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PsNYo0YsNs8xrb+jwsnFkfkNY3CsLyZk0ScKGuwNA3c=;
        b=pnDuYOYGfglcjkvGnl7jBFrbKJ8RpZKHHuZehYd/d35rMyV9CwmUJWHRuWbyU5bo44
         PW/dQ+z2x5uoVco+04B/wK5/Tfnf/GeE1GHF7Jbsj0uLqRVvuhRXJNC3t/rMVUNWYPWm
         p9OYf2feu43w8k3tnBDaHEqhXosUccAWq2leUfKTF7XTxcS0hH5G+9w7JFP/glG0jtbO
         gYlo9l8V1dTLSYPurIIiI7zsUbxRA5DBj6PHSjcegPjhEzkNcWMe5MZ+FS6Odw+BiueG
         sbcfp5ji2YSqaoH0UJcp3s0hbwqdJp8uNmV2dQFZ+eIIXMxfXvHpEJL/92fq4UFDPlig
         NG0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PsNYo0YsNs8xrb+jwsnFkfkNY3CsLyZk0ScKGuwNA3c=;
        b=VeoQDSEf7ODcECdJG3B3tAA9fqEWHDnRD6gEAH9YoBK97y0Z1+wtkXU/he4ST5goG0
         gbjXDZB2s1KjhCkybQkqqUGYG+Su8u2pwULgJ9fkY+r/SAIX8i3PcM8mtbROj4aWddDK
         gL34GtZyujf4A7cNnW6iv6Zmm7sOUNFYsONNsooHnQX8o4d539iMkeCFvDqGMEien5ye
         ufy47mwfjG7qybV9viA2fZrTywJa+YxdKECOLk1H9U55w8hpOj2Gej1F41dQIisKMoZv
         /lpkgVgEkwABgK2/VI5/NXt53lCGwb/dneJvZXdgPIUt47nRYaUt8F2q8Xr3u3P7Zhrp
         CW6g==
X-Gm-Message-State: AOAM530XtEsQecDbE7yS9YYchByjjKV1erQKsT3yqCYzpJrU4jBLyCkD
        N1XtxdJxAuy9Re+fB7ynNTtvqg==
X-Google-Smtp-Source: ABdhPJzTHRWzaoPywHudcIiE2qJDlBJY4ZDJ4ju/8kJUZOsHC+U8poTe0NHFWKD/gP0U9d++HafolQ==
X-Received: by 2002:aed:2308:: with SMTP id h8mr7659240qtc.65.1601560235500;
        Thu, 01 Oct 2020 06:50:35 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:4e22])
        by smtp.gmail.com with ESMTPSA id p205sm5801638qke.2.2020.10.01.06.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 06:50:34 -0700 (PDT)
Date:   Thu, 1 Oct 2020 09:48:54 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH v4 4/4] mm: convert page kmemcg type to a page memcg flag
Message-ID: <20201001134854.GF469663@cmpxchg.org>
References: <20201001002710.748166-1-guro@fb.com>
 <20201001002710.748166-5-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001002710.748166-5-guro@fb.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 05:27:10PM -0700, Roman Gushchin wrote:
> PageKmemcg flag is currently defined as a page type (like buddy,
> offline, table and guard). Semantically it means that the page
> was accounted as a kernel memory by the page allocator and has
> to be uncharged on the release.
> 
> As a side effect of defining the flag as a page type, the accounted
> page can't be mapped to userspace (look at page_has_type() and
> comments above). In particular, this blocks the accounting of
> vmalloc-backed memory used by some bpf maps, because these maps
> do map the memory to userspace.
> 
> One option is to fix it by complicating the access to page->mapcount,
> which provides some free bits for page->page_type.
> 
> But it's way better to move this flag into page->memcg_data flags.
> Indeed, the flag makes no sense without enabled memory cgroups
> and memory cgroup pointer set in particular.
> 
> This commit replaces PageKmemcg() and __SetPageKmemcg() with
> PageMemcgKmem() and an open-coded OR operation setting the memcg
> pointer with the MEMCG_DATA_KMEM bit. __ClearPageKmemcg() can be
> simple deleted, as the whole memcg_data is zeroed at once.
> 
> As a bonus, on !CONFIG_MEMCG build the PageMemcgKmem() check will
> be compiled out.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
