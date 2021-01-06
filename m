Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6F02EC0FA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 17:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbhAFQUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 11:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbhAFQUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 11:20:16 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C39C06134C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 08:19:35 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id r7so2938636wrc.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 08:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ccJXkFCHcbWzoVg8fwcwjSZOSP9Qy6IzcR2ikRjQkFo=;
        b=dRM33wqcllQU/Qcc6+km3ejRY+F7IPUzilOAChZSaM72T2dLZ9OG0e4yuR5Jd1N5sN
         1OByYbLtxyO/32YJmPidAkh80pCu4V7hoHnEFWbX/6B1rJfVOsnvs24leFRHwiPG+gho
         txSB5JK3JGGzerA86gz/3rGtYeC0/+2P9FOWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ccJXkFCHcbWzoVg8fwcwjSZOSP9Qy6IzcR2ikRjQkFo=;
        b=SY+uOtCx+y0FtjfZ/iWPbD0255OJFZ8KGcEtZgBVak4LKh/lV8tywxpUJbLG6p/Uqt
         KdeBR6imxLWDkQvaa0kWWxN4Ub49qlKUCHnHKqOvz3Z5a4G/Wvtl57RNLe6ITPGG6Y6G
         FOPJgsZwfLi1Ou1jGikL6HTJ5hoBdTAhAj9jbg0i4UElknlfc1ut0tHxmHrNLgzuFSZv
         qWND5xujF1CoLe90cGL8twykO3ZDysXv9pdm+je19ACRRBezQwNdzo5e28K2EOUwLl04
         7oqtulDxba9rQx8PwHYkErYYBNPLOiMqbMr4eIoCXk8DCERCsEbACJhiT8oXcAoPDASD
         YuiA==
X-Gm-Message-State: AOAM530l6EKn5H/YCbzRndEAxCOWpPjpimzNUZAIVEh5AWZ3mznHeWxP
        anYeG5TT46VATX5PZzAX75vSxQ==
X-Google-Smtp-Source: ABdhPJyFyfCm0PB8TNXdV5gs6GdSJUt+qDsm4IrZ5KU4ysohYqCm3r09U2oOGaHUGUNyC0uTHN+EBA==
X-Received: by 2002:adf:f10f:: with SMTP id r15mr5109599wro.302.1609949974716;
        Wed, 06 Jan 2021 08:19:34 -0800 (PST)
Received: from localhost ([2620:10d:c093:400::5:5586])
        by smtp.gmail.com with ESMTPSA id t16sm3971660wmi.3.2021.01.06.08.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 08:19:34 -0800 (PST)
Date:   Wed, 6 Jan 2021 16:19:33 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, Hui Su <sh_def@163.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm/memcontrol: fix warning in mem_cgroup_page_lruvec()
Message-ID: <X/XjFfDV7tllAqAd@chrisdown.name>
References: <alpine.LSU.2.11.2101032056260.1093@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2101032056260.1093@eggly.anvils>
User-Agent: Mutt/2.0.3 (a51f058f) (2020-12-04)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins writes:
>Boot a CONFIG_MEMCG=y kernel with "cgroup_disabled=memory" and you are
>met by a series of warnings from the VM_WARN_ON_ONCE_PAGE(!memcg, page)
>recently added to the inline mem_cgroup_page_lruvec().
>
>An earlier attempt to place that warning, in mem_cgroup_lruvec(), had
>been careful to do so after weeding out the mem_cgroup_disabled() case;
>but was itself invalid because of the mem_cgroup_lruvec(NULL, pgdat) in
>clear_pgdat_congested() and age_active_anon().
>
>Warning in mem_cgroup_page_lruvec() was once useful in detecting a KSM
>charge bug, so may be worth keeping: but skip if mem_cgroup_disabled().
>
>Fixes: 9a1ac2288cf1 ("mm/memcontrol:rewrite mem_cgroup_page_lruvec()")
>Signed-off-by: Hugh Dickins <hughd@google.com>

Thanks.

Acked-by: Chris Down <chris@chrisdown.name>
