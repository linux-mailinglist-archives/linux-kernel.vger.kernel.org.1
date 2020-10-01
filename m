Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7031C280070
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 15:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732276AbgJANsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 09:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732018AbgJANsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 09:48:22 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04063C0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 06:48:21 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id q63so5304034qkf.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 06:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J07dmbsk/hmgIpcYIkXh0p3U0uIy5v1p6RA5XO+CLeU=;
        b=WrP4qg+LA4thd9MAXuQz83ACLMcWis6RLyd84dLnuZNL1otp+Rg/azur+Mzz3upQb2
         7Xy2twk2EJhPGKnBbcFRXF5CnTmMXL6lg92Rni/yjOCzeIE1uhjQgvvKXc1OWe7pjHjj
         5Jd/GTPZEFjHZlSwCz0np3Skui6Y9yOSslwPOjMyk/alFHiUHZwF0QGYtKQf/Aq94L8B
         sbmHHy30e6QYnVi8toHwwT+49zqbMsU5xNt6shfLCtbrCkWQFIYgGP9OsTHX/z5OPqPJ
         s869LMmBNRuxuJpUhq54myQGB1nrgHN/zZVqJuIVGw570zX9ULGRkGGG4csrGvdztKpg
         3NAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J07dmbsk/hmgIpcYIkXh0p3U0uIy5v1p6RA5XO+CLeU=;
        b=d33JAe5RhwZSJkue7AEZV88zYj9GfXtOSO22+wn7yFZMzPKIl2US8Tj9RrXQWreUZW
         luN4CV4j+bfTib4FF7cdAi4ZfsAzokXsuo49S1zUVqVBgB+1z/2+EnZPI7RrWXJKegAA
         s8d8MCt+WGnehhLNSgRBWJ8DYRr1N/TMONQJE3cfJfbIFJB9mHccqgONTC9gVnzQ+F9c
         ipwWL5mnNFMPyQYLEZm+DV54PbhkZgH7GXjE07JmWNPEtJkizrZjdcMn/x8iSI3k4ScX
         aqS5iwtRWXyNWdYhuYCOUPZJKFcs7Nmv7z4qlXuYjocehZDtOregAjDHL+b7Wic+Cw/N
         q7MA==
X-Gm-Message-State: AOAM531uUz6MDyoQuN9m8XDQPgpH0yB12PtokvyXAVi8p3lHIZwJ1s+u
        4zWPgemO/5xk3kglHtDCBrpVfg==
X-Google-Smtp-Source: ABdhPJzXk+8NGgVicwe4wEzDF3OXCV1C+B3oNYreo/P0acAUv7wtFEWy367Cmzot2uPTsUBpX3dW3A==
X-Received: by 2002:a05:620a:526:: with SMTP id h6mr7650128qkh.25.1601560100278;
        Thu, 01 Oct 2020 06:48:20 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:4e22])
        by smtp.gmail.com with ESMTPSA id o4sm5837971qkj.22.2020.10.01.06.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 06:48:19 -0700 (PDT)
Date:   Thu, 1 Oct 2020 09:46:38 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH v4 1/4] mm: memcontrol: use helpers to access page's
 memcg data
Message-ID: <20201001134638.GE469663@cmpxchg.org>
References: <20201001002710.748166-1-guro@fb.com>
 <20201001002710.748166-2-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001002710.748166-2-guro@fb.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 05:27:07PM -0700, Roman Gushchin wrote:
> +/*
> + * set_page_memcg - associate a page with a memory cgroup
> + * @page: a pointer to the page struct
> + * @memcg: a pointer to the memory cgroup
> + *
> + * Associates a page with a memory cgroup.
> + */
> +static inline void set_page_memcg(struct page *page, struct mem_cgroup *memcg)
> +{
> +	VM_BUG_ON_PAGE(PageSlab(page), page);
> +
> +	/*
> +	 * Please, refer to page_memcg()'s description for the page and memcg
> +	 * binding stability requirements.
> +	 */
> +	page->memcg_data = (unsigned long)memcg;
> +}

Please delete and inline this as per previous feedback, thanks.
