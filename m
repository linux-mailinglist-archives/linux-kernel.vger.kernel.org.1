Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAA7C2B0A11
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 17:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbgKLQej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 11:34:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727739AbgKLQei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 11:34:38 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45884C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 08:34:38 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id i12so4405943qtj.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 08:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tta6+LviygyONzH3K33DQhKUnQL5Cid6phvS37hMgnc=;
        b=fv8KOJHmSVjHkmEqC6RVTwmIeO5fDrzc4Jlb1o9d5LPazF4SMd6nn+N+hMzU/CAor+
         DIcRplp7LwvjHrCL+Zd88sxQY2zezrPcij8Xdelhg1BNOaMtTC3fMPV9RbnQX4yFd5TM
         TGRJrNHcRRj0mLk1WE3slN1jFa6WE9hJquAGPmLy30dW2rVNxa+cB5W8Yx+uzsuFBG5p
         W0/Q+8CjPB4rKbZXTGuRbLhHl62Buxu66L1VJlZ4N4+gHyy6+NI8P+yyyHi+mpVAOlvW
         WVOUQPK9YAE9p4+t1g4Ob55ondRvTcyzi/hCj2YoAptlwFJx0puC7f0ZwtJU3GZqSjE+
         xmHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tta6+LviygyONzH3K33DQhKUnQL5Cid6phvS37hMgnc=;
        b=erHVdygTqL5WLxF0y2FKjcVKEjUdp5YGQqynTqksJLgi4IDi1LWhdeIviazQYJbTCb
         eDTzwj7Qbuzke82NH9maEh+8I5WwaJK7cwOif1VEbLo55n7ksVyD6qqLQuxLvFu21pdH
         9q8aWxBcpmPUyrCRUyqDsL9F8HE6Wbchp9QKeRS0JZxZlok06kI03SW7PQ30BB4hle1Q
         5F1IfJCnXI9L+A+P/2UXnAAGGd29bKff725fpVxUNcOP1bOxzUTNnDs+6qwurkatCv9H
         y6cnObnIpP1cstWEYZD2YhQVJf77ayqbcmlNrN3+Un2JcJfDoGwjPisD7fxS4sm1bq0K
         1i/g==
X-Gm-Message-State: AOAM532C/5BcZn2tSK0JxxNi5K/q9T/KUQuTqpLIup9qQ6VPvzgEYh4e
        GFa4MyFR7g7xovODf/q3BLXcDA==
X-Google-Smtp-Source: ABdhPJzPADCn0IsEY9NTEdhyY+gaHnht4dudoTAdWwVJ+jhch7XWN/7ZV/6bPrO4Pjv6wmtYlyQmEg==
X-Received: by 2002:ac8:5a04:: with SMTP id n4mr20585340qta.21.1605198877612;
        Thu, 12 Nov 2020 08:34:37 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:7257])
        by smtp.gmail.com with ESMTPSA id q189sm5181971qkd.41.2020.11.12.08.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 08:34:36 -0800 (PST)
Date:   Thu, 12 Nov 2020 11:32:48 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        David Rientjes <rientjes@google.com>, kernel-team@fb.com
Subject: Re: [PATCH v1 3/3] cgroup: remove obsoleted broken_hierarchy and
 warned_broken_hierarchy
Message-ID: <20201112163248.GE873621@cmpxchg.org>
References: <20201110220800.929549-1-guro@fb.com>
 <20201110220800.929549-4-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110220800.929549-4-guro@fb.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 02:08:00PM -0800, Roman Gushchin wrote:
> With the deprecation of the non-hierarchical mode of the memory
> controller there are no more examples of broken hierarchies left.
> 
> Let's remove the cgroup core code which was supposed to print
> warnings about creating of broken hierarchies.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>
> Acked-by: David Rientjes <rientjes@google.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
