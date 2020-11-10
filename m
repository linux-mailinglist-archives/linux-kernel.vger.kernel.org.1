Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBF632ADA58
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 16:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732532AbgKJPYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 10:24:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732232AbgKJPYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 10:24:54 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41E3C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 07:24:53 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id h15so11725029qkl.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 07:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4K7M+yU2qQGJnBqVAjylDdUBTFCEnQjaCz6moXfYMEE=;
        b=on8OoPlw3VSXy8JNQfuM/sHMVZ8emLX5MZJzG0sTRRpgjWF3aRCwxgJSI9FEVC44qS
         4kQmG920BaTWRgy9W2+iS2syx5dG8Yg/RXtBHWoo/nKw12Ik/Ir0l7CSBjpeXHec2dph
         lNTHcg4fv8MpCEcu4c1MPc5PltE4KD+y6Lh3c2Wbsrd3pxKmW1K3nSqPVTtn/9yghgNO
         pM8A1l0COcK6/hiUfry60njJLbjv+PNmAhrx5oDAM/Um3Rwv00auj9hEJ+rr8/0YIKVG
         vTQ4g4GT+ArZWI37EDyK9bWNccjv5MrIbne6986cr4gqOKWA46X7OiN7nEmlRpHxIGJJ
         yFIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4K7M+yU2qQGJnBqVAjylDdUBTFCEnQjaCz6moXfYMEE=;
        b=k6NY95UIe+66Clv+uoLuxDhgoUajmFUotOGI0m+T0t9P5QoHsuPKLzTmVVbWofxquB
         wjil348LRG8Rw7cxf8od8hF71bXweDX+EvOIe7jHy1LU8AtHso8AzE6iSl3uju6rgfUa
         0tzF2b4NwXJmMVI6Lv0MHeLz9u+qyJbFmFTCi/h+gc/sWdUjeqT7NRbUbnRnJhQKqK8e
         2JcD8QVjJP4OURWajAVh4HTPrKx8Nogbl5NWHCho8aJ/QQKkir0UDNVJV+FQqpEK15Hi
         qaymCUzAJU2ebPAyTgSWCkESGS9xzP/H96RfGgwg2w+TnIQIYwalZJq4EHTpj95hgeo6
         vwPA==
X-Gm-Message-State: AOAM5317bURXLQTK2PaFRp+m2kYuPOSjMNzYLTlkH0QE8/iaKRP4ekYP
        xBJm4/zW6IEzrgfD1yqEgjhjarywyh/yDw==
X-Google-Smtp-Source: ABdhPJxuT7o7jGuflTbr/sPJgqp+0sOaR0b+eEindXqCvTJFRyfwlR+LPCGxtZ48m83DCNLhjDx0mA==
X-Received: by 2002:a37:8685:: with SMTP id i127mr19241385qkd.37.1605021893130;
        Tue, 10 Nov 2020 07:24:53 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:64f7])
        by smtp.gmail.com with ESMTPSA id o16sm589744qkg.27.2020.11.10.07.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 07:24:52 -0800 (PST)
Date:   Tue, 10 Nov 2020 10:23:05 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, shakeelb@google.com,
        guro@fb.com, vbabka@suse.cz, laoar.shao@gmail.com,
        chris@chrisdown.name, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] mm: memcg/slab: Fix root memcg vmstats
Message-ID: <20201110152305.GB842337@cmpxchg.org>
References: <20201110031015.15715-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110031015.15715-1-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 11:10:15AM +0800, Muchun Song wrote:
> If we reparent the slab objects to the root memcg, when we free
> the slab object, we need to update the per-memcg vmstats to keep
> it correct for the root memcg. Now this at least affects the vmstat
> of NR_KERNEL_STACK_KB for !CONFIG_VMAP_STACK when the thread stack
> size is smaller than the PAGE_SIZE.
> 
> Fixes: ec9f02384f60 ("mm: workingset: fix vmstat counters for shadow nodes")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Roman Gushchin <guro@fb.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
