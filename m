Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0122ADEFD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 20:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731514AbgKJTBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 14:01:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730775AbgKJTBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 14:01:16 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C82C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:01:15 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id e27so19117868lfn.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zKnP0UjT9/41FW96welsKE4nmHYtePDjICGtIuKNYDE=;
        b=YutSGkcINLiH87RXw6H6GyKh691g0QzbgNl7CF4HK08iAClCp9ea/n89O0RSe2aNmb
         Ur9I2aaz3qjCQ1CVxCZrwzro/3uPHPE6hLU5TegLPUTE8LAEjX+1RA2mh0uC0hjT0Kdk
         fTH/PUwuj5ZMwRxfryXySmYoQNPa9wkVclmN7xSW8RrTkWvPkVVkKpuA9LINs0tIxKSt
         JKlFHkT2+IU19ecYwZqiIwautQRIPzJSwOuf75WjGxwS1MyrSoJ6T0PZBnWP5SVdxgNF
         IIJBz79fOk2GKvBzFDx4hlJhjrYkiGpocwnWXRpSEUgRPfbXcDJU/dNbK2CVKDm296Wa
         SjlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zKnP0UjT9/41FW96welsKE4nmHYtePDjICGtIuKNYDE=;
        b=BoNwHt5yKEGiYDEt8OeyJVnv36hCV5Sxtcmd/iAt/H4DzcoJqb842zx0PYPhefNNAF
         Jd+lZuz6hfznC571Rhf/2s+CTD1NT1dOfe+mVIfx2H3xoCWyXB74pCToUEwh2ijfvg2F
         7FQivCD/LxJwuXSHgtFk1CpZnd9INSaXIvsCQ9/MseyeN1cbcjLl9ErBrRtNmyXY9CnT
         g7YNwzsOeH1Rw10y/3SAbKVveHyNRjsAglyEe5pRtDRCuomxCAnEGBYRI93y1nKk+EJQ
         Qm4bYeEJUJYm/uO45+HH+GDf3Og8M4JmRsqt6+XyfOAV3ZKgWfvyaY4P8IlXC3c+jGoP
         srxQ==
X-Gm-Message-State: AOAM533a23o6YEw/vBytCFmxA/o8jWn5gBEShL1QxKZmpCj5WUj6gtAa
        UJpz2FTaByE+OP4BJSVV1pQrmg6OzcsqmeLs6Cs7kA==
X-Google-Smtp-Source: ABdhPJyODxBXTvRgxgz8DW1RA9365vP/o33VJ8YR44Ees8mNhL+3QyMtohiO6gQ6QFgjuCrW3qonmeZ6hyDThXC14rY=
X-Received: by 2002:a19:85c2:: with SMTP id h185mr8571397lfd.494.1605034874125;
 Tue, 10 Nov 2020 11:01:14 -0800 (PST)
MIME-Version: 1.0
References: <20201110184615.311974-1-guro@fb.com>
In-Reply-To: <20201110184615.311974-1-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 10 Nov 2020 11:01:02 -0800
Message-ID: <CALvZod4kLJ+HsciThWkYiYiVDNjx9oUVBC+7k9jYtwHM4+QV_Q@mail.gmail.com>
Subject: Re: [PATCH] mm: memcg: fix obsolete code comments
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 10:46 AM Roman Gushchin <guro@fb.com> wrote:
>
> This patch fixes/removes some obsolete comments in the code related
> to the kernel memory accounting:
> - kmem_cache->memcg_params.memcg_caches has been removed
>   by commit 9855609bde03 ("mm: memcg/slab: use a single set of
>   kmem_caches for all accounted allocations")
> - memcg->kmemcg_id is not used as a gate for kmem accounting since
>   commit 0b8f73e10428 ("mm: memcontrol: clean up alloc, online,
>   offline, free functions")
>
> Signed-off-by: Roman Gushchin <guro@fb.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
