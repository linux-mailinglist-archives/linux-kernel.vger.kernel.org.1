Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4AF8283898
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 16:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgJEO7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 10:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbgJEO7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 10:59:24 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8258C0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 07:59:23 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id de3so1617860qvb.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 07:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RT0ma1EUakIzUMYHMs6mAe4vLDvK12cOAN+Y7MwGXfk=;
        b=B9OJw1YX9ajKEgG2ZKYbqsIYA1hwymQvhH6ShC9QsEQFp8VVEdYzqPKjw83OandrR/
         Ziwhh45leCFbegeu2+saSiPSP4diJGDchgw14+zNrusKHY3t3NIbPxSodYM1WW13uZyL
         G8uYKZd6grR+pRLL2zY8mcn1aHDP+x38Lx7c+feUzm3cgw0akljm4ATYFEHz/Stsgdd+
         cXVeaPQOh1UxMl9o7+ITFNfiw9rZjpuiW3TqZWdiu/2XxhVpjwur8k0KeAPDrBv7aeIp
         uC2FY9F0eI4/oWn1Iu7I29gFNQ9vgSV3eHxekuhX/BCr/gMM1OWyg2VgesHLKCGh0lQS
         mWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RT0ma1EUakIzUMYHMs6mAe4vLDvK12cOAN+Y7MwGXfk=;
        b=sZWLwOx/hji4tN9MxeBh+VTrhU2I5w2iyOWsgqL45WtU4EQ54FedHIzuMS4OjNhASM
         2n4M+BfFEj7Rc9p+nhKNjeprFljYUyQ/niX5/odMIGwD3yQNAoiBDcxacbRljqdiXToT
         HwDpPvYzAeXrUpoAacY7Ax2lkSNC+mUdjh2CKuedLXPpXdOHnnw9LAY/rQwht/7u1hs5
         cwNQ7JGYUSAvGi6aHWROraEV0zHnRfbGc5qpP9miv7OLZ3lqwQPTIzV/UKve9Q/yBmR4
         1MgD/pwu6YCtpo8YcQ0YCuwpjnMlicgccza+B9dfenWMvng/WqTKJVkuOc36rt3xwBXF
         C1WQ==
X-Gm-Message-State: AOAM530m7zCJfBCrf46M8ChWKlMaInMDg7wVHQeafMEjPACQx/junKIr
        PDNlLw+R5z8hMRRy7NLV5yNGEQ==
X-Google-Smtp-Source: ABdhPJyNbXVslMrpzIjiy8waMqYvFIS9jqQ7LFXxftd6fApSEGpz/R9+9D/RQRc1mvSJnkDm08178A==
X-Received: by 2002:a0c:c407:: with SMTP id r7mr122718qvi.36.1601909963083;
        Mon, 05 Oct 2020 07:59:23 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:4c18])
        by smtp.gmail.com with ESMTPSA id l30sm3288637qta.73.2020.10.05.07.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 07:59:21 -0700 (PDT)
Date:   Mon, 5 Oct 2020 10:57:49 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH v5 3/4] mm: introduce page memcg flags
Message-ID: <20201005145749.GA3390@cmpxchg.org>
References: <20201002172559.4000748-1-guro@fb.com>
 <20201002172559.4000748-4-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002172559.4000748-4-guro@fb.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 02, 2020 at 10:25:58AM -0700, Roman Gushchin wrote:
> The lowest bit in page->memcg_data is used to distinguish between
> struct memory_cgroup pointer and a pointer to a objcgs array.
> All checks and modifications of this bit are open-coded.
> 
> Let's formalize it using page memcg flags, defined in enum
> page_memcg_data_flags.
> 
> Additional flags might be added later.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
