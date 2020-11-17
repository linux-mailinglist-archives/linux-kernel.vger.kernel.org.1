Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 730DB2B67AD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 15:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732407AbgKQOmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 09:42:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728344AbgKQOl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 09:41:59 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0B6C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 06:41:58 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id ec16so10681270qvb.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 06:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7P9jVoxiN2XeeqlFhH6mghYTdw/Tp+4rlAyPEA3z/rg=;
        b=I6S+QcRX2mFpbyQr0vcRNYaflVo4PdeIx1m4jWIMQX7wvqS+/dJDJQ94cx7ztvtC1G
         fKg/FEdlvgdqlcmXo92gL8CneBlksCAkpzRkIyEglPqv3lUMKvx74QAANDNXTTLMxLrQ
         ngmJ+EQStoy17JWl7wfqSIxqjTG0K2IW6bJYceBqPjTpD+bnatsEa9et+oA3GLte2zu0
         V1l1H7HTarRJ4to+xPoHd4A3fgEkBuweP8y19mKgs7CsGfu9mZEdjmiZ/ox53xJDW3Jp
         uXaru4vahuZqdoYUCLSwb3F+kiJAEloUAvvjtkwM81W9izeEf0DIticCoE+CL+HtKMHE
         kFiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7P9jVoxiN2XeeqlFhH6mghYTdw/Tp+4rlAyPEA3z/rg=;
        b=aS4uxV0xRaOgUhQrCUYcZif+R05GZuJJs+bb6CaiUe+6TMvQ7415gt2a/70CtAOvvy
         VuUPO1N4U560Vw0aoihXmLs7g3FXPXHaUgOcolaGtn36rYh0oAyifqA9Bdfg3DLr/kUq
         qPUp4s4YkSotcRXJCiEGYKetXABPBVI0uN68heD50bNAR/1WahUHu1cQ6Y4QkI6CNw9g
         iwLY8lOIvtzge1PHur29yh4i/IDVxMgFDpA/EVW6f1YQC4y8IHL1pKeMY0ulbuWSm195
         CBMeKjmsrSsG0H0JqgIVG6c3YnKOVo3KO2S8WlPTwlYtF+Q8KEMNqUpXj6Zrdpg/qAgR
         RmAQ==
X-Gm-Message-State: AOAM533QFMh2LHajpLLejU2ziDNnaN92W5GEnF7xZPqM4jYGmwY9MyhK
        5rwlu+i8j7J6Nd4wn/yv6ZJ/EQ==
X-Google-Smtp-Source: ABdhPJyJr3s3sVAEolQRuBTmYJoT/XW5fjCQiDMiEllqDFZZxjIVVniMmQnPEDmH6pnPxFVO6GwRwQ==
X-Received: by 2002:ad4:4721:: with SMTP id l1mr20792011qvz.30.1605624117566;
        Tue, 17 Nov 2020 06:41:57 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:ba3])
        by smtp.gmail.com with ESMTPSA id z186sm358923qke.100.2020.11.17.06.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 06:41:56 -0800 (PST)
Date:   Tue, 17 Nov 2020 09:40:04 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, shakeelb@google.com, guro@fb.com,
        laoar.shao@gmail.com, chris@chrisdown.name,
        christian.brauner@ubuntu.com, mingo@kernel.org,
        peterz@infradead.org, ebiederm@xmission.com, esyr@redhat.com,
        tglx@linutronix.de, surenb@google.com, areber@redhat.com,
        elver@google.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 RESEND] mm: memcg/slab: Rename *_lruvec_slab_state to
 *_lruvec_kmem_state
Message-ID: <20201117144004.GA1013321@cmpxchg.org>
References: <20201117085249.24319-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117085249.24319-1-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 04:52:49PM +0800, Muchun Song wrote:
> The *_lruvec_slab_state is also suitable for pages allocated from buddy,
> not just for the slab objects. But the function name seems to tell us that
> only slab object is applicable. So we can rename the keyword of slab to
> kmem.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Roman Gushchin <guro@fb.com>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
