Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 267D52779A2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 21:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgIXTpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 15:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbgIXTpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 15:45:10 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C330C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 12:45:10 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id y17so164670lfa.8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 12:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eSsieBQidgogH93zGkfDZQP5/e21cBSfkOWDaUDT/2s=;
        b=WsW29SUqjJiJZddNLF2A4XcocJgaEx0BV+Vy0q1CP+GSyP5JYj9UbL6j/eyrMH/O/e
         JEggZ6szgy5px13yB/GvZGpvG4HFLDBI2DJe5KgA/+44PxtQ5SSHCiWnAyBTh6ppYc4d
         aF9ECLAcXWDweHPeCKzogJK7koWVmC0S22wughhnHvaGL6+kY1jq57WWughJSGNBs3Cn
         ysQHRNQMqMCf09GJiCKMPAD1OSWE3i7QV174YfyWr9n6fiPcsC9ngRZeWOD+xtB9Sfk0
         Mi4VOnfvovoOv37WBRWrAqYfHnw6SI9RxuJUEKQzh1kGLtK54VrgKVemubLLRGMLEIQ7
         VDdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eSsieBQidgogH93zGkfDZQP5/e21cBSfkOWDaUDT/2s=;
        b=Uk4xxUDFbdRLdGlgGi/YS7+O26W+sH8gw+TzcgL8Y2N6DiGX8cmCdmangJSPQbeDOK
         +47gB0uUwrf0WS4/flVCEnsbuXwGqrnhe6yOR0vZF9M4g7v8mGeIzTucKQABLsqEmUIO
         8yAWOxZSC9SVt30y0gVI1X71t38xhWeZnUYmoWJZp7GjrhURleAfNkYhW8nYtw+fWwi4
         J6PF07orUnpxs4xCPlSDuKMQbTHDUVvAccITMaOZLQKiEw7EQFxsC8xPVLtuVqT+OAT2
         f3J1zPoKm462CSsM+5mXHwVAnjgKAKIfZb5C+hmuOD8yiDmkV3+0p0F54Gk+a01W4QKL
         vCGw==
X-Gm-Message-State: AOAM530NWxF/yhKKVbLnsplfmh2dNIfFWc3/4JAOiqa1EUduHrh/Xs0W
        UzIaKwHfv9c3zehMPRLM+3iQLQChpwuDcK4yegHk4g==
X-Google-Smtp-Source: ABdhPJzwMf70r+Jbg5ClZuPQJVH30T0YFAgaYPUOBkG5Sek0S4eGoPy1cdQ0EaRabYdSQPBatK2KJn3ISrRr4WKNrz4=
X-Received: by 2002:a19:604e:: with SMTP id p14mr131976lfk.385.1600976708381;
 Thu, 24 Sep 2020 12:45:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200924192706.3075680-1-guro@fb.com> <20200924192706.3075680-4-guro@fb.com>
In-Reply-To: <20200924192706.3075680-4-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 24 Sep 2020 12:44:57 -0700
Message-ID: <CALvZod4DGrLnXNB7pyDSu1Dnx0Jqf0_PoV5VXcVgeB_uSYBxPw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] mm: introduce page memcg flags
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 12:29 PM Roman Gushchin <guro@fb.com> wrote:
>
> The lowest bit in page->memcg_data is used to distinguish between
> struct memory_cgroup pointer and a pointer to a objcgs array.
> All checks and modifications of this bit are open-coded.
>
> Let's formalize it using page memcg flags, defined in page_memcg_flags
> enum, and replace all open-coded accesses with test_bit()/__set_bit().
>
> Additional flags might be added later.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>

Thanks.

Reviewed-by: Shakeel Butt <shakeelb@google.com>
