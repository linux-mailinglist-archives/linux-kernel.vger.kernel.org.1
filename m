Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9965A1E508F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 23:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbgE0VgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 17:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgE0VgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 17:36:00 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92492C05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 14:36:00 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id x22so15353998lfd.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 14:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=as3BYd5V48LzAfXq5MM61GLeWE7HSlJgIWf5MOeOsaA=;
        b=NSD+l04JBs90l+P0ssMbRlXN6rfx+6DVrxcpxm685MajuD2Z+Gsuuo9i06CdFnke0Z
         z0BFVRZyLRGq0DR8XQQd++L5Kkd+pwsrvpxdXsDkmGS6ZBIGyAW9Cz9y/GyzTnIqQ/mC
         Zik5Wcc/OWD5tKk45qnesqvKSmeSFgEFriSm843WY8EyL2WwbKu6GGMOxetZE2Uiu0hX
         Bp4UQLxCVuiEPENoAx9RHs4/rU4i07qDimCbhFmvC2KvTko542dum7IZsHoiYN2tdbr/
         jNKt5y2Gxi7PaNuWa0uxGTE4ewpChgG3uU6kFC5wLc/AMTFkMaWk/AWS7cZsEB8lRWYx
         CI9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=as3BYd5V48LzAfXq5MM61GLeWE7HSlJgIWf5MOeOsaA=;
        b=mxJg3TdgfMK4Ob5QI6CIj08HpiL8v9HsOCio6WH8XPmIyZLYDfXue6DW8eLhBWGpib
         e+mPsRHQ7T6sP1cZ7LSpKAuGh3Es7ko6XrpxdWZTA8pcQNlQC/p04CbEgRe+G3y8gcia
         /FoCkdpyFQ6Mz0qj6h+UIkmXTIoGb4vN8NgPa38Q21zmF7T295hL/WoQivmDXKy3mg+P
         WKVyu5azGLVKsBOhIjXmHsVWpyzwyn8aHPaoKkY7M+ajLBwrjkv3Qn+qmrwgTn61uU1/
         fTaY92iFEH/hwvbg8O/VZZsBs8tbBMhQr9d+GJN1nXHRO+xWd65nK5PLz4uh7wtM2Z6b
         9VvA==
X-Gm-Message-State: AOAM532A7zI5HnEUdYSuAnwdJ+i24SX0+S4KzGa0a9TBZLjZ/Z/bW4vv
        xcfFU3tumVnmyvUhP6wLQDRIiwsT+HyvNxTu03iQ6g==
X-Google-Smtp-Source: ABdhPJysoKK5Xdn8qL8s61C5Rb9q6OqJQys+vgn0AbALfz2jYuE8WERfuDUMop/1lJ26i6Qub3Awsm6YywCOYSiB0Kk=
X-Received: by 2002:a19:4854:: with SMTP id v81mr11754lfa.189.1590615358686;
 Wed, 27 May 2020 14:35:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200527182958.252402-1-shakeelb@google.com> <20200527194148.GA47905@cmpxchg.org>
 <20200527134650.18b3fb3f0be85bb73037da20@linux-foundation.org>
In-Reply-To: <20200527134650.18b3fb3f0be85bb73037da20@linux-foundation.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 27 May 2020 14:35:47 -0700
Message-ID: <CALvZod7Phd1H4vXXPOD_7u+1EU-52+3P-nV4eG+63_4_FuwYVA@mail.gmail.com>
Subject: Re: [PATCH resend 3/3] mm: fix LRU balancing effect of new
 transparent huge pages
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Mel Gorman <mgorman@suse.de>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 1:46 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed, 27 May 2020 15:41:48 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> > On Wed, May 27, 2020 at 11:29:58AM -0700, Shakeel Butt wrote:
> > > From: Johannes Weiner <hannes@cmpxchg.org>
> > >
> > > Currently, THP are counted as single pages until they are split right
> > > before being swapped out. However, at that point the VM is already in
> > > the middle of reclaim, and adjusting the LRU balance then is useless.
> > >
> > > Always account THP by the number of basepages, and remove the fixup
> > > from the splitting path.
> > >
> > > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > > Signed-off-by: Shakeel Butt <shakeelb@google.com>
> >
> > This is now already in mm as part of the "mm: balance LRU lists based
> > on relative thrashing" series that I sent out last week and where it
> > was originally from.
>
> Yup.  I hope [1/3] and [2/3] weren't urgent?

No urgency.
