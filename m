Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1B22D60FB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 17:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403912AbgLJQD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 11:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392200AbgLJQDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 11:03:33 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500ADC061793
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 08:02:53 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id m5so6013681wrx.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 08:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6cqy3h6zeyXBfeazWGfRXkH+RsOnGkrK4uYLa4meA10=;
        b=F55eqp5BdR+2SiD7cUjPc/dE5pm//HKBnJEcNN5JIQ3kahgaFcm0unTLLFNeCYA/Hd
         mo7zbwH1GSpHvmwgMtLlswl7zttk633FKLWuA8j2R6zKbbTOwJPzK9qAjGbt32uLuL9E
         3qT0+KI8QM1ZnsV+MPMeOJmcQZ+hGQTxRAC3++ooyZlY35akuYScnqpB0mLR0PT38nzY
         3/i0V4j1Rd3vnz8E/9ditif0EzUdhdzgBSvDcW91585TV28VDRDMer1gez6ryZTsRRya
         xFaWZ7TA5GBO/ZOctXMy2slNo0Ju3Vf9KOqund3aOhniPqFeoR78cVC+bfD2xzG5pIjZ
         +F+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6cqy3h6zeyXBfeazWGfRXkH+RsOnGkrK4uYLa4meA10=;
        b=PP63Rg7+OqeKSpLwgQwTWhgUqS3xXuyqNuVztbPRu92VVQnKBh2S04NqupFFsQAp83
         dw5wIV3lT/V1pIuRWBCfWPe/MC8VpjMrxdKLwo4eiB4OEIwSAgl4FQIW0OHXzTYu+aJJ
         gWUxqsBA8cmB/egF3Uyps3hrHrDYzS5og8W2f3OhF2qi8BgQxM7Jdh4b5ZHvbANOnN58
         Yc83Tr7xf9E1y5KkMXJ30mSYG4cFyRwR/l9OJCRBkpi0aZdc3xtbf1PME4i8otTrePVn
         qUW87K6/SjFKf2F3X0kMsDVZr8nriV0aRrdg5yFL/BC23gPDunyLLqxYYOu5F4Yp0MdG
         d3QA==
X-Gm-Message-State: AOAM531txxRJg8wyLAqfpQ6VZU9PZival40oQLit4qDb4T0BQkuTeIJK
        rsg+QazkC+rKujBduhH2ZmuaAQ==
X-Google-Smtp-Source: ABdhPJwtafMVZTP78ChvtU3M0dgyS+B17bQv+/8rCQxS4HbWkwTRVKhsStph2yQMX0DPOFG/1UunXw==
X-Received: by 2002:a5d:678d:: with SMTP id v13mr8994936wru.71.1607616171987;
        Thu, 10 Dec 2020 08:02:51 -0800 (PST)
Received: from localhost (p4fdabc80.dip0.t-ipconnect.de. [79.218.188.128])
        by smtp.gmail.com with ESMTPSA id h3sm10278777wmm.4.2020.12.10.08.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 08:02:51 -0800 (PST)
Date:   Thu, 10 Dec 2020 17:00:45 +0100
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org, adobriyan@gmail.com,
        akpm@linux-foundation.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, hughd@google.com, will@kernel.org,
        guro@fb.com, rppt@kernel.org, tglx@linutronix.de, esyr@redhat.com,
        peterx@redhat.com, krisman@collabora.com, surenb@google.com,
        avagin@openvz.org, elver@google.com, rdunlap@infradead.org,
        iamjoonsoo.kim@lge.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org
Subject: Re: [RESEND PATCH v2 01/12] mm: memcontrol: fix NR_ANON_THPS account
Message-ID: <20201210160045.GF264602@cmpxchg.org>
References: <20201206101451.14706-1-songmuchun@bytedance.com>
 <20201206101451.14706-2-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201206101451.14706-2-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 06, 2020 at 06:14:40PM +0800, Muchun Song wrote:
> The unit of NR_ANON_THPS is HPAGE_PMD_NR already. So it should inc/dec
> by one rather than nr_pages.

This is a real bug, thanks for catching it.

However, your patch changes the user-visible output of /proc/vmstat!

NR_ANON_THPS isn't just used by memcg, it's a generic accounting item
of the memory subsystem. See this from the Fixes:-patch:

-                       __inc_node_page_state(page, NR_ANON_THPS);
+                       __inc_lruvec_page_state(page, NR_ANON_THPS);

While we've considered /proc/vmstat less official than other files
like meminfo, and have in the past freely added and removed items,
changing the unit of an existing one is not going to work.
