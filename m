Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 294B32779E8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 22:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgIXUHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 16:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgIXUHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 16:07:16 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E450C0613DB
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 13:07:16 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id w16so721339qkj.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 13:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sQQqT7lXz3jFrJdbP9q31KQeKrrgb5R/h0Foqx78Wgk=;
        b=hPSRXMz0thLlO8DDHLe2Kvu7sfLhn9YKyAshnQhEodrE4K2HFOSgY4pA7/T/GoeeMJ
         qlmDV+ZulSJyq7v75vNlAcS/eEwNxPAv3hjFdFdUB5TAIVyEyxPnynj0UDKq7l2OprND
         oK+9gHUbKfI/TCixB1tHNIBlK1emaBgTgFqAlnnYcpNLt/JCHgA5X/gu0YDmeQR8DlMz
         U+mgD7s/55MHZbGBR1F7YZMK9HnFkHYzvHjnn7XSBbht8FJ4e+tI7uru8Q3Ie/XRphcP
         3jyw5TCqhqAkXjnPKbLbCXq4x/VcAN4CYg81EVuYBBtUcqoZxNa+lFHdJNNy3eagJWq2
         /98A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sQQqT7lXz3jFrJdbP9q31KQeKrrgb5R/h0Foqx78Wgk=;
        b=WkmC+uOos+1PpSyUWob1qKQF8biBo0bTb9RrEOzJEdhuWb6urB495H/5RkCWGqwvKu
         xqdshuQtlBl0nnYAvHyZeQaWycbRnQ5sa2GM+DDipdZd5uRPtAlSSzObX965dNQCljS4
         t8dZoMnU6+rmd9X4p4tjqEVLPWcAQJNDrYHowTeNKbTa+O3XaridhgzKUMyaLQ37Uh/o
         zu3A9eO2uMlp7HJeg7dJKuXXXl94QTqIx8oNTQmlOx6SFu+KP6hH9B0Mg+AsGZH3vsOH
         E+Osq5oBJOzQj8cwyH5deEisEeBcJNv1bRiyvJacIJ0VhbKpu2b/vTIrg4Un9XCgemyK
         TNMg==
X-Gm-Message-State: AOAM531njRv8UxY+WRdYt3oiOuSnEfGpCyGRHrnwxZlKYhDL97T5XLcc
        VjSChsmggubEO5l6fDztlZLs7g==
X-Google-Smtp-Source: ABdhPJxLoAQBtTJDtAeZpw46U3NlJhiubUs7vv6tJfei+zOYw/VZKUfnGTyNPIAwv3WfLkmsV/Z5ew==
X-Received: by 2002:a05:620a:1341:: with SMTP id c1mr803886qkl.460.1600978035352;
        Thu, 24 Sep 2020 13:07:15 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:4d7a])
        by smtp.gmail.com with ESMTPSA id k26sm452774qtf.35.2020.09.24.13.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 13:07:14 -0700 (PDT)
Date:   Thu, 24 Sep 2020 16:05:42 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH v1 3/4] mm: introduce page memcg flags
Message-ID: <20200924200542.GD329853@cmpxchg.org>
References: <20200922203700.2879671-1-guro@fb.com>
 <20200922203700.2879671-4-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922203700.2879671-4-guro@fb.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 01:36:59PM -0700, Roman Gushchin wrote:
> @@ -422,7 +421,13 @@ static inline void clear_page_mem_cgroup(struct page *page)
>   */
>  static inline struct obj_cgroup **page_obj_cgroups(struct page *page)
>  {
> -	return (struct obj_cgroup **)(page->memcg_data & ~0x1UL);
> +	unsigned long memcg_data = page->memcg_data;
> +
> +	VM_BUG_ON_PAGE(memcg_data && !test_bit(PG_MEMCG_OBJ_CGROUPS,
> +					       &memcg_data), page);
> +	__clear_bit(PG_MEMCG_OBJ_CGROUPS, &memcg_data);
> +
> +	return (struct obj_cgroup **)memcg_data;

Slab allocations set up page->memcg_data locklessly, right? AFAICS,
the page_objcg lookup functions all need READ_ONCE() loads.
