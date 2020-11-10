Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFB12ADEC0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 19:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731546AbgKJSup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 13:50:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731417AbgKJSul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 13:50:41 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853E5C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 10:50:39 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id 13so6370130qvr.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 10:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ao4gO8dckdnbUrVLtqZDO6K8/CHWVv04osrwbe3s3CE=;
        b=aD1YSSjm5h1E5fKJUFCbr7un4ITDFwPpH6MF9varMrqIuVbGJBuFVykbxLg6VBTlR2
         tUkpEBkPpR8DPcUIo0qFS6gFiGku7QOoKoQBtjKBKDNpokJOdt4IStbsoWjphGGuEIe3
         rsI4GBvWMkch7slymkedYAaZbD+xCPLbfIZ6GnBCRmIMgFA/3XwHS4WrRB+h21kNDxEv
         yOCKKNCwlspZuRBiQvvK9EdTbTaHZ+3cJcK3xZLEcFIWMSEjzeJQGDQ+wlOIpFQISCyd
         rss3dJMftolMW5jlmv73BOiORadddv7rPLT2D1Ncc6b1S+mG7UF7n7uZBlthn8zRh769
         2Paw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ao4gO8dckdnbUrVLtqZDO6K8/CHWVv04osrwbe3s3CE=;
        b=tS3hG1gyqTFLJcU/Y6snoBO86Ok6ndU5vTasOI7kK8f56DQTb+BCvfhJJkLBFB7ffr
         vTuwaYxEzXhqaMNVQhw3O60ipPsuD1IfWBNAI4L8GZHC9JU4baldBGCdOWo1eJp3/4P3
         bM8r7ait0bSvjEuKh6b2+Zqrj/tpitzdiiP/gxjc4FSwQ2xhdyPBt+1yBKo42cCAil8R
         fiXowIeCo+nDe7kF0si2Orcqr8LSPObgx+UAKlO3nuhhiKA2RGZ5aWyuNlVthn5XhTAz
         3XngjXvwLxV4ZJLhrOaPPdBOcAkC0WMSy2fgcryKWklFJGSly0CqWfM3HFZRk/MsKB0u
         EmRw==
X-Gm-Message-State: AOAM532Bbw+BqGpAEgUQThhNRHMiGTHeSMUq/zdc+oo3xCOXnBqzTLt9
        hBajWb1oJLc5UnceHLtzwppZSA==
X-Google-Smtp-Source: ABdhPJzzxCdfp78n0ASzjgdakdyVzAJCxf5dldOeoZdGScdsYAQ1wKF4N8gSu4becV/R64CgioXQlQ==
X-Received: by 2002:ad4:4943:: with SMTP id o3mr20168428qvy.9.1605034238663;
        Tue, 10 Nov 2020 10:50:38 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:64f7])
        by smtp.gmail.com with ESMTPSA id c76sm9398105qkb.20.2020.11.10.10.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 10:50:37 -0800 (PST)
Date:   Tue, 10 Nov 2020 13:48:50 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm: memcg: fix obsolete code comments
Message-ID: <20201110184850.GA850433@cmpxchg.org>
References: <20201110184615.311974-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110184615.311974-1-guro@fb.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 10:46:15AM -0800, Roman Gushchin wrote:
> This patch fixes/removes some obsolete comments in the code related
> to the kernel memory accounting:
> - kmem_cache->memcg_params.memcg_caches has been removed
>   by commit 9855609bde03 ("mm: memcg/slab: use a single set of
>   kmem_caches for all accounted allocations")
> - memcg->kmemcg_id is not used as a gate for kmem accounting since
>   commit 0b8f73e10428 ("mm: memcontrol: clean up alloc, online,
>   offline, free functions")
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks Roman
