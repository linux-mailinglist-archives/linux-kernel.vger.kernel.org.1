Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A25D2D210E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 03:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbgLHCoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 21:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728081AbgLHCoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 21:44:14 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13CBC0613D6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 18:43:34 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id p6so6198647plr.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 18:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jdb7C5Aq6omc7IwwxIaz9ZxTwUguDQHTm2UuR3rHd+Y=;
        b=ydR/LN6K9fneUKUhkvE0+Qv6s3BVCHWfdKrE8qmGsJQvTKxAvH9WDn3PvEV1YToQ++
         ENpqHWssU08a9ws5Cz79XXu2j8Q0956aFERX3PY4UC1SSHoXCBCdCGV/rgwtWULf+KOC
         szt0cHALCdHrYWL4imlZnAkQp9vw0sgOXP0WXl1BcK0B2RH9Ba1SV/nEg7H9W2ZSk00y
         risTzoaMsDDNspp3wyshZifGP61j6MGm1spuBHXbJ9fRUy491LUSUAXxifd/Pyb/+qJy
         R6tsRdYWrGbaeU6n5MgdwPuTfvydofDO5YHGF6V+LZJ0YJeNSm19aKSbA34QXd277huE
         dLwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jdb7C5Aq6omc7IwwxIaz9ZxTwUguDQHTm2UuR3rHd+Y=;
        b=UWPkuXwYei7JIP486dV+09pTFx2witzF5y3ArxrEC8R5PhLH7kQDNNVhc1Dazulcw/
         RUdtMd8eY0XG0CJH6k6ZrfcycaDpZWMKfvSLGQ1r1NZZYSIRoc7tskDAh66E/EJ0BhMh
         BcjOC6S4brr2N44ChS8DD4l4iB71tULMAV22o/XYVYXbYgkwM6119456bux4rRCTP7ia
         PJcPU9zodn1ugbwJAJI+2Z7vhsFY3FEMbcV/w4H1j6BjTsu7cBflgvRja3bft2mJubuI
         njZNy6CiYO1WMTsBP0HC5VoGDFimJiWDgU2z8mWgsSUwEVtBIU4FiQP7z/LF1tijxR8h
         svWQ==
X-Gm-Message-State: AOAM530Ej9w9AzASWBVVyLYSnNrjOlIXSaRG0iOUEchuRI4MyEfnNltH
        bBC05ycHB4DVeG9d2Xge4OD+LTQJZHi7GGOrGO8LLA==
X-Google-Smtp-Source: ABdhPJyPzEAErBPAXhs9T4MgPYqRu/l5uY0/YAfd1sbtAWYcjj6t0I1hQ8V/3A5xcAjooM+5EAgJiAjAFZSjaBHO4E0=
X-Received: by 2002:a17:902:bb92:b029:d9:e9bf:b775 with SMTP id
 m18-20020a170902bb92b02900d9e9bfb775mr19302708pls.24.1607395414374; Mon, 07
 Dec 2020 18:43:34 -0800 (PST)
MIME-Version: 1.0
References: <20201206101451.14706-1-songmuchun@bytedance.com>
 <20201207130018.GJ25569@dhcp22.suse.cz> <CAMZfGtWSEKWqR4f+23xt+jVF-NLSTVQ0L0V3xfZsQzV7aeebhw@mail.gmail.com>
 <20201207150254.GL25569@dhcp22.suse.cz> <20201207195141.GB2238414@carbon.dhcp.thefacebook.com>
 <alpine.LSU.2.11.2012071218540.9574@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2012071218540.9574@eggly.anvils>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 8 Dec 2020 10:42:58 +0800
Message-ID: <CAMZfGtUKvTLOud1cL6mtisq6gtMu-X8th8uoyGtTD4d7LXPa+Q@mail.gmail.com>
Subject: Re: [External] Re: [RESEND PATCH v2 00/12] Convert all vmstat
 counters to pages or bytes
To:     Hugh Dickins <hughd@google.com>
Cc:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Greg KH <gregkh@linuxfoundation.org>, rafael@kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Will Deacon <will@kernel.org>, Mike Rapoport <rppt@kernel.org>,
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

On Tue, Dec 8, 2020 at 4:33 AM Hugh Dickins <hughd@google.com> wrote:
>
> On Mon, 7 Dec 2020, Roman Gushchin wrote:
> > On Mon, Dec 07, 2020 at 04:02:54PM +0100, Michal Hocko wrote:
> > >
> > > As I've said the THP accounting change makes more sense to me because it
> > > allows future changes which are already undergoing so there is more
> > > merit in those.
> >
> > +1
> > And this part is absolutely trivial.
>
> It does need to be recognized that, with these changes, every THP stats
> update overflows the per-cpu counter, resorting to atomic global updates.
> And I'd like to see that mentioned in the commit message.

Thanks for reminding me. Will add.

>
> But this change is consistent with 4.7's 8f182270dfec ("mm/swap.c: flush
> lru pvecs on compound page arrival"): we accepted greater overhead for
> greater accuracy back then, so I think it's okay to do so for THP stats.

Agree. Thanks.

>
> Hugh



-- 
Yours,
Muchun
