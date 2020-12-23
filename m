Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0384C2E21DC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 22:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbgLWVCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 16:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728976AbgLWVCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 16:02:01 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB709C06179C
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 13:01:20 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id l11so495236lfg.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 13:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g36tAmTEjSaA0vpBKIUlCpStJerd4pisa8lbF6yxKNQ=;
        b=kn3BVILCed5+28QuNVyEq3hRiqw3fts33Is0SKnBnm17qBAVZ6oxU+DgC7uMmunsTH
         2a8wsM30fyoKI6v9GWohnvTMO5TYWEKkVvE4s/DF3tT8r5sdLksMQxtNkyWi0AcTFDW4
         hzsZELBW0HTOt7N1u6bEzGc/JOnkLsHiAVA5rj/vh/uyWPVcX86QX6MXrj/vEh+tO/wr
         0sSNB2ZbmhP1LDMvMU6ZvEQDpTyGMYClmNF1sruJq5YfeMV7C8cqn0Px8HjHsQIdLbk8
         5GRLH2bKy5K4w+EZF35tH6U5vIO0TqDfdYVDaxNJu/ntR7m/JgE56e2Kf41SGSmLlpc3
         h6Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g36tAmTEjSaA0vpBKIUlCpStJerd4pisa8lbF6yxKNQ=;
        b=iB6Nz7yV66C7Q4LVrK6GD3hrOhhnsRB4GZmTmDmQDAk4gFh/uf/V8SAOK3ICRmN6ZR
         h91zg4rvTXaaIRjdZj51/3i9RprO65xeSmaCrbk+pL4QL19XpIZ+XNTwtDKiw4UboSvo
         9MwZYMAGm0/gwQrsEbcPxpS+4rSjkXzDv6HkMQTyr14DQpJaISDXLhgkAQ9Z+GOoyIIO
         k0Sm0/NzAEI/ObBYf6dKlhLHRv4YD+ALICODrOuB2QW1m9fENQToGJQ18sOzg1ztf0Nl
         ftIx97ujZ6bimbpo8ccBPcDhXjtajymcXc9jG4oANWNc4R4z2sC56xtITCmHl/b+ywp1
         erFg==
X-Gm-Message-State: AOAM530lhOnnYliYJu7ynZp4k4C8euGSMM+ND2KmWHS3Z4rKCBm3es7u
        be5l8d53mJyg52R0/Uw1GFOj/bNkXsSBaCg3OftryA==
X-Google-Smtp-Source: ABdhPJzUj3Wj8zvd/BiNPBjip+KqSkpO464X2X8czRYKgivNp/qw7V05sLyQmik/Lb/Q79cNJkjuGGYHdZ2ec0Abdnk=
X-Received: by 2002:a05:6512:687:: with SMTP id t7mr10984209lfe.432.1608757278987;
 Wed, 23 Dec 2020 13:01:18 -0800 (PST)
MIME-Version: 1.0
References: <20201217034356.4708-1-songmuchun@bytedance.com> <20201217034356.4708-2-songmuchun@bytedance.com>
In-Reply-To: <20201217034356.4708-2-songmuchun@bytedance.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 23 Dec 2020 13:01:07 -0800
Message-ID: <CALvZod7WqYEVOD0o7y+JVcTjdF8N=cbZHEeXa3VvkMsJDQjeKg@mail.gmail.com>
Subject: Re: [PATCH v5 1/7] mm: memcontrol: fix NR_ANON_THPS accounting in
 charge moving
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rafael@kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Feng Tang <feng.tang@intel.com>, Neil Brown <neilb@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 16, 2020 at 7:45 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
> The unit of NR_ANON_THPS is HPAGE_PMD_NR already. So it should inc/dec
> by one rather than nr_pages.
>
> Fixes: 468c398233da ("mm: memcontrol: switch to native NR_ANON_THPS counter")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
> Reviewed-by: Roman Gushchin <guro@fb.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
