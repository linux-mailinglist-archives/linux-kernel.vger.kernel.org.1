Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAD692D62B5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 17:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392440AbgLJQ5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 11:57:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392442AbgLJQ5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 11:57:16 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4879C06179C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 08:56:36 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id s21so4635104pfu.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 08:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WNgKN7a4ded1LeBkq8RoIInVbovzz2QvQreFxC7eifA=;
        b=ngrw6r3STU/Y2YvnJY7eQsNYC2nhNp7w0fatD7eeX09k8h47QOCikE0TwWuSgtp318
         UpbWRrRKJw+AxR0sEi/HWSxsLXfRq8h5A6rL3xl/+vhPCJLuOKcE6PHAYgcX6CVcj96r
         ozPHOIebKkCQ2dasDIPUEULrRnSmQmY7edbwfV7AnRzgnQAd7Z4tGMVR+s+uNSdVjwoa
         3Ybb4So9apwKgYFpDY0Va15eDsYUnFOYSOA9122EdxeG8SAekN3QckiVt4NIIQ2p8ogh
         +LzA6FY+N50reiNcOrc0ywGp3fholP1Vxp1Lk6qEGtbrgH58W+2Rm7GEB7Pt5Mfs0l5R
         Ud6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WNgKN7a4ded1LeBkq8RoIInVbovzz2QvQreFxC7eifA=;
        b=RSXrfN+K48/tUcVQOcc8R7aQGlSkNsQcJy+XzIw0OGQHVPxnbNy2GtefCXzrc/D+U/
         OgkZGt/hgWCUNHm2xDpXYibzA5kYhio60Iz0RlVJAxqg0v6Ep7uFeR9YPvUrYkFTa/CF
         MSmOjjy/F0nQdN8SRZB+jdj4SyLGHaKrMAc0rVYmUwhvJk+RuARWeCjsaEMX6ZmVoguK
         ps+pk0veNyU8VxANSnaI2KwG3TI5bPjFXyMNna0tLL1MTXE3eEvPNtsDQ29XuJNcTCYJ
         T9TIhtD4g1Nw9SVccFMk5WjyPp/b3Y/lhjmd3++FnjNUDzO3sgAKNsoAYj/Ot8FiRRuN
         YepA==
X-Gm-Message-State: AOAM532fpIRZnZpfo3k+ZIEN59lF6kjfa3EDyGmtLRwluZD+aGb5rpxh
        Ek5NDk4WW9hpdDbslQhEcMTVbTTuKOBhoMPXCQ/+Mg==
X-Google-Smtp-Source: ABdhPJy9pD/1lJ2qDgAePSWfoMb1GSMyq/JYmVxrm4dOjUbd/QptTorDHdnT6QbcEBnOyfTp+iPIECjZd6VjWW8O9JQ=
X-Received: by 2002:a63:c15:: with SMTP id b21mr7349998pgl.341.1607619396305;
 Thu, 10 Dec 2020 08:56:36 -0800 (PST)
MIME-Version: 1.0
References: <20201206101451.14706-1-songmuchun@bytedance.com>
 <20201206101451.14706-2-songmuchun@bytedance.com> <20201210160413.GH264602@cmpxchg.org>
In-Reply-To: <20201210160413.GH264602@cmpxchg.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 11 Dec 2020 00:56:00 +0800
Message-ID: <CAMZfGtVqwUdXjS4WL97XUcrV4=U2si3pkcoeLbQbeS=k1uMgdA@mail.gmail.com>
Subject: Re: [External] Re: [RESEND PATCH v2 01/12] mm: memcontrol: fix
 NR_ANON_THPS account
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>, Will Deacon <will@kernel.org>,
        Roman Gushchin <guro@fb.com>, Mike Rapoport <rppt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, esyr@redhat.com,
        peterx@redhat.com, krisman@collabora.com,
        Suren Baghdasaryan <surenb@google.com>, avagin@openvz.org,
        Marco Elver <elver@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020 at 12:06 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Sun, Dec 06, 2020 at 06:14:40PM +0800, Muchun Song wrote:
> > The unit of NR_ANON_THPS is HPAGE_PMD_NR already. So it should inc/dec
> > by one rather than nr_pages.
> >
> > Fixes: 468c398233da ("mm: memcontrol: switch to native NR_ANON_THPS counter")
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>
> But please change the subject to
>
>         'mm: memcontrol: fix NR_ANON_THPS accounting in charge moving'

OK. Will do that. Thanks.

-- 
Yours,
Muchun
