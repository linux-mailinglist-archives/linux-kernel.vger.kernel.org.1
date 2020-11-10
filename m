Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40A792ADA4E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 16:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732478AbgKJPXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 10:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731182AbgKJPXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 10:23:35 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D440CC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 07:23:34 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id d28so6651935qka.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 07:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=K5DYC0FobzbOJlRls9qSbY8/GAak6t3HIKm/xVpE3ns=;
        b=FUGXZAUOLHUkTcP4cjeXCSoGU8L1zbPYlFXRTukgjTvaNV4VmPdoTLN7PgunQS0e3I
         zz9ZrsXqcJKMJstDSanvHZjFmDfPwF6TICz+RZ1imaBp6vp+96VH6EyygGO7TuQhoG8S
         GzgILEKH9P0dMJIGCbHqqSgHPqPGr3LOIAC1zwVyJ2f89gG3bzXiUiTdQEzCTaw2UWoY
         ZbcgXnmrLbFSdpjcteVRdAXdWbz0Ccuj3CUGD+fEm09sEbpJN7SuDCHzdKNfVgT1Yqgm
         wkaC8IQH2WmJKPYjp2Ij8yk9VGDCLqVvsAOLwVaS1VBuSsrUt2NIlRUY4RRxqnbrz7xl
         Ch3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K5DYC0FobzbOJlRls9qSbY8/GAak6t3HIKm/xVpE3ns=;
        b=flQl98VT/ABGYaM4IcHXWBrB4nYoJgFMvr0GaUgbPeleTHzCYJAS9nms2n2T3mfuLN
         lV+//dp+chT0aGxetgPWFCgyh7kjck+54048jC8MQJiWT/+fyjaw7gaHQ0Zim8T9ziYi
         O0y7ltAU56txbASdyjcVsUGqnNJ/Wk5aFihFl5WhCOPZZHzhiMi4J96ybUhsDkm62Ov8
         t60GC5RoWRQGUfYlbRdJvKzscDTLjM0FpgJTLm1xQCCBIab0ad7fyqwUJ4GTIf7tp7X0
         C+oeOtbKUnAObWw82J2cu3vIrC7HQ5Hggn+UE0hLmEPQuUHz7Fpg/IC36dTfIjYE+1cV
         hMOw==
X-Gm-Message-State: AOAM532+tMBZ79gPRv+DpQ4EaIJEcdJW8Q+oq7ZNX4U4aaUaD0s6NB/F
        ViJqZdvhUjyaTuH1QzckqO/KnQ==
X-Google-Smtp-Source: ABdhPJz/w81kK3M3g49A8qO08fFld6TFs0sT7VUQmRNYF8+G8TbS49BlNYUAL0utDT4+QJpNUey1DA==
X-Received: by 2002:ae9:dc06:: with SMTP id q6mr20220970qkf.310.1605021812009;
        Tue, 10 Nov 2020 07:23:32 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:64f7])
        by smtp.gmail.com with ESMTPSA id 203sm5869940qkd.25.2020.11.10.07.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 07:23:31 -0800 (PST)
Date:   Tue, 10 Nov 2020 10:21:43 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm: memcg/slab: enable slab memory accounting atomically
Message-ID: <20201110152143.GA842337@cmpxchg.org>
References: <20201110010615.1273043-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110010615.1273043-1-guro@fb.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 09, 2020 at 05:06:15PM -0800, Roman Gushchin wrote:
> Many kernel memory accounting paths are guarded by the
> memcg_kmem_enabled_key static key. It changes it's state during
> the onlining of the first non-root cgroup. However is doesn't
> happen atomically: before all call sites will become patched
> some charges/uncharges can be skipped, resulting in an unbalanced
> charge. The problem is mostly a theoretical issue, unlikely
> having a noticeable impact ion the real life.

memcg_online_kmem() is called from .css_alloc rather than .css_online,
at a time where memcg is brandnew and the css hasn't been set up and
published yet (the refcount isn't even initialized for css_tryget()).

I don't really see how charges could race with that.

We may want to rename memcg_online_kmem() to memcg_alloc_kmem() or
something.

> Before the rework of the slab controller we relied at setting
> kmemcg_id after enabling the memcg_kmem_enabled_key static key.
> Now we can use the setting of memcg->objcg to enable the slab
> memory accounting atomically.

I suspect that code comment has been out of date since commit
0b8f73e104285a4badf9d768d1c39b06d77d1f97.
