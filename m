Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29B372ADA35
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 16:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731280AbgKJPUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 10:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730814AbgKJPUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 10:20:15 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD89C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 07:20:14 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id y16so9068116ljh.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 07:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WmN5VaPF0VfKq6YJQkL5I5tdRY/0dNSzeDneZSSWFWo=;
        b=RHV4dD/PH2eVHEGLppo5X2MUled5LUub72YBQga/LNnTZ22HhU43+vTAmrULNqaOte
         xGl2ryvOIaOWdO9v7vdNUHIDp/iaAovzcdqdoelBQ6Qv5XevhcKuAriM8jvAQE+LFsyM
         nwn+7aO2ha2d0t+pJl/GfR4HMXoO7WOi0YiH1UHnwv818ggwHmoz6IFNlUY9o0JdpBU1
         WIoVB5NYs8bIkMh05qYJsgAm5Vw6ccUNIaDxBRV0wxG8MPrna1i0OJEK418mW3Z9wTiS
         sFnnXhg7cH4FNPWIxMr1Qe8tctLlxoE/N+QTNM75OGhRH4Kd2GFWqxxKrg9/ykUHzw0o
         8DOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WmN5VaPF0VfKq6YJQkL5I5tdRY/0dNSzeDneZSSWFWo=;
        b=ELTyEijhEtvwxe7jHhKWdSj+Rw65TNVXIhd4H/e7T3Ju5eP+o6lBu4gWT2ngFwijaE
         TSx62py9sUIgdwAHQtVjLEWHcWV99N3P2ZstfaJ3WzlrCEALXLltfkKrs4zwS+u6rl+M
         PY/Zr2d2miHKlLPqc3zrxGPMp9Gq2EAZlCP6ZPmCbp2s6QVoPp274qfFm2KxUzIoKvjt
         pi7Bjx1QQuyeZjmwy/ovPsWTo67wu0BDXigBxd5mwZMvzhpRAT+3oDRKDiEQ7+NNd9Vs
         wN2kWKU252pIkk70r7qwezePCCNC7BZ/N5qOsj5OnVP27DmGSnQoBYGqCXTOrJjl9LhE
         JIog==
X-Gm-Message-State: AOAM531oUkNP1UNA2JpRyqIpih/dyS9mB+s1UfbEw3GJENHOn2derEDB
        0lJez2Khvl+6lB3RmeTS8YieNA7XMVlUeEBlodPMeQ==
X-Google-Smtp-Source: ABdhPJxoc9N1XPBGEHguW7769dHZH8sKInRsdW+9S8b4sQsIlf8L6UFumJc6i1uVUiQZG11Jmn7YJR6o/yq8CEs13Tc=
X-Received: by 2002:a2e:874a:: with SMTP id q10mr9197068ljj.446.1605021612719;
 Tue, 10 Nov 2020 07:20:12 -0800 (PST)
MIME-Version: 1.0
References: <20201110031015.15715-1-songmuchun@bytedance.com>
In-Reply-To: <20201110031015.15715-1-songmuchun@bytedance.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 10 Nov 2020 07:20:01 -0800
Message-ID: <CALvZod77gWhLE-dc2CaBF_=Ae37P-puL_RZK83SYuXCiW2CZFQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm: memcg/slab: Fix root memcg vmstats
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Yafang Shao <laoar.shao@gmail.com>,
        Chris Down <chris@chrisdown.name>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 9, 2020 at 7:10 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
> If we reparent the slab objects to the root memcg, when we free
> the slab object, we need to update the per-memcg vmstats to keep
> it correct for the root memcg. Now this at least affects the vmstat
> of NR_KERNEL_STACK_KB for !CONFIG_VMAP_STACK when the thread stack
> size is smaller than the PAGE_SIZE.
>
> Fixes: ec9f02384f60 ("mm: workingset: fix vmstat counters for shadow nodes")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Roman Gushchin <guro@fb.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
