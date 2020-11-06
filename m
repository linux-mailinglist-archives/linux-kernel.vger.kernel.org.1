Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D64442A9970
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 17:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgKFQ1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 11:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbgKFQ1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 11:27:43 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EAFC0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 08:27:42 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id v19so1979604lji.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 08:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cg6Ea4ZIQz7Iz4jtKuc6TtwU1Q/3erkd321DHgapy5w=;
        b=wKd0P7w7Z55PwoDm3Q2dRs+ipQ5l1Tp4zAlZxMLsFhU2d9Uv3avuJyc5Q31ZmF9T3E
         2f1Wq7u8yy/OwHvVvW3fAVPVNUyHSAbrCOXuN9QdMaBLuHK8NddCbDDOA4xzdRgctzaV
         fFY3RSASfyYIhNWgGHab2k7kw9GSrdC1Wiv3PlId70PdkMfp+hMVexogOwVW8N7+hSSq
         JRooAArqq3aUvqCMx8SWk7YiT1c2KUmsRn3+s70x+ZPE9vxoGD4NP06e9oEbYoSmZ1G9
         btga9BB+A51FHypXfdErSG2V/ipIn5NxYFSViuVckKRdUu6kg3tJf6UGS3o1uMqmQlPT
         0FJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cg6Ea4ZIQz7Iz4jtKuc6TtwU1Q/3erkd321DHgapy5w=;
        b=i3okY6C4UBjAO4RmCMV5suXJfi1cNrRNHy5VLeJZNK6mIAH24ut5DiQtEqrpWe/tO5
         RI22yZtdNP2Cia/xfbFSVh0X6rhr3zK8W3MTEyL2TStg3uwyPFiJKhuaaL44s3pg7iKj
         BU8lU0ygsSJGi9M+6VDHM4xSmmrh2qUubPdSezdItygBApCnhUfyGWMu09ut+5qlBhJu
         lR+G4ClL93EElCzhOPfOpo1QbOY18LrV3EmuPu7kb39EVJ13X7Pbc5DS7BD7pNibybgP
         oSNkV+jl2tOJrgsBShvDla51CFTETqF6h7uM48xKNB+Sdwot25g3UodBeuPZBKszbanJ
         oYHg==
X-Gm-Message-State: AOAM533QCPm9tN+vSO1bWkKsDxgT7ghILqwlLipoN6ZVim4stSLaoehe
        e3OUj+OtqTl3GnaS5dpbnoOc7mTZ0EqNq7Z04Owirg==
X-Google-Smtp-Source: ABdhPJzi/6QCPfqhWtR9KxT4D+ow53YZUynQpL6pg2WVjYC38TIBurLFbHkQoqLu8iAG1WkGA00ezlRAWpIGY7ISqqA=
X-Received: by 2002:a2e:1613:: with SMTP id w19mr962342ljd.192.1604680060154;
 Fri, 06 Nov 2020 08:27:40 -0800 (PST)
MIME-Version: 1.0
References: <20201105161936.98312-1-songmuchun@bytedance.com>
In-Reply-To: <20201105161936.98312-1-songmuchun@bytedance.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 6 Nov 2020 08:27:27 -0800
Message-ID: <CALvZod5_+nT9iDCihY0+2vhG8CfH7MvTCoDWTZXBOc-MaxVk9g@mail.gmail.com>
Subject: Re: [PATCH v2] mm: memcontrol: fix missing wakeup polling thread
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Chris Down <chris@chrisdown.name>, Tejun Heo <tj@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 5, 2020 at 8:20 AM Muchun Song <songmuchun@bytedance.com> wrote:
>
> When wen poll the swap.events,

we*

> we can miss being waked up when the swap

being woken up

> event occurs. Because we didn't notify.
>
> Fixes: f3a53a3a1e5b ("mm, memcontrol: implement memory.swap.events")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
