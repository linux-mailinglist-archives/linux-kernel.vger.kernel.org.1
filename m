Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3A26257B6C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 16:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbgHaOky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 10:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbgHaOkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 10:40:47 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731CBC061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 07:40:46 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id y17so3623765lfa.8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 07:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aBc9GqAOeob+g82UBj3WHcciacjOztGabwAMKaGbokY=;
        b=iaYuYqZWpCOIP5gqDddZfxEMZa1ED6+kEUFy10cukmAGbQKaLn6m8XIZm8fbsoQ6OX
         jcTuuFYfbmeaDttOt9sijFcNCmwxD7kvSd2CadGtgBrivQX3SoJqlo4xAc/SZ2+HKRC/
         2UTf5VPm6ynFob/FWNcKpNQ5o6BoTw4Lcj7MKMJ7+gtmWKHLuYHf/91/XXQoaW/5I7Pc
         G4QYQhRIYHGEfjFY4spRJ7kP7tMeknNqMxN/LMFFnke6tMxbEWzS72b+YSm3j4B0bld9
         kwDff5ROwA9/WL/bwUpopQ1SiifV8r7I2ZDABPIELEKPnReg8BcjeeKFW/0ojz9c/d0a
         yIqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aBc9GqAOeob+g82UBj3WHcciacjOztGabwAMKaGbokY=;
        b=BmmgllKb4pWGdnQEOrYzd/h52Y1vZEKk4sp9zCZdhQRAyXCEbYqfLtq2v0BNlmEiit
         dPPluGv0AdCG4cgFIKyBVtdUcD2YNOSdD5P/UO6yIIsWLC93U3/cUUSxv+siTor+VTHM
         j/zuzbXyjrxUX6ZfvBoif22lgfUQyDpcppmtEkQHbOJClz4gEN9b3yU4d0l/eoYsFVpA
         L43tORwoB9D85eL/zCGpv115NR2lUtKxT/XcUGjLQPhjB0/xkRbtMdfHb9XorBKGC4aM
         R+7oFOZ16i7aiHrXR2GuXCD5qL+HV9drfClUO/sAnRnhLzDhnS/8yJyWkernVpJygVLt
         rD7A==
X-Gm-Message-State: AOAM530EJfdqI7zCvwX3Pu1WJs6JAMLDRZFFZg/UL4j6BEKpPwGkl5v/
        oqqjo/JWQtakuwdkG1ZIweuMAcvw4MtM7/JS5Pg2hQ==
X-Google-Smtp-Source: ABdhPJz65BezQMN9weABTKeFJF3Wz8lWn/i9UYUlkCj51gOlOUWKkAyJXWrPlZZ5FLXQm17wMixQHe+kFoMJzKuqD1o=
X-Received: by 2002:ac2:4add:: with SMTP id m29mr805362lfp.189.1598884844682;
 Mon, 31 Aug 2020 07:40:44 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LSU.2.11.2008301343270.5954@eggly.anvils> <alpine.LSU.2.11.2008301359460.5954@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2008301359460.5954@eggly.anvils>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 31 Aug 2020 07:40:33 -0700
Message-ID: <CALvZod7e06CizEkpeCCSKLmT1fb=93EubSo6+yQD_zM69+01Ag@mail.gmail.com>
Subject: Re: [PATCH 2/5] mm: migration of hugetlbfs page skip memcg
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Qian Cai <cai@lca.pw>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 30, 2020 at 2:01 PM Hugh Dickins <hughd@google.com> wrote:
>
> hugetlbfs pages do not participate in memcg: so although they do find
> most of migrate_page_states() useful, it would be better if they did
> not call into mem_cgroup_migrate() - where Qian Cai reported that LTP's
> move_pages12 triggers the warning in Alex Shi's prospective commit
> "mm/memcg: warning on !memcg after readahead page charged".
>
> Signed-off-by: Hugh Dickins <hughd@google.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
