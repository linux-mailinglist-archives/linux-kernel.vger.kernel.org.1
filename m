Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE18292A18
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 17:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729988AbgJSPNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 11:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729717AbgJSPNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 11:13:02 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6A7C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 08:13:01 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id a28so454787ljn.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 08:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zk46YEU8AFrJPMd2DZK0YXhrQs/eaI3r0nLePqJ0ljY=;
        b=QfCrOWagyVz1D/JQhVoyJQsbYNAjvQ/iL7mZq7ErUA3+oG3FeUeyngHtmr1rE78TW2
         jEnzyi82NX2BxtlxZFHebEGmu38P5zJj9WCs6+iSqnxIoj5aGi0JeTWr3DPX+dP3+yKX
         ROusE4YeJT4cVzU+K8MYz96BljmWIdtJ4HuB9/BgDhjxhYPDGT9OUp0VhAxFbSPCyCJz
         DYeUCyUbDI2Esf8lS0dCx3esOjAXoE4j9oDYLRJMVAOtEtegY53K58fX77sPIETx8NZO
         JuHNAesgnTu5m+RsUsU2DJ5hVSNRke6vMLvbfwGKTfX1Qwu/jUJ7of6sDfo5LButNPCA
         FYZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zk46YEU8AFrJPMd2DZK0YXhrQs/eaI3r0nLePqJ0ljY=;
        b=VX7AGb08uW4nT76HZ89Foyh533wdTHTc5pY5CL469pjjhLFHuKK6y77qBKMMp+v74n
         MP2BL92lMUn0m4b409rDA3upH7YlFYbYbcVWVYKLq20uexOF3tcrRyODuF9ARUAwwEYs
         fIri2SNszwAIkGGPLGddd/+PmqSIlr+0juOCXE2KB9BkSXNy4/w9VSW+1O35cDp4E7LL
         8/65dAO8ExX4lQ1ZXPT1+QJJaqn+xsqfuaNcUIBdz3j7VLIcyWZ/5B3V5S6sCKGg7Fu7
         qYvtPj2eX3mPZw9OdKfxv7DmKdUN07zNAT/Tx2O7oVSjspUHSrWSDJUIHRBisgOa4Vjv
         R4Cw==
X-Gm-Message-State: AOAM532FA1RJgdduZlasvhifdkc/ZriefIBgJ9zLf7dSDCNBUubLRFSw
        izmQGL3cQTJMM3Skg7CqqysSicLfyBH/e/TshA6/Kw==
X-Google-Smtp-Source: ABdhPJyy1bxdUdOPXMnQ5eKDGPZT8n6dCCKjJ9rZMIhGQSyK/ZSc4sXbGHMHJl0Se48FIReMKBaaBIn4QgIzJEXOaiw=
X-Received: by 2002:a2e:b60e:: with SMTP id r14mr223627ljn.77.1603120379795;
 Mon, 19 Oct 2020 08:12:59 -0700 (PDT)
MIME-Version: 1.0
References: <20201013153504.92602-1-songmuchun@bytedance.com>
In-Reply-To: <20201013153504.92602-1-songmuchun@bytedance.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 19 Oct 2020 08:12:48 -0700
Message-ID: <CALvZod49YJkG7z+Bnben2pUbw=TyXrHJE1wWt9HbY_85oNpXNA@mail.gmail.com>
Subject: Re: [PATCH] mm: memcontrol: Remove unused mod_memcg_obj_state()
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

On Tue, Oct 13, 2020 at 8:36 AM Muchun Song <songmuchun@bytedance.com> wrote:
>
> Since commit:
>
>   991e7673859e ("mm: memcontrol: account kernel stack per node")
>
> There is no user of the mod_memcg_obj_state(). This patch just remove
> it. Also rework type of the idx parameter of the mod_objcg_state()
> from int to enum node_stat_item.
>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
