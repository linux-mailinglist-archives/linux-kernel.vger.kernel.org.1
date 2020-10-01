Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBA6280068
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 15:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732256AbgJANqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 09:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732018AbgJANqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 09:46:34 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6F3C0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 06:46:34 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id k25so4375873qtu.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 06:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+ryoO5iz5GpNRthFw16aQfyhzPGUY7XEpOeYN1t5Gz4=;
        b=DUaEBOMR9eVIEbTKve8bWOgpsbGjA+kGFEDHsWkYI88w+8xGwfS6Xu03uoetOb1Z7G
         lKMmlQz9fYP1wBfQGKOtXAGCy5ndFBejQInH2tpGKV5fjQ0c8GbZ9GNwZygvbJknIVqa
         Zuzs+pwTp7/tuL7lsoVHDecCGOsu99E0xjjHMpKceipWMF6bmFPDx4gQmjzFluvOy3yT
         QEbGhre1UJdm7/rW6UL+6wNOHJmE1c4sgHBKDq+XQUldyb8oU3TPDzSxCc/XkVsEN4tC
         fPLWZQin2bzc4lwPGUDOp6QxoNKzlbJmjspdHRrUzxEaQbKwFhNDKV3QU8v58AkOOpRG
         to4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+ryoO5iz5GpNRthFw16aQfyhzPGUY7XEpOeYN1t5Gz4=;
        b=BXF/IP1YJ4i0iYJR/jyEpohXWjFef4EcpUWuPeuRFUCO7TlxB3IrhNdQlj4+3LvFzQ
         lhdzgwJvPl0o18wMvCnFTDXGHk32cSh2FgqFsso7UaXEf2WY42o+u2xesJpMP6BWEpI2
         qbEFrz0J5yOJGhLqMOahTOjZ/K1yS6A7QcJ96qiSCZojWuNyxfto3R6CpJdZkM5/Nhmv
         SnBcLZgP78YN79ug77dUxmhwG6eLLqMS8S4dMXKr5pUkimwpVecpOi34gvveEdWlzWwY
         22kDg/t2cljw/9DqaxNZ1hdoWJp37mkeiH7quBOH4Qx/lNWS9vEs8X4dJUKsJG8fhKOZ
         HtPg==
X-Gm-Message-State: AOAM532/x0U8wf1vQKsK4uz1ZpnWKD2BDmQF7HbiqB/4TksZyfMxHXDU
        R0QEu4iM3rNldN+ITm2Duk1OkA==
X-Google-Smtp-Source: ABdhPJzkOC1luPDjD9py+Wzqx1vepKxas1CYiiwMRbmprhzYqz/mavlSVBy7VHS6t8S71J4LEbxcUA==
X-Received: by 2002:aed:2703:: with SMTP id n3mr7815853qtd.235.1601559993928;
        Thu, 01 Oct 2020 06:46:33 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:4e22])
        by smtp.gmail.com with ESMTPSA id z9sm6628173qta.95.2020.10.01.06.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 06:46:32 -0700 (PDT)
Date:   Thu, 1 Oct 2020 09:44:52 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH v4 3/4] mm: introduce page memcg flags
Message-ID: <20201001134452.GD469663@cmpxchg.org>
References: <20201001002710.748166-1-guro@fb.com>
 <20201001002710.748166-4-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001002710.748166-4-guro@fb.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 05:27:09PM -0700, Roman Gushchin wrote:
> @@ -448,7 +451,12 @@ static inline void set_page_memcg(struct page *page, struct mem_cgroup *memcg)
>   */
>  static inline struct obj_cgroup **page_objcgs(struct page *page)
>  {
> -	return (struct obj_cgroup **)(READ_ONCE(page->memcg_data) & ~0x1UL);
> +	unsigned long memcg_data = READ_ONCE(page->memcg_data);
> +
> +	VM_BUG_ON_PAGE(memcg_data &&
> +		       !(memcg_data & MEMCG_DATA_OBJCGS), page);

This fits on a single line.

> +	return (struct obj_cgroup **)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
>  }
>  
>  /*
> @@ -463,8 +471,9 @@ static inline struct obj_cgroup **page_objcgs_check(struct page *page)
>  {
>  	unsigned long memcg_data = READ_ONCE(page->memcg_data);
>  
> -	if (memcg_data && (memcg_data & 0x1UL))
> -		return (struct obj_cgroup **)(memcg_data & ~0x1UL);
> +	if (memcg_data && (memcg_data & MEMCG_DATA_OBJCGS))
> +		return (struct obj_cgroup **)
> +			(memcg_data & ~MEMCG_DATA_FLAGS_MASK);

	if (!memcg_data || (memcg_data & MEMCG_DATA_OBJCGS))
		return NULL;

	return (struct obj_cgroup **)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);

> @@ -479,7 +488,11 @@ static inline struct obj_cgroup **page_objcgs_check(struct page *page)
>  static inline bool set_page_objcgs(struct page *page,
>  					struct obj_cgroup **objcgs)
>  {
> -	return !cmpxchg(&page->memcg_data, 0, (unsigned long)objcgs | 0x1UL);
> +	unsigned long memcg_data = (unsigned long)objcgs;
> +
> +	memcg_data |= MEMCG_DATA_OBJCGS;
> +
> +	return !cmpxchg(&page->memcg_data, 0, memcg_data);

	return !cmpxchg(&page->memcg_data, 0, memcg_data | MEMCG_DATA_OBJCGS);
